class Repository < ActiveRecord::Base
  has_many :commits, dependent: :destroy
  attr_accessible :name

  include Grit

  validate :clone_repository

  def sync(name = "origin", branch = "master")
    repo.git.reset({:chdir => repo.working_dir, :hard => true}, 'HEAD')
    repo.git.pull({:chdir => repo.working_dir}, name, branch)
    update_attribute(:last_synced_at, synced_at)
    update_attribute(:synced_at, Time.now)
    new_commits.each do |commit|
      ::Commit.from_git_commit(commit, repository_id: self.id)
    end
    License.load_from_gemfile(repo.working_dir)
  end

  def stats_per_week
    per_week = commits.select([:created_at, :status]).to_a.group_by { |d| d.created_at.to_date.cweek }
    per_week.collect do |week|
      number  = week[0]
      commits = week[1]
      [number, Hash[commits.group_by { |c| c.status }.map { |w| [w[0].to_sym, w[1].size] }]]
    end.sort { |a,b| b[0] <=> a[0]}
  end

  def new_commits(branch = "master")
    repo.commits(branch, false)
  end

  private

  def repo
    @_repo ||= Repo.new(File.join(Rails.configuration.repository_path, self.name))
  end

  def clone_repository
    user            = name.split("/", 2).first
    repository_path = Rails.configuration.repository_path
    Rails.logger.error('WHOAMI:' + `whoami`)
    clone_cmd = "cd #{repository_path} && mkdir -p #{user} && cd #{user} && git clone git@github.com:#{name}.git"
    Rails.logger.error("executing: #{clone_cmd}")
    status, stdout, stderr = systemu(clone_cmd)
    Rails.logger.error("git clone status: #{status}")
    Rails.logger.error("git clone stdout: #{stdout}")
    Rails.logger.error("git clone stderr: #{stderr}")
    Rails.logger.error(File.join(repository_path, user, name))
    success = File.exists?(File.join(repository_path, name))
    errors.add(:name, :invalid) unless success
  end
end

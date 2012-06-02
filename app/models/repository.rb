class Repository < ActiveRecord::Base
  has_many :commits, dependent: :destroy
  attr_accessible :name

  include Grit

  validate :clone_repository

  def sync(name = "origin")
    repo.remote_fetch(name)
    update_attribute(:last_synced_at, synced_at)
    update_attribute(:synced_at, Time.now)
    new_commits.each do |commit|
      ::Commit.from_git_commit(commit, repository_id: self.id)
    end
  end

  def new_commits(branch = "master")
    repo.commits_since(branch, last_synced_at || Time.at(0), until: synced_at)
  end

  private

  def repo
    @_repo ||= Repo.new(File.join(Rails.configuration.repository_path, self.name))
  end

  def clone_repository
    user = name.split("/", 2).first
    repository_path = Rails.configuration.repository_path
    Rails.logger.debug('WHOAMI:' + `whoami`)
    output = `cd #{repository_path} && mkdir #{user} && cd #{user} && git clone git@github.com:#{user}/#{name}.git`
    Rails.logger.debug(output)
    Rails.logger.debug(File.join(repository_path, user, name))
    success = File.exists?(File.join(repository_path, name))
    errors.add(:name, :invalid) unless success
  end
end

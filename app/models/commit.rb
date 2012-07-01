class Commit < ActiveRecord::Base
  belongs_to :repository
  belongs_to :reviewer, class_name: User

  attr_accessible :committed_at, :message, :sha, :writtin_at, :reviewer_id, :status

  class Status
    REVIEWING = "reviewing"
    OPEN      = "open"
    CLOSED    = "closed"
    ALL       = [REVIEWING, OPEN, CLOSED]
  end

  def self.from_git_commit(git_commit, options = {})
    commit                 = self.find_or_initialize_by_repository_id_and_sha(options[:repository_id], git_commit.sha)
    commit.author_name     = git_commit.author.name
    commit.author_email    = git_commit.author.email
    commit.written_at      = git_commit.authored_date
    commit.committed_at    = git_commit.committed_date
    commit.committer_name  = git_commit.committer.name
    commit.committer_email = git_commit.committer.email
    commit.message         = git_commit.message
    commit.save
  end
end

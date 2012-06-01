class CommitsController < ApplicationController

  def index
    session[:commit_filter] = params[:status] if params[:status]
    @repository = Repository.find(params[:repository_id])
    scope = @repository.commits.order("committed_at DESC").page(params[:page])
    if session[:commit_filter].present?
      @commits = scope.where(:status => session[:commit_filter])
    else
      @commits = scope
    end
  end

  def show
    @repository = Repository.find(params[:repository_id])
    @commit = @repository.commits.find_or_create_by_sha(params[:id])
  end

  def claim
    @repository = Repository.find(params[:repository_id])
    @commit = @repository.commits.find_or_create_by_sha(params[:commit_id])

    @repository.commits.
        where(reviewer_id: [nil, current_user.id], sha: params[:commit_id]).
        update_all(reviewer_id: current_user.id, status: Commit::Status::REVIEWING)
    respond_with @commit, :location => repository_commits_path(@repository)
  end

  def close
    @commit = current_user.commits.find(params[:commit_id])
    @commit.update_attributes(reviewer_id: current_user.id, status: Commit::Status::CLOSED)
    respond_with @commit, :location => repository_commits_path(@repository)
  end

end

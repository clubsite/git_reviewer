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
    @commit = @repository.commits.find_by_sha(params[:id])
  end

  def claim
    @repository = Repository.find(params[:repository_id])
    @commit = @repository.commits.find_or_create_by_sha(params[:commit_id])

    rows = @repository.commits.
        where(reviewer_id: [nil, current_user.id], sha: params[:commit_id]).
        update_all(reviewer_id: current_user.id, status: Commit::Status::REVIEWING, updated_at: Time.now)
    if rows == 0
      @repository.commits.
          where(status: Commit::Status::CLOSED, sha: params[:commit_id]).
          update_all(reviewer_id: current_user.id, status: Commit::Status::REVIEWING, updated_at: Time.now)
    end
    @commit.reload
    respond_to do |format|
      format.html { redirect_to repository_commits_path(@repository) }
      format.js { render 'status' }
    end
  end

  def close
    @repository = Repository.find(params[:repository_id])
    @commit = current_user.commits.find(params[:commit_id])
    @commit.update_attributes(reviewer_id: current_user.id, status: Commit::Status::CLOSED)
    @commit.reload
    respond_to do |format|
      format.html { redirect_to repository_commits_path(@repository) }
      format.js { render 'status' }
    end
  end

end

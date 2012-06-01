require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  before_filter :authenticate_user!
  before_filter :set_headers

  protect_from_forgery

  private

  def repositories
    @repositories = Repository.all
  end
  helper_method :repositories

  def set_headers
    response.headers["X-Frame-options"] = ""
  end

  def current_user
    user = super
    if user
      user.git_type        = :github
      user.git_credentials = session['github_credentials']
    end
    user
  end


end

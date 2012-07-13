class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    # You need to implement the method below in your model
    @user = User.find_for_github_oauth(request.env["omniauth.auth"], current_user)
    omniauth_auth = request.env["omniauth.auth"]
    session["github_credentials"] = {login:       omniauth_auth.extra.raw_info.login,
                                     oauth_token: omniauth_auth.credentials.token}
    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Github"
      sign_in_and_redirect @user, :event => :authentication
    else
      flash[:alert] = I18n.t "devise.omniauth_callbacks.failure", :kind => "Github", :reason => "you'r not registered"
      redirect_to new_user_session_path
    end
  end
end

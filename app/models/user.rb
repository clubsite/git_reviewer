class User < ActiveRecord::Base
  include GitReviewer::Git

  has_many :repositories
  has_many :commits, foreign_key: "reviewer_id"

  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  attr_accessible :email, :password, :password_confirmation, :remember_me

  def self.find_for_github_oauth(access_token, signed_in_resource=nil)
    data = access_token.info
    if user = self.find_by_email(data.email)
      user
    else # return a new user
      User.new
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.github_data"] && session["devise.github_data"]["info"]
        user.email = data["email"]
      end
    end
  end
end

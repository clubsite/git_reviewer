module ApplicationHelper
  def github_commit_url(repository, sha)
    "https://github.com/#{repository.name}/commit/#{sha}"
  end

  def gravatar_icon(user_email = '', size = 40)
    return unless user_email
    gravatar_host = request.ssl? ? "https://secure.gravatar.com" : "http://www.gravatar.com"
    user_email.strip!
    "#{gravatar_host}/avatar/#{Digest::MD5.hexdigest(user_email.downcase)}?s=#{size}&d=identicon"
  end

  def review_label(status)
    case status
      when Commit::Status::REVIEWING
        "label-warning"
      when Commit::Status::CLOSED
        "label-success"
    end
  end
end

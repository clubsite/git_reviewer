module GitReviewer
  module Git
    extend ActiveSupport::Concern

    class UnsupportedClientError < StandardError; end

    SUPPORTED_CLIENTS = [:github]

    class Github
      attr_accessor :client

      def initialize(credentials)
        @client = Octokit::Client.new(credentials)
      end

      def repos
        @client.repos
      end

      def commits(repository)
        @client.commits(repository)
      end
    end

    included do
      attr_accessor :git_type, :git_credentials
    end

    def git_client
      raise UnsupportedClientError unless SUPPORTED_CLIENTS.include?(@git_type)
      "GitReviewer::Git::#{@git_type.to_s.camelize}".constantize.new(@git_credentials)
    end
  end
end

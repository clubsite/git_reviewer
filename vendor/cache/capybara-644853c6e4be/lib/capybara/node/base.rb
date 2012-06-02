module Capybara
  module Node

    ##
    #
    # A {Capybara::Node::Base} represents either an element on a page through the subclass
    # {Capybara::Node::Element} or a document through {Capybara::Node::Document}.
    #
    # Both types of Node share the same methods, used for interacting with the
    # elements on the page. These methods are divided into three categories,
    # finders, actions and matchers. These are found in the modules
    # {Capybara::Node::Finders}, {Capybara::Node::Actions} and {Capybara::Node::Matchers}
    # respectively.
    #
    # A {Capybara::Session} exposes all methods from {Capybara::Node::Document} directly:
    #
    #     session = Capybara::Session.new(:rack_test, my_app)
    #     session.visit('/')
    #     session.fill_in('Foo', :with => 'Bar')    # from Capybara::Node::Actions
    #     bar = session.find('#bar')                # from Capybara::Node::Finders
    #     bar.select('Baz', :from => 'Quox')        # from Capybara::Node::Actions
    #     session.has_css?('#foobar')               # from Capybara::Node::Matchers
    #
    class Base
      attr_reader :session, :base, :parent

      include Capybara::Node::Finders
      include Capybara::Node::Actions
      include Capybara::Node::Matchers

      def initialize(session, base)
        @session = session
        @base = base
      end

      # overridden in subclasses, e.g. Capybara::Node::Element
      def reload
        self
      end

      def synchronize(seconds=Capybara.default_wait_time)
        retries = (seconds.to_f / 0.05).round

        begin
          yield
        rescue => e
          raise e unless driver.wait?
          raise e unless driver.invalid_element_errors.include?(e.class) or e.is_a?(Capybara::ElementNotFound)
          raise e if retries.zero?
          sleep(0.05)
          reload if Capybara.automatic_reload
          retries -= 1
          retry
        end
      end

    protected

      def driver
        session.driver
      end
    end
  end
end

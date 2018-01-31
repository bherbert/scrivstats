# frozen_string_literal: true

require 'thor'
require 'thor/actions'

module ScrivStats
  # The Command Line Interface (CLI) for the gem.
  class CLI < Thor
    include Thor::Actions

    package_name Identity.version_label

    def initialize(args = [], options = {}, config = {})
      super args, options, config
    #   @configuration = self.class.configuration
    rescue Runcom::Errors::Base => error
      abort error.message
    end

    desc '-f, [--file]', 'Process Scrivener Document File'
    map %w[-f --file] => :generate
    def generate(path = '.')
      runner = Runner.new path
      if runner.file?
        runner.run
        say 'Stats generated for: ' + path
      else
        say 'Scrivener document not found: ' + path
      end
    end

    desc '-v, [--version]', 'Show gem version.'
    map %w[-v --version] => :version
    def version
      say Identity.version_label
    end

    # desc "-h, [--help=COMMAND]", "Show this message or get help for a command."
    # map %w[-h --help] => :help
    # def help task = nil
    #   say and super
    # end

    private

    attr_reader :configuration
  end
end

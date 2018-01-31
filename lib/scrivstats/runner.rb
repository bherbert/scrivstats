module Scrivstats
  class Runner
    def initialize(path = '.')
      @path = path
    end

    # Does Scrivener document exist?
    def file?
      File.exist?(path) && File.directory?(path)
    end

    def run
      puts format("Running on [%s]...\n", @path)

      scriven = Scriven.new(path)
      scriven.parse

      # Dump the final structure
      puts scriven.to_str

      # Render a bargraph showing percentages of chapter and scenes
      puts "\nChapter & Scene Heat Map\n\n"
      puts scriven.stats_bargraph
      puts "\n"
    end

    private

    attr_reader :path
  end
end

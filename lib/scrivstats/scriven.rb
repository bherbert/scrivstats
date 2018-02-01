
require 'nokogiri'
require 'shellwords'

  # -----------------------------------------------------------------------------
  # Model a Scrivener document
  class Scriven
    # Relative path within the Scrivener document (package) to text files
    DOCS_PATH = '/Files/Docs/'.freeze

    def initialize(scrivener_path)
      # Path to the Scrivener project document (less trailing slash)
      @scrivener_path = scrivener_path.chomp("\/")
      @chapters = []
      # @counter = WordCounter.new
      @scrivx_name = scrivx_name
      @wc = nil
    end

    # Parse the document structure into chapters and scenes
    def parse
      # parse the project and compute statistics
      xml = File.read(scrivx)
      doc = Nokogiri::Slop(xml)
      binder_items = doc.ScrivenerProject.Binder.BinderItem
      manu = binder_items.detect { |el| el.Title.content == 'Manuscript' }
      chapter_nodes = manu.Children.BinderItem.select { |el| el.Title.content.match('Chapter') }
      chapter_nodes.each do |chapter_node|
        title = chapter_node.Title.content
        id = chapter_node['ID']
        chapter = Chapter.new(id, title)
        add_chapter(chapter)
        node = chapter_node.Children.BinderItem("[Type='Text']")
        if node.class == Nokogiri::XML::Element
          # only one node
          save_scene(node, chapter)
        else
          node.each do |scene|
            save_scene(scene, chapter)
          end
        end
      end
      compute_wc
    end

    attr_reader :chapters

    # Compute word counts of all document components
    def compute_wc
      @chapters.each(&:wc)
    end

    # Answer a wordcount of an RTF file within the Scrivener project
    def word_count(filename)
      path = abs_docs_path + filename
      wc = `textutil -stdout -convert txt #{path} | wc -w`
      wc.chomp.to_i
    end

    # Stats output

    def to_str
      s = format("Document: %s (%5d)\n", scrivx_name, wc)
      @chapters.each { |chapter| s += chapter.to_str }
      s
    end

    # Answer a bargraph rendering of the document structure.
    # This gives a quick visual of the relative sizes of chapters and scenes.
    def stats_bargraph
      bar_graph = ''

      # Traverse the structure and compute percentage:
      #   - of each chapter relative to the whole
      #   - of each scene relative to its chapter
      total_words = @wc
      chapters.each do |chapter|
        chapter.fraction_of_total(total_words)
        chapter.scenes.each { |scene| scene.fraction_of_total(chapter.wc) }
      end

      # Largest chapter renders a bar of this length
      bar_length = 100

      # Longest chapter gets full bar length.
      longest_chapter = chapters.max_by(&:wc)
      
      words_per_chart_segment = longest_chapter.wc / bar_length

      # Other chapters are scaled relative to longest
      chapter_bar_scale_factor = bar_length / longest_chapter.fraction

      # Compute a bar graph showing relative sizes of chapter (to the whole) and
      # relative sizes of scenes (to the chapter)
      chapters.each do |chapter|
        # Show length of chapter relative to its percentage of the document
        chapter_bar_length = chapter_bar_scale_factor * chapter.fraction
        bar = chapter.scenes.collect do |scene|
          # Show length of each scene relative to relative size of chapter
          bar_len = chapter_bar_length * scene.fraction
          "*" * bar_len
        end
        bar_graph += format("[%-10s] %s\n", chapter.title, bar.join("_"))
                # bar_graph += format("[%-10s] %s\n", chapter.title, bar.join("\u2581"))
      end
      
      bar_graph += format("\n  * = %d words (min)",words_per_chart_segment)
      
      bar_graph
    end

    private

    def add_chapter(chapter)
      @chapters << chapter
    end

    # Save a scene defined by the given node to the given chapter
    def save_scene(node, chapter)
      id = node['ID']
      title = node.Title.content
      chapter.add_scene(Scene.new(id, title, self))
    end

    # Answer the wordcount of the entire manuscript
    def wc
      @wc ||= @chapters.inject(0) { |sum, chapter| sum + chapter.wc }
    end

    # Answer the absolute path to the 'Docs' folder within the Scrivener package.
    def abs_docs_path
      Shellwords.shellescape(format('%s%s', @scrivener_path, DOCS_PATH))
    end

    # Answer the basename of the Scrivener project document
    def scrivx_name
      File.basename(@scrivener_path, '.scriv')
    end

    # Answer the absolute path to the .scrivx metadata file in the Scrivener
    # project. The file defines the structure of the project.
    def scrivx
      format('%s/%s.scrivx', @scrivener_path, scrivx_name)
    end

    # -----------------------------------------------------------------------------
    # A Chapter in the manuscript
    class Chapter
      attr_reader :id, :title, :scenes, :fraction
      def initialize(id, title)
        @id = id
        @title = title
        @wc = nil
        @scenes = []
        @fraction = nil
      end

      # Add another scene to the chapter
      def add_scene(scene)
        @scenes << scene
      end

      def to_str
        s = ''
        s << format("%4s (%5d) => %s\n", @id, wc, @title)
        @scenes.each { |scene| s << scene.to_str }
        s
      end

      # The word count of a chapter is the sum of the scenes
      def wc
        @wc ||= @scenes.inject(0) { |sum, scene| sum + scene.wc }
      end

      # Compute the percent of words in this chapter relative to total
      # words in the document.
      def fraction_of_total(total)
        @fraction = wc.to_f / total
      end
    end

    # -----------------------------------------------------------------------------
    # a Scene in a Chapter
    class Scene
      attr_reader :id, :title, :fraction
      def initialize(id, title, scrivener)
        @id = id
        @title = title
        @scrivener = scrivener
        @fraction = nil
        @wc = nil
      end

      def to_str
        format("  %4s (%5d) => %s\n", @id, @wc, @title)
      end

      # Answer the word count of the scene file
      def wc
        path = format('%s.rtf', @id)
        @wc ||= @scrivener.word_count(path)
      end

      # Compute the percent of words in this scene relative to total
      # words in the chapter.
      def fraction_of_total(total)
        @fraction = wc.to_f / total
      end
    end
  end
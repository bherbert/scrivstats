#
# Status: 2018-01-26
#   moving code into Scriven
#   refactoring the WordCounter code
#
require 'nokogiri'
require 'shellwords'
require 'pathname'
require 'rtf'

# Next: 2018-01-28

# Path to Scrivener document
doc_path = './data/book.scriv/'
# xx
class Scriven
  # Relative path within the Scrivener document (package) to text files
  DOCS_PATH = '/Files/Docs/'.freeze

  attr_reader :chapters
  def initialize(scrivener_path)
    # Path to the Scrivener project document (less trailing slash)
    @scrivener_path = scrivener_path.chomp("\/")
    @chapters = []
    # @counter = WordCounter.new
    @scrivx_name = scrivx_name
  end

  # Answer the wordcount of an RTF file within the Scrivener project
  def word_count(filename)
    path = abs_docs_path + filename
    wc = `textutil -stdout -convert txt #{path} | wc -w`
    wc.to_i
  end

  # Answer the absolute path to the 'Docs' folder within the Scrivener package.
  def abs_docs_path
    Shellwords.shellescape(format('%s%s', @scrivener_path, DOCS_PATH))
  end

  def scrivx_name
    File.basename(@scrivener_path, '.scriv')
  end

  # Answer the absolute path to the .scrivx metadata file
  # in the Scrivener project
  def scrivx
    format('%s/%s.scrivx', @scrivener_path, scrivx_name)
  end

  def add_chapter(chapter)
    @chapters << chapter
  end

  def parse
    # parse the project and compute statistics
    xml = File.read(scrivx)
    doc = Nokogiri::Slop(xml)
    binder_items = doc.ScrivenerProject.Binder.BinderItem
    manu = binder_items.detect { |el| el.Title.content == 'Manuscript' }
    chapter_nodes = manu.Children.BinderItem.select { |el| el.Title.content.match('Chapter') }
    chapter_nodes.each do |chapter_node|
      # puts chap.class
      title = chapter_node.Title.content
      id = chapter_node['ID']
      chapter = Chapter.new(id, title)
      add_chapter(chapter)
      # puts '===== ' + title
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
  end

  # Save a scene defined by the given node to the given chapter
  def save_scene(node, chapter)
    id = node['ID']
    title = node.Title.content
    chapter.add_scene(Scene.new(id, title, self))
  end

  def to_str
    s = format("Document: %s (%5d)\n", scrivx_name, wc)
    @chapters.each { |chapter| s += chapter.to_str }
    s
  end

  # Answer the wordcount of the entire manuscript
  def wc
    @chapters.sum(&:wc)
  end

  # A Chapter in the manuscript
  class Chapter
    attr_reader :id, :title, :wc, :scenes
    def initialize(id, title)
      @id = id
      @title = title
      @wc = 0
      @scenes = []
    end

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
      @scenes.sum(&:wc)
    end
  end

  # a Scene in a Chapter
  class Scene
    attr_reader :id, :title
    def initialize(id, title, scrivener)
      @id = id
      @title = title
      @scrivener = scrivener
    end

    def to_str
      format("  %4s (%5d) => %s\n", @id, @wc, @title)
    end

    # Answer the word count of the scene file
    def wc
      # path = Shellwords.shellescape(format('%s%s.rtf', @@docsPath, @id))
      path = format('%s.rtf', @id)
      @wc ||= @scrivener.word_count(path)
    end
  end

  # Counts words in a file
  class WordCounter
    def initialize(path)
      @path = path
    end

    # Answer the wordcount of the file at the path
    def wc
      puts @path
      d = `date`
      puts d
      10
    end
  end
end

puts format('Running on [%s]...', doc_path)

scriven = Scriven.new(doc_path)
scriven.parse

# Dump the final stats
puts scriven.to_str
exit

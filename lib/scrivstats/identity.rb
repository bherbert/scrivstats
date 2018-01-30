# frozen_string_literal: true

module ScrivStats
  # Gem identity information.
  module Identity
    def self.name
      'scrivstats'
    end

    def self.label
      'Scrivener Stats'
    end

    def self.version
      '0.1.0'
    end

    def self.version_label
      "#{label} #{version}"
    end
  end
  end

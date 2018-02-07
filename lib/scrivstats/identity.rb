# frozen_string_literal: true

module Scrivstats
  # Gem identity information.
  module Identity
    def self.name
      "scrivstats"
    end

    def self.label
      "Scrivstats"
    end

    def self.version
      "0.1.2"
    end

    def self.version_label
      "#{label} #{version}"
    end
  end
end

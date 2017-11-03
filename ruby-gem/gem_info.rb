{{ruby_copyright}}
module {{ project_name | underscore | camelize }}
  module GemInfo
    MAJOR_VERSION = 0
    MINOR_VERSION = 0
    PATCH_VERSION = 0

    def self.version_string
      [MAJOR_VERSION, MINOR_VERSION, PATCH_VERSION].join('.')
    end
  end
end

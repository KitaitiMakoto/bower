require 'multi_json'

module Bower
  class Environment
    attr_accessor :directory, :json

    DEFAULT_DIRECTORY = 'components'
    DEFAULT_JSON      = 'component.json'

    def self.setup(bowerrc=nil)
      if bowerrc && File.exists?(bowerrc)
        conf = MultiJson.load(File.open(bowerrc))
        Environment.new(conf)
      else
        Environment.new
      end
    end

    def initialize(config={})
      @directory = config['directory'] || DEFAULT_DIRECTORY
      @json      = config['json'] || DEFAULT_JSON
    end

    def install
      run('bower install')
    end

    def update
      run('bower update')
    end

    private

    def run(cmd)
      return unless Dir.exists?(directory)

      Dir.chdir(directory) do
        `#{cmd}` if File.exists?(json)
      end
    end

  end
end

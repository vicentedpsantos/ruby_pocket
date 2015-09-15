require 'etc'
require 'ruby_pocket/environment'

module RubyPocket
  VERSION = '0.1'

  RubyPocketError = Class.new StandardError

  class << self
    attr_accessor :environment

    def environment=(environment)
      @environment = Environment.new(environment)
    end

    def environment
      self.environment = 'PRODUCTION' unless @environment
      @environment
    end

    def setup_data_dir
      return unless environment.production?
      return if Dir.exist?(data_dir)

      Dir.mkdir data_dir
    end

    def data_dir
      @data_dir ||= File.join(home_dir, '.ruby_pocket')
    end

    private

    def home_dir
      Dir.home(Etc.getlogin)
    end
  end
end

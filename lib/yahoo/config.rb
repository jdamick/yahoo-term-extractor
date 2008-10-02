
module Yahoo
  module Config
    def app_id()
      config[:app_id]
    end
    
    def output_format()
      config[:output_format] || :json
    end
    
    def endpoint_uri()
      if @endpoint_uri.nil?
        raise "Configuration Error - missing hostname" if config[:hostname].nil?
        raise "Configuration Error - missing endpoint" if config[:endpoint].nil?
        @endpoint_uri = URI.parse("#{config[:hostname]}/#{config[:endpoint]}".gsub(/^\:\/\//, '/'))
      end
      @endpoint_uri
    end
    
    private
    def config()
      @default_config ||= YAML.load_file(File.join(File.dirname(__FILE__), '..', '..', 'config', 'yahoo_service_config.yml'))            
      # try to load from RAILS_ROOT
      if @config.nil?
        config = YAML.load_file(File.join(RAILS_ROOT, 'config', 'yahoo_service_config.yml'))
        @config = @default_config.merge(config)
      end
      @config        
    end
    
  end
end

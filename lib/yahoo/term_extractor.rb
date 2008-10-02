require 'logger'
    
module Yahoo
  class RemoteServerError < RuntimeError; end
  class ConfigurationError < RuntimeError; end
  
  class TermExtractor
    extend Yahoo::Config

    # Extracts terms from content provided. Provide an optional query to provide context for your terms.
    def self.find_terms(content, query = nil)
      debug { "post_form(#{endpoint_uri()}, #{query_hash(content, query).inspect})" }
      response = Net::HTTP.post_form(endpoint_uri(), query_hash(content, query))
      raise Yahoo::RemoteServerError unless response.code == "200"
      results = JSON.parse(response.body)['ResultSet']['Result'] rescue []
    end

    private

    def self.query_hash(content, query)
      raise Yahoo::ConfigurationError if app_id().nil?
      { 'appid' => app_id(),
        'output' => output_format().to_s,
        'context' => content,
        'query' => query }
    end
    
    def self.debug()
      Logger.new(STDOUT).debug(yield) if ENV['DEBUG']
    end
  end
end

module NeonCrm
  class Configuration
    attr_accessor :api_key, :org_id

    def initialize()
      config = Configuration.config
      self.api_key = config['neoncrm']['api_key']
      self.org_id = config['neoncrm']['org_id']
    end

    class << self
      def config
        YAML.load_file("#{Rails.root}/config/networks.yml")[Rails.env]
      end
    end
  end
end
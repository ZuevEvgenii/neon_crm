module NeonCrm
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      def copy_networks
        template "networks.yml", "config/networks.yml"
      end
    end
  end
end
# frozen_string_literal: true

module SolidusAdmin
  module Generators
    class InstallGenerator < Rails::Generators::Base
      def install_solidus_core_support
        route <<~RUBY
          mount SolidusAdmin::Engine, at: '/admin', constraints: ->(req) {
            req.cookies['solidus_admin'] == 'true'
          }
        RUBY
      end

      def ignore_tailwind_build_files
        append_file(".gitignore", "app/assets/builds/solidus_admin/") if File.exist?(Rails.root.join(".gitignore"))
      end

      def build_tailwind
        rake "solidus_admin:tailwindcss:build"
      end
    end
  end
end
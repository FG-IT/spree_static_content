module SpreeStaticContent
  module Generators
    class InstallGenerator < Rails::Generators::Base
      class_option :migrate, type: :boolean, default: true, banner: 'Migrate the database'

      def add_javascripts
        javascripts_path = 'vendor/assets/javascripts/spree/backend/all.js'
        return unless File.file?(javascripts_path)

        append_file 'vendor/assets/javascripts/spree/backend/all.js', "//= require spree/backend/page_picker\n"
      end

      def add_migrations
        run 'bundle exec rake railties:install:migrations FROM=spree_static_content'
      end

      def run_migrations
        if options[:migrate]
          run 'bundle exec rake db:migrate VERBOSE=false'
        else
          puts 'Skipping rake db:migrate, don\'t forget to run it!'
        end
      end
    end
  end
end

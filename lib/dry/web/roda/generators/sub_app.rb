require "dry/web/roda/generators/abstract_generator"

module Dry
  module Web
    module Roda
      module Generators
        class SubApp < AbstractGenerator
          def populate_templates
            add_lib
            add_system
            add_web
          end

          private

          def destination
            options.fetch(:to) { File.join("apps", target_dir) }
          end

          def umbrella_name
            options.fetch(:umbrella)
          end

          def add_lib
            add_template('subapp/view_context.rb.tt', "lib/#{underscored_project_name}/view/context.rb")
            add_template('subapp/view_controller.rb.tt', "lib/#{underscored_project_name}/view/controller.rb")
            add_template('welcome.rb.tt', "lib/#{underscored_project_name}/views/welcome.rb")
          end

          def add_system
            %w(application container).each do |file|
              add_template("subapp/#{file}.rb.tt", "system/#{underscored_project_name}/#{file}.rb")
            end
            add_template('import.rb.tt', "system/#{underscored_project_name}/import.rb")
            add_template('subapp/boot.rb.tt', 'system/boot.rb')
          end

          def add_web
            add_template('example_routes.rb.tt', 'web/routes/example.rb')
            add_template('application.html.slim', 'web/templates/layouts/application.html.slim')
            add_template('welcome.html.slim', 'web/templates/welcome.html.slim')
          end

          def template_scope
            {
              underscored_project_name: underscored_project_name,
              camel_cased_app_name: Inflections.camel_cased_name(target_dir),
              underscored_umbrella_name: Inflections.underscored_name(umbrella_name),
              camel_cased_umbrella_name: Inflections.camel_cased_name(umbrella_name),
            }
          end
        end
      end
    end
  end
end

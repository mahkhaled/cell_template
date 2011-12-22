require 'rails/generators/erb/scaffold/scaffold_generator'

module Haml
  module Generators
    class ScaffoldGenerator < Erb::Generators::ScaffoldGenerator
      source_root File.expand_path("../templates", __FILE__)

      def copy_view_files
        available_views.each do |view|
          filename = filename_with_extensions(view)
          destination = filename_with_extensions(view.gsub('#{table_name}', table_name))
          template "#{view}.html.haml", File.join("app/views", controller_file_path, destination)
        end
      end
      
      def copy_view_javascript_files
        available_views_javascripts.each do |view|
          filename = "#{view}.js.haml"
          destination = filename.gsub('#{table_name}', table_name)
          template "#{view}.js.haml", File.join("app/views", controller_file_path, destination)
        end
      end

      hook_for :form_builder, :as => :scaffold

      def copy_form_file
        if options[:form_builder].nil?
          filename = filename_with_extensions("_form")
          template "_form.html.haml", File.join("app/views", controller_file_path, filename)
        end
      end
      
      def copy_localization
        # localize the default locale
        localize
        
        # english localization file
        if I18n.default_locale != :en
          I18n.locale = :en
          localize
          I18n.locale = I18n.default_locale 
        end
      end
      
    protected

      def available_views
        %w(index edit show new _#{table_name} _remote_form)
      end

      def available_views_javascripts
        %w(index edit update new create)
      end

      def handler
        :haml
      end

      def localize
        # transalte model name
        @sing_localized_name = translate(singular_table_name)
        @plu_localized_name = translate(table_name)
        
        @indefinite_sing_localized_name = translate(singular_table_name, {:definite => false})
        @indefinite_plu_localized_name = translate(table_name, {:definite => false})
        
        # translate attributes
        @translated_attributes = attributes.inject({}) do |memo, attribute|
          memo[attribute.name] = translate(attribute.name)
          memo
        end
        
        filename = "#{singular_table_name}.#{I18n.locale}.yml"
        template "localization.yml", File.join("config/locales/models/#{I18n.locale}", filename)
      end
      
      def translate(word, options={})
        word = word.titleize unless I18n.locale == :ar 
        return word if I18n.locale == :en
        
        # definite is by default for arabic
        if I18n.locale == :ar && options[:definite].nil?
          options[:definite] = true
        end
        
        localized_name = word.gsub("_", " ")
        
        require 'rubygems'
        require 'bing_translator'
        translator = BingTranslator.new 'A3129A3FF3AF2F41692E7D7BC4E18142435D18FA'
        localized_name = translator.translate localized_name, :from => 'en', :to => I18n.locale.to_s

        the = I18n.translate("the")
        if options[:definite] && !localized_name.starts_with?(the)
          localized_name = the + localized_name
        elsif !options[:definite] && localized_name.starts_with?(the)
          localized_name = localized_name[2..-1]
        end
        
        localized_name
      end
      
    end
  end
end

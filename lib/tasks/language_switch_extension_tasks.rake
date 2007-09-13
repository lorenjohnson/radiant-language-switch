namespace :radiant do
  namespace :extensions do
    namespace :language_switch do
      
      desc "Runs the migration of the Language Switch extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          LanguageSwitchExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          LanguageSwitchExtension.migrator.migrate
        end
      end
    
    end
  end
end
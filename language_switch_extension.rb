require File.dirname(__FILE__) + '/lib/language_switching.rb'

class LanguageSwitchExtension < Radiant::Extension
  version "1.0"
  description "Language switing tags and Page.process overrides to allow for inline language switching."
  url "http://www.hellovenado.com/radiant"
  
  def activate
    Page.send :remove_method, :process
    Page.send :remove_method, :cache?
    Page.send :include, LanguageSwitching
    Page.send :include, LanguageTags
  end
  
  def deactivate
  end
  
end
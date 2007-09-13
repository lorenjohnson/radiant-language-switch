require File.dirname(__FILE__) + '/../test_helper'

class LanguageSwitchExtensionTest < Test::Unit::TestCase
  
  # Replace this with your real tests.
  def test_this_extension
    flunk
  end
  
  def test_initialization
    assert_equal File.join(File.expand_path(RAILS_ROOT), 'vendor', 'extensions', 'language_switch'), LanguageSwitchExtension.root
    assert_equal 'Language Switch', LanguageSwitchExtension.extension_name
  end
  
end

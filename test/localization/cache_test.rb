require File.dirname(__FILE__) + '/../test_helper.rb'

class CacheTest < Test::Unit::TestCase
  
  def test_object_level_methods
    assert self.respond_to?(:l10n_formatter)
    assert self.respond_to?(:l10n_translator)
  end
  
  def test_translator_is_cached
    translator = l10n_translator
    
    assert !Mack::Localization::Cache.get("translator").nil?  
    assert Mack::Localization::Cache.get("translator") == translator
    assert Mack::Localization::Cache.translator == translator
  end
  
  def test_formatter_is_cached
    formatter = l10n_formatter
    
    assert !Mack::Localization::Cache.get("formatter").nil?  
    assert Mack::Localization::Cache.get("formatter") == formatter
    assert Mack::Localization::Cache.formatter == formatter
  end
  
end
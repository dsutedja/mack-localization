module Mack
  module Localization
    class Cache < Cachetastic::Caches::Base
      def self.translator
        translator = get("translator")
        translator = Mack::Localization::Translator.new if translator.nil?
        set("translator", translator)
        return translator
      end
        
      def self.formatter
        formatter = get("formatter")
        formatter = Mack::Localization::Formatter.new if formatter.nil?
        set("formatter", formatter)
        return formatter
      end
    end
  end
end

class Object
  def l10n_formatter
    Mack::Localization::Cache.formatter
  end
  
  def l10n_translator
    Mack::Localization::Cache.translator
  end
end
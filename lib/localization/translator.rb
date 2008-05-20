module Mack
  module Localization
    class Translator            
      def gets(view_sym, key, lang)
        view_name = view_sym.to_s
        base_lang = l10n_config.base_language
        base_lang = lang.to_s if !lang.nil?
        
        raise UnsupportedLanguage.new(base_lang) if !l10n_config.supported_languages.include?(base_lang)
        
        cache_key = "#{view_sym}_#{base_lang}_content"
        path      = File.join(l10n_config.base_directory, "views", "#{view_name}", "content_#{base_lang}.rb")
        puts path
        content_hash = load_content_hash(cache_key, base_lang, path)
      
        raise UnknownStringKey.new(key) if content_hash[key] == nil
        return content_hash[key]
      end
      
      def getimg(view_sym, key, lang)
        raise UnsupportedFeature.new("getimg")
      end
      
      # REVIEW: inflection... should localized inflection use the same inflection engine as the english counterpart?
      def pluralize(key, lang, num)
        return inflect(key, lang, num, :plural)
      end
      
      def irregular(key, lang, num)
        return inflect(key, lang, num, :irregular)
      end
    
      private
      
      def inflect(key, lang, num, type)
        base_lang = l10n_config.base_language
        base_lang = lang if !lang.nil?
        
        raise UnsupportedLanguage.new(base_lang) if !l10n_config.supported_languages.include?(base_lang)
        
        cache_key = "rules_content_#{base_lang}"
        path      = File.join(l10n_config.base_directory, "rules", "inflection_#{base_lang}.rb")
        content_hash = load_content_hash(cache_key, base_lang, path)
        
        hash = content_hash[type]
        raise InvalidConfiguration.new if hash.nil?
        
        arr = hash[key]
        raise InvalidConfiguration.new if arr.nil?
        raise InvalidConfiguration.new if arr.size != 2
        
        if num <= 1
          val = sprintf(arr[0], num)
        else
          val = sprintf(arr[1], num)
        end
        
        return val
      end
            
      private 
      
      def load_content_hash(cache_key, base_lang, path)
        content_hash = l10n_config.send("#{cache_key}")
        
        if content_hash.nil?
          raise InvalidConfiguration.new if base_lang.nil?
          raise LanguageFileNotFound.new if !File.exists?(path)
          
          data = File.read(path)
          # IO.foreach(path) do |line|
          #   data += (line + "\n")
          # end
          content_hash = eval data
          l10n_config.set("#{cache_key}", content_hash, l10n_config.content_expiry)
        end
        
        return content_hash
      end
      
    end
  end
end
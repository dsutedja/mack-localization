module Mack
  module Localization
    class NumberAndCurrencyFormat
      
      include Singleton
      
      def initialize
        @syms = {
          :bp => {:unit => "R$", :delimiter => ",", :separator => "."},
          :en => {:unit => "$", :delimiter => ",", :separator => "."},
          :fr => {:unit => "€", :delimiter => " ", :separator => ","},
          :it => {:unit => "€", :delimiter => ".", :separator => ","},
          :de => {:unit => "€", :delimiter => ".", :separator => ","},
          :es => {:unit => "€", :delimiter => ".", :separator => ","}
        }
      end
      
      def format_currency(num, lang)
        sym_hash  = @syms[lang.to_sym]
        unit      = sym_hash[:unit]
        currency = "#{unit}#{format_number(num, lang)}"
        return currency
      end
      
      def format_number(num, lang)
        sym_hash  = @syms[lang.to_sym]
        unit      = sym_hash[:unit]
        delimiter = sym_hash[:delimiter]
        separator = sym_hash[:separator]
        
        num_str = "%01.2f" % num
        parts = num_str.split(".")
        parts[0].gsub!(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1#{delimiter}")
        parts.join separator
      end
      
    end
  end
end

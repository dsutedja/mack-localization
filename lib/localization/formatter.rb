module Mack
  module Localization
    class Formatter
                
      def date_format(time, type, lang)
        return Mack::Localization::DateFormat.instance.format(time, type, lang)
      end
      
      def number_format(num, lang)
        Mack::Localization::NumberAndCurrencyFormat.instance.format_number(num, lang)
      end
      
      def currency_format(num, lang)
        Mack::Localization::NumberAndCurrencyFormat.instance.format_currency(num, lang)
      end
    end
  end
end

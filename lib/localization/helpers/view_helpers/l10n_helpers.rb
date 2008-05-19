module Mack
  module ViewHelpers
    module L10NHelpers
      
      def l10n_gets(view_sym, key, lang)
        return l10n_translator.gets(view_sym, key, lang)
      end
      
      def l10n_getimg(view_sym, key, lang)
        return l10n_translator.getimg(view_sym, key, lang)
      end
      
      def l10n_date(time, type, lang)
        return l10n_formatter.date_format(time, type, lang)
      end
      
      def l10n_number(num, lang)
        return l10n_formatter.number_format(num, lang)
      end
      
      def l10n_currency(amount, lang)
        return l10n_formatter.currency_format(amount, lang)
      end
      
    end
  end
end

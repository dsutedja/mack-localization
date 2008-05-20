#
# Date formatter for the Mack L10N.
# It currently support 5 languages (BP, EN, FR, IT, DE, ES).
# This class should not be access directly from the application, instead please use
# the l10n_formatter method that's given when Mack L10N is present.
#
# TODO: make it extensible so that developers can easily plug in their own date formatter
#
module Mack
  module Localization
    class DateFormat
      
      include Singleton
      
      def initialize
        init_templates
      end
      
      #
      # Format the date of the given time instance using
      # the template defined in the specified language.
      # The type parameter is to define what type of formatting 
      # is desired (:short, :medium, or :long).
      #
      # In :short format, the date will be formatted as follow:
      #    mm/dd/yyyy or 12/01/2008 in English
      # In :medium format, the date will be formatted as follow:
      #    DD, MM dd, yyyy or Tue, Dec 12, 2008 in English
      # In :long format, the date will be formatted as follow:
      #    DD, MM dd, yyyy or Tuesday, December 12, 2008 in English
      #
      def format(time, type, lang)
        day          = time.day
        day_of_week  = time.wday
        day_of_month = time.mday
        month        = time.month
        year         = time.year
        
        hash = @settings[lang.to_sym]
        template = hash["df_#{type}".to_sym].dup
        puts template
        template.gsub!("mm", "%02d" % month.to_s)
        
        type = :short if type == :medium
        template.gsub!("MM", hash["month_#{type}".to_sym][month-1])
        template.gsub!("dd", "%02d" % day.to_s)
        template.gsub!("yyyy", year.to_s)
        template.gsub!("DD", hash["dow_#{type}".to_sym][day_of_week-1])
        
        return template
      end
      
      private 
      
      def init_templates
        @settings = {
          :en => {
            :dow_short   => %w{Mon Tue wed Thu Fri Sat Sun},
            :dow_long    => %w{Monday Tuesday Wednesday Thursday Friday Saturday Sunday},
            :month_short => %w{Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec},
            :month_long  => %w{January February March April May June July August September October November December},
            :df_short    => "mm/dd/yyyy",
            :df_medium   => "DD, MM dd, yyyy",
            :df_long     => "DD, MM dd, yyyy"
          },
          :bp => {
            :dow_short   => %w{Seg Ter Qua Qui Sex Sáb Dom},
            :dow_long    => %w{Segunda Terça Quarta Quinta Sexta Sábado Domingo},
            :month_short => %w{Jan Fev Mar Abr Mai Jun Jul Ago Set Out Nov Dez},
            :month_long  => %w{Janeiro Fevereiro Março Abril Maio Junho Julho Agosto Setembro Outubro Novembro Dezembro},
            :df_short    => "dd/mm/yyyy",
            :df_medium   => "DD, dd MM, yyyy",
            :df_long     => "DD, dd MM, yyyy"
          },
          :de => {
            :dow_short   => %w{Mon Die Mit Don Fre Sam Son},
            :dow_long    => %w{Montag Dienstag Mittwoch Donnerstag Freitag Samstag Sonntag},
            :month_short => %w{Jan Feb Mär Apr Mai Jun Jul Aug Sep Okt Nov Dez},
            :month_long  => %w{Januar Februar März April Mai Juni Juli August September Oktober November Dezember},
            :df_short    => "dd/mm/yyyy",
            :df_medium   => "DD, dd MM, yyyy",
            :df_long     => "DD, dd MM, yyyy"
          },
          :it => {
            :dow_short   => %w{Lun Mar Mer Gio Ven Sab Dom},
            :dow_long    => %w{Lunedi Martedì Mercoledì Giovedi Venerdì Sabato Domenica},
            :month_short => %w{Gen Feb Mar Apr Mag Giu Lug Ago Set Ott Nov Dic},
            :month_long  => %w{Gennaio Febbraio Marzo Aprile Maggio Giugno Luglio Agosto Settembre Ottobre Novembre Dicembre},
            :df_short    => "dd/mm/yyyy",
            :df_medium   => "DD, dd MM, yyyy",
            :df_long     => "DD, dd MM, yyyy"
          },
          :fr => {
            :dow_short   => %w{Lun Mar Mer Jeu Ven Sam Dim},
            :dow_long    => %w{Lundi Mardi Mercredi Jeudi vendredi samedi dimanche},
            :month_short => %w{Jan Fév Mar Avr Mai Jun Jui Aoû Sep Oct Nov Dec},
            :month_long  => %w{Janvier Février Mars Avril Mai Juin Juillet Août Septembre Octobre Novembre Décembre},
            :df_short    => "dd/mm/yyyy",
            :df_medium   => "DD, dd MM, yyyy",
            :df_long     => "DD, dd MM, yyyy"
          },
          :es => {
            :dow_short   => %w{Lun Mar Mié Jue Vie Sáb Dom},
            :dow_long    => %w{Lunes Martes Mi\303\251rcoles Jueves Viernes S\303\241bado Domingo},
            :month_short => %w{Ene Feb Mar Abr May Jun Jul Ago Sep Oct Nov Dic},
            :month_long  => %w{Enero Febrero Marzo Abril Mayo Junio Julio Agosto Septiembre Octubre Noviembre Diciembre},
            :df_short    => "dd/mm/yyyy",
            :df_medium   => "DD, dd MM, yyyy",
            :df_long     => "DD, dd MM, yyyy"
          }
        }
      end
      
    end
  end
end

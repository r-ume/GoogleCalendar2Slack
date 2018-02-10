module Util
  class ArrayHandler
    CURRENT_DATETIME  = DateTime.now
    TOMORROW_DATETIME = CURRENT_DATETIME + 1

    class << self
      def remove_no_start_time_elements(array)
        array.delete_if{ |element| element[:start_time].nil? }
      end

      def select_tomorrow_elements(array)
        array.select{ |element| element[:start_time].between?(CURRENT_DATETIME, TOMORROW_DATETIME) }
              .map{ |element|
                {
                  calendar_name: element[:calendar_name],
                  start_time:    element[:start_time].strftime("%Y-%m-%d %H:%M")
                }
              }
      end
    end
  end
end

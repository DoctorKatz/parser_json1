require 'json'
#AZSBrands_errors_7042301.json

class AnalysisError

  def initialize(file_name, search)
    @@file = File.read(file_name)
    @search = search
  end

  def self.data_from_json
    #@event_ids = hash.new
    @error_hash = JSON.parse(@@file)

    @error_hash.each do |key, val|
      if key == "ImportInfo"
        import_date = val
        import_date.each do |key, val|
          if key == "EmisEventID"
            event_id = val
            puts(event_id)
          end
        end
      end
      if key == "ErrorItems"
        error_items = val
        puts(error_items)
        error_items.each do |key, val|
          puts(key)
          case key
          when "Item"
            puts(val)
          when "Errors"
            puts(val)
          end
        end
      end
    end
  end
end

puts("Hello")
file_name = "AZSBrands_errors_7042301.json"

AnalysisError.new(file_name, 0)
AnalysisError.data_from_json
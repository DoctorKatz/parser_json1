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
    @items = 0
    @errors = 0

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
          item = key
          item.each do |key, val| #возможно неправильно собран json или у меня кривые руки
            i, j = 0
            case key
            when "Item"
              @items = val
              i += 1
              puts(items)
            when "Errors"
              @errors = val
              j += 1
              puts(errors)
            end
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
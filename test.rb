#!/bin/env ruby
# encoding: utf-8
require 'json'
#AZSBrands_errors_7042301.json

class AnalysisError

  def initialize(file_name, search)
    @@file = File.read(file_name)
    @search = search
  end

  def self.create_struct_data(event_id, import_date, azs_brand_id, azs_brand_name, modificator_id, message)
    #собрать структуру из данных
    #@data_hash = ["event_id" => event_id, "import_date" => import_date, "azs_brand_id" => azs_brand_id,"azs_brand_name" => azs_brand_name, "modificator_id" => modificator_id, "message" => message]

  end

  def data_from_json
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
            @@data_hash = ["event_id" => event_id]
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
              @items = JSON.parse(val) #parse JS-array in JSON
              puts(@items)
            when "Errors"
              @errors = val
              puts(@errors)
            end
          end
        end
      end
    end
    AnalysisError.create_struct_data(event_id, )
  end


end

puts("Hello")
file_name = "AZSBrands_errors_7042301.json"

temp = AnalysisError.new(file_name, 0)
temp.data_from_json
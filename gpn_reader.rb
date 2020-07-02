# AZSBrands_errors_7042301.json

require 'json'
require_relative 'data_struct.rb'

class ReadGpnError
  attr_accessor :file, :json_hash
  attr_accessor :data_list # EmisID -> [Brand Name, Brand ID, Modificator ID  ... ] -> [Messages ... ]

  def initialize(file_name)
    @file = File.read(file_name)
    @json_hash = JSON.parse(@file)
  end

  def pars_hash_to_list
    @json_hash.each do |key_hash, val_hash|
      if key_hash == 'ImportInfo'
        val_hash.each do |key_ev_id, val_ev_id|
          if key_ev_id == 'EmisEventID'
            @data_list = LinkedList.new(val_ev_id) # add EventID in the list
          end
        end
      end

      if key_hash == 'ErrorItems'
        val_hash.each do |key_items, val_items| #val_items in json = nil, maybe JSON is wrong or I have crooked hands
          key_items.each do |key_items_2, val_items_2|

            case key_items_2
            when 'Item'
              ReadGpnError.write_items_in_list(JSON.parse(val_items_2), data_list) # parse JS-array in JSON
            when 'Errors' # Error messages hasn't got JS or JSON format. It's simple array
              ReadGpnError.write_error_message_in_list(val_items_2, data_list)
            else
              puts('Error in file') # TODO: use error handler
            end

          end
        end
      end
    end
  end

  def self.write_error_message_in_list(errors, data_list)
    temp = errors.to_s

    while temp.include? 'Message'
      pos_start = temp.index('{')
      pos = temp.index('Message')
      temp.slice!(pos_start..pos + 10)
      pos = temp.index('}')
      temp.slice!(pos)
    end

    data_list.addition(temp)
  end

  def self.write_items_in_list(items, data_list)
    temp = " " # write a check for nil

    items.each do |key, val|
      case key
      when 'AZSBrandID'
        temp = key.to_s + ':' + val.to_s + ', '
      when 'AZSBrandName'
        temp <<  key.to_s + ':' + val.to_s + ', '
      when 'ModificatorID'
        temp <<  key.to_s + ':' + val.to_s
      end
    end

    data_list.addition(temp) # if temp != nil create error handler for empty items

  end
end

class AnalysGnpErrors < ReadGpnError
  attr_accessor :quantity_errors, :find_type

  def self.get_quantity_errors(list)
    @quantity_errors = (list.length - 1) / 2
  end

end

# file_name = "JSON_errors/AZSBrands_errors_7042301.json"
# file_name = "JSON_errors/vAZSsCompetitors_errors_7042302.json"

file_name = 'JSON_errors/LawSubjects_errors_7037790.json'

temp = ReadGpnError.new(file_name)
temp.pars_hash_to_list
temp.data_list.print_list

puts (AnalysGnpErrors.get_quantity_errors(temp.data_list))
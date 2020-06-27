#require 'json'

puts "Hello world"
putc(1)
class AnalysisJSON
  def initialize(file_name, search)
    @file = File.read(file_name)
    @search = search
    putc(1)
  end

  def _get_data_from_json
    @event_ids = Array.new

    file_in_hash = JSON.parse(file)
    file_in_hash.each_value { |value| puts value }

    #for count in file_in_hash do
    # @event_ids = file_in_hash.value{'EmisEventID'}
    # @count = count
    #end
  end
end
file_name = ARGV
kaka1 = AnalysisJSON.new(file_name, 0)
putc(1)
#puts kaka1.filee




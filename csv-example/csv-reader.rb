require 'csv'

FILE_NAME = 'bitcoin.csv'
data = CSV.read(FILE_NAME, headers:true)
data.each do |d|
    puts "Date: #{d['date']}, conversion: #{d['price'].to_f+1}"
end
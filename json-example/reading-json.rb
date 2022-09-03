require 'json'
require 'date'

def extract_data(content)
    data = JSON.parse(content)
    id = data['id']
    first_name = data['firstName']
    birth_date = Date.parse(data['birthDate']).strftime("%Y-%m-%d")
    return { id: id, birth_date: birth_date}
end

FILE_NAME = 'sample.json'

content = File.read(FILE_NAME)

data = extract_data(content)
puts data
puts "ID #{data[:id]}"
puts "ID #{data[:birth_date]}"

require 'json'

hash = {
    id: 1,
    firstName: 'Leia',
    lastName: 'Organa'
}

content = hash.to_json
pretty_content = JSON.pretty_generate(hash)
data = JSON.parse(content)

puts "ID #{data['firstName']}"
puts pretty_content

File.write("test.json", pretty_content)
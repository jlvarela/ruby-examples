require 'json'
data = {
    records: []
}

1000000.times do |idx|
    data[:records] << {id: idx+1}
end

content = JSON.pretty_generate(data)

File.write('large.json', content)
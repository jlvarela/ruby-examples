file_name = 'writting_sample_file.txt'
content = 'This is an example'
File.open(file_name, mode:'a') do |file|
    file.write(content+"\n")
end
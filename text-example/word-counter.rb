FILE_NAME = "romeo-juliet.txt"
COMPARE_FILE_NAME = "hamlet.txt"

def words_from_file(text_file)
    begin
        File.read(text_file).downcase.gsub(/[^A-Za-z]/, " ").split
    rescue
        puts "Archivo #{FILE_NAME} no encontrado"
        exit
    end
end
words = words_from_file(FILE_NAME)
words_compare = words_from_file(COMPARE_FILE_NAME).uniq

words_compare.each do |to_remove|
    words.delete to_remove
end

WORD_COUNT = {}

words.each do |word|
    WORD_COUNT[word] = 0 unless WORD_COUNT[word]
    WORD_COUNT[word] += 1
end

WORD_COUNT.sort_by {|word, count| count}
          .reverse[0...40]
          .each {|word, count| puts "#{word}: #{count}"};
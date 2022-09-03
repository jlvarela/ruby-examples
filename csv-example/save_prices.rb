require 'csv'

FILE_NAME = 'prices.csv'

dataset = (1..50).map {|number| [number, number*number*100]}
CSV.open(FILE_NAME, "w") { |f|
    f << ['id', 'price']
    dataset.each { |data|
        f << data
    }
}
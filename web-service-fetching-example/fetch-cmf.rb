require 'net/http'
require 'json'
require 'date'

API_KEY_FILE_NAME='cmf.key'
URI_CMF = 'https://api.cmfchile.cl/api-sbifv3/recursos_api/'

def get_api_key(file_name)
    return File.read(file_name)
end

def fetch_currency(uri, currency_code, date)
    response = Net::HTTP.get_response(uri)
    if (response.code == '200' && response.content_type.include?('json'))
        json_result = JSON.parse(response.body)
        parse_json(currency_code, date, json_result)
    else
        raise "There was an error with the request: STATUS: #{response.code}; CONTENT_TYPE: #{response.content_type}; BODY: #{response.body}";
    end
end

def parse_json(currency_code, date, json_result)
    if (currency_code.downcase == 'uf')
        results = json_result['UFs']
        get_exchange_value(results, date);
    elsif (currency_code.downcase == 'usd' || currency_code.downcase == 'dolar')
        results = json_result['Dolares']
        get_exchange_value(results, date)
    else
        raise 'Not a valid currency'
    end
end

def get_exchange_value(results, date)
    results.each do |result|
        if (result['Fecha'] == date)
            return result['Valor']
        end
    end
    return nil
end

def format_date(date)
    date.strftime("%Y-%m-%d")
end

api_key = get_api_key(API_KEY_FILE_NAME)
currency = ARGV && ARGV.size > 0 ? ARGV[0] : 'uf'
params = {apikey: api_key, formato: 'json'}
now_date = ARGV && ARGV.size > 1 ? Date.parse(ARGV[1]) : Date.today
uri = URI("#{URI_CMF}#{currency}/#{now_date.year}/#{now_date.month}/dias/#{now_date.day}")
uri.query = URI.encode_www_form(params)
#puts "#{uri}"
exchange_value = fetch_currency(uri, currency, format_date(now_date))
puts "#{exchange_value.delete('.').gsub(',', '.').to_f}"
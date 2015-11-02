# encoding: UTF-8
require 'cgi'
require 'nokogiri'
require 'open_uri_redirections'
require 'open-uri'
require 'rubygems'

class MarketYandex

  SEARCH_URL = 'http://market.yandex.ru/search.xml?cvredirect=1&text='

  #### ПОИСК ТОВАРОВ

  # Поиск товара по ключевому слову
  def self.search(product_name)
    doc = product "#{SEARCH_URL}#{CGI.escape(product_name)}"
    parse_offers_list(doc)
  end

  def self.get_content(url)
    #use_proxy
    begin
      data = open(url, "User-Agent" => "Ruby/#{RUBY_VERSION}",
      "From" => "foo@bar.invalid",
      "Referer" => "http://www.ruby-lang.org/",
      :allow_redirections => :safe)
      #:proxy => "http://#{proxy_list}")
      data = Nokogiri::HTML(data)
    if !data.to_s.include? 'product-offers-list' # иногда может возвращаться бесполезная информация
      puts data
      puts "<=== получил не нужную информацию! пробую еще! ===>"
      get_content(url)
    end
    rescue
      puts "<=== не могу получить информацию! пробую еще! ===>"
      get_content(url)
    end
    return data
  end

  # по урлу ищет товар
  def self.product(url)
    puts "parsing product: #{url.inspect}"
    doc = get_content(url)
  end

  def self.use_proxy
    ENV['http_proxy'] = "http://#{proxy_list}"
    puts "using proxy = #{ENV['http_proxy']}"
  end

  def self.proxy_list
    # http://hidemyass.com/proxy-list/
    list = %w{ 205.134.177.18:80
               222.88.236.236:81
               185.28.193.95:8080
               218.200.66.201:80
               192.240.46.123:80
               158.69.146.5:80
               14.32.22.125:80 }
    res = list[rand(list.size)]
  end

  #### ИЗВЛЕЧЕНИЕ ДАННЫХ СО СТРАНИЦЫ ТОВАРА О ПРЕДЛОЖЕНИЯХ ОТ ДРУГИХ МАГАЗИНОВ

  # парсилка предложений со страницы товара
  def self.parse_offers_list(doc)
    i = 0
    offers = []
    doc.css('.product-offer').each do
      price = doc.css('.product-offer__item_type_price')[i].text.gsub(/[руб.]/, '').gsub(/\u2009/, '').to_i
      shop  = doc.css('.product-offer__item_type_shop')[i].text
      url   = doc.css('.product-offer__item_type_shop a')[i]['href']
      offers << "#{price}.....#{shop}.....https:#{url}"
      i += 1
    end
    return offers
  end

end

#pr=MarketYandex.search('DELL U2412M')

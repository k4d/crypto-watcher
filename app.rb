# app.rb
require 'httparty'
require 'json'
require 'colorize'
require 'rufus-scheduler'

# Класс для получения текущих цен на криптовалюты и объемов торговли с использованием API CoinGecko
class CoinPriceFetcher
	include HTTParty
	base_uri 'https://api.coingecko.com/api/v3'

	DEFAULT_CURRENCY = 'usd'.freeze

	# Инициализация класса
	def initialize
	end

	# Получение списка криптовалют и получение текущей цены по id
	def fetch_price(ids, vs_currencies = DEFAULT_CURRENCY)
		ids = ids.join(",") if ids.is_a?(Array)
		response = self.class.get("/simple/price", query: { ids: ids, vs_currencies: vs_currencies })

		if response.success?
			data = JSON.parse(response.body)
			data || nil
		else
			puts "Ошибка при получении цены: #{response.code}".colorize(:red)
			nil
		end
	end

	# Выводит текущую цену криптовалюты в консоль
	def get_price(ids, vs_currencies = DEFAULT_CURRENCY)
		prices = fetch_price(ids, vs_currencies)

		if prices
			prices.each do |id, data|
				if data && data.key?(vs_currencies)
					formatted_data = format_price(data[vs_currencies])
					puts "Цена #{id.capitalize}: #{formatted_data} #{vs_currencies.upcase}".colorize(:green)
				else
					puts "Ошибка при получении цены #{id}".colorize(:red)
				end
			end
		else
			puts "Ошибка API при запросе цены для #{ids}".colorize(:red)
		end
	end

	private

	# Форматирует цену для красивого отображения
	def format_price(price)
		case price
		when 0...0.00001
			sprintf('%.8f', price)
		when 0...1
			sprintf('%.5f', price)
		when 1...10
			sprintf('%.3f', price)
		else
			price.to_s
		end
	end
end

# TaskStats
module TaskStats
	class << self
		attr_accessor :counter
	end
	self.counter = 0
end

# Основная задача
def run_task
	TaskStats.counter += 1
	current_time = Time.now.strftime("%Y-%m-%d %H:%M:%S")
	puts "Задача запущена #{TaskStats.counter} раз(а) в #{current_time}.".colorize(:gray)

	# Создаем экземпляр класса CoinPriceFetcher
	coins_price = CoinPriceFetcher.new
	# Получаем текущую цену Coins list
	coins_list = ['bitcoin', 'ethereum', 'the-open-network', 'zilliqa']
	coins_price.get_price(coins_list)
end

if $PROGRAM_NAME == __FILE__
	scheduler = Rufus::Scheduler.new

	# Первый запуск задачи
	run_task

	# Запуск задачи каждые 30 секунд
	scheduler.every('30s') do
		run_task
	end

	# Запуск планировщика
	scheduler.join
end

# Guardfile
guard :shell do
  watch(%r{.+\.rb$}) do |m|
    puts "🔁 Форматируем файл: #{m[0]}"
    system("rufo #{m[0]}")
  end
end

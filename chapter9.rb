require 'date'
# 例外処理
# 9.2
puts 'Start'
module Greeter
  def hello
    'hello'
  end
end
# 例外処理を組み込んで例外に対処する
begin
  # 例外が起きうる処理
  greeter = Greeter.new
rescue => e
  # 例外が発生した場合の処理
  puts "エラークラス: #{e.class}"
  puts "エラーメッセージ: #{e.message}"
  puts "バックトレース -----"
  puts e.backtrace
  puts "-----"
  # 例外処理を組み込んだので、最後まで実行可能
  puts 'End.'
end

begin
  'abc'.foo
rescue ZeroDivisionError
  puts "0で除算しました"
rescue NoMethodError
  puts "存在しないメソッドが呼び出されました"
end
#=> 存在しないメソッドが呼び出されました
begin
  'abc'.foo
rescue ZeroDivisionError, NoMethodError => e
  puts "0で除算したか、存在しないメソッドが呼び出されました"
  puts "エラー: #{e.class} #{e.message}"
end
#=> 0で除算したか、存在しないメソッドが呼び出されました
# エラー: NoMethodError undefined method `foo' for "abc":String
def currency_of(country)
  case country
  when :japan
    'yen'
  when :us
    'dollar'
  when :india
    'rupee'
  else
    # RuntimeErrorではなく、ArgumentErrorを発生させる
    raise ArgumentError, "無効な国名です。#{country}"
  end
end
currency_of(:japan) #=> ArgumentError: 無効な国名です。italy
# 9.4 例外処理のベストプラクティス
# 平成表記をDateクラスに直す
def convert_heisei_to_date(heisei_text)
  m = heisei_text.match(/平成(?<jp_year>\d+)年(?<month>\d+)月(?<day>\d+)日/)
  year = m[:jp_year].to_i + 1988
  month = m[:month].to_i
  day = m[:day].to_i
  # 例外処理の範囲を狭め、捕捉する例外クラスを限定する
  begin
    Date.new(year, month, day)
  rescue ArgumentError
    # 無効な日付であればnilを返す
    nil
  end
end
convert_heisei_to_date('平成28年12月31日') #=> #<Date: 2016-12-31 ((2457754j...
convert_heisei_to_date('平成28年99月99日') #=> nil
# rescue を修飾子として使う
def to_date(string)
  Date.parse(string) rescue nil
end
to_date('2017-01-01') #=> #<Date: 2017-01-01 ((2457755j,0s,0n),+0s,2299161j)>
to_date('abcdef') #=> nil
# rescue した例外を再度発生させる（情報をログに残したりメールで送信する時などに使う）
def fizz_buzz(n)
  if n % 15 == 0
  'Fizz Buzz'
  elsif n % 3 == 0
  'Fizz'
  elsif n % 5 == 0
  'Buzz'
  else
  n.to_s
  end
rescue => e
  # 発生した例外をログやメールに残す(ここはputsで代用)
  puts "[LOG] エラーが発生しました: #{e.class} #{e.message}"
  # 捕捉した例外を再度発生させ、プログラム自体は異常終了させる
  raise
end
fizz_buzz(15)
#=> [LOG] エラーが発生しました: NoMethodError undefined method `%' for nil:NilClass
# NoMethodError: undefined method `%' for nil:NilClass

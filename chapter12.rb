# CSV
require 'csv'
# CSVファイルの出力
CSV.open('./lib/sample.csv', 'w') do |csv|
# ヘッダ行を出力する
csv << ['Name', 'Email', 'Age']
# 明細行を出力する
csv << ['Alice', 'alice@example.com', 20]
end
# タブ区切りのCSV(TSV)ファイルを読み込む
# CSV.foreach('./lib/sample.tsv', col_sep: "\t") do |row|
# # 各行について、1列目から3列目の値をターミナルに表示する
# puts "1: #{row[0]}, 2: #{row[1]}, 3: #{row[2]}"
# end

# json
# jsonライブラリをrequireすると配列やハッシュでto_jsonメソッドが使えるようになる
require 'json'
user = { name: 'Alice', email: 'alice@example.com', age: 20 }
# ハッシュをJSON形式の文字列に変換する(Rubyのハッシュに似ているがこれはJSON形式)
user_json = user.to_json
puts user_json #=> {"name":"Alice","email":"alice@example.com","age":20}

# YAML
require 'yaml'
# YAML形式のテキストデータを用意する
yaml = <<TEXT
alice:
name: 'Alice'
email: 'alice@example.com'
age: 20
TEXT
# YAMLテキストをパースしてハッシュに変換する
# users = YAML.load(yaml)
#=> {"alice"=>{"name"=>"Alice", "email"=>"alice@example.com", "age"=>20}}
# ハッシュに新しい要素を追加する
# users['alice']['gender'] = :female
# # ハッシュからYAMLテキストに変換する
# puts YAML.dump(users)
#=> ---
# alice:
# name: Alice
# email: alice@example.com
# age: 20
# gender: :female
# 12.6
# eval メソッド　文字列としてコードを受け取り実行する
# 文字列としてRubyのコードを記述する
code = '[1, 2, 3].map { |n| n * 10 }'
# evalメソッドに渡すと、文字列がRubyのコードとして実行される
eval(code) #=> [10, 20, 30]
# バッククオートリテラル　バッククォートで囲まれた文字列をOSコマンドとして実行する
# OSのcatコマンドでテキストファイルの中身を表示する
puts `cat lib/fizz_buzz.rb`
#=> def fizz_buzz(n)
# if n % 15 == 0
# 'Fizz Buzz'
# 以下省略
# バッククオートの代わりに％ｘを使うこともできる
puts %x{cat lib/fizz_buzz.rb}
# sendメソッド　レシーバに対して指定した文字列(またはシンボル)のメソッドを実行
str = 'a,b,c'
# str.upcaseを呼ぶのと同じ
str.send('upcase') #=> "A,B,C"
# str.split(',')を呼ぶのと同じ
str.send('split', ',') #=> ["a", "b", "c"]

# DSLとは“Domain Specific Language”の略で、「ドメイン固有言語」(または「ドメイン特化言語」)と訳される
# 「何か特別な目的を実現するために定義された、人間(=非技術者)にとって読みやすく、機械にとっても処理しやすいテキストファイルの記述ルール」

# Gemfile
# 1.7.2に固定
gem 'faker', '1.7.2'
# 1.7.2以上(上は制限なし)
gem 'faker', '>= 1.7.2'
# 1.7.2以上かつ1.8未満(1.7.11などは良いが、1.8.0はNG)
gem 'faker', '̃> 1.7.2'
# 1.7以上かつ2.0未満(1.9.0などは良いが、2.0.0はNG)
gem 'faker', '̃> 1.7'

# Railsでメソッドの定義場所・ソースコードの場所を確認
# # underscoreメソッドは文字列をスネークケースに変換するメソッド
# 'OrderItem'.underscore #=> "order_item"
# # このメソッドが定義されているのはactivesupport gemのinflections.rbの118行目
# 'OrderItem'.method(:underscore).source_location
# #=> ["/(gemがインストールされているパス)/activesupport-5.0.0/lib/active_support/core_ext/ ュ
# string/inflections.rb", 118]
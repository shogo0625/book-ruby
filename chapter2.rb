# 改行
puts "こんにちは\nこんばんは"
# 文字列内にダブルクォーテーション
puts "He said, \"Don't speak.\""
# Rationalクラスで丸め誤差回避
puts 0.1r * 3.0r
# 後置きif
fee = 1800
day = 'Wednesday'
fee = 1200 if day == 'Wednesday'
puts fee
# メソッドを途中で脱出するためのreturn
def greeting(country)
  # country or return 'countryを入力してね'
  return 'countryを入力してね' if country.nil?
  if country == 'japan'
    'こんにちは'
  else
    'Hello'
  end
end
puts greeting(nil)
puts greeting('japan')
# クラスを呼び出すメソッド
puts 'abc'.class
# シングルクオートと同じ
puts %q!He said, "Don't speak."!
# ダブルクオートと同じ(式展開や改行文字が使える)
puts %Q!He said, "Don't speak."!
greet = 'Bye.'
puts %!He said, "#{greet}"!
# ヒアドキュメント（長い文字列など） 式展開も有効
def some_method
  <<~TEXT
    これはヒアドキュメントです。
    <<~を使うと内部文字列のインデントが無視されます。
  TEXT
end
puts some_method
name = 'Alice'
a = <<TEXT
ようこそ、#{name}さん！
TEXT
puts a
# ヒアドキュメントを直接引数として渡す(prependは渡された文字列を先頭に追加するメソッド)
language = "CSS\nRuby"
language.prepend(<<TEXT)
HTML
TEXT
puts language
# 小数点第3位まで表示させるsprintfメソッド
puts sprintf('%0.3f', 1.2)
# 配列を連結して1つの文字列にするjoinメソッド
puts ['See', 'You', 'Later'].join
# *演算子で文字列を繰り返す
puts 'YAH!' * 7

# case文の戻り値を変数に入れる
lang = 'Japanese'
say_hello =
  case lang
  when 'English'
    'Hello'
  when  'Japanese'
    'こんにちは'
  else
    "???"
  end
puts say_hello
# 条件演算子（シンプルなif文であればこちらに置き換えた方がスッキリするかも？）
n = 11
message = n > 10 ? '10より大きい' : '10以下'
puts message

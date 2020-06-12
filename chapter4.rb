# 配列の最後に要素を追加
a = [1, 2, 3]
a << 4
p a
# 配列内の特定の位置の要素を削除
a.delete_at(3)
p a
# divmodメソッド　商と余りを配列で返す
quo_rem = 10.divmod(3)
puts "商=#{quo_rem[0]}, 余り=#{quo_rem[1]}"
# 多重代入で別々の変数として受け取る
quotient, remainder = 10.divmod(3)
puts "商=#{quotient}, 余り=#{remainder}"
# delete_ifメソッド　配列の要素を順番に取り出し条件に真の値だけ削除
a = [1, 2, 3, 1, 2, 3]
a.delete_if do |n|
  n.odd? # 奇数だけ削除
end
p a
# each文のブロック引数は使わない場合省力化
sum = 0
numbers = [1, 2, 3, 4]
numbers.each do
  sum += 1
end
puts sum
# do...endの代わりに{}も使える　通常は短いブロックを書く時に使う
sum = 0
numbers.each { |n|
  n = n.even? ? n * 10 : n
  sum += n
}
puts sum
# mapメソッド　処理後に新しい値の配列で返す
new_numbers = numbers.map { |n| n * 10 }
p new_numbers
# selectメソッド(エイリアスはfind_all)　処理後の評価が真の値のみで新しい配列を返す
numbers = [1, 2, 3, 4, 5, 6]
even_numbers = numbers.select { |n| n.even? }
p even_numbers
# findメソッド(エイリアスはdetect)　処理後の評価が真の値で最初の要素を返す
even_number = numbers.find { |n| n.even? }
p even_number
# injectメソッド(エイリアスはreduce)
sum = numbers.inject(0) { |result, n| result + n }
p sum
# ブロックを使うメソッドの書き換え
p ['ruby', 'java', 'perl'].map { |s| s.upcase }
p ['ruby', 'java', 'perl'].map(&:upcase)
p [1, 2, 3, 4, 5, 6].select { |n| n.odd? }
p [1, 2, 3, 4, 5, 6].select(&:odd?)
# 範囲オブジェクトを使って、n以上m以下を表現
num = 65
p (0..100).include?(num)
# 範囲オブジェクトにto_aメソッドで配列を作成
p ('a'..'e').to_a
p [*1..5].to_a #splat展開
# stepメソッドで間隔を指定
numbers = []
(1..10).step(2) { |n| numbers << n }
p numbers
# rjustメソッド　桁数を合わせる（第1引数：桁数　第2引数：埋め合わせる文字)
p 0.to_s(16).rjust(2, '0')
# 配列[位置, 取得する長さ]　2つめの要素から3つ分の要素取得
a = [1, 2, 3, 4, 5]
p a[1, 3]
# values_atメソッドで取得したい要素のインデックス番号を複数指定
p a.values_at(0, 2, 4)
# 最後から2番目の要素から2つの要素を取得
p a[-2, 2]
# lastメソッド（firstメソッド） 配列の最後（最初）から（n）個の要素取得 引数なしで最後（最初）の1つだけ
p a.last(2)
p a.first(2)
# pushメソッドで要素を追加　<< と違い複数追加可能
p a.push(6, 7)
# deleteメソッド　指定した値に一致する要素を削除
a.delete(7)
p a
# concatメソッド　配列を連結する→元の配列が変更される
b = [7, 8]
p a.concat(b)
# ＋ で配列を連結する→元の配列は更新せず、新しい配列を作成
b = [9, 10]
p a + b
p a
# 配列の和集合、差集合、積集合
a = [1, 2, 3]
b = [3, 4, 5]
p a | b # 和集合
p a - b # 差集合
p a & b # 積集合
# 多重代入で左辺に＊を付けると余りの要素を配列として受け取る
e, *f = 100, 200, 300
p e, f
# 配列の中に配列を要素として分解してpush　*を付けた引数＝個数に制限のない引数＝可変長引数
p a.push(*b)
# joinメソッドに区切り文字を引数として渡せる
def greeting(*names)
  "#{names.join('と')}、こんにちは！"
end
p greeting('田中さん', '鈴木さん', '佐藤さん')
# []の中に配列を置くと配列の配列になる
a = [1, 2, 3]
p [a]
# *付きで置くと展開されて別々の要素になる
p [*a]
p [*a, 4, 5]
# %w で文字列の配列を作れる
p %w!apple melon orange! # ! で囲む場合
p %w(apple melon orange) # () で囲む場合
p %w(big\ apple small\ melon orange) # 値にスペースを含めたい場合
# 式展開や改行文字(\n)、タブ文字(\t)などを含めたい場合は、%W(大文字のW)を使う
prefix = 'This is'
p %W(#{prefix}\ an\ apple small\nmelon orange)
# charsメソッド　文字列を分解して配列の要素にする
p 'Ruby'.chars
# splitメソッド　引数に渡した区切り文字で文字列を配列に分解
p 'Ruby&Java&Perl&PHP'.split('&')
# Arrayで配列を作る
# 要素が5つで0を初期値とする配列を作成する　第2引数ではなくブロックを使って初期値の作成も可能
a = Array.new(5, 0)
p a #=> [0, 0, 0, 0, 0]
# 4.8
# each_with_index　添字を取得する
fruits = ['apple', 'orange', 'melon']
# ブロック引数のiには0, 1, 2...と要素の添え字が入る　引数に1を渡すことでインデックス番号も1からに
fruits.each.with_index(1) { |fruit, i| puts "#{i}: #{fruit}" }
#=> 1: apple 2: orange 3: melon
# .with_indexメソッドを他のメソッドと組み合わせる
fruits = ['apple', 'orange', 'melon']
# 名前に"a"を含み、なおかつ添え字が奇数である要素を削除する
p fruits.delete_if.with_index { |fruit, i| fruit.include?('a') && i.odd? }
#=> ["apple", "melon"]
# 配列がブロック引数に渡される場合
dimensions = [
  # [縦, 横]
  [10, 20],
  [30, 40],
  [50, 60],
]
# 面積の計算結果を格納する配列
areas = []
# 配列の要素分だけブロック引数を用意すると、各要素の値が別々の変数に格納される
dimensions.each do |length, width|
areas << length * width
end
p areas #=> [200, 1200, 3000]
# ブロック引数を()で囲んで、配列の要素を別々の引数として受け取る
dimensions.each_with_index do |(length, width), i|
  puts "length: #{length}, width: #{width}, i: #{i}"
end
#=> length: 10, width: 20, i: 0
# length: 30, width: 40, i: 1
# length: 50, width: 60, i: 2

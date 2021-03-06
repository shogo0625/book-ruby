# 最初の繰り返し処理ではhexに"#"が入る
# ブロックの中のhex + n.to_s(16).rjust(2, '0')で作成された文字列は、次の繰り返し処理のhexに入る
# 繰り返し処理が最後まで到達したら、ブロックの戻り値がinjectメソッド自身の戻り値になる
def to_hex(r, g, b)
  [r, g, b].inject('#') do |hex, n|
    hex + n.to_s(16).rjust(2, '0')
  end
end

# 引数の文字列から3つの16進数を抜き出す
# 3つの16進数を配列に入れ、ループを回しながら10進数の整数に変換した値を別の配列に詰め込む
# 10進数の整数が入った配列を返す
def to_ints(hex)
  # r = hex[1..2]
  # g = hex[3..4]
  # b = hex[5..6]
  # [r, g, b].map do |s|
  #   s.hex
  # end
  # 上記記述をリファクタリング
  # scanメソッドは正規表現にマッチした文字列を配列にして返す ex:['12', 'ab', 'cd']
  hex.scan(/\w\w/).map(&:hex)
end
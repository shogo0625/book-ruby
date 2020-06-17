# yeild と proc
# yeild を使ってブロックの処理を呼び出す
def greeting
  puts 'おはよう'
  # ブロックの有無を確認してからyeild を呼び出す
  if block_given?
    # ここでブロックの処理を呼び出す
    yield
  end
  puts 'こんばんは'
end
greeting do
  puts 'こんにちは'
end
  #=> おはよう
  # こんにちは
  # こんばんは
# yeild はブロックに引数を渡したり受け取ったりできる
def greeting2
  puts 'おはよう'
  # ブロックに引数を渡し、戻り値を受け取る
  text = yield 'こんにちは'
  # ブロックの戻り値をコンソールに出力する
  puts text
  puts 'こんばんは'
end
greeting2 do |text|
  # yieldで渡された文字列("こんにちは")を2回繰り返す
  text * 2
end
#=> おはよう
#   こんにちはこんにちは
#   こんばんは
# ブロックを引数として他のメソッドに引き渡す
# 日本語版のgreetingメソッド
def greeting_ja(&block)
  texts = ['おはよう', 'こんにちは', 'こんばんは']
  # ブロックを別のメソッドに引き渡す
  greeting_common(texts, &block)
end
# 英語版のgreetingメソッド
def greeting_en(&block)
  texts = ['good morning', 'hello', 'good evening']
  # ブロックを別のメソッドに引き渡す
  greeting_common(texts, &block)
end
# 出力処理用の共通メソッド
def greeting_common(texts, &block)
  puts texts[0]
  # ブロックを実行する
  puts block.call(texts[1])
  puts texts[2]
end
# 日本語版のgreetingメソッドを呼び出す
greeting_ja do |text|
  text * 2
end
#=> おはよう
#   こんにちはこんにちは
#   こんばんは
# 英語版のgreetingメソッドを呼び出す
greeting_en do |text|
  text.upcase
end
#=> good morning
#   HELLO
#   good evening
# ブロック引数の数に応じて、yeild で渡す引数の個数と内容を変える
# arity メソッドでブロック引数の個数を確認できる
def greeting5(&block)
  puts 'おはよう'
  text =
    if block.arity == 1
      # ブロック引数が1個の場合
      yield 'こんにちは'
    elsif block.arity == 2
      # ブロック引数が2個の場合
      yield 'こんに', 'ちは'
    end
  puts text
  puts 'こんばんは'
end
# 1個のブロック引数でメソッドを呼び出す
greeting5 do |text|
  text * 2
end
#=> おはよう
#   こんにちはこんにちは
#   こんばんは
# 2個のブロック引数でメソッドを呼び出す
greeting5 do |text_1, text_2|
  text_1 * 2 + text_2 * 2
end
#=> おはよう
#   こんにこんにちはちは
#   こんばんは
# 10.3　Procオブジェクト
# Proc クラス ＝ ブロック「何らかの処理」を表す
# "Hello!"という文字列を返すProcオブジェクトを作成する
hello_proc = Proc.new { 'Hello!' }
# Procオブジェクトを実行する(文字列が返る)
hello_proc.call #=> "Hello!"
add_proc = Proc.new { |a, b| a + b }
add_proc.call(10, 20) #=> 30
# 引数にデフォルト値を設定
add_proc = Proc.new { |a = 0, b = 0| a + b }
add_proc.call #=> 0
add_proc.call(10) #=> 10
add_proc.call(10, 20) #=> 30
# Proc.newのかわりにprocメソッドを使う（Kernel モジュールのproc メソッド）
add_proc = proc { |a, b| a + b }
# ブロックの代わりにProcオブジェクトを引数として渡す
def greeting3(&block)
  puts 'おはよう'
  text = block.call('こんにちは')
  puts text
  puts 'こんばんは'
end
# Procオブジェクトを作成し、それをブロックの代わりとしてgreetingメソッドに渡す
repeat_proc = Proc.new { |text| text * 2 }
greeting3(&repeat_proc)
#=> おはよう
#   こんにちはこんにちは
#   こんばんは
# 上記のようにブロックとしてではなく、Procオブジェクトを引数として渡す場合は＆いらない
# 3種類のProcオブジェクトを受け取り、それぞれのあいさつ文字列に適用するgreetingメソッド
def greeting4(proc_1, proc_2, proc_3)
  puts proc_1.call('おはよう')
  puts proc_2.call('こんにちは')
  puts proc_3.call('こんばんは')
end
# greetingメソッドに渡すProcオブジェクトを用意する
shuffle_proc = Proc.new { |text| text.chars.shuffle.join }
repeat_proc = Proc.new { |text| text * 2 }
question_proc = Proc.new { |text| "#{text}?" }
# 3種類のProcオブジェクトをgreetingメソッドに渡す
greeting4(shuffle_proc, repeat_proc, question_proc)
#=> はおうよ
#   こんにちはこんにちは
#   こんばんは?
# Proc.new と ラムダの違い
# ->構文またはlambdaメソッドでProcオブジェクトを作成する
->(a, b) { a + b }
lambda { |a, b| a + b }
# ラムダはProc.new より引数のチェックが厳密になる
# Proc.newの場合(引数がnilでもエラーが起きないようにto_iメソッドを使う)
add_proc = Proc.new { |a, b| a.to_i + b.to_i }
# Proc.newは引数が1つまたは3つでも呼び出しが可能
add_proc.call(10) #=> 10
add_proc.call(10, 20, 100) #=> 30
# ラムダの場合
add_lambda = ->(a, b) { a.to_i + b.to_i }
# ラムダは個数について厳密なので、引数が2個ちょうどでなければエラーになる
add_lambda.call(10) 
#=> ArgumentError: wrong number of arguments (given 1, expected 2)
add_lambda.call(10, 20, 30)
#=> ArgumentError: wrong number of arguments (given 3, expected 2)
# 10.5
# Procオブジェクトを実行する様々な方法
add_proc = Proc.new { |a, b| a + b }
# callメソッドを使う
add_proc.call(10, 20) #=> 30
# yieldメソッドを使う
add_proc.yield(10, 20) #=> 30
# .()を使う
add_proc.(10, 20) #=> 30
# []を使う
add_proc[10, 20] #=> 30

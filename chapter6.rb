# 正規表現
# パターンを指定して、文字列を効率よく検索/置換するためのミニ言語
# 6.2
text = <<TEXT
I love Ruby.
Python is a great language.
Java and JavaScript are different.
TEXT

p text.scan(/[A-Z][A-Za-z]+/)
# 郵便番号をハイフンで区切って置換させる
text = <<TEXT
私の郵便番号は1234567です。
僕の住所は6770056 兵庫県西脇市板波町1234だよ。
TEXT

puts text.gsub(/(\d{3})(\d{4})/, '\1-\2')
#=> 私の郵便番号は123-4567です。
#   僕の住所は677-0056 兵庫県西脇市板波町1234だよ。
# 参考Qiitaより　メタ文字
# 始まりと終わりは / / で囲む
# \d = 半角数字
# 文字の個数を限定するときは {n,m} や {n} を使う（文字量を指定するので、特に 「量指定子」 と呼ばれる）
# {n,m} は「直前の文字が n 個以上、m 個以下」の意味です。
# また、 {n} とすれば「ちょうど n 文字」の意味
# 「AまたはBのいずれか1文字」表す場合は [AB]
# 電話番号を認識する正規表現の例　0[1-9]\d{0,3}[-(]\d{1,4}[-)]\d{4}
# 「～が1文字、または無し」を表現するためには ? というメタ文字を使う
# 「任意の1文字」を表す . というメタ文字
# クープ.?バ[ゲケ]ット
text = <<-TEXT
クープバゲットのパンは美味しかった。
今日はクープ バゲットさんに行きました。
クープ　バゲットのパンは最高。
ジャムおじさんのパン、ジャムが入ってた。
また行きたいです。クープ・バゲット。
クープ・バケットのパン、売り切れだった（><）
TEXT
p text.split(/\n/).grep(/クープ.?バ[ゲケ]ット/)
# => ["クープバゲットのパンは美味しかった。", "今日はクープ バゲットさんに行きました。", "クープ　バゲットのパンは最高。", "また行きたいです。クープ・バゲット。", "クープ・バケットのパン、売り切れだった（><）"]
# 「直前の文字が 1文字以上 」を表す場合は + というメタ文字（量指定子）
# 「直前の文字が0文字以上」を表す場合は * というメタ文字（量指定子）
# *? や +? にすると最長ではなく、最短のマッチを結果として返すようになる（これを 最小量指定子 と呼ぶ）
# 正規表現に (　) を使うと、その部分がキャプチャ（捕捉）され、連番が付けられる
# キャプチャする必要がない ( ) は (?: ) のように、?: をつける
# \w = [a-zA-Z0-9_]（半角英数字とアンダースコア1文字）
# < 以外の任意の文字を表す場合は [^<]
html = <<-HTML
<select name="game_console">
<option value="none"></option>
<option value="wii_u" selected>Wii U</option>
<option value="ps4">プレステ4</option>
<option value="gb">ゲームボーイ</option>
</select>
HTML
replaced = html.gsub(/<option value="(\w+)"(?: selected)?>(.*?)<\/option>/, '\1,\2')
puts replaced
# => <select name="game_console">
#    none,
#    wii_u,Wii U
#    ps4,プレステ4
#    gb,ゲームボーイ
#    </select>

# ^ + は「行頭からスペースが1文字以上続く」という意味
# $ は ^ の反対で、「行末」を意味するメタ文字（アンカー）
# つまり、^ +$ は「行頭から行末までスペースが1文字以上続く」という意味
# タブ文字は \t というメタ文字（文字クラス）を使って表現
# 以下、不要なスペースやタブ文字を削除する正規表現
text = <<-TEXT
def hello(name)
  puts "Hello, \#{name}!"
end

hello('Alice')
     
hello('Bob')
	
hello('Carol')
TEXT
puts text.gsub(/^[ \t]+$/, '')
# ハッシュの ： 後のスペースを半角スペース一個に統一する正規表現
hash = <<-TEXT
{
  japan:	'yen',
  america:'dollar',
  italy:     'euro'
}
TEXT
puts hash.gsub(/:[ \t]*/, ': ') # 「コロンの後ろにスペースまたはタブ文字が0文字以上」
#  \s は半角スペースやタブ文字、改行文字など、目に見えない「空白文字全般」を表す文字クラス　\s = [ \t\r\n\f]
# カンマ区切りからタブ文字区切りに変更( & その逆)
text = <<TEXT
name,email
alice,alice@example.com
bob,bob@example.com
TEXT
puts text.gsub(/,/, '\t')
text = <<TEXT
name	email
alice	alice@example.com
bob	bob@example.com
TEXT
puts text.gsub(/\t/, ',')
# (ABC|DEF) のように書くと、「文字列ABC、または文字列DEF」という OR条件 の意味
# heroku/api or scheduler の行と改行を消す
text = <<TEXT
Feb 14 07:33:02 app/web.1:  Completed 302 Found ...
Feb 14 07:36:46 heroku/api:  Starting process ...
Feb 14 07:36:50 heroku/scheduler.7625:  Starting ...
Feb 14 07:36:50 heroku/scheduler.7625:  State ...
Feb 14 07:36:54 heroku/router:  at=info method=...
Feb 14 07:36:54 app/web.1:  Started HEAD "/" ...
Feb 14 07:36:54 app/web.1:  Completed 200 ...
TEXT
puts text.gsub(/^.+heroku\/(api|scheduler).+\n/, '')
# 「行頭からの何らかの文字が1文字以上続き（^.+）、"heroku/"が現れ（heroku\/）、"api" または "scheduler" が続き（(api|scheduler)）、その後何らかの文字が1文字以上続いて（.+）、改行文字で終わる（\n）」

# \b というメタ文字は「単語の境界」を表す
# 英単語「 ear 」だけ抜き出す　EARに変える
text = <<TEXT
sounds that are pleasing to the ear.
ear is the organ of the sense of hearing.
I can't bear it.
Why on earth would anyone feel sorry for you?
TEXT
puts text.gsub(/\bear\b/, 'EAR')
# (?<=filename=)　filename の後から検索する

# 6.3
# 正規表現と文字列の比較（ =~ ）
# マッチした場合はマッチした文字列の開始位置が返る(つまり真)
# !~ を使うとマッチしなかったときにtrueを、マッチしたときにfalseを返す
p '123-4567' =~ /\d{3}-\d{4}/ #=> 0
# マッチしない場合はnilが返る(つまり偽)
p 'hello' =~ /\d{3}-\d{4}/ #=> nil
# match メソッドを使ってキャプチャを活用する
text = '私の誕生日は1977年7月17日です。'
m = /(\d+)年(\d+)月(\d+)日/.match(text)
p m[1] #=> "1977"
p m[2] #=> "7"
p m[3] #=> "17"
p m[0] #=> "1977年7月17日"
# キャプチャには（?<name>）というメタ文字で名前を付けれる
m = /(?<year>\d+)年(?<month>\d+)月(?<day>\d+)日/.match(text)
# シンボルで名前を指定してキャプチャの結果を取得する
m[:year] #=> "1977"
m[:month] #=> "7"
m[:day] #=> "17"
# キャプチャの名前がそのままローカル変数に割り当てられる
if /(?<year>\d+)年(?<month>\d+)月(?<day>\d+)日/ =~ text
  puts "#{year}/#{month}/#{day}"
end
#=> 1977/7/17
# 正規表現と組み合わせるメソッド
# scan メソッド　引数で渡した正規表現にマッチする部分を配列に入れて返す
p '123 456 789'.scan(/\d+/) #=> ["123", "456", "789"]
# （　）でキャプチャされた部分が配列の配列になって返ってくる
p '1977年7月17日 2016年12月31日'.scan(/(\d+)年(\d+)月(\d+)日/)
#=> [["1977", "7", "17"], ["2016", "12", "31"]]
# [　]に正規表現を渡すと、文字列から正規表現にマッチした部分を抜き出す
text = '郵便番号は123-4567です'
p text[/\d{3}-\d{4}/] #=> "123-4567"
# 第2引数で何番目のキャプチャを取得するか指定できる
text = '私の誕生日は1977年7月17日です'
p text[/(\d+)年(\d+)月(\d+)日/, 3] #=> "17"
# 名前付きキャプチャなら名前で指定も可能
p text[/(?<year>\d+)年(?<month>\d+)月(?<day>\d+)日/, 'day'] #=> "17"
# slice メソッドは [　] のエイリアスメソッド　slice! にすると文字列から破壊的に取り除く
p text.slice(/(\d+)年(\d+)月(\d+)日/, 3) #=> "17"
# split メソッド　マッチした文字列を区切り文字にして配列として返す
text = '123,456-789'
# 正規表現を使ってカンマまたはハイフンを区切り文字に指定する
text.split(/,|-/) #=> ["123", "456", "789"]
# gsub メソッド　第1引数の正規表現にマッチした文字列を第2引数の文字列で置換
text = '123,456-789'
# 第1引数に文字列を渡すと、完全一致する文字列を第2引数で置き換える
text.gsub(',', ':') #=> "123:456-789"
# 正規表現を渡すと、マッチした部分を第2引数で置き換える
text.gsub(/,|-/, ':') #=> "123:456:789"
# キャプチャを使うと、第2引数で\1や\2のようにしてキャプチャした文字列を連番で参照できます。
text = '誕生日は1977年7月17日です'
text.gsub(/(\d+)年(\d+)月(\d+)日/, '\1-\2-\3') #=> "誕生日は1977-7-17です"
# 名前付きキャプチャの場合は\k<name>のようにして参照できます。
text = '誕生日は1977年7月17日です'
text.gsub(
/(?<year>\d+)年(?<month>\d+)月(?<day>\d+)日/,
'\k<year>-\k<month>-\k<day>'
)
#=> "誕生日は1977-7-17です"
# 第2引数にハッシュを渡して、変換のルールを指定することもできます。
text = '123,456-789'
# カンマはコロンに、ハイフンはスラッシュに置き換える
hash = { ',' => ':', '-' => '/' }
text.gsub(/,¦-/, hash) #=> "123:456/789"
# 第2引数を渡す代わりに、ブロックの戻り値で置き換える文字列を指定することもできます。
text = '123,456-789'
# カンマはコロンに、それ以外はスラッシュに置き換える
text.gsub(/,|-/) { ¦matched¦ matched == ',' ? ':' : '/' }
#=> "123:456/789"
# gsub!メソッドは文字列の内容を破壊的に置換します。
text = '123,456-789'
text.gsub!(/,|-/, ':')
text #=> "123:456:789"
# 6.5 More about 正規表現オブジェクト
# /　/を使う方法以外の正規表現
# /\d{3}-\d{4}/と書いた場合と同じ　Regexp.new(エイリアスはRegexp.compile)
Regexp.new('\d{3}-\d{4}')
# %r!　! or (　) を使う方法
# %rを使うとスラッシュをエスケープしなくて良い
%r!http://example\.com!
# !ではなく{}を区切り文字にする
%r{http://example\.com}
# /　/や %r の中で#{}を使うと変数の中身を展開することができます。
pattern = '\d{3}-\d{4}'
# 変数が展開されるので/\d{3}-\d{4}/と書いたことと同じになる
'123-4567' =~ /#{pattern}/ #=> 0(true)
# case文で正規表現
text = '03-1234-5678'
case text
when /^\d{3}-\d{4}$/
  puts '郵便番号です'
when /^\d{4}\/\d{1,2}\/\d{1,2}$/
  puts '日付です'
when /^\d+-\d+-\d+$/
  puts '電話番号です'
end #=> 電話番号です
# 正規表現オブジェクト作成時のオプション
# iオプション　大文字小文字を区別しない
'HELLO' =~ /hello/i #=> 0(true)
'HELLO' =~ %r{hello}i #=> 0(true)
# mオプションを付けると.が改行文字にもマッチする
"Hello\nBye" =~ /Hello.Bye/m #=> 0(true)
# xオプションを付けたので改行やスペースが無視され、コメントも書ける
regexp = /
\d{3} # 郵便番号の先頭3桁
- # 区切り文字のハイフン
\d{4} # 郵便番号の末尾4桁
/x
'123-4567' =~ regexp #=> 0(true)
# match? メソッド
# マッチすればtrueを返す
/\d{3}-\d{4}/.match?('123-4567') #=> true
# マッチしても組み込み変数やRegexp.last_matchを書き換えない
# (すでにどこかで=̃やmatchを使っていた場合は、そのときに設定された値になります)
$~ #=> nil
Regexp.last_match #=> nil
# 文字列と正規表現を入れ替えてもOK
'123-4567'.match?(/\d{3}-\d{4}/) #=> true

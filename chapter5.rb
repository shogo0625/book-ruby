# ハッシュやシンボル
# 5.2 ハッシュ
currencies = { 'japan' => 'yen', 'us' => 'doller', 'india' => 'rupee'}
# ハッシュの追加
currencies['italy'] = 'euro'
p currencies
# ハッシュから値の取り出し
p currencies['india']
# ハッシュを使った繰り返し処理
currencies.each do |key, value|
  puts "#{key.capitalize} : #{value.upcase}"
end
# sizeメソッド(エイリアスはlength)　要素の個数を調べる
p currencies.size
# deleteメソッド　指定したキーに対応する要素を削除する
currencies.delete('italy')
p currencies
# 5.3 シンボル
# 同じシンボルなら同じオブジェクトID　整数としての扱い　文字列より高速に処理できる
# 5.4 続ハッシュ
currencies = { japan: 'yen', us: 'doller', india: 'rupee' }
p currencies[:india]
# 5.6 ハッシュ詳細
# keys メソッド
p currencies.keys #=> [:japan, :us, :india]
# values メソッド
p currencies.values #=> ["yen", "dollar", "rupee"]
# has_key?/key?/include?/member?
p currencies.has_key?(:japan)
# ** or merge(ハッシュ名)で他のハッシュのとキーと値を展開
h = { us: 'dollar', india: 'rupee' }
# 変数hのキーと値を**で展開させる
{ japan: 'yen', **h } #=> {:japan=>"yen", :us=>"dollar", :india=>"rupee"}
{ japan: 'yen' }.merge(h) #=> {:japan=>"yen", :us=>"dollar", :india=>"rupee"}
# キーワード引数で想定外のキーワードはothers引数で受け取る
def buy_burger(menu, drink: true, potato: true, **others)
  # othersはハッシュとして渡される
  puts others
end
buy_burger('fish', drink: true, potato: false, salad: true, chicken: false)
#=> {:salad=>true, :chicken=>false}
# to_a メソッド　ハッシュから配列へ変換
currencies = { japan: 'yen', us: 'doller', india: 'rupee' }
p currencies.to_a #=> [[:japan, "yen"], [:us, "dollar"], [:india, "rupee"]]
# to_h メソッド　配列からハッシュへ変換
array = [[:japan, "yen"], [:us, "dollar"], [:india, "rupee"]]
p array.to_h #=> {:japan=>"yen", :us=>"dollar", :india=>"rupee"}
# ハッシュに指定されたキーと初期値を同時に設定する
h = Hash.new { |hash, key| hash[key] = 'hello' }
h[:foo] #=> "hello"
h[:bar] #=> "hello"
# ハッシュにキーと値が追加されている
h #=> {:foo=>"hello", :bar=>"hello"}
# 5.7 シンボル詳細
# ％記法でシンボルを作成
p %s!ruby!
p %s(ruby)
# シンボルの配列を作成
p %i(apple melon orange)
# %Iでは改行文字や式展開が有効になったうえでシンボルが作られる
name = 'Alice'
p %I(hello\ngood-bye #{name.upcase}) #=> [:"hello\ngood-bye", :ALICE]
# to_sym メソッドで文字列をシンボルに変換
string = 'apple'
symbol = :apple
p string.to_sym == symbol
# ＆.演算子を使うとオブジェクトがnil出ない場合は値を、nilの場合はnilを返す
is_something = 'something'
is_nil = nil
p is_something&.upcase
p is_nil&.upcase
# ||= 値 を使った自己代入　nilまたはfalseであれば値を代入する　x = x || 30
x = nil
p x ||= 30
# !! を付けるとオブジェクトに対応する真偽値が true or false として取得できる

# クラス
# ７．２
# クラス　オブジェクトの設計図、オブジェクトのひな形
# レシーバ　メソッドの返しを受け取る側
# user.name　userというレシーバに対してnameというメッセージを送っている
# 状態（ステート）　オブジェクトごとに保持されるデータのこと
# 属性（アトリビュート、プロパティ）　オブジェクトから取得できる値のこと
# ７．３　クラスの定義
# Initialize メソッド　.newメソッドを使ったときに呼び出される共通して行いたい処理
# インスタンスメソッド　クラス構文の内部で定義されたメソッド
class User
  def initialize(name)
    @name = name
  end
  # self.を付けるとクラスメソッドになる
  def self.create_users(names)
    names.map do |name|
      User.new(name)
    end
  end
  # これはインスタンスメソッド
  def hello
    "Hello, I am #{@name}."
  end
end

names = ['Alice', 'Bob', 'Carol']
# クラスメソッドの呼び出し
users = User.create_users(names)
users.each do |user|
  # インスタンスメソッドの呼び出し
  puts user.hello
end
#=> Hello, I am Alice.
# Hello, I am Bob.
# Hello, I am Carol.
user = User.new
user.to_s #=> "#<User:0x007f8f9286d598>"
user.nil? #=> false
User.superclass #=> Object
# userはUserクラスのインスタンスか?
user.instance_of?(User) #=> true
# is_a?はis-a関係にあればtrueになる
user.is_a?(User) #=> true

# スーパークラス
class Product
  attr_reader :name, :price
  def initialize(name, price)
    @name = name
    @price = price
  end
end
product = Product.new('A great movie', 1000)
product.name #=> "A great movie"
product.price #=> 1000
# Productクラスのサブクラス
class DVD < Product
  attr_reader :running_time
  def initialize(name, price, running_time)
    # スーパークラスのinitializeメソッドを呼び出す
    super(name, price)
    @running_time = running_time
  end
end
dvd = DVD.new('A great movie', 1000, 120)
dvd.name #=> "A great movie"
dvd.price #=> 1000
dvd.running_time #=> 120
# メソッドの公開レベル
# public　クラスの外部からでも呼び出せる　initializeメソッド以外はデフォルトでこれ
# private　クラスの外からは呼び出せず、内部のみで使えるメソッド　厳密に言うと、「レシーバを指定して呼び出すことができないメソッド」
# 　サブクラスからでも呼出可　privateになるのはインスタンスメソッドだけ　クラスメソッドはならない
# 　クラスメソッドをprivateにしたい場合は、class << self構文 or private_class_method :hello で変更
# protected　そのメソッドを定義したクラス自身と、そのサブクラスのインスタンスメソッドからレシーバ付きで呼び出せる

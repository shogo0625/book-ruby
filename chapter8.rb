# モジュール
# 8.2
# モジュールの定義
module Loggable
  # private も指定できる
  def log(text)
    puts "[LOG] #{text}"
  end
  # logメソッドをミックスインとしても、モジュールの特異メソッドとしても使えるようにする
  # (module_functionは対象メソッドの定義よりも下で呼び出すこと)
  module_function :log
  # ミックスインとしてもモジュールの特異メソッドとしても使えるメソッド＝モジュール関数
end
# モジュールの特異メソッドとしてlogメソッドを呼び出す
Loggable.log('Hello.') #=> [LOG] Hello.

# 8.3 モジュールのミックスイン（include と extend）
# include 上記モジュールをクラスで呼び出せるようにする ＝ ミックスイン
class Product
  # 上で作ったモジュールをincludeする
  include Loggable

  def title
    log 'title is called.'
    'A great movie'
  end
end
product = Product.new
product.title
#=> [LOG] title is called.
# "A great movie"
class User
  # モジュール内のメソッドを特異メソッド（クラスメソッド）にすることができる
  extend Loggable

  def self.create_users(users)
    # logメソッドをクラスメソッド内で呼び出す
    #(つまりlogメソッド自体もクラスメソッドになっている)
    log 'create_users is called.'
    # ほかの実装は省略
  end
end
# クラスメソッド経由でlogメソッドが呼び出される
User.create_users([]) #=> [LOG] create_users is called.
# Userクラスのクラスメソッドとして直接呼び出すことも可能
User.log('Hello.') #=> [LOG] Hello.

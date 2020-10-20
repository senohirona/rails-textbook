# newアクション

## routes
`http://localhost:3000/rails/info/routes`にアクセスしてRoutes表を見てみる
今回の場合はリクエストパスが/book/new、HTTPメソッドがGETなので、BooksControllerのnewアクションへ処理が進む。

## controlloer

bookscontrollerのnewアクションのコードを見てみる
(app/controllers/books_controller.rb)

```
def new
  @book = Book.new
end
```

newアクションはBooks.newでBookクラスのインスタンスを作り、@bookインスタンス変数へと代入し、ビューへ渡す。
Book.newで作ったBookクラスのインスタンスはタイトルとメモを格納できるようになっているが、タイトルとメモのデータは空っぽ。

## view
`views/books/new.html.erb `を見てみる

```
<h1>New Book</h1>

<%= render 'form', book: @book %>

<%= link_to 'Back', books_path %>
```

renderメソッドは別のビューファイルを埋め込む。
わざわざ別のファイルに書く理由は、他の画面でもそのファイルを使用して部品を共有するため。
埋め込む用のビューファイルをパーシャルと呼ぶ。

```
<%= render 埋め込みたいファイル名, パーシャル内で使う変数名: 渡す変数 %>
```

埋め込むファイル名にはルールが有り、renderで書いた文字列の先頭に_をつけたファイル名にする。
今回の場合、`、<%= render 'form', book: @book %>`で埋め込まれるファイルは`_form.html.erb`になる。

`book: @book`の部分は、`@book`変数を埋め込み先のパーシャル内でbook変数として使うための指示。

# Createアクション

## routes

URLのパスは/books、HTTPメソッドはPOSTなので対応するコントローラとアクションはbook#create、つまりBooksControllerのcreateアクションが呼び出される。

## controller

コントローラのソースファイルファイルを見てみる。
(`app/controllers/books_controller.rb`)

```
  def create
    @book = Book.new(book_params) # リクエストのパラメータを使って本のデータを作る

    respond_to do |format|
      if @book.save # 本のデータを保存する
        # 成功したらshow画面へ
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        # 保存失敗したらnew画面へ
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

```

### パラメータ
`app/controllers/books_controller.rb`

```
def book_params
  params.require(:book).permit(:title, :memo)
end
```

`book_params`メソッドはパラメータに関する処理を行っている。
パラメータはブラウザから飛んでくるリクエストの中に含まれる情報で、例えばユーザーの入力した値が入っている。

`book_params`の残りのrequireとpermitについて。
これらはパラメータの内容を制限する。
意図していないデータが入ってくるのを防ぐための仕組み。
今回の内容ではbookのtitle, memoだけを受け取るようにしている。



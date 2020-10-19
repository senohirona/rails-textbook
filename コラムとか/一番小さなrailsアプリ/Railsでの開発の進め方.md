railsでの基本的な開発の進め方は以下の2つを繰り返すサイクルになる
- 雛形になるファイルの生成
- 作っているアプリ用にファイルを変更、追記

今回作ったアプリもこの手順で進めた

```
$ rails new helloworld
$ rails g controller hello index
```

これらのコマンドは「雛形になるファイルの生成」を行っていた。
その後に、`app/views/hello/index.html.erb`を編集して内容を変更した。


# railsが生成するコマンド

## rails new コマンド
やっていることとしては以下
- Railsアプリとして動作するのに必要なファイルとフォルダを作成する。
- 利用するGemライブラリをDL
- rails webpack:install, yarm install実行(JavascriptのライブラリをDLする)

### 各ファイルの役割
この項目で利用したファイルを対象に解説
```
app
    controllers...いろいろな処理を行う箇所
    views...表示に関する処理を行う箇所
config
    routes.rb…URLとコントローラの対応表
```

## rails g コマンド
今回実行した`rails g controller hello index`を対象とすると

URLのパスが/hello/indexであるページを表示するためのファイル群を作成する。
(gはgenerateの略)

このコマンドで生成・追記されたファイルの内重要なのは以下3つのファイル
- app/controllers/hello_controller.rb
- app/views/hello/index.html.erb
- config/routes.rb

# railsアプリの処理の流れ
ブラウザからアクセスしたときのrailsアプリはどのように動作しているのか?

リクエストを受けたrailsアプリは以下のコードを順番に通過する
1 Routes
2 Constoller
3 View
それぞれの場所で処理を行い、レスポンスとしてHTMLを生成して返す。


## Routes
「リクエストのUTLとHTTPメソッド」に応じて次に処理を行う先を決める役割を持つ。
railsではRoutesの処理が終わると、次はコントローラへ処理が移る。
RoutesはリクエストとControllerのアクションとの対応表とも言える。
(対応表は`/rails/info/routes`にアクセスするとみることができる)

今回を例にすると、Routesは`config/routes.rb`から生成されている。

```
get 'hello/index'
```

↑は「パス"hello/index"へのGETでのアクセスでHelloControllerのindexアクションが呼ばる」という意味を示している。

## コントローラー
様々な処理を行い、次のビューで使うデータを作って渡す。
コントローラーのファイルは`app/controllers`ヘ置く。

@から始まる変数のことをインスタンス変数と呼ぶ。
インスタンス変数を使うと、コントローラからこのあとの処理先であるビューへ情報を伝えることができる。
ビューで利用するためにはインスタンス変数を利用する。

## ビュー
HTML等、ユーザーの目に届く部分を作る。
作られたHTMLはレスポンスとしてブラウザに送られる。

`index.html.erb`はHTMLの元になるファイル。ブラウザで表示するさせるため言語HTMLをそのまま書くことができる。
さらに、Rubyのコードを実行した結果を埋め込むこともできる。
（このようなファイルをテンプレートと言う）

ビューで使う情報をコントローラから送ってもらう時はインスタンス変数を利用する。

※実行したコマンドの意味などを記載していく


# scaffoldコマンド
`rails g scaffold`コマンドは新規作成、表示、更新、削除、各機能を一度に作る機能。
scaffoldを利用すると、CRUD機能をもったページを作ることができる。
(CRUD...webアプリの基本となる4つの機能、新規作成(create)、表示(read)、更新(update)、削除(destroy)のこと)

このコマンドで作成されるroute(`invoke resource`), controller(`invoke scaffold_controller`),やview(`invoke erb`)は前の章で説明したrailsの各機能を担うファイル。

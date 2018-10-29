# Stairs web バックエンド勉強会 README
## 日程
- 2018/11/30
- 2018/11/31

## 準備
- PostManをインストール(https://www.getpostman.com/)
- Ruby 2.4をインストール(Macでrbenvの人は`rbenv install 2.4.1`, windowsの人は[RubyInstaller for Windows](https://rubyinstaller.org/downloads/)から)
- ruby gemの bundler をインストール
- 何かしらのエディタ(vim, atom, vscode等)がインストール
## 資料
今回作成するのは劣化版Twitter   
ユーザがいてツイートのみできるというものを作る   
基本的なCRUDとRESTを学ぶのが今回の軸    
- CRUD
    - Create, Read, Update, Destroyのこと
- REST
    - プログラム呼び出し規約
    - URL/URIで全てのリソースを一意に識別
    - ステートレス(セッション管理や状態管理を行わない)
    - 同じURLに対する呼び出し結果は常に同じことが期待される
    - リソースのHTTPメソッド(GET, POST等)によって指定
    - 結果はHTML, XML, JSON等で返される
    - 処理結果はHTTPステータスコードで通知する

### 1. railsアプリケーションの作成
#### 1.1 railsのインストール
好きなディレクトリにて`mkdir /* 好きなディレクトリ名 */`でディレクトリを作成 (講師は`mkdir stairs-backend-sample`とする, この名前がプロジェクト名となる)  
作ったディレクトリに入って`rbenv local 2.4.1`でrubyをディレクトリに適用   
ruby2.4.1にbundlerが入っていなければ`gem install bundler`を実行  
作ったディレクトリに入り, `bundle init`を実行, `Gemfile`が作成される   
Gemfileに`gem 'rails', '~> 5.2.1'`を記入   
`bundle install --path vendor/bundle`を実行   
Ruby on Rails のインストール完了   
#### 1.2 プロジェクトの作成
railsをインストールしたディレクトリにて`bundle exec rails new . --api`を実行  

- `bundle exec`は`bundle install`でインストールしたものを実行する時に必要, vendor/bundle内を参照しに行く
- `.`は今いるディレクトリに対して`rails new`を行う
- `--api`はAPIモードでrailsアプリケーションを立ち上げるという意味, viewを作成しないようになる

### 2. モデルの作成
#### 2.1 モデル設計（スキーマ設計）
今回のモデルはUserとTweetの二つ
```scala
- User
    - name     : string(not null)
    - bio      : string
    - location : string
    - website  : string

- Tweet
    - text     : string(not null)
    - user_id  : integer(foreign key)
```
のような構造を持つものとする
User : Tweet に関して1対nの関係がある   

#### 2.2 実装
作成したディレクトリにて   
`bundle exec rails g model User name:string bio:string location:string website:string`    
`bundle exec rails g model Tweet text:string user_id:integer`   
を実行  
モデルはできるが, 制約等が付いてないのでmigrationにて追加設定
`bundle exec rails g migration AddNotNullConstraintToNameOfUser`  
を実行しマイグレーションファイルを作成   
nameにnotnull制約を追加するコードを記述  
    
`bundle exec rails g migration AddConstraintsToTweetAttributes`   
を実行しマイグレーションファイルを作成    
textにnotnull, user_idをforeignkeyに設定   
    
`bundle exec rails db:migrate`を実行   
    
モデル作成完了

### 3. ルーティングの作成
#### 3.1 ルーティング設計
RESTfulなルーティングを作成する   
REST再訪   
- REST
    - プログラム呼び出し規約
    - URL/URIで全てのリソースを一意に識別
    - ステートレス(セッション管理や状態管理を行わない)
    - 同じURLに対する呼び出し結果は常に同じことが期待される
    - リソースのHTTPメソッド(GET, POST等)によって指定
    - 結果はHTML, XML, JSON等で返される
    - 処理結果はHTTPステータスコードで通知する

これを元にルーティング(エンドポイント)を作成していく
どのようなエンドポイントがほしいかを考える（Twitterを触ってみる）
- User
    - 作成, 読出, 更新, 削除
- Tweet
    - 作成, 読出(Userに紐づいたもの[User押下後], 紐付きを考慮しないもの[TLに表示されるTweet]), 削除

ここで考えたエンドポイントをRESTfulに作成する   
HTTPメソッド   
- 作成:POST
- 読出:GET
- 更新:PUT
- 削除: DELETE 


#### 3.2 実装
まず, 一つずつ実装していく   
その後, restfulなルーティングをresourcesを使って実装   
コードはdevelopmentブランチの`config/routes.rb`を参照


### 4. コントローラの作成
#### 4.1 コントローラ設計


#### 4.2 実装

### 5. エンドポイント

##### 5.1 GET `/users/:user_id/tweets`
ユーザに紐づくツイートを取得します   
レスポンス例:
```json
{
    "status": 200,
    "data": [
        {
            "id": 1,
            "text": "janken",
            "user_id": 1,
            "created_at": "2018-10-29T13:15:34.710Z",
            "updated_at": "2018-10-29T13:15:34.710Z"
        },
        {
            "id": 2,
            "text": "test1",
            "user_id": 1,
            "created_at": "2018-10-29T13:15:46.278Z",
            "updated_at": "2018-10-29T13:15:46.278Z"
        },
        {
            "id": 3,
            "text": "test2",
            "user_id": 1,
            "created_at": "2018-10-29T13:16:03.800Z",
            "updated_at": "2018-10-29T13:16:03.800Z"
        }
    ]
}
```

##### 5.2 GET `/users`
全ユーザを取得します　　　
レスポンス例:  
```json
{
    "status": 200,
    "data": [
        {
            "id": 1,
            "name": "momotarou",
            "bio": "I am peach taro",
            "location": "peach",
            "website": "onigashima.com",
            "created_at": "2018-10-28T00:47:16.270Z",
            "updated_at": "2018-10-28T00:47:16.270Z"
        },
        {
            "id": 2,
            "name": "gold taro",
            "bio": "kuma is best friend forever",
            "location": "forest",
            "website": "nihonmukashibanashi.com",
            "created_at": "2018-10-28T02:31:01.168Z",
            "updated_at": "2018-10-28T02:31:01.168Z"
        },
        {
            "id": 3,
            "name": "saru",
            "bio": null,
            "location": null,
            "website": null,
            "created_at": "2018-10-28T02:31:37.762Z",
            "updated_at": "2018-10-28T02:31:37.762Z"
        }
    ]
}
```
##### 5.3 GET `/users/:id`
idで指定したユーザを取得します   
レスポンス例:  
```json
{
    "status": 200,
    "data": {
        "id": 1,
        "name": "momotarou",
        "bio": "I am peach taro",
        "location": "peach",
        "website": "onigashima.com",
        "created_at": "2018-10-28T00:47:16.270Z",
        "updated_at": "2018-10-28T00:47:16.270Z"
    }
}
```

##### 5.4 POST `/users`
ユーザを新規作成します
リクエスト例:  
```json
{
	"user": {
		"name": "urashimataro",
		"bio": "竜宮城マジ卍",
		"location": "竜宮城",
		"website": "ryugujo.com"
	}
}
```
レスポンス例:  
```json
{
    "status": 201,
    "data": {
        "id": 4,
        "name": "urashimataro",
        "bio": "竜宮城マジ卍",
        "location": "竜宮城",
        "website": "ryugujo.com",
        "created_at": "2018-10-29T15:00:31.084Z",
        "updated_at": "2018-10-29T15:00:31.084Z"
    }
}
```

##### 5.5 PUT `/users/:id`
 idで指定したユーザの情報を更新します
 リクエスト例:   
 ```json
 {
	"user": {
		"name": "yamada",
		"bio": "デブです",
		"location": "豚小屋",
		"website": "yamachannodebu.com"
	}
}
 ```
 
 レスポンス例:  
 ```json
 {
    "status": 200,
    "data": {
        "id": 2,
        "name": "yamada",
        "bio": "デブです",
        "location": "豚小屋",
        "website": "yamachannodebu.com",
        "created_at": "2018-10-28T02:31:01.168Z",
        "updated_at": "2018-10-29T15:04:10.166Z"
    }
}
```
##### 5.6 DELETE `/users/:id`
idで指定したユーザを削除します   
レスポンス例:  
```json
{
    "status": 200,
    "message": "success"
}
```


##### 5.7 GET `/tweets`
全ツイートを取得します   
レスポンス例:  
```json
{
    "status": 200,
    "data": [
        {
            "id": 1,
            "text": "janken",
            "user_id": 1,
            "created_at": "2018-10-29T13:15:34.710Z",
            "updated_at": "2018-10-29T13:15:34.710Z"
        },
        {
            "id": 2,
            "text": "test1",
            "user_id": 1,
            "created_at": "2018-10-29T13:15:46.278Z",
            "updated_at": "2018-10-29T13:15:46.278Z"
        },
        {
            "id": 3,
            "text": "test2",
            "user_id": 1,
            "created_at": "2018-10-29T13:16:03.800Z",
            "updated_at": "2018-10-29T13:16:03.800Z"
        }
    ]
}
```


##### POST `/tweets`
ツイートを新規作成します
リクエスト例:  
```json
{
	"tweet": {
		"text": "痩せたい",
		"user_id": 2
	}
}
```
レスポンス例:  
```json
{
    "status": 201,
    "data": {
        "id": 4,
        "text": "痩せたい",
        "user_id": 2,
        "created_at": "2018-10-29T15:11:22.042Z",
        "updated_at": "2018-10-29T15:11:22.042Z"
    }
}
```

##### DELETE `/tweets/:id`
idで指定したツイートを削除します   
レスポンス例:  
```json
{
    "status": 200,
    "message": "OK"
}
```


## キーワード
- Ruby
- Ruby on Rails
- APIサーバ
- REST, RESTful
- JSON
- HTTPメソッド
- SQL
- RDBMS
- MVC

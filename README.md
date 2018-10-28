# Stairs web バックエンド勉強会 README
### 日程
- 
-

### 前提
    - Ruby 2.4をインストールしている
    - ruby gemの bundler をインストールしている
    - 何かしらのエディタ(vim, atom, vscode等)がインストールされている
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
#### 2.1
    今回のモデルはUserとTweetの二つ
    ```
    - User
        - name     : string
        - bio      : string
        - location :string
        - website  : string
    
    - Tweet
        - text     : string
        - user_id  : integer
    ```
    のような構造を持つものとする
    User : Tweet に関して1対nの関係がある   

#### 2.2
    作成したディレクトリにて   
    `bundle exec rails g model Users name:string bio:string location:string website:string`    
    `bundle exec rails g model Tweets text:string user_id:integer`   
    を実行  


### 3. ルーティングの作成

### 4. コントローラの作成

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













# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# README

### アプリケーション名

Fightsong

### アプリケーション概要

プロ野球における魅力の一つである”応援歌”に特化した動画投稿アプリです。  
主に動画の投稿、編集、削除が出来ます。  
検索機能では、選手名やチーム、スタジアム、歌詞から検索可能です。  

### URL  

http://54.249.60.231/  

### テスト用アカウント  

・メールアドレス：1@1  
・ログインパスワード：111111rou  

### 利用方法  

1.一覧ページヘッダーより新規登録（もしくはログイン）します  
2.投稿ボタンより動画の投稿後、一覧にて表示されます  
3.一覧から動画をクリックすると詳細ページに遷移し、編集・削除が可能です  
4.これらは自分の投稿データに限り可能で、他人のデータへは干渉できません  
5.検索欄では、プルダウンもしくは文字列での検索が可能でマッチする動画を一覧で表示することができます  

### アプリケーションを作成した背景

応援歌が大好きで、YouTubeや自分のフォルダから再生させています。  
ただ、YouTubeは  
⑴あらゆるカテゴリーの動画が混在する  
⑵検索するときに文字列でしか検索できない  
という難点があり、自分が望む応援歌を確実に見つけたいと思った背景があります。

### 要件定義
https://docs.google.com/spreadsheets/d/14gTPRQgsj9biHBJ9ItGPY22XUcwPlZVqbDFe2APpKTg/edit#gid=982722306  

### 現在の実装内容（主要部のみ）

[![Image from Gyazo](https://i.gyazo.com/4efec37b64950311cf4ae61e110ac8f3.png)](https://gyazo.com/4efec37b64950311cf4ae61e110ac8f3)
[![Image from Gyazo](https://i.gyazo.com/b2c76394c4dbeb6de27ed0349feccf0e.png)](https://gyazo.com/b2c76394c4dbeb6de27ed0349feccf0e)
[![Image from Gyazo](https://i.gyazo.com/37a239adaba4dd64932cc9eb24ad12ff.png)](https://gyazo.com/37a239adaba4dd64932cc9eb24ad12ff)

### 実装予定の機能

タグの追加や、ランキング機能も実装したいと考えています。  
より”欲しい情報を取りに行ける”アプリを目指したいです。

### 開発環境
・フロントエンド：HTML/CSS  
・バックエンド：Ruby/Ruby on Rails  
・テキストエディタ：Visual Studio Code  
・デプロイ：AWS  
・タスク管理：GitHub  

### 工夫したポイント

1.フロントエンドに関して  
メインコンテンツである動画が最も映えるよう邪魔をしないデザインを意識しました。  
検索ページを別で作成することも考えましたが、ふとしたときに検索するものだと思い、  
一覧ページ内に収めることに決めました。  
また、アイコンについてもこのアプリの顔となる部分のため、丁寧に作成しました。  
動画のサムネイルや記事の見出し同様、アプリの第一印象を決めるアイコンに  
一定の力を注ぐことでより愛着の湧くものになりました。

2.バックエンドに関して  
データの安定性があるため投稿フォームにactivehashを多用しました。  
これにより検索方法がプルダウンとなり確実にidが与えられたデータの検索が可能になります。  
”欲しい情報を取りに行ける”という点で、実装前から構想を練っていたので実現できて良かったです。  
ただ、activehashによって痛い目も見ました。  
バリデーションでid=1（初期値である”---”）は選択できない、としたことでactivehashを設定した  
team,stadium以外で検索したいときに検索結果がエラーになってしまいました。  
そこで検索フォームには見た目は同じ”---”だがidが1ではない”---”を表示することで  
エラーにならずに通過させることが出来ました。

### 改善点

自分のGoogleフォトに動画が多くあったため、動画のフォームをURL型にした影響で、  
URLを読み込む必要が出ました。  

  def embedded_video_code  
  self[:embedded_video_code]  
  end  

というコードで読み込もうとしましたが表示ができませんでした。  
メインコンテンツが表示されていないので現状最も改善すべき点だと考えます。  

### ER図

  [![Image from Gyazo](https://i.gyazo.com/2eca3c2e035cef64e3f2d9d0c14ebf03.png)](https://gyazo.com/2eca3c2e035cef64e3f2d9d0c14ebf03)


# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| name               | string | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |

### Association

- has_many :movies
- has_many :comments
- has_many :favorites

## movies テーブル

| Column     | Type    | Options     |
| ---------- | ------- | ----------- |
| team_id    | integer | null: false |
| player     | string  | null: false |
| day        | date    | null: false |
| lyrics     | string  | null: false |
| stadium_id | integer | null: false |
| text       | text    | null: false |

### Association

- belongs_to :user
- has_many :favorites
- has_many :comments

## favorites テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| movie  | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :movie

## comments テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| text   | string     |                                |
| user   | references | null: false, foreign_key: true |
| movie  | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :movie
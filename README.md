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
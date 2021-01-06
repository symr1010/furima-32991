# テーブル設計

## users テーブル

| Column             | Type    | Option                     |
| -----------------  | ------- | -------------------------- |
| nickname           | string  | null: false                |
| email              | string  | null: false, unique: true  |
| encrypted_password | string  | null: false                |
| first_name         | string  | null: false                |
| first_name(kana)   | string  | null: false                |
| last_name          | string  | null: false                |
| last_name(kana)    | string  | null: false                |
| birthday           | date    | null: false                |

### Association

- has_many :items
- has_many :records

## items テーブル

| Column                | Type        | Option             |
| --------------------- | ----------- | ------------------ |
| product_name          | string      | null: false        |
| description_of_item   | text        | null: false        |
| category_id           | integer     | active hashで実装   |
| product_condition_id  | integer     | active hashで実装   |
| shipping_charges_id   | integer     | active hashで実装   |
| prefectures_id        | integer     | active hashで実装   |
| days_to_ship_id       | integer     | active hashで実装   |
| price                 | integer     | null: false        |
| user                  | references  | foreign_key: true  |

### Association

- belongs_to :user
- has_one    :record

## records テーブル

| Column  | Type        | Option             |
| ------- | ----------- | ------------------ |
| user    | references  | foreign_key: true  |
| item    | references  | foreign_key: true  |

### Association

- belongs_to :user
- belongs_to :item
- has_one    :address

## addresses テーブル

| Column          | Type                   | Option              |
| --------------- | ---------------------- | ------------------- |
| postal_code     | string                 | null: false         |
| prefectures_id  | integer                | active hashで実装    |
| municipality    | string                 | null: false         |
| address         | string                 | null: false         |
| building_name   | string                 |                     |
| phone_number    | string                 | null: false         |
| record          | references             | foreign_key: true   |

### Association

- belongs_to :record

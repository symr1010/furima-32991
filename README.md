# テーブル設計

## users テーブル

| Column            | Type    | Option                     |
| ----------------- | ------- | -------------------------- |
| nickname          | string  | null: false                |
| email             | string  | null: false, unique: true  |
| password          | string  | null: false                |
| first_name        | string  | null: false                |
| first_name(kana)  | string  | null: false                |
| last_name         | string  | null: false                |
| last_name(kana)   | string  | null: false                |
| year              | string  | null: false                |
| month             | string  | null: false                |
| day               | string  | null: false                |

### Association

- has_many :items
- has_many :records

## items テーブル

| Column               | Type                 | Option             |
| -------------------- | -------------------- | ------------------ |
| image                | active storageで実装  |                    |
| product_name         | text                 | null: false        |
| description_of_item  | text                 | null: false        |
| category             | active hashで実装     |                    |
| product_condition    | active hashで実装     |                    |
| shipping_charges     | active hashで実装     |                    |
| shipping_area        | active hashで実装     |                    |
| days_to_ship         | active hashで実装     |                    |
| price                | integer              | null: false        |
| user                 | references           | foreign_key: true  |

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

| Column         | Type                   | Option              |
| -------------- | ---------------------- | ------------------- |
| postal_code    | integer                | null: false         |
| prefectures    | string                 | null: false         |
| municipality   | text                   | null: false         |
| address        | text                   | null: false         |
| building_name  | text                   |                     |
| phone_number   | integer                | null: false         |
| credit_card    | テーブルには保存しない！   |                     |
| record         | references             | foreign_key: true   |

### Association

- belongs_to :record

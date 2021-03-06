# テーブル設計

## users テーブル

| Column             | Type    | Option                     |
| -----------------  | ------- | -------------------------- |
| nickname           | string  | null: false                |
| email              | string  | null: false, unique: true  |
| encrypted_password | string  | null: false                |
| last_name          | string  | null: false                |
| first_name         | string  | null: false                |
| last_name_kana     | string  | null: false                |
| first_name_kana    | string  | null: false                |
| birthday           | date    | null: false                |

### Association

- has_many :items
- has_many :orders

## items テーブル

| Column                | Type        | Option             |
| --------------------- | ----------- | ------------------ |
| product_name          | string      | null: false        |
| description_of_item   | text        | null: false        |
| category_id           | integer     | null: false        |
| product_condition_id  | integer     | null: false        |
| shipping_charge_id    | integer     | null: false        |
| prefecture_id         | integer     | null: false        |
| days_to_ship_id       | integer     | null: false        |
| price                 | integer     | null: false        |
| user                  | references  | foreign_key: true  |

### Association

- belongs_to :user
- has_one    :order

## orders テーブル

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
| prefecture_id   | integer                | null: false         |
| municipality    | string                 | null: false         |
| address         | string                 | null: false         |
| building_name   | string                 |                     |
| phone_number    | string                 | null: false         |
| order           | references             | foreign_key: true   |

### Association

- belongs_to :order

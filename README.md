# Qiita-kenny

Qiita の模倣アプリです。

## 概要説明

下記アプリの要件です。

- ログイン機能
  - ユーザー登録情報を元に認証し、ユーザー独自のユーザーエクスペリエンス（UX）を実現します。
- 投稿機能
  - ユーザーは自身が登録した投稿内容を編集または削除することができます。
- 検索機能
  - キーワードやカテゴリを使用して記事を簡単に検索できます。
- いいね機能
  - 記事に「いいね」をすることができ、自身が獲得した「いいね」の数はダッシュボードで確認できます。

## 環境構築手順

1. 作業ディレクトリに本リポジトリを clone する

```bash {iscopy=true}
git clone https://github.com/Kenty-725/qiita-kenny.git
```

2. `app/app`ディレクトリ直下に env ファイルを作成し中身に下記を記載する

```bash {iscopy=true}
BASE_URL="http://localhost:3001"
```

3. `docker-compose.yml`があるディレクトリで build する

```bash {iscopy=true}
docker-compose build
```

4. db を作成する

```bash {iscopy=true}
docker-compose run --rm api db:create
```

5. scheme をマイグレーションする

```bash {iscopy=true}
docker-compose run --rm api db:migrate
```

6. seed データを投入する。

```bash {iscopy=true}
docker-compose run --rm api db:seed
```

7. アプリを起動させる

```bash {iscopy=true}
docker-compose up -d
```

8. `http://localhost:3000/`にアクセスする。

## 使用環境

- Ruby on rails 7.0.6
- Nuxt 2.15.8
- Mysql 8.0
- Docker
<p style="display: inline">
  <!-- フロントエンドのフレームワーク一覧 -->
  <img src="https://img.shields.io/badge/-Nuxt.js-00C58E.svg?logo=nuxt.js&style=for-the-badge">
  <!-- バックエンドのフレームワーク一覧 -->
  <img src="https://img.shields.io/badge/-Rails-CC0000.svg?logo=rails&style=for-the-badge">
  <!-- バックエンドの言語一覧 -->
  <img src="https://img.shields.io/badge/-ruby-CC0000.svg?logo=rails&style=for-the-badge">
  <!-- ミドルウェア一覧 -->
  <img src="https://img.shields.io/badge/-Nginx-269539.svg?logo=nginx&style=for-the-badge">
  <img src="https://img.shields.io/badge/-MySQL-4479A1.svg?logo=mysql&style=for-the-badge&logoColor=white">
  <!-- インフラ一覧 -->
  <img src="https://img.shields.io/badge/-Docker-1488C6.svg?logo=docker&style=for-the-badge">
</p>

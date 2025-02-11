# app/Dockerfile.nuxt
FROM node:14

# 作業ディレクトリの設定（Nuxtプロジェクトフォルダ）
WORKDIR /usr/src/app/app

# package.json と package-lock.json をコンテナにコピー
COPY app/package*.json ./

# npm install を実行して依存関係をインストール
RUN npm install

# プロジェクトの全ファイルをコピー
COPY app/ .

# コンテナが起動した時に実行するコマンド
CMD ["npm", "run", "dev"]

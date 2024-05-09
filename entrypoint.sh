#!/bin/bash
set -e

# データベースが起動するまで待つコマンドをここに書くか、または別の方法を採用
# 例: wait-for-it.sh db:5432 -- echo "Database is up."

# データベースマイグレーションを実行
echo "Running database migrations..."
bundle exec rails db:migrate

# 他に必要なコマンドがあればここに記述

# 最終的に実行するコマンド（このスクリプトの最後に来るべき）
exec "$@"
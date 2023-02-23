#!/bin/bash

# 文字色を設定する変数
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Nodeバージョンに関する変数
NODE_VERSION=$(node -v)
DEFAULT_NODE_VERSION="v15.14.0"

# 編集するschema.goファイルの変数
PLUGIN_SCHEMA_GO=~/plugin-deployment/Plugin/core/store/orm/schema.go

# Nodeバージョン確認とインストール
if [[ $NODE_VERSION != $DEFAULT_NODE_VERSION ]]; then

    echo
    echo -e "${YELLOW}--------------------------------------------------------------------------------"
    echo -e "${YELLOW} Current Node version is $NODE_VERSION, changing to $DEFAULT_NODE_VERSION."
    echo -e "${YELLOW}--------------------------------------------------------------------------------${NC}"
    echo

    # node v15.14.0をインストールし使用を宣言
    source ~/.nvm/nvm.sh
    nvm install $DEFAULT_NODE_VERSION
    nvm use $DEFAULT_NODE_VERSION
    NODE_VERSION=$(node -v)

    echo
    echo -e "${YELLOW}--------------------------------------------------------------------------------"
    echo -e "${YELLOW} Node version has been changed to $NODE_VERSION."
    echo -e "${YELLOW}--------------------------------------------------------------------------------${NC}"
    echo
else
    echo
    echo -e "${YELLOW}--------------------------------------------------------------------------------"
    echo -e "${YELLOW} Current Node version is $NODE_VERSION, no changes needed."
    echo -e "${YELLOW}--------------------------------------------------------------------------------${NC}"
    echo
fi

# `schema.go`を編集
BEFORE_NUM=$(grep -oP 'DefaultMaxHTTPAttempts\s+uint\s+`env:"MAX_HTTP_ATTEMPTS"\s+default:"\K[^"]+' $PLUGIN_SCHEMA_GO)
sed -i 's/\(DefaultMaxHTTPAttempts.*default:\)"'$BEFORE_NUM'"/\1"2"/' $PLUGIN_SCHEMA_GO
AFTER_NUM=2

# pm2 stop PM2_MAIN_PROCESS
if pm2 describe 2_nodeStartPM2 >/dev/null 2>&1; then
    PM2_MAIN_PROCESS=2_nodeStartPM2
elif pm2 describe '[sS]tart[nN]ode' >/dev/null 2>&1; then
    PM2_MAIN_PROCESS='[sS]tart[nN]ode'
else
    echo "Cannot find pm2 process to stop"
    exit 1
fi
pm2 stop $PM2_MAIN_PROCESS

# プロファイルを読み込む
Plugin=$HOME/plugin-deployment/Plugin
cd $Plugin
source ~/.profile

# 再インストール
echo
echo -e "${YELLOW}--------------------------------------------------------------------------------"
echo -e "${YELLOW} It may take up to 5 minutes depending on the environment. "
echo -e "${YELLOW} Please do not do anything until it's finished."
echo -e "${YELLOW}--------------------------------------------------------------------------------${NC}"
echo
sleep 5
# make install

# pm2 reset & start & list
pm2 start $PM2_MAIN_PROCESS
pm2 reset $PM2_MAIN_PROCESS
sleep 5
pm2 list
sleep 2

# 終了アナウンス
echo
echo -e "${YELLOW}--------------------------------------------------------------------------------"
echo -e "${YELLOW} DefaultMaxHTTPAttempts has been changed from $BEFORE_NUM to $AFTER_NUM."
echo -e "${YELLOW} Please make sure that the number of  ↺  for $PM2_MAIN_PROCESS has not increased."
echo -e "${YELLOW} Node.js version will remain $DEFAULT_NODE_VERSION even after this process is finished."
echo -e "${YELLOW}--------------------------------------------------------------------------------${NC}"
echo
echo

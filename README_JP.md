<br/>
<p align="center">
<img src="./img/img2.jpg" width="225" alt="PluginJapan">
</a>
</p>
<br/>

# Plugin_HTTPAttempts

このスクリプトは、`schema.go` ファイルを編集し、DefaultMaxHTTPAttempts の値を `2` に変更するリポジトリです。APIからデータを失わないように留意して、`5`回試行されていましたが、`2`回に減らすことになりました。詳しくは以下を参照してください。

### [Plugin](https://github.com/GoPlugin/Plugin)

## 機能
Plugin_HTTPAttempts.shは、以下の機能を持ちます。

1. 現在の`Node.js`のバージョンを確認します。PluginNodeのデフォルトである`v15.14.0`とは異なる場合、`nvm` を使用してバージョンを `v15.14.0` に変更します
2. スクリプトで `schema.go` ファイルを編集します。編集する項目は、DefaultMaxHTTPAttempts の値を`5` から `2` に変更することです
3. `pm2`を使用して、メインプロセスを停止し、プロファイルを読み込みます
4. Pluginを`make install`でインストールを実行します

## 要件
このスクリプトを使用する前に、以下の要件を満たす必要があります。
* `nvm` を使用して `Node.js` のバージョンを切り替えることができるようになっていること
* `PM2` がインストールされており、PluginNodeを管理するために必要なスクリプトが実行できること
* スクリプトで使用する `schema.go` ファイルのパスが正しいこと。デフォルトでは、`~/plugin-deployment/Plugin/core/store/orm/schema.go`がパスになります。

## 注意事項
* このスクリプトを使用する前に、バックアップを作成することをお勧めします
* メインプロセスの名前は、`2_nodeStartPM2` または `[sS]tart[nN]ode` である必要があります。これらのプロセス名が見つからない場合、スクリプトはエラーで終了します
* スクリプトは`./Plugin_HTTPAttempts.sh` だけで実行すると、Node.jsのバージョンは、シェルスクリプトのプロセス内だけで有効で、シェルスクリプトが終了すると変更は破棄されます。`source ./Plugin_HTTPAttempts.sh`を実行することで、Node.js のバージョンがPluginNodeのデフォルトである`v15.14.0`になります

## 実行コマンド
以下のコマンドを使用して、このスクリプトを実行することができます。

1. 以下の手順で、git clone して source コマンドを実行できるようにします。 ターミナルを開いて、任意のディレクトリに移動します

2. 以下のコマンドを実行して、リポジトリをクローンします
```sh
git clone https://github.com/11ppm/Plugin_HTTPAttempts
```

3. Plugin_HTTPAttemptsディレクトリに移動します
```sh
cd Plugin_HTTPAttempts
```

4. Plugin_HTTPAttempts.sh ファイルに実行権限を付与します
```sh
chmod +x Plugin_HTTPAttempts.sh
```

5. `source` コマンドを使用して、シェルスクリプトを実行します。`./`は必ずつけてください
```sh
source ./Plugin_HTTPAttempts.sh
```

## 重要
* スクリプトは`./Plugin_HTTPAttempts.sh` だけで実行すると、でシェルスクリプトのプロセス内だけで有効で、シェルスクリプトが終了すると変更は破棄されます。`source ./Plugin_HTTPAttempts.sh`を実行することで、Node.jsのバージョンがPluginNodeのデフォルトである`v15.14.0`になります。もし`v15.14.0`ではなく、すでに実行しているバージョンを使用したい場合は、以下を実行してください。もしくは`nvm use <version>`を実行してください。

```sh
./Plugin_HTTPAttempts.sh
```

## Author

* @11ppm

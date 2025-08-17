# パスワードマネージャー

## 動作環境 (OS)

次の環境で動作します。

- Ubuntu (WSL2などの仮想環境で動作するものを含む)
- macOS

## 事前準備

### GnuPGのインストール (Ubuntu)

UbuntuにはデフォルトでGnuPGがインストールされているようです。
次のコマンドでGnuPGのバージョンが確認できればインストール不要です。
```bash
gpg --version
```

GnuPGがインストールされていなければ、次のコマンドでインストールします。
```bash
apt install gnupg
```

### GnuPGのインストール (macOS)

次ののHomebrew コマンドでインストールできます。

```bash
brew install gnupg
```

次のコマンドでインストール確認 (バージョン確認) をします。
```bash
gpg --version
```

### プログラムのダウンロード

任意のディレクトリにこのリポジトリをクローン (git clone) してください。

### 初期設定

クローンしたディレクトリに移動します。
```bash
cd password-manager
```

#### パスフレーズの設定

1. プログラムのルートディレクトリ(password_manager.sh があるディレクトリ) に空の .passphrase ファイルを作成してください。
1. このファイルの1行目に暗号化・復号化に使用する任意のパスフレーズを書き込みます。

#### .passphrase ファイルの権限変更

次のコマンドで .passphrase の権限を変更します。
```bash
chmod 600 .passphrase
```

# 使い方

プログラムのルートディレクトリで次のコマンドを実行します。
```bash
./password_manager.sh
```
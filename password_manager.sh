#!/bin/bash

echo
echo "-----------------------------------"
echo " パスワードマネージャーへようこそ! "
echo "-----------------------------------"
echo

readonly PASSPHRASE_FILE=".passphrase"
readonly GPG_PW_FILE="pw_list.gpg"
readonly PW_FILE="pw_list"

# 暗号化
encrypt()
{
    if [ ! -s "$PASSPHRASE_FILE" ]; then
        # パスフレーズ設定ファイル未定義
        gpg --batch --yes -c --s2k-cipher-algo AES256 --s2k-digest-algo SHA512 --s2k-count 65536 "$PW_FILE"
    else
        gpg --batch --yes --passphrase-file "$PASSPHRASE_FILE" -c --s2k-cipher-algo AES256 --s2k-digest-algo SHA512 --s2k-count 65536 "$PW_FILE"
    fi
    rm "$PW_FILE"
}

# 復号化
decrypt()
{
    if [ ! -s "$PASSPHRASE_FILE" ]; then
        # パスフレーズ設定ファイル未定義
        gpg --batch --yes --output "$PW_FILE" --decrypt "$GPG_PW_FILE"
    else
        gpg --batch --yes --passphrase-file "$PASSPHRASE_FILE" --output "$PW_FILE" --decrypt "$GPG_PW_FILE"
    fi
}

# パスワード登録
register_password()
{
    # 復号化
    if [ -e "$GPG_PW_FILE" ]; then
        decrypt
    fi

    # パスワード書き込み
    echo ""$1":"$2":"$3"" >> "$PW_FILE"

    # 暗号化
    encrypt

    echo
    echo "パスワードの追加は成功しました。"
}

# パスワード追加
add_password()
{
    echo "サービス名を入力してください:"
    local service
    read service
    echo

    echo "ユーザー名を入力してください:"
    local user
    read user
    echo

    echo "パスワードを入力してください:"
    local password
    read password
    echo
    
    register_password "$service" "$user" "$password"
}

# 情報を表示
print_info()
{
    # 復号化
    if [ -e "$GPG_PW_FILE" ]; then 
        decrypt
    else
        touch "$PW_FILE"
    fi

    # 対象サービスの行番号を取得
    local record_num=`cut -d : -f 1 "$PW_FILE" | grep -nx "$1" | head -n 1 | cut -d : -f 1`

    if [ -z "$record_num" ]; then
        echo
        echo "そのサービスは登録されていません。"
    else
        # サービス名を取得
        local disp_service=`sed -n "$record_num"p "$PW_FILE" | cut -d : -f 1`

        # ユーザー名を取得
        local disp_user=`sed -n "$record_num"p "$PW_FILE" | cut -d : -f 2`

        # パスワードを取得
        local disp_password=`sed -n "$record_num"p "$PW_FILE" | cut -d : -f 3`

        # 各情報を表示
        echo
        echo "サービス名: "$disp_service""
        echo "ユーザー名: "$disp_user""
        echo "パスワード: "$disp_password""
    fi

    # 暗号化
    encrypt
}

# パスワードを取得
get_password()
{
    echo "サービス名を入力してください:"
    local target_service
    read target_service
    echo
    print_info $target_service
}

# 終了
exit_func()
{
    echo "Thank you!"
    echo
    exit
}

while true
do
    echo "ご希望の選択肢の番号を入力してください:"
    echo
    echo "  1. Add Password"
    echo "  2. Get Password"
    echo "  9. Exit"
    echo
    read function_num
    echo

    case "$function_num" in
        "1")
            add_password
            ;;
        "2")
            get_password
            ;;
        "9")
            exit_func
            ;;
        *)
            echo "入力が間違えています。"
            echo "[ 1, 2, 9 ] のいずれかを入力してください。"
            ;;
    esac
    echo
done


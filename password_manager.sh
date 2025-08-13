#!/bin/bash

echo
echo "-----------------------------------"
echo " パスワードマネージャーへようこそ! "
echo "-----------------------------------"
echo

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

    echo ""$service":"$user":"$password"" >> pw_list
    echo "パスワードの追加は成功しました。"
    echo
}

# 情報を表示
print_info()
{
    # 対象サービスの該当行を取得
    local target_record
    target_record=`cat ./pw_list | grep "$1"`

    if [ -z "$target_record" ]; then
        echo "そのサービスは登録されていません。"
    else
        # サービス名を取得
        local disp_service
        disp_service=`echo "$target_record" | cut -d : -f 1`

        # ユーザー名を取得
        local disp_user
        disp_user=`echo "$target_record" | cut -d : -f 2`

        # パスワードを取得
        local disp_password
        disp_password=`echo "$target_record" | cut -d : -f 3`

        # 各情報を表示
        echo "サービス名: "$disp_service""
        echo "ユーザー名: "$disp_user""
        echo "パスワード: "$disp_password""
    fi
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
    echo
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


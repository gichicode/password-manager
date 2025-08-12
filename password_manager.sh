#!/bin/bash

echo
echo "-----------------------------------"
echo " パスワードマネージャーへようこそ! "
echo "-----------------------------------"
echo

add_password()
{
    echo "サービス名を入力してください:"
    read service
    echo

    echo "ユーザー名を入力してください:"
    read user
    echo

    echo "パスワードを入力してください:"
    read password
    echo

    echo "$service:$user:$password" >> pw_list
    echo "パスワードの追加は成功しました。"
    echo
}

get_data()
{
    target_record=`cat ./pw_list | grep $target_service`
    disp_service=`echo $target_record | cut -d : -f 1`
    disp_user=`echo $target_record | cut -d : -f 2`
    disp_password=`echo $target_record | cut -d : -f 3`
}

print_info()
{
    get_data $1
    echo "サービス名: $disp_service"
    echo "ユーザー名: $disp_user"
    echo "パスワード: $disp_password"
}

get_password()
{
    echo "サービス名を入力してください:"
    read target_service
    echo
    print_info $1
}

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
            add_password $1
            ;;
        "2")
            get_password $1
            ;;
        "9")
            exit_func $1
            ;;
    esac
    echo
done


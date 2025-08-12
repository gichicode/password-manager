#!/bin/bash

echo
echo "---------------------------------"
echo "パスワードマネージャーへようこそ!"
echo "---------------------------------"
echo

while true
do
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

    echo "----------"
    echo "Thank you!"
    echo "----------"
    echo
done


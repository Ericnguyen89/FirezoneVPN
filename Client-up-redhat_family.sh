#!/bin/bash

# Kiểm tra xem script có được chạy bởi root hay không
if [[ $EUID -ne 0 ]]; then
   echo "Vui lòng chạy script này với quyền root."
   exit 1
fi

# Cài đặt WireGuard nếu chưa được cài đặt
if ! command -v wg &> /dev/null; then
    echo "Cài đặt WireGuard..."
    yum install -y wireguard-tools
fi

# Kiểm tra xem có tệp cấu hình WireGuard trong thư mục hiện tại hay không
if ls *.conf 1> /dev/null 2>&1; then
    for conf_file in *.conf; do
        echo "Importing $conf_file..."
        nmcli connection import type wireguard file "$conf_file"
    done
else
    echo "Không có Profile config trên thư mục hiện tại... vui lòng nhập bằng tay."
fi

#!/bin/bash

MYFOLDER="$HOME/myfolder"

mkdir -p "$MYFOLDER"

{
    echo "Привет! Это файл 1."
    date
} > "$MYFOLDER/file1.txt"

touch "$MYFOLDER/file2.txt"
chmod 777 "$MYFOLDER/file2.txt"

tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c 20 > "$MYFOLDER/file3.txt"

touch "$MYFOLDER/file4.txt" "$MYFOLDER/file5.txt"

echo "script1.sh: все файлы созданы в $MYFOLDER"

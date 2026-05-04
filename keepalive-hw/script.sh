#!/bin/bash

PORT=80
INDEX_FILE="/var/www/html/index.html"

# Проверка порта (nginx должен слушать)
ss -tuln | grep -q ":$PORT "

PORT_STATUS=$?

# Проверка index.html
if [[ -f "$INDEX_FILE" ]]; then
    FILE_STATUS=0
else
    FILE_STATUS=1
fi

# Итоговая логика
if [[ $PORT_STATUS -eq 0 && $FILE_STATUS -eq 0 ]]; then
    exit 0
else
    exit 1
fi


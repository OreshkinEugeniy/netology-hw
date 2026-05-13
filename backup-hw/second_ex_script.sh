#!/bin/bash

log_file="/var/log/rsync_2.log"

if [[ -e $log_file  ]]; then
	echo "file ${log_file} already exist"
else
	touch "$log_file"
	echo "file ${log_file} has created"
fi


backup_from_dir="/home/oreshkinem/netology-hw/backup-hw"
backup_to_dir="/tmp/backup/secondhw"

if [[ -d $backup_to_dir  ]]; then
        echo "backup dir ${backup_to_dir} already exist"
else
        mkdir -p "$backup_to_dir"
        echo "dir ${log_backup_to_dir} has created"
fi

run_backup() {

    date_now=$(date "+%Y-%m-%d %H:%M:%S")

    output=$(rsync -a --progress "$1" "$2" 2>&1)
    status=$?

    if [[ $status -eq 0 ]]; then
        echo "${date_now} SUCCESS ${output}" >> "$log_file"
    else
        echo "${date_now} ERROR ${output}" >> "$log_file"
    fi
}

run_backup "$backup_from_dir" "$backup_to_dir"

PGPASSWORD=replicatorpass pg_basebackup -h postgres-master -U replicator -p 5432 -D /var/lib/postgresql/data -Fp -Xs -P -R -S
slave1 -C

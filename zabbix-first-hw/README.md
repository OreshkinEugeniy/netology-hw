# Домашнее задание к занятию "`Git`" - `Орешкин Евгений`


### Задание 1
Установите Zabbix Server с веб-интерфейсом.

Процесс выполнения
Выполняя ДЗ, сверяйтесь с процессом отражённым в записи лекции.
Установите PostgreSQL. Для установки достаточна та версия, что есть в системном репозитороии Debian 11.
Пользуясь конфигуратором команд с официального сайта, составьте набор команд для установки последней версии Zabbix с поддержкой PostgreSQL и Apache.
Выполните все необходимые команды для установки Zabbix Server и Zabbix Web Server.
Требования к результатам
Прикрепите в файл README.md скриншот авторизации в админке.
Приложите в файл README.md текст использованных команд в GitHub.

<img width="1680" height="1050" alt="image" src="https://github.com/user-attachments/assets/755e4d20-d689-4f07-80e6-961081b7af02" />

sudo apt install postgresql

wget https://repo.zabbix.com/zabbix/6.0/debian/pool/main/z/zabbix-release/zabbix-
release_6.0-4%2Bdebian11_all.deb 
dpkg -i zabbix-release_6.0-4+debian11_all.deb 
apt update
sudo apt install zabbix-server-pgsql zabbix-frontend-php php7.4-pgsql zabbix-apache-conf zabbix-sql-
scripts nano -y # zabbix-agent
sudo -u postgres createuser --pwprompt zabbix
sudo -u postgres createdb -O zabbix zabbix
zcat /usr/share/zabbix-sql-scripts/postgresql/server.sql.gz | sudo -u zabbix psql zabbix
sudo nano /etc/zabbix/zabbix_server.conf
sudo systemctl restart zabbix-server apache2 # zabbix-agent 
sudo systemctl enable zabbix-server apache2 # zabbix-agent
### Задание 2

Установите Zabbix Agent на два хоста.

Процесс выполнения
Выполняя ДЗ, сверяйтесь с процессом отражённым в записи лекции.
Установите Zabbix Agent на 2 вирт.машины, одной из них может быть ваш Zabbix Server.
Добавьте Zabbix Server в список разрешенных серверов ваших Zabbix Agentов.
Добавьте Zabbix Agentов в раздел Configuration > Hosts вашего Zabbix Servera.
Проверьте, что в разделе Latest Data начали появляться данные с добавленных агентов.

Требования к результатам
Приложите в файл README.md скриншот раздела Configuration > Hosts, где видно, что агенты подключены к серверу
Приложите в файл README.md скриншот лога zabbix agent, где видно, что он работает с сервером
Приложите в файл README.md скриншот раздела Monitoring > Latest data для обоих хостов, где видны поступающие от агентов данные.
Приложите в файл README.md текст использованных команд в GitHub


<img width="1680" height="1050" alt="image" src="https://github.com/user-attachments/assets/45abe018-4581-45da-8d69-589ce58484af" />
<img width="830" height="633" alt="image" src="https://github.com/user-attachments/assets/a5658257-5755-4d8a-940f-f96cf65898e5" />
<img width="1680" height="1050" alt="image" src="https://github.com/user-attachments/assets/5849920e-dee6-4e56-bf27-6f89bae52ff6" />
<img width="1680" height="1050" alt="image" src="https://github.com/user-attachments/assets/16ee4d8f-c8e9-4c4b-8737-538c4f841e2e" />
<img width="1680" height="1050" alt="image" src="https://github.com/user-attachments/assets/5bc8fa1a-ea07-47dc-8978-9c7a575f4ea1" />
<img width="1680" height="1050" alt="image" src="https://github.com/user-attachments/assets/2fb39aeb-ed65-4937-a800-299285ffabbe" />

wget https://repo.zabbix.com/zabbix/6.0/debian/pool/main/z/zabbix-release/
zabbix-release_6.0-4%2Bdebian11_all.deb 
dpkg -i zabbix-release_6.0-4+debian11_all.deb 
apt update
sudo apt install zabbix-agent -y
sudo systemctl restart zabbix-agent 
sudo systemctl enable zabbix-agent

### Задание 3

```


```
### Задание 4*


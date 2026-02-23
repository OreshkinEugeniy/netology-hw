# Домашнее задание к занятию "`Название занятия`" - `Орешкин Евгений`


### Задание 1

Установите Docker Compose и опишите, для чего он нужен и как может улучшить лично вашу жизнь.

[установленная версия dokcer]

<img width="422" height="47" alt="image" src="https://github.com/user-attachments/assets/a602dfb6-fb40-48ba-a056-353a96049073" />

---

### Задание 2

Создайте файл docker-compose.yml и внесите туда первичные настройки:

version;
services;
volumes;
networks.
При выполнении задания используйте подсеть 10.5.0.0/16. Ваша подсеть должна называться: <ваши фамилия и инициалы>-my-netology-hw. Все приложения из последующих заданий должны находиться в этой конфигурации.

[docker-compose.yml] 

<img width="465" height="321" alt="image" src="https://github.com/user-attachments/assets/536ef31e-c980-44d1-a6ff-6ad678fba2d5" />


### Задание 3

Создайте конфигурацию docker-compose для Prometheus с именем контейнера <ваши фамилия и инициалы>-netology-prometheus.
Добавьте необходимые тома с данными и конфигурацией (конфигурация лежит в репозитории в директории 6-04/prometheus ).
Обеспечьте внешний доступ к порту 9090 c докер-сервера.

<img width="510" height="487" alt="image" src="https://github.com/user-attachments/assets/5a6e91ac-7903-42bc-867d-72d802fd9901" />


prometheus.yml:
```
lobal:
  scrape_interval: 15s 
  evaluation_interval: 15s 


# Alertmanager configuration
alerting:
  alertmanagers:
    - static_configs:
        - targets:
rule_files:

scrape_configs:

```
docker_compose.yml
```
ervices:
  prometheus:
    image: prom/prometheus:latest
    container_name: oreshkinem-netology-prometheus
    ports:
      - 9090:9090
    volumes:
      - ./prometheus/prometheus.yml:/etc/prometheus/prometheus.yml
      - web_data:/etc/prometheus
    networks:
      - oreshkinem-my-netology-hw
    restart: unless-stopped


```

Открытие Prometheus в браузере
<img width="889" height="717" alt="image" src="https://github.com/user-attachments/assets/4cc0c4e2-4a72-4e58-991e-1e9e540b50a8" />


### Задание 4

Создайте конфигурацию docker-compose для Pushgateway с именем контейнера <ваши фамилия и инициалы>-netology-pushgateway.
Обеспечьте внешний доступ к порту 9091 c докер-сервера.

Прописываю сервис pushgateway в docker-compose.yml

```
pushgateway:
    image: prom/pushgateway:v1.6.2
    container_name: oreshkinem-netology-pushgateway
    ports:
      - 9091:9091
    networks:
      - oreshkinem-my-netology-hw
    depends_on:
      - prometheus
    restart: unless-stopped

```

Добавляем scrape_configs, в prometheus.yml с указанием сервиса pushgateway
```
scrape_configs:
  - job_name: 'pushgateway'
    honor_labels: true
    static_configs:
      - targets: ["pushgateway:9091"]

```


Открытие pushgateway в браузере

### Задание 5

Создайте конфигурацию docker-compose для Grafana с именем контейнера <ваши фамилия и инициалы>-netology-grafana.
Добавьте необходимые тома с данными и конфигурацией (конфигурация лежит в репозитории в директории 6-04/grafana.
Добавьте переменную окружения с путем до файла с кастомными настройками (должен быть в томе), в самом файле пропишите логин=<ваши фамилия и инициалы> пароль=netology.
Обеспечьте внешний доступ к порту 3000 c порта 80 докер-сервера.


Настройка Docker-compose сервиса grafana

```
grafana:
    image: grafana/grafana
    container_name: oreshkinem-netology-grafana
    environments:
      GF_PATHS_CONFIG: /etc/grafana/custom.ini
    ports:
      - 80:3000
    volumes:
      - web_data:/var/lib/grafana
      - ./grafana:/etc/grafana
    networks:
      - oreshkinem-my-netology-hw
    depends_on:
      - prometheus
    restart: unless-stopped


```

custom.ini

```
admin_user = netology
admin_password = netology
```


<img width="786" height="821" alt="image" src="https://github.com/user-attachments/assets/8324240d-e5d0-4d31-80ea-d82de773651c" />


### Задание 6

Настройте поочередность запуска контейнеров.
Настройте режимы перезапуска для контейнеров.
Настройте использование контейнерами одной сети.
Запустите сценарий в detached режиме.



```
services:
  prometheus:
    image: prom/prometheus:latest
    container_name: oreshkinem-netology-prometheus
    ports:
      - 9090:9090
    volumes:
      - ./prometheus/prometheus.yml:/etc/prometheus/prometheus.yml
      - prometheus_data:/etc/prometheus
    networks:
      - oreshkinem-my-netology-hw
    restart: unless-stopped


  pushgateway:
    image: prom/pushgateway:v1.6.2
    container_name: oreshkinem-netology-pushgateway
    ports:
      - 9091:9091
    networks:
      - oreshkinem-my-netology-hw
    depends_on:
      - prometheus
    restart: unless-stopped


  grafana:
    image: grafana/grafana
    container_name: oreshkinem-netology-grafana
    environment:
      GF_PATHS_CONFIG: /etc/grafana/custom.ini
    ports:
      - 80:3000
    volumes:
      - ./grafana:/etc/grafana
      - grafana_data:/var/lib/grafana
    networks:
      - oreshkinem-my-netology-hw
    depends_on:
      - prometheus
    restart: unless-stopped




volumes:
  prometheus_data:
  grafana_data:


networks:
  oreshkinem-my-netology-hw:
    ipam:
      config:
        - subnet: 10.5.0.0/16




```

<img width="803" height="441" alt="image" src="https://github.com/user-attachments/assets/f30fb49c-9cda-4c9b-b0ef-eab2615fdb67" />




### Задание 7

Выполните запрос в Pushgateway для помещения метрики <ваши фамилия и инициалы> со значением 5 в Prometheus: echo "<ваши фамилия и инициалы> 5" | curl --data-binary @- http://localhost:9091/metrics/job/netology.
Залогиньтесь в Grafana с помощью логина и пароля из предыдущего задания.
Cоздайте Data Source Prometheus (Home -> Connections -> Data sources -> Add data source -> Prometheus -> указать "Prometheus server URL = http://prometheus:9090" -> Save & Test).
Создайте график на основе добавленной в пункте 5 метрики (Build a dashboard -> Add visualization -> Prometheus -> Select metric -> Metric explorer -> <ваши фамилия и инициалы -> Apply.
В качестве решения приложите:

docker-compose.yml целиком;
скриншот команды docker ps после запуске docker-compose.yml;
скриншот графика, постоенного на основе вашей метрики.

1. `Заполните здесь этапы выполнения, если требуется ....`
2. `Заполните здесь этапы выполнения, если требуется ....`
3. `Заполните здесь этапы выполнения, если требуется ....`
4. `Заполните здесь этапы выполнения, если требуется ....`
5. `Заполните здесь этапы выполнения, если требуется ....`
6. 

```
Поле для вставки кода...
....
....
....
....
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота](ссылка на скриншот)`


### Задание 8

Остановите и удалите все контейнеры одной командой.
В качестве решения приложите скриншот консоли с проделанными действиями.



1. `Заполните здесь этапы выполнения, если требуется ....`
2. `Заполните здесь этапы выполнения, если требуется ....`
3. `Заполните здесь этапы выполнения, если требуется ....`
4. `Заполните здесь этапы выполнения, если требуется ....`
5. `Заполните здесь этапы выполнения, если требуется ....`
6. 

```
Поле для вставки кода...
....
....
....
....
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота](ссылка на скриншот)`


### Задание 9

Создайте конфигурацию docker-compose для Alertmanager с именем контейнера <ваши фамилия и инициалы>-netology-alertmanager.
Добавьте необходимые тома с данными и конфигурацией, сеть, режим и очередность запуска.
Обновите конфигурацию Prometheus (необходимые изменения ищите в презентации или документации) и перезапустите его.
Обеспечьте внешний доступ к порту 9093 c докер-сервера.
В качестве решения приложите скриншот с событием из Alertmanager.



1. `Заполните здесь этапы выполнения, если требуется ....`
2. `Заполните здесь этапы выполнения, если требуется ....`
3. `Заполните здесь этапы выполнения, если требуется ....`
4. `Заполните здесь этапы выполнения, если требуется ....`
5. `Заполните здесь этапы выполнения, если требуется ....`
6. 

```
Поле для вставки кода...
....
....
....
....
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота](ссылка на скриншот)`


### Задание 10

Запустите свой сценарий на чистом железе без предзагруженных образов.

Ответьте на вопросы в свободной форме:

Опишите выполненный вами процесс развертывания сценария.
Как вы думаете зачем может понадобиться такой способ развертывания?

1. `Заполните здесь этапы выполнения, если требуется ....`
2. `Заполните здесь этапы выполнения, если требуется ....`
3. `Заполните здесь этапы выполнения, если требуется ....`
4. `Заполните здесь этапы выполнения, если требуется ....`
5. `Заполните здесь этапы выполнения, если требуется ....`
6. 

```
Поле для вставки кода...
....
....
....
....
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота](ссылка на скриншот)`


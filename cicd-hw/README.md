# Домашнее задание к занятию "`Что такое DevOps. CI/CD`" - `Орешкин Евгений`


### Задание 1

Что нужно сделать:

Установите себе jenkins по инструкции из лекции или любым другим способом из официальной документации. Использовать Docker в этом задании нежелательно.
Установите на машину с jenkins golang.
Используя свой аккаунт на GitHub, сделайте себе форк репозитория. В этом же репозитории находится дополнительный материал для выполнения ДЗ.
Создайте в jenkins Freestyle Project, подключите получившийся репозиторий к нему и произведите запуск тестов и сборку проекта go test . и docker build ..
В качестве ответа пришлите скриншоты с настройками проекта и результатами выполнения сборки.

<img width="3360" height="2100" alt="image" src="https://github.com/user-attachments/assets/a602a679-101c-4123-883f-6b581e590660" />

<img width="3360" height="2100" alt="image" src="https://github.com/user-attachments/assets/21199d89-7f16-406b-83ec-814da2f57169" />


<img width="3360" height="2100" alt="image" src="https://github.com/user-attachments/assets/05cfbb22-451f-4692-9840-8a3d5368db88" />


### Задание 2

Что нужно сделать:

Создайте новый проект pipeline.
Перепишите сборку из задания 1 на declarative в виде кода.
В качестве ответа пришлите скриншоты с настройками проекта и результатами выполнения сборки.



<img width="3360" height="2100" alt="image" src="https://github.com/user-attachments/assets/9c063759-6f01-4d7c-83e2-b8c60b7e0cad" />
<img width="3360" height="2100" alt="image" src="https://github.com/user-attachments/assets/13d2c9e1-325e-4992-b818-dccf8ac933e6" />





### Задание 3

Что нужно сделать:

Установите на машину Nexus.
Создайте raw-hosted репозиторий.
Измените pipeline так, чтобы вместо Docker-образа собирался бинарный go-файл. Команду можно скопировать из Dockerfile.
Загрузите файл в репозиторий с помощью jenkins.
В качестве ответа пришлите скриншоты с настройками проекта и результатами выполнения сборки.

<img width="3360" height="2100" alt="image" src="https://github.com/user-attachments/assets/f7deca9d-5c53-4430-80ff-bcf0c41e56bf" />
<img width="3360" height="2100" alt="image" src="https://github.com/user-attachments/assets/413afad5-ff18-43cc-b7d5-8ffa14b28a33" />
<img width="3360" height="2100" alt="image" src="https://github.com/user-attachments/assets/5386b8f9-304f-4beb-b019-50753d706323" />

код ppeline:
```
pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/OreshkinEugeniy/cicd-netology-hw.git'
            }
        }

        stage('Test') {
            steps {
                sh 'go test .'
            }
        }

        stage('Go build') {
            steps {
                sh 'go build -o go_app .'
            }
        }
        stage('Uoload to Nexus'){
            steps {    
                sh '''
                curl -v -u admin:18192275Aa! \
                --upload-file go_app \
                http://127.0.0.1:8081/repository/cicd-netology/go_app
                ls -la
                ''' 
            }    
        }
    }
}
```

### Задание 4

Придумайте способ версионировать приложение, чтобы каждый следующий запуск сборки присваивал имени файла новую версию. Таким образом, в репозитории Nexus будет храниться история релизов.

Подсказка: используйте переменную BUILD_NUMBER.

В качестве ответа пришлите скриншоты с настройками проекта и результатами выполнения сборки.

<img width="3360" height="2100" alt="image" src="https://github.com/user-attachments/assets/bcfb9c9f-db60-424a-a274-3d9124740dd8" />

<img width="3360" height="2100" alt="image" src="https://github.com/user-attachments/assets/59ad1d26-61cf-4794-a03d-5e4ab37a7980" />







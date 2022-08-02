Lesson 1:
Проделанная работа:
  1. Написал Dockerfile с веб-сервером nginx, собрал образ, запушил в dockerhub
  2. Написал манифест web-pod.yaml с init контейнером для подтягивания статики в общий mountPath /app
  3. Собрал образ microservices-demo и запушил в dockerhub
  4. Сгенерировал ad-hoc коммандой манифест frontend-pod.yaml для сервиса microservices-demo
  5. Создал исправленный frontend-pod-healthy.yaml на основе frontend-pod.yaml
  6. Запушил ДЗ в репу

q: Разберитесь почему все pod в namespace kube-system восстановились после удаления. Укажите причину в описании PR

a: Потому что они были восстановлены deployment'ом

Lesson 2:
Проделанная работа:
  1. Развернул кластер через kind
  2. Запустил под frontend с контроллером ReplicaSet
  3. Запустил под frontend с контроллером Deployment
  4. Произвёл обновление образа в Deployment
  5. Сделал rollback 
  6. Сделал два варианта обновления: "Аналог blue-green" и "Reverse Rolling Update"
  7. Добавил Health-check probes
  8. Создал DaemonSet манифест с node-exporter
  9. Исправил развертку node-exporter для снятия метрик в том числе и с control-plane ноды

Lesson 3:
Проделанная работа:
  1. Научился создавать пространство имён
  2. Научился создавать пользователей в конкретном пространстве имён
  3. Научился выдавать встроенные кластерные роли "view" и "admin"
  4. Научился создавать свои роли
  5. Научился выдавать права на отдельных пользователей и всё пространство имён

lesson 4
Проделанная работа:




Lesson 5:
  1. Установил kind
  2. Запустил minio
  3. Научился создавать секреты
  4. Научился получать секреты в окружение пода
Запуск:
  kind create cluster
  kubectl apply -f kubernetes-volumes

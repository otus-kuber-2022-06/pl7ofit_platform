Проделанная работа:
  1. Написал Dockerfile с веб-сервером nginx, собрал образ, запушил в dockerhub
  2. Написал манифест web-pod.yaml с init контейнером для подтягивания статики в общий mountPath /app
  3. Собрал образ microservices-demo и запушил в dockerhub
  4. Сгенерировал ad-hoc коммандой манифест frontend-pod.yaml для сервиса microservices-demo
  5. Создал исправленный frontend-pod-healthy.yaml на основе frontend-pod.yaml
  6. Запушил ДЗ в репу

q: Разберитесь почему все pod в namespace kube-system восстановились после удаления. Укажите причину в описании PR

a: Потому что они были восстановлены deployment'ом

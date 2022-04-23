version: '3'
services:
  db:
    image: mysql:5.7
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: 123456
      MYSQL_USER: barakat
      MYSQL_PASSWORD: 123456
  elasticsearch:
    image: docker.elastic.co/elasticsearch/elasticsearch:5.0.2
    container_name: elasticsearch
    environment:
      - node.name=elasticsearch
      - discovery.seed_hosts=elasticsearch
      - cluster.initial_master_nodes=elasticsearch
      - cluster.name=docker-cluster
      - bootstrap.memory_lock=true
      - "ES_JAVA_OPTS=-Xms512m -Xmx512m"
    ulimits:
      memlock:
        soft: -1
        hard: -1
    volumes:
      - esdata1:/usr/share/elasticsearch/data
    ports:
      - 9200:9200
  sidekiq:
    build: .
    volumes:
      - .:/backend
    depends_on:
      - redis
  redis:
      image: redis
  backend:
    build: ./
    volumes:
      - .:/backend
    container_name: instabug
    links:
      - db
      - redis
    ports:
      - "3000:3000"
volumes:
      esdata1:
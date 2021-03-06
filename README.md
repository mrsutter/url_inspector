[![Build Status](https://travis-ci.org/mrsutter/url_inspector.svg?branch=master)](https://travis-ci.org/mrsutter/url_inspector) [![Coverage Status](https://coveralls.io/repos/github/mrsutter/url_inspector/badge.svg?branch=feature%2Fcoveralls)](https://coveralls.io/github/mrsutter/url_inspector?branch=feature%2Fcoveralls)

# UrlInspector

## Описание

Скрипт, запрашивающий урлы с определенным интервалом. Для каждого урла существуют два возможных интервала между запросами:
  * Обычный (если статус предыдущего ответа 20x или 30x)
  * Авральный (в остальных случаях)

Пользователь указывает:

  * путь до файла, содержащего урлы
  * величину обычного и аврального интервала в секундах
  * стратегию инспектирования

## Стратегии

Скрипт работает по одной из двух стратегий, выбранных пользователем:

  * *thread* - каждый урл обрабатывается в отдельном потоке
  * *thread_pool* - скрипт работает в соответствии с паттерном [Thread Pool](https://en.wikipedia.org/wiki/Thread_pool). Размер пула задан в *config/config.yml* и равен 20.

## Логгирование
  Все запросы логируются в файл *log/main.log*.

    [13.04.2016 21:11:41] [85636140] [INFO] url=http://southparkstudios.com/games/create.html next_interval=30
    [13.04.2016 21:11:41] [85636720] [ERROR] url=http://www.sbpost.ie/ next_interval=60

## Установка зависимостей

    bundle install

## Пример запуска

    bundle exec ruby url_inspector.rb yourfile.txt 30 60 thread_pool

## Примеры файлов

В папке *docs/* находятся примеры файлов - *10_urls.txt*, *50_urls.txt* и *500_urls.txt*


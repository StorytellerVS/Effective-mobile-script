# Effective-mobile-script

Проект состоит из Bash-скрипта и systemd-юнитов (таймер и сервис), которые периодически проверяют, запущен ли нужный процесс, и перезапускают его при необходимости. Информация о перезапуске сохраняется в лог.

## Состав проекта

- monitor.sh — скрипт, проверяющий наличие процесса и запускающий его при отсутствии.
- monitor.service — systemd unit для запуска скрипта.
- monitor.timer — systemd таймер для регулярного запуска сервиса.

## Как использовать

1. Установить файлы monitor.sh, monitor.service и monitor.timer в соответствующие директории:
   - Скрипт: /usr/local/bin/monitor.sh
   - Юниты: /etc/systemd/system/

2. Сделать скрипт исполняемым:
   chmod +x /usr/local/bin/monitor.sh

3. Активировать таймер:
   systemctl daemon-reexec
   systemctl enable monitor.timer
   systemctl start monitor.timer

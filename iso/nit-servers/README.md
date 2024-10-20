# README

Данный набор скриптов предназначен для предварительной настройки и активации Microsoft Windows 10/11 Pro и Microsoft Windows Sever 2012 R2, 2022, 2025 Datacenter.

Во время настройки скрипт:

- Разрешает выполнение скриптов Powershell
- Отключает режим усиленной безопасности Microsoft Internet Explorer для текущего пользователя Windows Server
- Настраивает параметры безопасности Internet Explorer
- Отключает автозапуск Server Manager
- Отключает запрос о цели остановки или перезагрузки сервера
- Отключает режим повышенной сложности для задаваемых пользователем паролей
- Создаёт стандартных пользователей с паролями по умолчанию
- Делает пароли этих пользователей не устаревающими
- Чистит системный диск
- Активирует Windows

## Системные требования

1. Компьютер, удовлетворяющий минимальным требованиям к программному обеспечению.
2. Операционная система Microsoft Windows 10/11 редакции PRO или Microsoft Windows Server 2012 R2, 2022, 2025 редакции Datacenter Core, Datacenter Desktop.
3. Установленное окружение рабочего стола (для Desktop Edition), а также Command Shell, Microsoft Managements Framework 5.1, Windows Shell Scripts, WMI Wmic. Данные пакеты (пока) устанавливаются в систему по-умолчанию, необходимо, чтобы их специально не отключали.
4. (Желательно) Microsoft Internet Explorer 11 и поддержке HTML Applications (для автозапуска дисков).

## Расположение программ

- В каталоге `SCRIPTS` расположены собственно файлы скриптов. Для определения последовательности их запуска смотри файл *INSTALL*.
- В каталоге `EDITPAD` содержится текстовый редактор для просмотра файлов скриптов и документации.
- В каталоге `ACTIVATE` содержатся скрипты для активации Microsoft Windows с помощью приватного сервера.


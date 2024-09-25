#!/bin/bash

# chmod +x myscript.sh

# Визначаємо масив з URL вебсайтів для перевірки
sites=(
  "https://google.com"
  "https://facebook.com"
  "https://twitter.com"
)

# Назва файлу логів
logfile="website_status.log"

# Очищаємо файл логів перед записом нових даних
> "$logfile"

# Функція для перевірки статусу сайту
check_site() {
    status_code=$(curl -L -s -o /dev/null -w "%{http_code}" "$1")
    
    if [ "$status_code" -eq "200" ]; then
        echo "$1 is UP" | tee -a "$logfile"
    else
        echo "$1 is DOWN" | tee -a "$logfile"
    fi
}

# Перебір кожного сайту з масиву та виклик функції check_site
for site in "${sites[@]}"; do
  check_site "$site"
done

# Виводимо повідомлення про те, що результати записано у файл логів
echo "Results have been logged to $logfile"
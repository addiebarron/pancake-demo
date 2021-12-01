# Update the database once
/etc/periodic/daily/cron

# Dev 
if [[ $APP_ENV == "dev" ]]; then
    npm run dev
# Prod
else
    npm run build && node ./build
fi
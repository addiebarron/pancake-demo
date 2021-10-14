if [[ $APP_ENV == "dev" ]]; then
    /cron.sh
    npm run dev
else
    # do something more production-y
    npm run build && node ./build
fi
if [[ $APP_ENV == "dev" ]]; then
    npm run dev
else
    # do something more production-y
    npm run build && node ./build
fi
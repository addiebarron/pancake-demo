FROM mhart/alpine-node:16

# Install necessary tools for data processing
RUN apk --update add bash git postgresql-client
# Add data processing as a cron job in the container
RUN npm i -g degit
COPY cron.sh /etc/periodic/daily/

# Install svelte & dependencies
WORKDIR /app
COPY app/package.json app/package-lock.json ./
RUN npm ci

# Copy all local files into the image.
COPY app/ ./

###
# Only copy over the Node pieces we need
# (No npm in this image, make sure only `node ./build` is run)
# ~> Saves 35MB in prod
###
# FROM mhart/alpine-node:slim-16
# WORKDIR /app
# COPY --from=0 /app .

EXPOSE 3000
ENTRYPOINT ["sh", "entrypoint.sh"]
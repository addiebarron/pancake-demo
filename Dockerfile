FROM mhart/alpine-node:16

# Install necessary tools for data processing
RUN apk --update add bash git postgresql-client
RUN npm i -g degit
# Add data processing as a cron job in the container
COPY cron.sh /etc/periodic/daily/

# Copy all local files into the image.
COPY app/ /app/
COPY data/ /data/
# Install svelte & dependencies
WORKDIR /app
RUN npm ci

EXPOSE 3000
ENTRYPOINT ["sh", "app-entrypoint.sh"]
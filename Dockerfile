FROM mhart/alpine-node:16

# Install necessary tools for data processing
RUN apk --update add bash git postgresql-client
RUN npm i -g degit

# Copy local files into the image.
COPY app/ /app/
COPY data/ /data/

# Add data processing as a cron job in the container
COPY /cron /etc/periodic/daily/cron
# Set permissions
RUN chmod +x /etc/periodic/daily/cron
RUN chmod +x /data/process-data.sh

# Only works in prod -- chmod won't work in dev where /data is a volume

# Install svelte & dependencies
WORKDIR /app
RUN npm ci

EXPOSE 3000
ENTRYPOINT ["sh", "app-entrypoint.sh"]

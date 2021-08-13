FROM mhart/alpine-node:12

# install dependencies
WORKDIR /app
COPY app/package.json app/package-lock.json ./
RUN npm ci

# Copy all local files into the image.
COPY app/ .

RUN npm run build

###
# Only copy over the Node pieces we need
# ~> Saves 35MB
###
FROM mhart/alpine-node:slim-12

WORKDIR /app
COPY --from=0 /app .
COPY . .

EXPOSE 3000
CMD ["node", "./build"]
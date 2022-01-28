FROM node:14 as sdk

WORKDIR /app

COPY . /app

RUN npm install

FROM node:14 as builder

WORKDIR /app

COPY --from=sdk /app /app

COPY . /app

RUN npm run build --prod

FROM nginx:1.17.9

WORKDIR /app

RUN rm -rf /usr/share/nginx/html/*

COPY --from=builder /app/dist/hellAngular /usr/share/nginx/html

EXPOSE 80

ENTRYPOINT /bin/sh -c "nginx -g 'daemon off;'"

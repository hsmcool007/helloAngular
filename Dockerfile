FROM node AS builder
# set working directory
WORKDIR /app

# install and cache app dependencies
COPY . /app

# install dependencies and build the angular app
RUN npm install
RUN npm run build --prod

FROM nginx:stable-alpine

# copy from dist to nginx root dir
COPY --from=builder /app/dist/helloAngular  /usr/share/nginx/html

# expose port 80
EXPOSE 80

# set author info
LABEL maintainer="Simon Huang"

# run nginx in foreground
# https://stackoverflow.com/questions/18861300/how-to-run-nginx-within-a-docker-container-without-halting
CMD ["nginx", "-g", "daemon off;"]

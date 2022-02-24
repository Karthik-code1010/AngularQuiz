### STAGE 1: Build ###
FROM node:16.13.1-alpine as builder

WORKDIR /usr/src/app

COPY . .
# ./Dockerfile

#FROM node:12-alpine as node-angular-cli

LABEL authors="Karthik"
# Linux setup
# I got this from another, deprecated Angular CLI image.
# I trust that developer, so I continued to use this, but you
# can leave it out if you want.
RUN apk update \
  && apk add --update alpine-sdk \
  && apk del alpine-sdk \
  && rm -rf /tmp/* /var/cache/apk/* *.tar.gz ~/.npm \
  && npm cache verify \
  && sed -i -e "s/bin\/ash/bin\/sh/" /etc/passwd

# Angular CLI
RUN npm install -g @angular/cli@8


### STAGE 2: Setup ###
FROM nginx:alpine

COPY nginx.conf /etc/nginx/conf.d/
RUN rm -rf /usr/share/nginx/html/*
COPY --from=builder /usr/src/app/dist /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]
EXPOSE 4200
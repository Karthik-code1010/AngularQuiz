# Stage 1: Compile and Build angular codebase

# Use official node image as the base image
#FROM node:latest as build

# ./Dockerfile

FROM node:latest as node-angular-cli

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

# Expose port 80
EXPOSE 80
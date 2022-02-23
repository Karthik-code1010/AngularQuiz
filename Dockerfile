### STAGE 1: Build ###
FROM node:16.13.1-alpine as builder

WORKDIR /usr/src/app

COPY . .

RUN npm i @angular/cli --no-progress --loglevel=error
RUN npm i --only=production --no-progress --loglevel=error

#RUN npm run build:app
RUN npm run build:prod -- --prod

### STAGE 2: Setup ###
FROM nginx:alpine

COPY nginx.conf /etc/nginx/conf.d/
RUN rm -rf /usr/share/nginx/html/*
COPY --from=builder /usr/src/app/dist /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]
EXPOSE 4200
# Stage 1: Compile and Build angular codebase

# Use official node image as the base image
FROM node:latest as build

RUN mkdir -p /app

WORKDIR /app

COPY package.json /app

RUN npm install

COPY . /app

RUN npm run build --prod
# Stage 2
FROM nginx:1.17.1-alpine

COPY --from=builder /app/dist/angularQuizApp/ /usr/share/nginx/html

# Expose port 80
EXPOSE 80
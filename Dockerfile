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
#FROM nginx

#COPY --from=build /app/dist/out/ /usr/share/nginx/html

# Expose port 80
#EXPOSE 80
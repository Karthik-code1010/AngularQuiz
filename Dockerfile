FROM nginx:1.17.1-alpine 

COPY /dist/quizAngular /usr/share/nginx/html 
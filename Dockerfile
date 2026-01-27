FROM nginx:alpine
RUN echo "Hello, Actions!" > /usr/share/nginx/html/index.html

FROM ghcr.io/cirruslabs/flutter:3.7.12 AS build
ARG API_URL=/gestion
WORKDIR /app
COPY . .
RUN printf 'API_URL=%s\n' "$API_URL" > .env \
    && flutter pub get \
    && flutter build web --release --base-href /patient/ --web-renderer html

FROM nginx:stable-alpine
COPY --from=build /app/build/web /usr/share/nginx/html
COPY docker/nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80


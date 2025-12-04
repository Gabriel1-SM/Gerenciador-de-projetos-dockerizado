# Build do Flutter Web com Dart 3.x
FROM ghcr.io/cirruslabs/flutter:latest AS build

WORKDIR /app

# Copia os arquivos
COPY . .

# Baixa dependências
RUN flutter pub get

# Compila para web
RUN flutter build web

# -----------------------------
# Segunda etapa: servidor Nginx
# -----------------------------
FROM nginx:alpine

RUN rm -rf /usr/share/nginx/html/*

COPY --from=build /app/build/web /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

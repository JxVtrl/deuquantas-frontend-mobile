# Etapa 1: Build
FROM node:18-alpine AS builder

# Definir o diretório de trabalho
WORKDIR /app

# Copiar arquivos de dependências
COPY package*.json ./

# Instalar dependências
RUN npm install

# Copiar o restante do código do projeto
COPY . .

# Construir a aplicação Expo para web
RUN npx expo export:web

# Etapa 2: Produção
FROM nginx:alpine AS production

# Copiar arquivos de build do Expo para o diretório padrão do NGINX
COPY --from=builder /app/web-build /usr/share/nginx/html

# Expor a porta do NGINX
EXPOSE 80

# Comando para iniciar o NGINX
CMD ["nginx", "-g", "daemon off;"]

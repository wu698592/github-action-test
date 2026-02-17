# 构建阶段
FROM node:20-alpine as build-stage
WORKDIR /app

# 1. 指向新的文件夹名 app
COPY package*.json ./
RUN npm install

# 2. 拷贝 app 目录下的所有源码
COPY . .
RUN --mount=type=secret,id=ENV_FILE_CONTENT \
    cat /run/secrets/ENV_FILE_CONTENT > .env && \
    npm run build

# --- 生产阶段 ---
FROM nginx:alpine as production-stage

# 3. 拷贝构建产物
COPY --from=build-stage /app/dist /usr/share/nginx/html

# 4. 修正 Nginx 配置
# 确保你的根目录下有一个 nginx.conf 文件
COPY nginx.conf /etc/nginx/templates/default.conf.template

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
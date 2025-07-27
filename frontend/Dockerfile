# 使用官方Node.js 24镜像（最新版本）
FROM node:24-alpine

# 安装curl用于健康检查
RUN apk add --no-cache curl

# 升级npm到最新版本（Node.js 24内置最新npm）
RUN npm install -g npm@latest

# 设置工作目录
WORKDIR /app

# 复制package文件
COPY package*.json ./

# 安装依赖（使用legacy-peer-deps解决Svelte 5兼容性问题）
RUN npm install --legacy-peer-deps

# 复制源代码
COPY . .

# 构建应用
RUN npm run build

# 暴露端口
EXPOSE 3000

# 健康检查
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:3000 || exit 1

# 设置环境变量
ENV NODE_ENV=production
ENV PORT=3000

# 运行应用
CMD ["node", "build"]
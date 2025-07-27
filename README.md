# AI创作平台

基于AI的智能创作平台，支持多人协作、实时编辑、智能生成。

## 🚀 快速开始

### 一键部署（推荐）

#### 跨平台部署
```bash
# Linux/macOS
chmod +x deploy.sh
./deploy.sh

# Windows
deploy.bat
```

### Windows 10/11 Docker 部署指南

#### 1. 安装 Docker Desktop

1. **下载 Docker Desktop**
   - 访问 [Docker Desktop for Windows](https://www.docker.com/products/docker-desktop/)
   - 下载并安装 Docker Desktop for Windows

2. **系统要求**
   - Windows 10 64位：专业版、企业版或教育版（版本1903或更高）
   - 启用 Hyper-V 和容器功能
   - 至少 4GB RAM

3. **安装步骤**
   ```bash
   # 1. 运行下载的 Docker Desktop Installer.exe
   # 2. 按照安装向导完成安装
   # 3. 重启计算机
   # 4. 启动 Docker Desktop
   ```

4. **验证安装**
   ```bash
   # 打开 PowerShell 或 CMD，运行：
   docker --version
   docker-compose --version
   ```

#### 2. 克隆项目

```bash
# 使用 Git 克隆项目（如果没有 Git，请先安装）
git clone https://github.com/chouniu666/ai-creative-platform.git
cd ai-creative-platform

# 或者直接下载 ZIP 文件并解压
```

#### 3. 配置环境变量

```bash
# 复制环境变量模板
copy .env.example .env

# 编辑 .env 文件，配置必要的环境变量
notepad .env
```

**重要配置项：**
```env
# 数据库配置
POSTGRES_DB=ai_creative_platform
POSTGRES_USER=postgres
POSTGRES_PASSWORD=your_secure_password

# JWT密钥（请生成一个安全的密钥）
JWT_SECRET=your_jwt_secret_key_here

# OpenAI API密钥（可选，用于AI功能）
OPENAI_API_KEY=your_openai_api_key_here

# Redis配置
REDIS_PASSWORD=your_redis_password

# 应用配置
APP_ENV=production
APP_PORT=8080
FRONTEND_PORT=3000
```

#### 4. 一键部署

```bash
# 方法一：使用统一部署脚本
deploy.bat

# 方法二：使用Windows专用脚本（修复版）
deploy\windows\deploy-fixed.bat

# 方法三：手动部署
docker-compose up -d

# 查看服务状态
docker-compose ps

# 查看日志
docker-compose logs -f
```

#### 5. 访问应用

- **前端应用**: http://localhost:3000
- **后端API**: http://localhost:8080
- **API文档**: http://localhost:8080/docs
- **数据库管理**: http://localhost:8081 (Adminer)
- **监控面板**: http://localhost:3001 (Grafana)

#### 6. 停止服务

```bash
# 停止所有服务
docker-compose down

# 停止并删除数据卷（注意：会删除所有数据）
docker-compose down -v
```

## 🛠️ 开发环境设置

### 后端开发

```bash
# 进入后端目录
cd backend

# 安装 Go 依赖
go mod download

# 运行开发服务器
go run cmd/server/main.go
```

### 前端开发

```bash
# 进入前端目录
cd frontend

# 安装 Node.js 依赖
npm install

# 运行开发服务器
npm run dev
```

## 📋 功能特性

### 🤖 AI智能创作
- 基于 GPT-4 的智能写作助手
- 专业化 Prompt 模板
- 内容生成、分析、优化
- 智能续写和补全

### 👥 实时协作
- 多人同时编辑
- 实时同步更新
- 用户活动追踪
- 冲突解决机制

### 📝 可视化编辑
- 7种创作节点类型
- 直观的节点连接
- Monaco 编辑器集成
- 版本控制系统

### 🔒 安全可靠
- JWT 认证体系
- 基于角色的权限控制
- 数据加密存储
- API 请求限流

## 🏗️ 技术架构

### 后端技术栈
- **Go 1.24** + Gin 框架
- **PostgreSQL 16** + GORM ORM
- **Redis 7** 缓存和会话
- **Qdrant** 向量数据库
- **OpenAI API** 集成
- **WebSocket** 实时通信

### 前端技术栈
- **SvelteKit 2.0** + TypeScript 5.0
- **TailwindCSS 3.3** 原子化样式
- **Monaco Editor** 代码编辑器
- **PWA** 渐进式Web应用

### 基础设施
- **Docker** 容器化部署
- **Nginx** 反向代理
- **Prometheus** + **Grafana** 监控
- **Redis** 缓存和会话存储

## 📊 系统监控

### 健康检查
```bash
# 检查所有服务状态
curl http://localhost:8080/health

# 检查数据库连接
curl http://localhost:8080/health/db

# 检查 Redis 连接
curl http://localhost:8080/health/redis
```

### 性能监控
- **Grafana 面板**: http://localhost:3001
- **默认登录**: admin/admin
- **预配置仪表板**: 系统性能、API 指标、用户活动

## 🔧 故障排除

### 常见问题

1. **Docker 启动失败**
   ```bash
   # 检查 Docker 服务状态
   docker info
   
   # 重启 Docker Desktop
   # 右键系统托盘 Docker 图标 -> Restart
   ```

2. **端口冲突**
   ```bash
   # 检查端口占用
   netstat -ano | findstr :3000
   netstat -ano | findstr :8080
   
   # 修改 docker-compose.yml 中的端口映射
   ```

3. **数据库连接失败**
   ```bash
   # 检查数据库容器状态
   docker-compose logs postgres
   
   # 重启数据库服务
   docker-compose restart postgres
   ```

4. **前端构建失败**
   ```bash
   # 清理 node_modules 和重新安装
   cd frontend
   rmdir /s node_modules
   npm install
   ```

### 日志查看
```bash
# 查看所有服务日志
docker-compose logs

# 查看特定服务日志
docker-compose logs backend
docker-compose logs frontend
docker-compose logs postgres

# 实时跟踪日志
docker-compose logs -f backend
```

## 📚 API 文档

### 认证 API
- `POST /api/v1/auth/register` - 用户注册
- `POST /api/v1/auth/login` - 用户登录
- `POST /api/v1/auth/refresh` - 刷新令牌
- `POST /api/v1/auth/logout` - 用户登出

### 项目 API
- `GET /api/v1/projects` - 获取项目列表
- `POST /api/v1/projects` - 创建项目
- `GET /api/v1/projects/{id}` - 获取项目详情
- `PUT /api/v1/projects/{id}` - 更新项目
- `DELETE /api/v1/projects/{id}` - 删除项目

### AI API
- `POST /api/v1/ai/generate` - AI 内容生成
- `POST /api/v1/ai/analyze` - 内容分析
- `POST /api/v1/ai/optimize` - 内容优化

## 🤝 贡献指南

1. Fork 项目
2. 创建功能分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 打开 Pull Request

## 📄 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情。

## 📞 支持

如果您遇到任何问题或需要帮助，请：

1. 查看 [FAQ](docs/FAQ.md)
2. 搜索 [Issues](https://github.com/chouniu666/ai-creative-platform/issues)
3. 创建新的 Issue
4. 联系我们：support@ai-creative-platform.com

---

**让AI成为您的创作伙伴！** 🚀
# Google Gemini API 配置指南

本指南将帮助您配置AI创作平台使用Google Gemini API。

## 🚀 快速配置

### 1. 复制Gemini配置文件
```bash
# 复制专门的Gemini配置文件
copy .env.gemini .env
```

### 2. 验证您的Gemini API配置
您提供的配置看起来是正确的：
```env
OPENAI_API_KEY=AIzaSyCEx1qe-q9QZpkmzvOvB5TL8FU5kOcDtGo
OPENAI_BASE_URL=https://generativelanguage.googleapis.com/v1beta/openai/
AI_DEFAULT_MODEL=gemini-2.0-flash-exp
```

## 🔧 Gemini API 详细配置

### API Key 获取
1. 访问 [Google AI Studio](https://aistudio.google.com/)
2. 登录您的Google账户
3. 创建新的API Key
4. 复制API Key到配置文件

### 可用模型列表
```env
# 推荐模型（按性能排序）
AI_DEFAULT_MODEL=gemini-2.0-flash-exp    # 最新实验版本，性能最佳
AI_DEFAULT_MODEL=gemini-1.5-pro          # 专业版本，平衡性能和成本
AI_DEFAULT_MODEL=gemini-1.5-flash        # 快速版本，响应速度快
AI_DEFAULT_MODEL=gemini-1.0-pro          # 标准版本，稳定可靠
```

### 模型特性对比
| 模型 | 特点 | 适用场景 | 成本 |
|------|------|----------|------|
| gemini-2.0-flash-exp | 最新技术，性能最强 | 复杂创作任务 | 较高 |
| gemini-1.5-pro | 平衡性能和成本 | 通用创作任务 | 中等 |
| gemini-1.5-flash | 响应速度快 | 实时对话 | 较低 |
| gemini-1.0-pro | 稳定可靠 | 基础创作任务 | 最低 |

## 📋 完整配置文件示例

```env
# ===========================================
# AI服务配置 - Google Gemini
# ===========================================
# 您的Gemini API Key
OPENAI_API_KEY=AIzaSyCEx1qe-q9QZpkmzvOvB5TL8FU5kOcDtGo

# Gemini API端点
OPENAI_BASE_URL=https://generativelanguage.googleapis.com/v1beta/openai/

# 选择Gemini模型
AI_DEFAULT_MODEL=gemini-2.0-flash-exp

# AI参数配置
AI_MAX_TOKENS=2000          # 最大输出长度
AI_TEMPERATURE=0.7          # 创意度 (0.0-1.0)
AI_TIMEOUT=30s              # 请求超时时间

# ===========================================
# 数据库配置
# ===========================================
DB_HOST=postgres
DB_PORT=5432
DB_NAME=ai_creative
DB_USER=postgres
DB_PASSWORD=ai_creative_secure_2025

# ===========================================
# 应用配置
# ===========================================
APP_ENV=production
APP_PORT=8080
FRONTEND_PORT=3000
```

## 🔍 配置验证

### 1. 测试API连接
部署后可以通过以下方式测试：
```bash
# 检查后端健康状态
curl http://localhost:8080/health

# 测试AI生成功能
curl -X POST http://localhost:8080/api/v1/ai/generate \
  -H "Content-Type: application/json" \
  -d '{"prompt": "写一个简短的故事开头", "model": "gemini-2.0-flash-exp"}'
```

### 2. 查看日志
```bash
# 查看后端日志
docker-compose logs backend

# 查看AI服务日志
docker-compose logs backend | grep "AI"
```

## ⚙️ 高级配置

### 1. 性能优化
```env
# 针对Gemini优化的配置
AI_MAX_TOKENS=4000          # Gemini支持更长的输出
AI_TEMPERATURE=0.8          # Gemini在较高温度下表现更好
RATE_LIMIT_REQUESTS=50      # 根据API配额调整
```

### 2. 成本控制
```env
# 成本控制配置
AI_MAX_TOKENS=1000          # 限制输出长度降低成本
AI_DEFAULT_MODEL=gemini-1.5-flash  # 使用成本较低的模型
```

### 3. 创作优化
```env
# 创作任务优化
AI_TEMPERATURE=0.9          # 提高创意度
AI_MAX_TOKENS=3000          # 允许更长的创作内容
```

## 🚨 常见问题

### Q: API Key无效
```
A: 解决方案：
1. 确认API Key正确复制
2. 检查Google AI Studio中API Key状态
3. 确认API Key有足够的配额
4. 重新生成API Key
```

### Q: 模型不可用
```
A: 解决方案：
1. 检查模型名称拼写
2. 确认您的账户有权限访问该模型
3. 尝试使用其他可用模型
4. 查看Google AI Studio的模型列表
```

### Q: 请求超时
```
A: 解决方案：
1. 增加AI_TIMEOUT值
2. 减少AI_MAX_TOKENS
3. 检查网络连接
4. 降低AI_TEMPERATURE
```

### Q: 配额超限
```
A: 解决方案：
1. 检查Google AI Studio的配额使用情况
2. 升级您的API计划
3. 调整RATE_LIMIT_REQUESTS
4. 优化请求频率
```

## 📊 监控和调试

### 1. 启用AI调试
```env
DEBUG_AI=true
LOG_LEVEL=debug
```

### 2. 监控API使用
- 访问 http://localhost:3001 查看Grafana监控面板
- 查看API调用统计和成本分析
- 监控响应时间和错误率

### 3. 日志分析
```bash
# 查看AI相关日志
docker-compose logs backend | grep "Gemini\|AI\|OpenAI"

# 查看错误日志
docker-compose logs backend | grep "ERROR"
```

## 🎯 最佳实践

### 1. 模型选择策略
- **开发环境**: 使用 `gemini-1.5-flash` 快速测试
- **生产环境**: 使用 `gemini-1.5-pro` 平衡性能和成本
- **高质量创作**: 使用 `gemini-2.0-flash-exp` 获得最佳效果

### 2. 参数调优
- **小说创作**: `AI_TEMPERATURE=0.8-0.9`
- **技术文档**: `AI_TEMPERATURE=0.3-0.5`
- **对话生成**: `AI_TEMPERATURE=0.7-0.8`

### 3. 成本优化
- 设置合理的 `AI_MAX_TOKENS` 限制
- 使用缓存减少重复请求
- 根据任务类型选择合适的模型

## 🔄 部署步骤

1. **配置文件准备**
   ```bash
   copy .env.gemini .env
   # 编辑.env文件，确认API Key正确
   ```

2. **启动服务**
   ```bash
   # Windows
   deploy\windows\deploy-fixed.bat
   
   # Linux/macOS
   ./deploy/linux/deploy.sh
   ```

3. **验证部署**
   ```bash
   # 检查服务状态
   docker-compose ps
   
   # 测试AI功能
   curl http://localhost:8080/health
   ```

现在您的AI创作平台已经配置为使用Google Gemini API！🎉
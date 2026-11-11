# Spring Boot HelloWorld + Spring Security

一个基于 **Spring Boot 3.2.0** 的示例项目，演示「受 Spring Security 保护的 HelloWorld 接口」和「用户名密码登录接口」。

## 功能

| 接口 | 方法 | 说明 |
|------|------|------|
| `/hello` | GET | 需要认证，认证通过后返回 `Hello World` |
| `/login` | POST | 用户名密码登录，返回登录结果 |

## 默认账号

- 用户名：`test`
- 密码：`123456`

（密码使用 BCrypt 编码后存储在内存中。）

## 技术栈

- Java 17
- Spring Boot 3.2.0
- Spring Security（内存用户 + HTTP Basic 认证）
- Maven

## 运行

```bash
# 使用 Maven Wrapper（无需本机安装 Maven）
./mvnw spring-boot:run

# 或本地已装 Maven
mvn spring-boot:run
```

应用启动后监听 `http://localhost:8080`。

## 接口调用示例

### 1. 登录

```bash
curl -X POST http://localhost:8080/login \
  -H "Content-Type: application/json" \
  -d '{"username":"test","password":"123456"}'
```

成功响应：

```json
{"message":"Login successful","username":"test"}
```

密码错误返回 `401`：

```json
{"message":"Invalid username or password"}
```

### 2. 访问受保护的 HelloWorld 接口

未认证直接访问会返回 `401`：

```bash
curl -i http://localhost:8080/hello
# HTTP/1.1 401
```

使用 HTTP Basic 认证访问：

```bash
curl -u test:123456 http://localhost:8080/hello
# Hello World
```

## 测试

```bash
./mvnw test
```

测试覆盖：
- `/hello` 未认证 → 401
- `/hello` 已认证 → 200 `Hello World`
- `/login` 正确凭据 → 200
- `/login` 错误凭据 → 401

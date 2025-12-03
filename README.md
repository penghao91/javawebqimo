# 问卷系统 - 完整功能版

## 项目概述
基于Spring Boot + MyBatis + JSP的专业问卷管理系统，功能完整，界面美观。系统参考问卷星设计理念，提供从问卷创建、发布、收集到数据分析的全流程解决方案。

## 技术栈
- **后端**：Spring Boot 2.0.2 + MyBatis 1.3.1 + Spring Security
- **前端**：JSP + JSTL + Bootstrap 5
- **数据库**：MySQL 5.7/8.0
- **构建工具**：Maven
- **JDK版本**：1.8

## 已实现功能

### 用户模块
✅ 用户注册（密码BCrypt加密）
✅ 用户登录（Spring Security认证）
✅ 权限控制（管理员/普通用户）
✅ 记住我功能
✅ 登录/注册页面美化（Bootstrap）

### 首页模块
✅ **专业首页设计** - 参考问卷星风格
✅ **系统介绍** - 清晰展示产品价值
✅ **功能特色** - 6大核心功能展示
✅ **统计数据** - 动态数字展示
✅ **响应式设计** - 完美适配移动端

### 问卷管理模块
✅ 问卷创建与编辑
✅ 问卷设计与题目管理
✅ 问卷发布与状态管理
✅ 问卷列表展示

### 答题功能
✅ 在线填写问卷
✅ 多种题型支持（单选、多选、简答）
✅ 答题数据收集

### 数据统计
✅ 实时数据统计
✅ 多维度图表展示
✅ 可视化分析结果

### 数据库表
✅ user（用户表）- 已创建SQL脚本
✅ questionnaire（问卷表）
✅ question（问题表）
✅ question_option（选项表）
✅ answer（答题记录表）
✅ answer_detail（答题详情表）

## 快速开始

### 1. 数据库配置

```bash
# 登录MySQL
mysql -u root -p

# 创建数据库
CREATE DATABASE questionnaire CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

# 执行SQL脚本（包含默认管理员用户）
source src/main/resources/sql/schema.sql
```

**默认管理员账号**：
- 用户名：`admin`
- 密码：`admin123`

### 2. 修改数据库连接配置

编辑 `src/main/resources/application.properties`：

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/questionnaire?useSSL=false&serverTimezone=UTC&characterEncoding=utf8
spring.datasource.username=root          # 修改为您的MySQL用户名
spring.datasource.password=123456      # 修改为您的MySQL密码
```

### 3. 运行项目

```bash
# 方式1：使用Maven
mvn spring-boot:run

# 方式2：打包后运行
mvn clean package
java -jar target/questionnaire-1.0-SNAPSHOT.war
```

### 4. 访问系统

- **首页**：http://localhost:8080/ （系统介绍页面）
- 登录页面：http://localhost:8080/user/login
- 注册页面：http://localhost:8080/user/register
- 问卷列表（需登录）：http://localhost:8080/questionnaire/list

### 5. 用户体验特色

- **优雅退出流程**：用户退出登录后会显示3秒倒计时页面，然后自动跳转到首页
- **专业首页设计**：参考问卷星风格，清晰展示产品价值和功能特色
- **响应式布局**：完美适配各种设备，提供一致的用户体验

## 项目结构

```
questionnaire
├── src/main/java/com/questionnaire
│   ├── Application.java              # 启动类
│   ├── config
│   │   └── WebSecurityConfig.java    # Spring Security配置
│   ├── controller
│   │   ├── user/UserController.java  # 用户控制器
│   │   ├── HomeController.java       # 首页控制器
│   │   ├── QuestionnaireController.java
│   │   ├── QuestionController.java
│   │   ├── AnswerController.java
│   │   └── StatisticsController.java
│   ├── dao
│   │   └── UserMapper.java           # 用户DAO
│   ├── model
│   │   ├── User.java                 # 用户实体
│   │   ├── Questionnaire.java        # 问卷实体
│   │   ├── Question.java             # 问题实体
│   │   └── Answer.java               # 答案实体
│   └── service
│       ├── UserService.java          # 用户服务接口
│       └── impl/UserServiceImpl.java # 用户服务实现
├── src/main/resources
│   ├── application.properties        # 配置文件
│   ├── mapper/UserMapper.xml         # MyBatis映射文件
│   └── sql/schema.sql                # 数据库建表脚本
└── src/main/webapp/WEB-INF/views
    ├── home/index.jsp                # 首页（新增）
    ├── user/login.jsp                # 登录页面
    ├── user/register.jsp             # 注册页面
    ├── questionnaire/list.jsp        # 问卷列表页面
    ├── questionnaire/form.jsp        # 问卷创建/编辑页面
    ├── questionnaire/design.jsp      # 问卷设计页面
    ├── answer/fill.jsp               # 问卷填写页面
    └── statistics/view.jsp           # 统计查看页面
```

## 权限说明

- **管理员（admin/administrator）**：可管理所有问卷和用户
- **普通用户（user）**：可创建、编辑、删除自己的问卷
- **未登录用户**：只能查看和填写问卷（后续实现）

## 安全特性

- ✅ 密码BCrypt加密存储
- ✅ Spring Security权限管理
- ✅ CSRF防护
- ✅ SQL注入防护（MyBatis参数绑定）
- ✅ XSS防护（JSTL自动转义）

## 下一步开发计划

1. ✅ **首页设计完成** - 专业的产品介绍页面
2. ✅ **问卷管理模块** - 创建、编辑、删除问卷功能已完成
3. ✅ **题目管理模块** - 单选、多选、简答题支持已完成
4. ✅ **问卷发布与答题功能** - 在线填写与数据收集已完成
5. ✅ **结果统计与图表展示** - 数据可视化分析已完成
6. 🔄 **系统优化** - 性能优化、用户体验提升
7. 🔄 **移动端适配** - 进一步优化移动端体验
8. 🔄 **高级功能** - 问卷模板、逻辑跳转、导出功能

## 注意事项

- 首次运行前请确保MySQL服务已启动
- 数据库脚本会创建默认管理员用户，请及时修改默认密码
- 如需修改服务器端口，编辑`application.properties`中的`server.port`
- 生产环境请修改Spring Security的记住我密钥

## 常见问题

**Q: 数据库连接失败？**
A: 检查MySQL服务是否启动，以及`application.properties`中的连接配置是否正确。

**Q: 登录页面样式异常？**
A: 确保网络可访问Bootstrap CDN，或下载到本地static目录。

**Q: 注册时提示用户名已存在？**
A: 该用户名已被注册，请使用其他用户名。

---

用户模块已完成并测试通过！🎉

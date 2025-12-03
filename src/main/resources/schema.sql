-- 用户表
CREATE TABLE IF NOT EXISTS user (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE COMMENT '用户名',
    password VARCHAR(255) NOT NULL COMMENT '密码',
    email VARCHAR(100) COMMENT '邮箱',
    role VARCHAR(20) DEFAULT 'user' COMMENT '角色：admin/administrator/user',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_username (username)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- 问卷表
CREATE TABLE IF NOT EXISTS questionnaire (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL COMMENT '问卷标题',
    description TEXT COMMENT '问卷描述',
    created_by INT NOT NULL COMMENT '创建用户ID',
    status TINYINT DEFAULT 1 COMMENT '状态：1-草稿，2-已发布',
    is_starred TINYINT DEFAULT 0 COMMENT '是否星标：0-否，1-是',
    is_deleted TINYINT DEFAULT 0 COMMENT '是否删除：0-否，1-是',
    deleted_time DATETIME DEFAULT NULL COMMENT '删除时间',
    folder_id INT DEFAULT NULL COMMENT '文件夹ID',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by) REFERENCES user(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='问卷表';

-- 问题表
CREATE TABLE IF NOT EXISTS question (
    id INT PRIMARY KEY AUTO_INCREMENT,
    questionnaire_id INT NOT NULL COMMENT '所属问卷ID',
    question_text TEXT NOT NULL COMMENT '问题内容',
    question_type TINYINT NOT NULL COMMENT '题型：1-单选，2-多选，3-简答',
    question_order INT DEFAULT 0 COMMENT '问题顺序',
    is_required TINYINT DEFAULT 1 COMMENT '是否必填：1-是，0-否',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (questionnaire_id) REFERENCES questionnaire(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='问题表';

-- 选项表
CREATE TABLE IF NOT EXISTS question_option (
    id INT PRIMARY KEY AUTO_INCREMENT,
    question_id INT NOT NULL COMMENT '所属问题ID',
    option_text VARCHAR(500) NOT NULL COMMENT '选项内容',
    option_order INT DEFAULT 0 COMMENT '选项顺序',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (question_id) REFERENCES question(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='选项表';

-- 用户答题记录表
CREATE TABLE IF NOT EXISTS answer (
    id INT PRIMARY KEY AUTO_INCREMENT,
    questionnaire_id INT NOT NULL COMMENT '问卷ID',
    user_id INT COMMENT '用户ID（未登录可为空）',
    submit_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    ip_address VARCHAR(45) COMMENT '提交IP',
    FOREIGN KEY (questionnaire_id) REFERENCES questionnaire(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES user(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户答题记录表';

-- 答题详情表
CREATE TABLE IF NOT EXISTS answer_detail (
    id INT PRIMARY KEY AUTO_INCREMENT,
    answer_id INT NOT NULL COMMENT '答题记录ID',
    question_id INT NOT NULL COMMENT '问题ID',
    answer_text TEXT COMMENT '答案内容',
    FOREIGN KEY (answer_id) REFERENCES answer(id) ON DELETE CASCADE,
    FOREIGN KEY (question_id) REFERENCES question(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='答题详情表';

-- 文件夹表
CREATE TABLE IF NOT EXISTS folder (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL COMMENT '文件夹名称',
    user_id INT NOT NULL COMMENT '用户ID',
    parent_id INT DEFAULT NULL COMMENT '父文件夹ID',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES user(id),
    FOREIGN KEY (parent_id) REFERENCES folder(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='文件夹表';

-- 插入默认管理员账号（密码：admin123）
INSERT IGNORE INTO user (username, password, email, role, create_time, update_time) 
VALUES ('admin', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBaUKkGzE6U6R6', 'admin@example.com', 'admin', NOW(), NOW());

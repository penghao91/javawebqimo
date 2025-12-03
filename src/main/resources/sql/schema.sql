-- 用户表
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(50) NOT NULL UNIQUE COMMENT '用户名',
  `password` varchar(100) NOT NULL COMMENT '密码（BCrypt加密）',
  `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `role` varchar(20) NOT NULL DEFAULT 'user' COMMENT '角色：admin/administrator/user',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- 插入默认管理员用户（密码：admin123）
INSERT INTO `user` (username, password, email, role) VALUES 
('admin', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBa3B6nOGAHFWG', 'admin@questionnaire.com', 'admin');

-- 问卷表
CREATE TABLE IF NOT EXISTS `questionnaire` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '问卷ID',
  `title` varchar(200) NOT NULL COMMENT '问卷标题',
  `description` text COMMENT '问卷描述',
  `user_id` int(11) NOT NULL COMMENT '创建用户ID',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态：0-草稿 1-已发布',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='问卷表';

-- 问题表
CREATE TABLE IF NOT EXISTS `question` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '问题ID',
  `questionnaire_id` int(11) NOT NULL COMMENT '所属问卷ID',
  `question_text` text NOT NULL COMMENT '问题内容',
  `question_type` varchar(20) NOT NULL COMMENT '问题类型：single-单选 multiple-多选 text-简答',
  `sort_order` int(11) DEFAULT '0' COMMENT '排序',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_questionnaire_id` (`questionnaire_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='问题表';

-- 选项表
CREATE TABLE IF NOT EXISTS `question_option` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '选项ID',
  `question_id` int(11) NOT NULL COMMENT '问题ID',
  `option_text` varchar(500) NOT NULL COMMENT '选项内容',
  `sort_order` int(11) DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`),
  KEY `idx_question_id` (`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='选项表';

-- 用户答题记录表
CREATE TABLE IF NOT EXISTS `answer` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '答题记录ID',
  `questionnaire_id` int(11) NOT NULL COMMENT '问卷ID',
  `user_id` int(11) DEFAULT NULL COMMENT '用户ID（未登录用户为null）',
  `ip_address` varchar(50) DEFAULT NULL COMMENT 'IP地址',
  `submit_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '提交时间',
  PRIMARY KEY (`id`),
  KEY `idx_questionnaire_id` (`questionnaire_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户答题记录表';

-- 答题详情表
CREATE TABLE IF NOT EXISTS `answer_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '答题详情ID',
  `answer_id` int(11) NOT NULL COMMENT '答题记录ID',
  `question_id` int(11) NOT NULL COMMENT '问题ID',
  `answer_text` text COMMENT '答案内容',
  PRIMARY KEY (`id`),
  KEY `idx_answer_id` (`answer_id`),
  KEY `idx_question_id` (`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='答题详情表';
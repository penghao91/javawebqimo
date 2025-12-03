-- 更新问卷表结构，添加新字段
ALTER TABLE questionnaire 
ADD COLUMN is_starred TINYINT DEFAULT 0 COMMENT '是否星标：0-否，1-是' AFTER status,
ADD COLUMN is_deleted TINYINT DEFAULT 0 COMMENT '是否删除：0-否，1-是' AFTER is_starred,
ADD COLUMN folder_id INT DEFAULT NULL COMMENT '文件夹ID' AFTER is_deleted;

-- 创建文件夹表
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

-- 插入默认文件夹
INSERT IGNORE INTO folder (name, user_id, parent_id) 
SELECT '默认文件夹', id, NULL FROM user WHERE username = 'admin';

-- 更新现有问卷的默认值为未删除
UPDATE questionnaire SET is_deleted = 0 WHERE is_deleted IS NULL;
UPDATE questionnaire SET is_starred = 0 WHERE is_starred IS NULL;

-- 添加索引
ALTER TABLE questionnaire ADD INDEX idx_is_starred (is_starred);
ALTER TABLE questionnaire ADD INDEX idx_is_deleted (is_deleted);
ALTER TABLE questionnaire ADD INDEX idx_folder_id (folder_id);

SELECT '数据库更新完成！' AS message;
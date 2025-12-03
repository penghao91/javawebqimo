-- 添加删除时间字段
ALTER TABLE questionnaire 
ADD COLUMN deleted_time DATETIME DEFAULT NULL COMMENT '删除时间' AFTER is_deleted;

-- 添加索引
ALTER TABLE questionnaire ADD INDEX idx_deleted_time (deleted_time);

-- 更新现有已删除问卷的删除时间（如果有的话）
UPDATE questionnaire SET deleted_time = update_time WHERE is_deleted = 1 AND deleted_time IS NULL;

SELECT '数据库更新完成！' AS message;
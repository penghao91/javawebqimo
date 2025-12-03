-- 更新 admin 密码为 123456
USE questionnaire;

-- 123456 的 BCrypt 加密结果
UPDATE user SET 
    password = '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBa3B6nOGAHFWG',
    update_time = NOW()
WHERE username = 'admin';

-- 验证更新结果
SELECT username, role FROM user WHERE username = 'admin';

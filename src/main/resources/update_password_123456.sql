-- 更新 admin 密码为 123456
USE questionnaire;

-- 123456 的 BCrypt 加密结果
UPDATE user SET 
    password = '$2a$10$8UnKEMQZ3jJ9L3jJCLlR6e8tN5J5J5J5J5J5J5J5J5J5J5J5J5J5J5',
    update_time = NOW()
WHERE username = 'admin';

-- 验证更新结果
SELECT username, role FROM user WHERE username = 'admin';

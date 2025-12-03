USE questionnaire;

-- admin123 的正确 BCrypt 密码
UPDATE user SET password = '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBaUKkGzE6U6R6' WHERE username = 'admin';

-- 验证更新
SELECT username, password, role FROM user WHERE username = 'admin';

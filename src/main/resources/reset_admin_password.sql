-- [FINAL SCRIPT - PLAINTEXT DEBUG]
-- Resets the admin user's password to the PLAINTEXT password 'admin123'.
-- This is for debugging the authentication flow and is NOT a secure practice.

UPDATE `user`
SET 
    `password` = 'admin123',
    `update_time` = NOW()
WHERE 
    `username` = 'admin';
package com.questionnaire.service;

import com.questionnaire.dao.UserDao;
import com.questionnaire.model.User;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

@Service
@Transactional
public class UserService {

    @Resource
    private UserDao userDao;

    /**
     * 根据用户名查询用户
     */
    public User findByUsername(String username) {
        return userDao.findByUsername(username);
    }

    /**
     * 根据ID查询用户
     */
    public User findById(Integer id) {
        return userDao.findById(id);
    }

    /**
     * 注册新用户（明文密码、设置默认角色）
     */
    public boolean register(User user) {
        if (usernameExists(user.getUsername())) {
            return false;
        }

        // 设置默认角色
        if (user.getRole() == null || user.getRole().isEmpty()) {
            user.setRole("user");
        }

        return userDao.insert(user) > 0;
    }

    /**
     * 判断用户名是否已存在
     */
    public boolean usernameExists(String username) {
        return userDao.countByUsername(username) > 0;
    }

    /**
     * 更新账号信息（主要是邮箱）
     */
    public void updateProfile(User user) {
        userDao.updateProfile(user);
    }

    /**
     * 查询除当前用户外是否有同邮箱
     */
    public boolean existsByEmailExceptUser(String email, Integer userId) {
        Integer count = userDao.countByEmailExceptUser(email, userId);
        return count != null && count > 0;
    }

    /**
     * 校验密码
     */
    public boolean checkPassword(Integer userId, String rawPassword) {
        User user = userDao.findById(userId);
        if (user == null) return false;

        // 根据你现在的密码存储方式来，以下假设明文 / 简单加密
        return rawPassword.equals(user.getPassword());
    }

    /**
     * 更新密码
     */
    public void updatePassword(Integer userId, String newPassword) {
        userDao.updatePassword(userId, newPassword);
    }
}
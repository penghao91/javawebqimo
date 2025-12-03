package com.questionnaire.service;

import com.questionnaire.model.User;
import org.springframework.security.core.userdetails.UserDetailsService;

/**
 * User service interface that integrates with Spring Security by extending UserDetailsService.
 */
public interface UserService extends UserDetailsService {

    /**
     * Finds a user by their unique ID.
     * @param id The user's ID.
     * @return The User object or null if not found.
     */
    User findById(Integer id);

    /**
     * Registers a new user in the system.
     * The implementation should handle password encoding.
     * @param user The user object with plaintext password.
     * @return true if registration is successful, false otherwise.
     */
    boolean register(User user);

    /**
     * Checks if a username already exists.
     * @param username The username to check.
     * @return true if the username exists, false otherwise.
     */
    boolean usernameExists(String username);
    
    /**
     * Finds a user by their username.
     * This is a convenience method, while loadUserByUsername is used by Spring Security.
     * @param username The username to find.
     * @return The User object or null if not found.
     */
    User findByUsername(String username);
}

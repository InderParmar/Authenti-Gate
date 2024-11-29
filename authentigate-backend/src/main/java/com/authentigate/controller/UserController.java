package com.authentigate.controller;

import com.authentigate.models.User;
import com.authentigate.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/users")
public class UserController {

    @Autowired
    private UserService userService;

    // User registration
    @PostMapping("/register")
    public ResponseEntity<Map<String, String>> registerUser(@RequestBody User user) {
        if (userService.findByEmail(user.getEmail()) != null) {
            Map<String, String> response = new HashMap<>();
            response.put("message", "Email is already in use.");
            return ResponseEntity.badRequest().body(response);
        }
        userService.registerUser(user);
        Map<String, String> response = new HashMap<>();
        response.put("message", "User registered successfully.");
        return ResponseEntity.ok(response);
    }

    // User login
    @PostMapping("/login")
    public ResponseEntity<Map<String, String>> loginUser(@RequestBody Map<String, String> request) {
        String email = request.get("email");
        String password = request.get("password");

        User user = userService.findByEmail(email);
        if (user == null) {
            Map<String, String> response = new HashMap<>();
            response.put("message", "Invalid email or password.");
            return ResponseEntity.status(401).body(response);
        }

        boolean isAuthenticated = userService.verifyPassword(password, user.getPasswordHash());
        if (!isAuthenticated) {
            Map<String, String> response = new HashMap<>();
            response.put("message", "Invalid email or password.");
            return ResponseEntity.status(401).body(response);
        }

        Map<String, String> response = new HashMap<>();
        response.put("message", "Login successful.");
        return ResponseEntity.ok(response);
    }

    // Get user by email
    @GetMapping("/{email}")
    public ResponseEntity<User> getUserByEmail(@PathVariable String email) {
        User user = userService.findByEmail(email);
        if (user == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(user);
    }
}

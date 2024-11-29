package com.authentigate.models;

import lombok.Data;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "Users")
@Data
public class User {
    @Id
    private String id;
    private String firstName;
    private String lastName;
    private String email;
    private String password; // Raw password for input
    private String passwordHash; // Hashed password for storage
    private String contactNumber;
    private String authType; // e.g., face or face_finger
}

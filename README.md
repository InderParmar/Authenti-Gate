# AuthentiGate

AuthentiGate is a secure authentication platform that integrates advanced face and finger gesture recognition for user registration and login. It leverages cutting-edge machine learning models and a robust architecture to ensure scalability, reliability, and security.

---

## 🚀 Features

### **Functional Features**
1. **User Registration**
   - Create accounts with username, email, and password.
   - Set up face lock using face and finger gesture recognition.

2. **User Login**
   - Authenticate with credentials and face/finger gestures.
   - Secure login and validation workflows.

3. **Data Encryption**
   - All user credentials and biometric data are securely encrypted.

---

## 🛠️ Architecture Overview

### **Frontend**
- Built with **Flutter** for cross-platform support.
- Provides a responsive and user-friendly interface.

### **Backend**
- Developed with **Java Spring Boot**.
- Handles API endpoints, business logic, and secure data interactions.

### **Database**
- **MongoDB** hosted on a cloud provider.
- Securely stores user credentials and authentication logs.

### **Face Lock Integration**
- Utilizes **Azure Face API** or a custom machine learning model for gesture recognition.

### **Hosting**
- Hosted on a reliable cloud platform for scalability.

---

## 📋 Requirements

### **Functional Requirements**
- Register users with secure credential storage.
- Authenticate using credentials and biometric data.
- Provide user-friendly error messages for authentication failures.

### **Non-Functional Requirements**
- Encrypt data during storage and transmission.
- Limit login attempts to five consecutive failures.

### **Compliance**
- Complies with relevant data protection regulations.
- Allows users to delete accounts and associated data.

---

## 🧰 Technology Stack

| Component                | Technology                     |
|--------------------------|---------------------------------|
| **Frontend**             | Flutter                        |
| **Backend**              | Java Spring Boot               |
| **Database**             | MongoDB                        |
| **Face Lock Integration**| Azure Face API / Custom ML Model|
| **Hosting**              | Cloud Hosting Platform         |

---

## 🌟 Advantages

1. **Scalable:** Designed to handle high traffic and large user bases.
2. **Secure:** Advanced encryption and HTTPS protocols ensure data safety.
3. **Responsive Design:** Supports both desktop and mobile platforms.
4. **Future-Proof:** Easily extendable to integrate features like voice authentication.

---

## 📜 How to Run

1. **Clone the Repository**
   ```bash
   git clone https://github.com/InderParmar/AuthentiGate.git
   cd AuthentiGate
   ```

2. **Set Up Environment Variables**
   Create a `.env` file with the following:
   ```plaintext
   MONGO_DB_PASSWORD=<your_password>
   ```

3. **Run the Backend**
   - Use Maven to run the Spring Boot application:
     ```bash
     ./mvnw spring-boot:run
     ```

4. **Run the Frontend**
   - Open the Flutter project in a Flutter-supported IDE and run it on your desired platform.

5. **Access the Application**
   - Backend API: `http://localhost:8080`
   - Frontend: Launch on a browser or emulator.

---

## 🤝 Contributions

This project is currently closed for external contributions.

---

## 📜 License

This project is proprietary. Unauthorized distribution or modification is prohibited.

This version reflects the use of **MongoDB** as the database, **Java Spring Boot** for the backend, and the non-open-source nature of the project. Let me know if additional edits are needed! 🚀

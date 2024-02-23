package com.example.desug;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Properties;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/generateToken")
public class GenerateTokenServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int tokenLength = 12; // Length of the token
        String token = generateToken(tokenLength);

        // Save the token in the database
        saveTokenToDatabase(token);

        // Display the token to the user
        response.setContentType("text/plain");
        response.getWriter().write(token);
    }

    private String generateToken(int length) {
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        StringBuilder token = new StringBuilder(length);
        Random random = new Random();

        for (int i = 0; i < length; i++) {
            token.append(characters.charAt(random.nextInt(characters.length())));
        }

        return token.toString();
    }

    private void saveTokenToDatabase(String token) {
        Properties properties = getConnectionData();

        String url = properties.getProperty("db.url");
        String username = properties.getProperty("db.username");
        String password = properties.getProperty("db.password");

        try (Connection conn = DriverManager.getConnection(url, username, password)) {
            String query = "INSERT INTO token (token_id, created_time) VALUES (?, ?)";
            try (PreparedStatement inserter = conn.prepareStatement(query)) {
                // Set token_id and created_time
                inserter.setString(1, token);
                inserter.setString(2, getCurrentDateTime());
                inserter.executeUpdate();
            }
        } catch (SQLException sqle) {
            Logger lgr = Logger.getLogger(GenerateTokenServlet.class.getName());
            lgr.log(Level.SEVERE, sqle.getMessage(), "");
        }
    }

    private Properties getConnectionData() {
        Properties props = new Properties();
        String fileName = "S:\\Coding '-'\\Software Engineering\\SE_Lab\\DESUG\\src\\main\\java\\com\\example\\desug\\db.properties";
        try (FileInputStream fis = new FileInputStream(fileName)) {
            props.load(fis);
        } catch (IOException ioe) {
            Logger lgr = Logger.getLogger(GenerateTokenServlet.class.getName());
            lgr.log(Level.SEVERE, ioe.getMessage(), ioe);
        }
        return props;
    }

    private String getCurrentDateTime() {
        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        return now.format(formatter);
    }
}



//import java.io.FileInputStream;
//import java.io.IOException;
//import java.sql.Connection;
//import java.sql.DriverManager;
//import java.sql.PreparedStatement;
//import java.sql.SQLException;
//import java.time.LocalDateTime;
//import java.time.format.DateTimeFormatter;
//import java.util.Properties;
//import java.util.Random;
//import java.util.logging.Level;
//import java.util.logging.Logger;
//
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//
//import jakarta.mail.*;
//import jakarta.mail.internet.InternetAddress;
//import jakarta.mail.internet.MimeMessage;
//
//@WebServlet("/generateToken")
//public class GenerateTokenServlet extends HttpServlet {
//
//    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
//        int tokenLength = 12; // Length of the token
//        String token = generateToken(tokenLength);
//
//        // Save the token in the database
//        saveTokenToDatabase(token);
//
//        // Send the token via email
//        sendTokenViaEmail("user@gmail.com", token);
//
//        // Display a success message to the user
//        response.setContentType("text/plain");
//        response.getWriter().write("Token sent successfully to user's email.");
//    }
//
//    private String generateToken(int length) {
//        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
//        StringBuilder token = new StringBuilder(length);
//        Random random = new Random();
//
//        for (int i = 0; i < length; i++) {
//            token.append(characters.charAt(random.nextInt(characters.length())));
//        }
//
//        return token.toString();
//    }
//
//    private void saveTokenToDatabase(String token) {
//        // Database saving logic remains the same
//        // Implement as per your database setup
//    }
//
//    private void sendTokenViaEmail(String recipientEmail, String token) {
//        // Sender's email details
//        String senderEmail = "your_email@example.com"; // Update with your email
//        String senderPassword = "your_password"; // Update with your email password
//
//        // Setup mail server properties
//        Properties props = new Properties();
//        props.put("mail.smtp.auth", "true");
//        props.put("mail.smtp.starttls.enable", "true");
//        props.put("mail.smtp.host", "smtp.example.com"); // Update with your SMTP server
//        props.put("mail.smtp.port", "587"); // Update with your SMTP port
//
//        // Create a mail session with authentication
//        Session session = Session.getInstance(props,
//                new Authenticator() {
//                    protected PasswordAuthentication getPasswordAuthentication() {
//                        return new PasswordAuthentication(senderEmail, senderPassword);
//                    }
//                });
//
//        try {
//            // Create a message
//            Message message = new MimeMessage(session);
//            message.setFrom(new InternetAddress(senderEmail));
//            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
//            message.setSubject("Your Token");
//            message.setText("Your token is: " + token);
//
//            // Send the message
//            Transport.send(message);
//
//            System.out.println("Email sent successfully.");
//
//        } catch (MessagingException e) {
//            Logger lgr = Logger.getLogger(GenerateTokenServlet.class.getName());
//            lgr.log(Level.SEVERE, e.getMessage(), e);
//        }
//    }
//}
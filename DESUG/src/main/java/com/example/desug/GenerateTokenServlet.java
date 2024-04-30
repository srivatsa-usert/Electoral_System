package com.example.desug;

import java.io.IOException;
import java.io.InputStream;
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

    // Method to get database connection properties
    private Properties getConnectionData() {
        Properties props = new Properties();
        try {
            // Load properties from file
            InputStream inputStream = getClass().getClassLoader().getResourceAsStream("db.properties");
            props.load(inputStream);
        } catch (IOException ioe) {
            Logger lgr = Logger.getLogger(GenerateTokenServlet.class.getName());
            lgr.log(Level.SEVERE, ioe.getMessage(), ioe);
        }
        return props;
    }

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
        } catch (SQLException e) {
            Logger lgr = Logger.getLogger(GenerateTokenServlet.class.getName());
            lgr.log(Level.SEVERE, e.getMessage(), "");
        }
    }

    private String getCurrentDateTime() {
        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        return now.format(formatter);
    }
}

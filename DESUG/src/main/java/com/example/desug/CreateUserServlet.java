package com.example.desug;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/CreateUserServlet")
public class CreateUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static Properties getConnectionData() {
        Properties props = new Properties();
        try {
            props.load(LoginServlet.class.getClassLoader().getResourceAsStream("db.properties"));
        } catch (IOException ioe) {
            Logger lgr = Logger.getLogger(CreateUserServlet.class.getName());
            lgr.log(Level.SEVERE, ioe.getMessage(), ioe);
        }
        return props;
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        Properties props = getConnectionData();

        // Database connection parameters
        String jdbcUrl = props.getProperty("db.url");
        String dbUser = props.getProperty("db.username");
        String dbPassword = props.getProperty("db.password");

        // JDBC variables
        Connection conn = null;

        try {
            // Establishing connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

            // Loop through each roll_number

                // Generate hashed password based on the roll_number
                String hashedPassword = hashPassword("ec");

                // Insert username and hashed password into login table
                String insertSql = "INSERT INTO login (username, password, type) VALUES (?, ?, ?)";
                PreparedStatement insertStmt = conn.prepareStatement(insertSql);
                insertStmt.setString(1, "ec");
                insertStmt.setString(2, hashedPassword);
                insertStmt.setString(3, "ElectionChair");
                insertStmt.executeUpdate();

            // Redirect to success page or perform other actions if needed
            response.sendRedirect("home.jsp");

        } catch (SQLException | ClassNotFoundException e) {
            Logger lgr = Logger.getLogger(CreateUserServlet.class.getName());
            lgr.log(Level.SEVERE, e.getMessage(), e);
            // Handle exceptions appropriately
        } finally {
            // Closing resources
            try {
                if (conn != null) conn.close();
            } catch (SQLException e) {
                Logger lgr = Logger.getLogger(CreateUserServlet.class.getName());
                lgr.log(Level.SEVERE, e.getMessage(), e);
            }
        }
    }

    private String hashPassword(String password) {
        try {
            // Create MessageDigest instance for MD5
            MessageDigest md = MessageDigest.getInstance("MD5");

            // Add password bytes to digest
            md.update(password.getBytes());

            // Get the hash's bytes
            byte[] bytes = md.digest();

            // These bytes[] has bytes in decimal format;
            // Convert it to hexadecimal format
            StringBuilder sb = new StringBuilder();
            for (byte b : bytes) {
                sb.append(Integer.toString((b & 0xff) + 0x100, 16).substring(1));
            }

            // Return the hashed password
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            Logger lgr = Logger.getLogger(CreateUserServlet.class.getName());
            lgr.log(Level.SEVERE, e.getMessage(), e);
            return null;
        }
    }
}
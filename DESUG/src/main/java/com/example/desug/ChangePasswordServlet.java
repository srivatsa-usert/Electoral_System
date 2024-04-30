package com.example.desug;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
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
import jakarta.servlet.http.HttpSession;

@WebServlet("/changePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static Properties getConnectionData() {
        Properties props = new Properties();
        try {
            InputStream inputStream = ChangePasswordServlet.class.getClassLoader().getResourceAsStream("db.properties");
            props.load(inputStream);
        } catch (IOException ioe) {
            Logger lgr = Logger.getLogger(ChangePasswordServlet.class.getName());
            lgr.log(Level.SEVERE, ioe.getMessage(), ioe);
        }
        return props;
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!newPassword.equals(confirmPassword)) {
            // Passwords don't match, show error message
            PrintWriter out = response.getWriter();
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Passwords do not match');");
            out.println("location='change_password.jsp';");
            out.println("</script>");
            return;
        }

        String newPasswordHash = hashPassword(newPassword);

        Properties props = getConnectionData();

        // Database connection parameters
        String jdbcUrl = props.getProperty("db.url");
        String dbUser = props.getProperty("db.username");
        String dbPassword = props.getProperty("db.password");

        // JDBC variables
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            // Establishing connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

            // SQL query to update password
            String sql = "UPDATE login SET password = ? WHERE username = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, newPasswordHash);
            stmt.setString(2, username);
            int rowsAffected = stmt.executeUpdate();

            PrintWriter out = response.getWriter();
            out.println("<script type=\"text/javascript\">");
            if (rowsAffected > 0) {
                // Password updated successfully
                out.println("alert('Password changed successfully');");
                out.println("location='home.jsp';");
            } else {
                // No rows affected, likely username not found
                out.println("alert('Failed to change password');");
                out.println("location='change_password.jsp';");
            }
            out.println("</script>");
        } catch (SQLException | ClassNotFoundException e) {
            Logger lgr = Logger.getLogger(ChangePasswordServlet.class.getName());
            lgr.log(Level.SEVERE, e.getMessage(), e);
        } finally {
            // Closing resources
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                Logger lgr = Logger.getLogger(ChangePasswordServlet.class.getName());
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
            Logger lgr = Logger.getLogger(ChangePasswordServlet.class.getName());
            lgr.log(Level.SEVERE, e.getMessage(), e);
            return null;
        }
    }
}

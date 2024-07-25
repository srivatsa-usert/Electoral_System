package com.example.desug;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.InputStream;
import java.sql.*;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/submitWithdrawal")
public class SubmitWithdrawalServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static Properties getConnectionData() {
        Properties props = new Properties();
        try {
            InputStream inputStream = SubmitWithdrawalServlet.class.getClassLoader().getResourceAsStream("db.properties");
            props.load(inputStream);
        } catch (IOException ioe) {
            Logger lgr = Logger.getLogger(SubmitWithdrawalServlet.class.getName());
            lgr.log(Level.SEVERE, ioe.getMessage(), ioe);
        }
        return props;
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Properties props = getConnectionData();

        // Database connection parameters
        String jdbcUrl = props.getProperty("db.url");
        String dbUser = props.getProperty("db.username");
        String dbPassword = props.getProperty("db.password");

        // JDBC variables
        Connection conn;
        PreparedStatement stmt = null;
        HttpSession session = request.getSession();

        try {
            // Establishing connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

            // SQL query to insert data into candidate_nomination table
            String sqlWithdrawal = "UPDATE nomination_status SET status = '-1' WHERE nomination_id = (SELECT id FROM candidate_nomination WHERE election_id = (SELECT election_id FROM elections ORDER BY created_at DESC LIMIT 1) AND registration_number = ?)";
            stmt = conn.prepareStatement(sqlWithdrawal);
            stmt.setString(1, session.getAttribute("username").toString());
            int rowsUpdated = stmt.executeUpdate();

            if (rowsUpdated > 0) {
                String email = session.getAttribute("username").toString() + "@uohyd.ac.in";
                sendEmail(email, "Withdrawal of Nomination", "Your nomination has been successfully withdrawn.");
                response.sendRedirect("nominationWithdrawal.jsp");
            } else {
                // Failed to insert data
                response.sendRedirect("error.jsp"); // Redirect to an error page
            }
        } catch (SQLException | ClassNotFoundException e) {
            Logger lgr = Logger.getLogger(SubmitWithdrawalServlet.class.getName());
            lgr.log(Level.SEVERE, e.getMessage(), e);
            // Redirect to an error page if an exception occurs
            response.sendRedirect("error.jsp");
        } finally {
            // Closing resources
            try {
                if (stmt != null) {
                    stmt.close();
                }
            } catch (SQLException e) {
                Logger lgr = Logger.getLogger(SubmitWithdrawalServlet.class.getName());
                lgr.log(Level.SEVERE, e.getMessage(), e);
            }
        }
    }

    // Method to send email
    private void sendEmail(String recipientEmail, String subject, String message) {
        // Email configuration
        String host = ""; // Your SMTP server host
        String port = ""; // Port for SMTP (587 for TLS, 465 for SSL)
        String senderEmail = ""; // Sender email address
        String senderPassword = ""; // Sender email password

        // Create properties for the JavaMail session
        Properties properties = new Properties();
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", port);
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");

        // Create session with authentication
        Session session = Session.getInstance(properties, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(senderEmail, senderPassword);
            }
        });

        try {
            // Create message
            MimeMessage mimeMessage = new MimeMessage(session);
            mimeMessage.setFrom(new InternetAddress(senderEmail));
            mimeMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(recipientEmail));
            mimeMessage.setSubject(subject);
            mimeMessage.setContent(message, "text/html");

            // Send message
            Transport.send(mimeMessage);
        } catch (MessagingException e) {
            Logger lgr = Logger.getLogger(SubmitWithdrawalServlet.class.getName());
            lgr.log(Level.SEVERE, e.getMessage(), e);
        }
    }
}

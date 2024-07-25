package com.example.desug;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.mail.*;
import jakarta.mail.internet.*;

@WebServlet("/confirmNomination")
public class ConfirmNominationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static Properties getConnectionData() {
        Properties props = new Properties();
        try {
            InputStream inputStream = ConfirmNominationServlet.class.getClassLoader().getResourceAsStream("db.properties");
            props.load(inputStream);
        } catch (IOException ioe) {
            Logger lgr = Logger.getLogger(ConfirmNominationServlet.class.getName());
            lgr.log(Level.SEVERE, ioe.getMessage(), ioe);
        }
        return props;
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the confirmation status (accept/reject)
        String confirmation = request.getParameter("confirmation");
        // Get the candidate registration number and nomination ID
        String registrationNumber = request.getParameter("candidate");
        String nominationId = request.getParameter("nomination_id");

        Properties props = getConnectionData();

        // Database connection parameters
        String jdbcUrl = props.getProperty("db.url");
        String dbUser = props.getProperty("db.username");
        String dbPassword = props.getProperty("db.password");

        // JDBC variables
        Connection conn = null;

        // Inside the doGet method
        try {
            // Establishing connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

            // Check if the confirmation is for accepting the nomination
            // SQL query to check if the registration number corresponds to a proposer
            String sqlCheckProposer = "SELECT COUNT(*) FROM candidate_nomination WHERE proposer_registration_number = ? AND id = ?";
            PreparedStatement stmtCheckProposer = conn.prepareStatement(sqlCheckProposer);
            stmtCheckProposer.setString(1, registrationNumber);
            stmtCheckProposer.setString(2, nominationId);
            ResultSet proposerResult = stmtCheckProposer.executeQuery();

            // SQL query to check if the registration number corresponds to a seconder
            String sqlCheckSeconder = "SELECT COUNT(*) FROM candidate_nomination WHERE seconder_registration_number = ? and id = ?";
            PreparedStatement stmtCheckSeconder = conn.prepareStatement(sqlCheckSeconder);
            stmtCheckSeconder.setString(1, registrationNumber);
            stmtCheckSeconder.setString(2, nominationId);
            ResultSet seconderResult = stmtCheckSeconder.executeQuery();

            // Check if the registration number corresponds to a proposer
            if (proposerResult.next() && proposerResult.getInt(1) > 0) {
                // Check if already confirmed
                String sqlCheckProposerStatus = "SELECT proposer_status FROM nomination_status WHERE nomination_id = ?";
                PreparedStatement stmtCheckProposerStatus = conn.prepareStatement(sqlCheckProposerStatus);
                stmtCheckProposerStatus.setString(1, nominationId);
                ResultSet proposerStatusResult = stmtCheckProposerStatus.executeQuery();

                if (proposerStatusResult.next() && proposerStatusResult.getString(1) != null) {
                    // Redirect to an error page if the proposer has already confirmed
                    response.sendRedirect("error.jsp?error=already_confirmed");
                    return;
                }
                else {
                    // Update proposer status
                    String sqlUpdateProposerStatus = "UPDATE nomination_status SET proposer_status = ? WHERE nomination_id = ?";
                    PreparedStatement stmtUpdateProposerStatus = conn.prepareStatement(sqlUpdateProposerStatus);
                    stmtUpdateProposerStatus.setString(1, confirmation);
                    stmtUpdateProposerStatus.setString(2, nominationId);
                    stmtUpdateProposerStatus.executeUpdate();

                    if (confirmation.equalsIgnoreCase("no")) {
                        // Update status to 3.5 if confirmation is 'no'
                        String updateStatusSql = "UPDATE nomination_status SET status = '3.5' WHERE nomination_id = ?";
                        PreparedStatement updateStatusStmt = conn.prepareStatement(updateStatusSql);
                        updateStatusStmt.setString(1, nominationId); // Set nomination ID here
                        updateStatusStmt.executeUpdate();
                    } else if (confirmation.equalsIgnoreCase("yes")) {
                        checkAndUpdateStatus(conn, nominationId, "proposer");
                    }
                }
            } else if (seconderResult.next() && seconderResult.getInt(1) > 0) {
                // Check if already confirmed
                String sqlCheckProposerStatus = "SELECT seconder_status FROM nomination_status WHERE nomination_id = ?";
                PreparedStatement stmtCheckProposerStatus = conn.prepareStatement(sqlCheckProposerStatus);
                stmtCheckProposerStatus.setString(1, nominationId);
                ResultSet seconderStatusResult = stmtCheckProposerStatus.executeQuery();

                if (seconderStatusResult.next() && seconderStatusResult.getString(1) != null) {
                    // Redirect to an error page if the seconder has already confirmed
                    response.sendRedirect("error.jsp?error=already_confirmed");
                    return;
                }
                else {
                    // Update seconder status
                    String sqlUpdateSeconderStatus = "UPDATE nomination_status SET seconder_status = ? WHERE nomination_id = ?";
                    PreparedStatement stmtUpdateSeconderStatus = conn.prepareStatement(sqlUpdateSeconderStatus);
                    stmtUpdateSeconderStatus.setString(1, confirmation);
                    stmtUpdateSeconderStatus.setString(2, nominationId);
                    stmtUpdateSeconderStatus.executeUpdate();

                    if (confirmation.equalsIgnoreCase("no")) {
                        // Update status to 3.5 if confirmation is 'no'
                        String updateStatusSql = "UPDATE nomination_status SET status = '3.5' WHERE nomination_id = ?";
                        PreparedStatement updateStatusStmt = conn.prepareStatement(updateStatusSql);
                        updateStatusStmt.setString(1, nominationId); // Set nomination ID here
                        updateStatusStmt.executeUpdate();
                    } else if (confirmation.equalsIgnoreCase("yes")) {
                        checkAndUpdateStatus(conn, nominationId, "seconder");
                    }
                }
            }
            // Redirect to a success page after processing confirmation
            response.sendRedirect("success.jsp");
        } catch (SQLException | ClassNotFoundException e) {
            Logger lgr = Logger.getLogger(ConfirmNominationServlet.class.getName());
            lgr.log(Level.SEVERE, e.getMessage(), e);
            // Redirect to an error page if an exception occurs
            response.sendRedirect("error.jsp?error=exception");
        } finally {
            // Closing resources
            try {
                if (conn != null) conn.close();
            } catch (SQLException e) {
                Logger lgr = Logger.getLogger(ConfirmNominationServlet.class.getName());
                lgr.log(Level.SEVERE, e.getMessage(), e);
            }
        }

    }

    private void checkAndUpdateStatus(Connection conn, String nominationId, String role) throws SQLException {
        String oppositeRoleStatus = role.equals("proposer") ? "seconder_status" : "proposer_status";

        // Check if the opposite role's status is 'yes' for the same nomination_id
        String sqlCheckOppositeStatus = "SELECT " + oppositeRoleStatus + " FROM nomination_status WHERE nomination_id = ?";
        PreparedStatement stmtCheckOppositeStatus = conn.prepareStatement(sqlCheckOppositeStatus);
        stmtCheckOppositeStatus.setString(1, nominationId);
        ResultSet oppositeStatusResult = stmtCheckOppositeStatus.executeQuery();

        if (oppositeStatusResult.next() && oppositeStatusResult.getString(1) != null && oppositeStatusResult.getString(1).equalsIgnoreCase("yes")) {
            // Both roles have confirmed, send email to dean
            // Change to dean mail later
            sendMailToDean("mail@domain", "Nomination Confirmation", "Both the proposer and seconder have confirmed the nomination for nomination ID: " + nominationId);

            // Update status to 3 for the given nomination ID if status is currently 2
            String updateStatusSql = "UPDATE nomination_status SET status = '3' WHERE nomination_id = ? AND status = '2'";
            PreparedStatement updateStatusStmt = conn.prepareStatement(updateStatusSql);
            updateStatusStmt.setString(1, nominationId); // Set nomination ID here
            updateStatusStmt.executeUpdate();
        }
    }

    private void sendMailToDean(String recipientEmail, String subject, String message) {
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
            Logger lgr = Logger.getLogger(ConfirmNominationServlet.class.getName());
            lgr.log(Level.SEVERE, e.getMessage(), e);
        }
    }
}

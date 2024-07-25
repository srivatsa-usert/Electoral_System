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

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.mail.*;
import jakarta.mail.internet.*;

@WebServlet("/submitNomination")
public class SubmitNominationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static Properties getConnectionData() {
        Properties props = new Properties();
        try {
            InputStream inputStream = SubmitNominationServlet.class.getClassLoader().getResourceAsStream("db.properties");
            props.load(inputStream);
        } catch (IOException ioe) {
            Logger lgr = Logger.getLogger(SubmitNominationServlet.class.getName());
            lgr.log(Level.SEVERE, ioe.getMessage(), ioe);
        }
        return props;
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Retrieve form data
        String position = request.getParameter("nameofThePosition");
        String registrationNumber = request.getParameter("candidateRegistrationNumber");
        String nameOnBallotPaper = request.getParameter("nameOnBallotPaper");
        String age = request.getParameter("age");
        String category = request.getParameter("categoryOfTheCandidate");
        String fathersName = request.getParameter("fathersName");
        String mobileNumber = request.getParameter("mobileNumber");
        String email = request.getParameter("email");
        String residentialAddress = request.getParameter("residentialAddress");
        String proposerRegistrationNumber = request.getParameter("proposerRegistrationNumber");
        String seconderRegistrationNumber = request.getParameter("seconderRegistrationNumber");

        /*System.out.println(registrationNumber + " - " + age);*/

        Properties props = getConnectionData();

        // Database connection parameters
        String jdbcUrl = props.getProperty("db.url");
        String dbUser = props.getProperty("db.username");
        String dbPassword = props.getProperty("db.password");

        // JDBC variables
        Connection conn = null;
        PreparedStatement stmtNomination = null;
        PreparedStatement stmtStatus = null;

        try {
            // Establishing connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

            // SQL query to insert data into candidate_nomination table
            String sqlNomination = "INSERT INTO candidate_nomination (position, registration_number, name_on_ballot_paper, age, category, fathers_name, mobile_number, email, residential_address, proposer_registration_number, seconder_registration_number, election_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, (SELECT election_id FROM elections ORDER BY created_at DESC LIMIT 1))";
            stmtNomination = conn.prepareStatement(sqlNomination, PreparedStatement.RETURN_GENERATED_KEYS);

            // Set parameters for the nomination SQL query
            stmtNomination.setString(1, position);
            stmtNomination.setString(2, registrationNumber);
            stmtNomination.setString(3, nameOnBallotPaper);
            stmtNomination.setString(4, age);
            stmtNomination.setString(5, category);
            stmtNomination.setString(6, fathersName);
            stmtNomination.setString(7, mobileNumber);
            stmtNomination.setString(8, email);
            stmtNomination.setString(9, residentialAddress);
            stmtNomination.setString(10, proposerRegistrationNumber);
            stmtNomination.setString(11, seconderRegistrationNumber);

            // Execute the nomination SQL query
            int rowsInsertedNomination = stmtNomination.executeUpdate();

            int nomination_id = -1;

            // Check if the insertion was successful
            if (rowsInsertedNomination > 0) {
                // Retrieve the generated keys (which should include the nomination ID)
                ResultSet generatedKeys = stmtNomination.getGeneratedKeys();
                if (generatedKeys.next()) {
                    nomination_id = generatedKeys.getInt(1);
                }
            }

            // SQL query to insert data into nomination_status table
            String sqlStatus = "INSERT INTO nomination_status (nomination_id, status) VALUES (?, '1')";
            stmtStatus = conn.prepareStatement(sqlStatus);
            stmtStatus.setInt(1, nomination_id);

            // Execute the status SQL query
            int rowsInsertedStatus = stmtStatus.executeUpdate();

            // Check if data inserted into both tables successfully
            if (rowsInsertedNomination > 0 && rowsInsertedStatus > 0) {
                // Data inserted successfully
                String proposerEmail = proposerRegistrationNumber+"@uohyd.ac.in";
                String seconderEmail = seconderRegistrationNumber+"@uohyd.ac.in";

                String proposerAcceptLink = "http://localhost:8080/Gradle___com_example___DESUG_1_0_SNAPSHOT_war/confirmNomination?confirmation=yes&candidate=" + proposerRegistrationNumber + "&nomination_id=" + nomination_id;
                String proposerRejectLink = "http://localhost:8080/Gradle___com_example___DESUG_1_0_SNAPSHOT_war/confirmNomination?confirmation=no&candidate=" + proposerRegistrationNumber + "&nomination_id=" + nomination_id;
                String seconderAcceptLink = "http://localhost:8080/Gradle___com_example___DESUG_1_0_SNAPSHOT_war/confirmNomination?confirmation=yes&candidate=" + seconderRegistrationNumber + "&nomination_id=" + nomination_id;
                String seconderRejectLink = "http://localhost:8080/Gradle___com_example___DESUG_1_0_SNAPSHOT_war/confirmNomination?confirmation=no&candidate=" + seconderRegistrationNumber + "&nomination_id=" + nomination_id;

                String messageToProposer = "<p>Hello,</p>"
                        + "<p>You have been nominated as the proposer for a candidate in the upcoming election.</p>"
                        + "<p>The candidate details are as follows:</p>"
                        + "<ul>"
                        + "<li><b>Position:</b> " + position + "</li>"
                        + "<li><b>Registration Number:</b> " + registrationNumber + "</li>"
                        + "<li><b>Name on Ballot Paper:</b> " + nameOnBallotPaper + "</li>"
                        + "<li><b>Age:</b> " + age + "</li>"
                        + "<li><b>Category:</b> " + category + "</li>"
                        + "<li><b>Father's Name:</b> " + fathersName + "</li>"
                        + "<li><b>Mobile Number:</b> " + mobileNumber + "</li>"
                        + "<li><b>Email:</b> " + email + "</li>"
                        + "<li><b>Residential Address:</b> " + residentialAddress + "</li>"
                        + "<li><b>Proposer Registration Number:</b> " + proposerRegistrationNumber + "</li>"
                        + "<li><b>Seconder Registration Number:</b> " + seconderRegistrationNumber + "</li>"
                        + "</ul>"
                        + "<p>Please review the candidate details and confirm your approval by clicking one of the following links:</p>"
                        + "<button style='background-color: #4CAF50; color: white; padding: 10px 24px; border: none; border-radius: 4px; cursor: pointer; margin-right: 10px;'>"
                        + "<a href='" + proposerAcceptLink + "' style='text-decoration: none; color: white;'>Accept Nomination</a>"
                        + "</button>"
                        +"<br>"
                        + "<button style='background-color: #f44336; color: white; padding: 10px 24px; border: none; border-radius: 4px; cursor: pointer;'>"
                        + "<a href='" + proposerRejectLink + "' style='text-decoration: none; color: white;'>Reject Nomination</a>"
                        + "</button>";

                String messageToSeconder = "<p>Hello,</p>"
                        + "<p>You have been nominated as the seconder for a candidate in the upcoming election.</p>"
                        + "<p>The candidate details are as follows:</p>"
                        + "<ul>"
                        + "<li><b>Position:</b> " + position + "</li>"
                        + "<li><b>Registration Number:</b> " + registrationNumber + "</li>"
                        + "<li><b>Name on Ballot Paper:</b> " + nameOnBallotPaper + "</li>"
                        + "<li><b>Age:</b> " + age + "</li>"
                        + "<li><b>Category:</b> " + category + "</li>"
                        + "<li><b>Father's Name:</b> " + fathersName + "</li>"
                        + "<li><b>Mobile Number:</b> " + mobileNumber + "</li>"
                        + "<li><b>Email:</b> " + email + "</li>"
                        + "<li><b>Residential Address:</b> " + residentialAddress + "</li>"
                        + "<li><b>Proposer Registration Number:</b> " + proposerRegistrationNumber + "</li>"
                        + "<li><b>Seconder Registration Number:</b> " + seconderRegistrationNumber + "</li>"
                        + "</ul>"
                        + "<p>Please review the candidate details and confirm your approval by clicking one of the following links:</p>"
                        + "<button style='background-color: #4CAF50; color: white; padding: 10px 24px; border: none; border-radius: 4px; cursor: pointer; margin-right: 10px;'>"
                        + "<a href='" + seconderAcceptLink + "' style='text-decoration: none; color: white;'>Accept Nomination</a>"
                        + "</button>"
                        +"<br>"
                        + "<button style='background-color: #f44336; color: white; padding: 10px 24px; border: none; border-radius: 4px; cursor: pointer;'>"
                        + "<a href='" + seconderRejectLink + "' style='text-decoration: none; color: white;'>Reject Nomination</a>"
                        + "</button>";


                // Send email to proposer
                sendEmail(proposerEmail, "Nomination Approval Confirmation", messageToProposer);

                // Send email to seconder
                sendEmail(seconderEmail, "Nomination Approval Confirmation", messageToSeconder);

                response.sendRedirect("candidateRegistration.jsp"); // Redirect to a success page
            } else {
                // Failed to insert data
                response.sendRedirect("error.jsp"); // Redirect to an error page
            }
        } catch (SQLException | ClassNotFoundException e) {
            Logger lgr = Logger.getLogger(SubmitNominationServlet.class.getName());
            lgr.log(Level.SEVERE, e.getMessage(), e);
            // Redirect to an error page if an exception occurs
            response.sendRedirect("error.jsp");
        } finally {
            // Closing resources
            try {
                if (stmtNomination != null) stmtNomination.close();
                if (stmtStatus != null) stmtStatus.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                Logger lgr = Logger.getLogger(SubmitNominationServlet.class.getName());
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
            Logger lgr = Logger.getLogger(SubmitNominationServlet.class.getName());
            lgr.log(Level.SEVERE, e.getMessage(), e);
        }
    }
}

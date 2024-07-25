package com.example.desug;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.io.IOException;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/sendMail")
public class SendMailServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get parameters from the request
        String recipientEmail = request.getParameter("recipientEmail");
        String message = request.getParameter("message");
        String subject = request.getParameter("subject");

        System.out.println(recipientEmail+"\n"+subject+"\n"+message);

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
            mimeMessage.setText(message);

            // Send message
            Transport.send(mimeMessage);

            // Send response to client
            response.getWriter().println("Email sent successfully!");
        } catch (MessagingException e) {
            Logger lgr = Logger.getLogger(FetchDetails.class.getName());
            lgr.log(Level.SEVERE, e.getMessage(), e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to send email");
        }
    }
}

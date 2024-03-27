package com.example.desug;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.io.IOException;
import java.util.Properties;

@WebServlet("/emailServlet")
public class EmailServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String to = request.getParameter("to");
        String subject = request.getParameter("subject");
        String messageText = request.getParameter("message");

        // Sender's email address
        String from = "21mcme06@uohyd.ac.in"; // Replace with your Gmail address
        final String username = "21mcme06@uohyd.ac.in"; // Replace with your Gmail username
        final String password = "duikkfhyeclrmvoq"; // Replace with your Gmail password

        // Gmail SMTP server details
        String host = "smtp.gmail.com";
        int port = 587;

        // Set properties
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", port);

        // Create session with authentication
        Session session = Session.getInstance(props,
                new jakarta.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(username, password);
                    }
                });

        try {
            // Create MimeMessage object
            MimeMessage message = new MimeMessage(session);

            // Set From: header field
            message.setFrom(new InternetAddress(from));

            // Set To: header field
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));

            // Set Subject: header field
            message.setSubject(subject);

            // Now set the actual message
            message.setText(messageText);

            // Send message
            Transport.send(message);

            response.getWriter().println("Email sent successfully.");
            response.sendRedirect("home.jsp");
        } catch (MessagingException mex) {
            mex.printStackTrace();
            response.getWriter().println("Error: unable to send email.");
        }
    }
}


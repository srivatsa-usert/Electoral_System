package com.example.desug;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/getNotifications")
public class GetNotificationsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the session
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Session expired or not logged in");
            return;
        }

        // Get the candidate registration number from session
        String candidateRegistrationNumber = (String) session.getAttribute("username");

        // Database connection parameters
        Properties props = getConnectionData();

        String jdbcUrl = props.getProperty("db.url");
        String dbUser = props.getProperty("db.username");
        String dbPassword = props.getProperty("db.password");

        Connection conn = null;
        PreparedStatement pstmtProposer = null;
        PreparedStatement pstmtSeconder = null;
        ResultSet rsProposer = null;
        ResultSet rsSeconder = null;

        List<String> proposerNotifications = new ArrayList<>();
        List<String> seconderNotifications = new ArrayList<>();

        try {
            // Establishing connection
            conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

            // SQL query to fetch ProposerList
            String sqlProposer = "SELECT cn.registration_number, cn.position, s.name, ns.id " +
                    "FROM nomination_status ns " +
                    "JOIN candidate_nomination cn ON cn.id = ns.nomination_id " +
                    "JOIN student s ON s.roll_number = cn.registration_number " +
                    "WHERE ns.proposer_status = 'no' AND ns.status = 'pending' AND cn.proposer_registration_number = ?";
            pstmtProposer = conn.prepareStatement(sqlProposer);
            pstmtProposer.setString(1, candidateRegistrationNumber);
            rsProposer = pstmtProposer.executeQuery();

            // Process result set for ProposerList
            while (rsProposer.next()) {
                String registrationNumber = rsProposer.getString("registration_number");
                String position = rsProposer.getString("position");
                String name = rsProposer.getString("name");
                int id = rsProposer.getInt("id");
                proposerNotifications.add("Registration Number: " + registrationNumber + ", Position: " + position + ", Name: " + name + ", ID: " + id);
            }

            // SQL query to fetch SeconderList
            String sqlSeconder = "SELECT cn.registration_number, cn.position, s.name, ns.id " +
                    "FROM nomination_status ns " +
                    "JOIN candidate_nomination cn ON cn.id = ns.nomination_id " +
                    "JOIN student s ON s.roll_number = cn.registration_number " +
                    "WHERE ns.seconder_status = 'no' AND ns.status = 'pending' AND cn.seconder_registration_number = ?";
            pstmtSeconder = conn.prepareStatement(sqlSeconder);
            pstmtSeconder.setString(1, candidateRegistrationNumber);
            rsSeconder = pstmtSeconder.executeQuery();

            // Process result set for SeconderList
            while (rsSeconder.next()) {
                String registrationNumber = rsSeconder.getString("registration_number");
                String position = rsSeconder.getString("position");
                String name = rsSeconder.getString("name");
                int id = rsSeconder.getInt("id");
                seconderNotifications.add("Registration Number: " + registrationNumber + ", Position: " + position + ", Name: " + name + ", ID: " + id);
            }

            // Forward notifications to notification.jsp
            request.setAttribute("proposerNotifications", proposerNotifications);
            request.setAttribute("seconderNotifications", seconderNotifications);
            request.getRequestDispatcher("notification.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error fetching notifications");
        } finally {
            // Closing resources
            try {
                if (rsProposer != null) rsProposer.close();
                if (rsSeconder != null) rsSeconder.close();
                if (pstmtProposer != null) pstmtProposer.close();
                if (pstmtSeconder != null) pstmtSeconder.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // Method to get database connection properties
    private Properties getConnectionData() {
        Properties props = new Properties();
        try {
            // Load properties from file
            InputStream inputStream = getClass().getClassLoader().getResourceAsStream("db.properties");
            props.load(inputStream);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return props;
    }
}

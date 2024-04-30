package com.example.desug;

import java.io.*;
import java.sql.*;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/getCandidateStatus")
public class GetCandidateStatus extends HttpServlet {

    private static String JDBC_URL;
    private static String JDBC_USERNAME;
    private static String JDBC_PASSWORD;
    private static Properties getConnectionData() {
        Properties props = new Properties();
        try {
            InputStream inputStream = GetCandidateStatus.class.getClassLoader().getResourceAsStream("db.properties");
            props.load(inputStream);
        } catch (IOException ioe) {
            Logger lgr = Logger.getLogger(GetCandidateStatus.class.getName());
            lgr.log(Level.SEVERE, ioe.getMessage(), ioe);
        }
        return props;
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        Properties props = getConnectionData();

        // Database connection parameters
        JDBC_URL = props.getProperty("db.url");
        JDBC_USERNAME = props.getProperty("db.username");
        JDBC_PASSWORD = props.getProperty("db.password");

        HttpSession session = request.getSession();
        String candidateRegNumber = "";

        // Check if session is not null and if username attribute is present
        if (session != null && session.getAttribute("username") != null) {
            // Get the registration number from session attribute "username"
            candidateRegNumber = (String) session.getAttribute("username");
        }


        // Check if candidate ID is provided
        if (candidateRegNumber == null || candidateRegNumber.isEmpty()) {
            out.println("Candidate registration Number is required.");
            return;
        }

        // Perform database operations to check candidate status
        String status = getCandidateStatus(candidateRegNumber);

        // Display candidate status
        String jsonResponse = "{\"status\": \"" + status + "\"}";

        // Send the JSON response
        out.println(jsonResponse);
    }

    // Method to retrieve candidate status from the database
    private String getCandidateStatus(String candidateId) {
        String status = "0"; // Default status

        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish connection to MySQL database
            Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);

            // Prepare SQL query to retrieve candidate status
            String query = "SELECT ns.status " +
                    "FROM nomination_status ns " +
                    "JOIN candidate_nomination cn ON cn.id = ns.nomination_id " +
                    "JOIN elections e ON e.election_id = cn.election_id " +
                    "WHERE e.election_id = (SELECT election_id FROM elections ORDER BY created_at DESC LIMIT 1) " +
                    "AND cn.registration_number = ?";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, candidateId);

            // Execute query
            ResultSet resultSet = statement.executeQuery();

            // Process query result
            if (resultSet.next()) {
                status = resultSet.getString("status");
            }

            // Close connections
            resultSet.close();
            statement.close();
            connection.close();
        } catch (ClassNotFoundException | SQLException e) {
            Logger lgr = Logger.getLogger(GetCandidateStatus.class.getName());
            lgr.log(Level.SEVERE, e.getMessage(), e);
        }

        return status;
    }
}

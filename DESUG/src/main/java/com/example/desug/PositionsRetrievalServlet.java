package com.example.desug;

import com.google.gson.JsonArray;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.*;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/positions")
public class PositionsRetrievalServlet extends HttpServlet {

    private static final Logger logger = Logger.getLogger(PositionsRetrievalServlet.class.getName());

    private static Properties getConnectionData() {
        Properties props = new Properties();
        try (InputStream inputStream = PositionsRetrievalServlet.class.getClassLoader().getResourceAsStream("db.properties")) {
            props.load(inputStream);
        } catch (IOException ioe) {
            logger.log(Level.SEVERE, "Error loading database properties", ioe);
        }
        return props;
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Connection conn;
            PreparedStatement stmt;
            ResultSet positionResult;

            HttpSession session = request.getSession();
            String candidateRegNumber = "";

            // Check if session is not null and if username attribute is present
            if (session != null && session.getAttribute("username") != null) {
                // Get the registration number from session attribute "username"
                candidateRegNumber = (String) session.getAttribute("username"); // can be used to get department/school when School Board Member and/or Councillor option is not available to all candidates
            }

            Properties props = getConnectionData();

            // Database connection parameters
            String jdbcUrl = props.getProperty("db.url");
            String dbUser = props.getProperty("db.username");
            String dbPassword = props.getProperty("db.password");

            // Register JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Open a connection
            conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

            // Execute SQL query to get the latest election ID
            String latestElectionQuery = "SELECT election_id FROM elections ORDER BY election_id DESC LIMIT 1";
            stmt = conn.prepareStatement(latestElectionQuery);
            ResultSet electionResult = stmt.executeQuery();

            int latestElectionId = 0;
            if (electionResult.next()) {
                latestElectionId = electionResult.getInt("election_id");
            }

            // Execute SQL query to get all positions for the latest election ID
            String positionQuery = "SELECT position FROM office_bearers WHERE election_id = ?";
            stmt = conn.prepareStatement(positionQuery);
            stmt.setInt(1, latestElectionId);
            positionResult = stmt.executeQuery();

            // Create a JSON array to hold positions
            JsonArray jsonArray = new JsonArray();

            // Add positions to the JSON array
            while (positionResult.next()) {
                jsonArray.add(positionResult.getString("position"));
            }

            // Add additional positions
            jsonArray.add("School Board Member");
            jsonArray.add("School Councillor");

            // Set response type to JSON
            response.setContentType("application/json");

            // Send JSON response
            PrintWriter out = response.getWriter();
            out.println(jsonArray);
            out.flush();

        } catch (ClassNotFoundException | SQLException e) {
            logger.log(Level.SEVERE, "Error retrieving positions", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error retrieving positions");
        }
    }
}

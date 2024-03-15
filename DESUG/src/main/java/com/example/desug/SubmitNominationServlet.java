package com.example.desug;

import java.io.IOException;
import java.io.InputStream;
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

        Properties props = getConnectionData();

        // Database connection parameters
        String jdbcUrl = props.getProperty("db.url");
        String dbUser = props.getProperty("db.username");
        String dbPassword = props.getProperty("db.password");

        // JDBC variables
        Connection conn = null;
        PreparedStatement pstmtNomination = null;
        PreparedStatement pstmtStatus = null;

        try {
            // Establishing connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

            // SQL query to insert data into candidate_nomination table
            String sqlNomination = "INSERT INTO candidate_nomination (position, registration_number, name_on_ballot_paper, age, category, fathers_name, mobile_number, email, residential_address, proposer_registration_number, seconder_registration_number) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            pstmtNomination = conn.prepareStatement(sqlNomination);

            // Set parameters for the nomination SQL query
            pstmtNomination.setString(1, position);
            pstmtNomination.setString(2, registrationNumber);
            pstmtNomination.setString(3, nameOnBallotPaper);
            pstmtNomination.setString(4, age);
            pstmtNomination.setString(5, category);
            pstmtNomination.setString(6, fathersName);
            pstmtNomination.setString(7, mobileNumber);
            pstmtNomination.setString(8, email);
            pstmtNomination.setString(9, residentialAddress);
            pstmtNomination.setString(10, proposerRegistrationNumber);
            pstmtNomination.setString(11, seconderRegistrationNumber);

            // Execute the nomination SQL query
            int rowsInsertedNomination = pstmtNomination.executeUpdate();

            // SQL query to insert data into nomination_status table
            String sqlStatus = "INSERT INTO nomination_status (nomination_id, status) VALUES (LAST_INSERT_ID(), 'Pending')";
            pstmtStatus = conn.prepareStatement(sqlStatus);

            // Execute the status SQL query
            int rowsInsertedStatus = pstmtStatus.executeUpdate();

            // Check if data inserted into both tables successfully
            if (rowsInsertedNomination > 0 && rowsInsertedStatus > 0) {
                // Data inserted successfully
                response.sendRedirect("home.jsp"); // Redirect to a success page
            } else {
                // Failed to insert data
                response.sendRedirect("error.jsp"); // Redirect to an error page
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            // Redirect to an error page if an exception occurs
            response.sendRedirect("error.jsp");
        } finally {
            // Closing resources
            try {
                if (pstmtNomination != null) pstmtNomination.close();
                if (pstmtStatus != null) pstmtStatus.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}

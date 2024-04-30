package com.example.desug;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/approveCandidate")
public class ApproveCandidateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static Properties getConnectionData() {
        Properties props = new Properties();
        try {
            InputStream inputStream = ApproveCandidateServlet.class.getClassLoader().getResourceAsStream("db.properties");
            props.load(inputStream);
        } catch (IOException ioe) {
            Logger lgr = Logger.getLogger(ApproveCandidateServlet.class.getName());
            lgr.log(Level.SEVERE, ioe.getMessage(), ioe);
        }
        return props;
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String registrationNumber = request.getParameter("registrationNumber");
        String candidateFileApproval = request.getParameter("candidate_file_pathAcceptReject");
        String proposerFileApproval = request.getParameter("proposer_file_pathAcceptReject");
        String seconderFileApproval = request.getParameter("seconder_file_pathAcceptReject");
        String dobProofFileApproval = request.getParameter("dob_proof_file_pathAcceptReject");
        String attendanceFileApproval = request.getParameter("attendance_file_pathAcceptReject");
        String categoryFileApproval = request.getParameter("category_file_pathAcceptReject");
        String comment = request.getParameter("comment");

        System.out.println(registrationNumber);
        System.out.println(candidateFileApproval);
        System.out.println(proposerFileApproval);
        System.out.println(seconderFileApproval);
        System.out.println(dobProofFileApproval);
        System.out.println(candidateFileApproval);

        String status = calculateStatus(candidateFileApproval, proposerFileApproval, seconderFileApproval, dobProofFileApproval);

        Properties props = getConnectionData();

        // Database connection parameters
        String jdbcUrl = props.getProperty("db.url");
        String dbUser = props.getProperty("db.username");
        String dbPassword = props.getProperty("db.password");

        try (Connection conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword)) {
            conn.setAutoCommit(false);

            updateNominationStatus(conn, registrationNumber, status);

            insertApproval(conn, registrationNumber, candidateFileApproval, proposerFileApproval,
                    seconderFileApproval, dobProofFileApproval, attendanceFileApproval,
                    categoryFileApproval, comment) ;

            conn.commit();
            response.sendRedirect("approveCandidates.jsp");
        } catch (SQLException e) {
            Logger.getLogger(ApproveCandidateServlet.class.getName()).log(Level.SEVERE, e.getMessage(), e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while processing your request.");
        }
    }

    private String calculateStatus(String candidateApproval, String proposerApproval, String seconderApproval, String dobProofApproval) {
        if ("accept".equals(candidateApproval) && "accept".equals(proposerApproval) &&
                "accept".equals(seconderApproval) && "accept".equals(dobProofApproval)) {
            return "5";
        } else {
            return "5.5";
        }
    }

    private void updateNominationStatus(Connection conn, String registrationNumber, String status) throws SQLException {
        String sqlUpdate = "UPDATE nomination_status SET status = ? WHERE nomination_id = (SELECT id FROM candidate_nomination WHERE election_id = (SELECT election_id FROM elections ORDER BY created_at DESC LIMIT 1) AND registration_number = ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sqlUpdate)) {
            stmt.setString(1, status);
            stmt.setString(2, registrationNumber);
            stmt.executeUpdate();
        }
    }

    private void insertApproval(Connection conn, String registrationNumber, String candidateApproval, String proposerApproval,
                                String seconderApproval, String dobProofApproval, String attendanceApproval,
                                String categoryApproval, String comment) throws SQLException {
        String sqlInsert = "INSERT INTO candidate_approval (registrationNumber, candidate_file_approval, proposer_file_approval, seconder_file_approval, dob_proof_file_approval, attendance_file_approval, category_file_approval, comment, nominationId) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, (SELECT id FROM candidate_nomination WHERE election_id = (SELECT election_id FROM elections ORDER BY created_at DESC LIMIT 1) AND registration_number = ?))";
        try (PreparedStatement stmt = conn.prepareStatement(sqlInsert)) {
            stmt.setString(1, registrationNumber);
            stmt.setString(2, candidateApproval);
            stmt.setString(3, proposerApproval);
            stmt.setString(4, seconderApproval);
            stmt.setString(5, dobProofApproval);
            stmt.setString(6, attendanceApproval);
            stmt.setString(7, categoryApproval);
            stmt.setString(8, comment);
            stmt.setString(9, registrationNumber);
            stmt.executeUpdate();
        }
    }

}

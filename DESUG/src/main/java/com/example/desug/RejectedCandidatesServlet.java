package com.example.desug;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
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
import jakarta.servlet.http.HttpSession;
import org.json.JSONObject;

@WebServlet("/rejectedCandidates")
public class RejectedCandidatesServlet extends HttpServlet {

    private static Properties getConnectionData() {
        Properties props = new Properties();
        try {
            InputStream inputStream = RejectedCandidatesServlet.class.getClassLoader().getResourceAsStream("db.properties");
            props.load(inputStream);
        } catch (IOException ioe) {
            Logger lgr = Logger.getLogger(RejectedCandidatesServlet.class.getName());
            lgr.log(Level.SEVERE, ioe.getMessage(), ioe);
        }
        return props;
    }

    // Method to retrieve rejected candidates based on the request status
    private JSONObject getProposerAndSeconderRejectedCandidates(String candidateRegNumber, String jdbcUrl, String dbUser, String dbPassword) throws SQLException {
        JSONObject jsonObject = new JSONObject();

        try (Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword)) {
            String query = "SELECT cn.proposer_registration_number, cn.seconder_registration_number, ns.proposer_status, ns.seconder_status "
                    + "FROM candidate_nomination cn "
                    + "INNER JOIN nomination_status ns ON cn.id = ns.nomination_id "
                    + "WHERE cn.registration_number = ? AND "
                    + "(ns.proposer_status = 'no' OR ns.seconder_status = 'no')";

            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, candidateRegNumber);

            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                String proposerRegistrationNumber = resultSet.getString("proposer_registration_number");
                String seconderRegistrationNumber = resultSet.getString("seconder_registration_number");
                String proposerStatus = resultSet.getString("proposer_status");
                String seconderStatus = resultSet.getString("seconder_status");

                if (proposerStatus.equals("no")) {
                    jsonObject.put("proposer_registration_number", proposerRegistrationNumber);
                }
                if (seconderStatus.equals("no")) {
                    jsonObject.put("seconder_registration_number", seconderRegistrationNumber);
                }

            }
        }
        return jsonObject;
    }

    private JSONObject getDeanRejectReasons(String candidateRegNumber, String jdbcUrl, String dbUser, String dbPassword) throws SQLException {
        JSONObject jsonObject = new JSONObject();

        try (Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword)) {
            String query = "SELECT attendance, academicArrears, registeredStudent, courseRequirements, researchProgress, DRCReport, comments, dateCertification "
                    + "FROM certification_data "
                    + "WHERE nominationId = (SELECT id FROM candidate_nomination WHERE election_id = (SELECT election_id FROM elections ORDER BY created_at DESC LIMIT 1) AND registration_number = ?)";

            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, candidateRegNumber);

            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                // Iterate through the result set and add non-null fields to the JSON object
                if (resultSet.getString("attendance") != null) {
                    jsonObject.put("attendance", resultSet.getString("attendance"));
                }
                if (resultSet.getString("academicArrears") != null) {
                    jsonObject.put("academicArrears", resultSet.getString("academicArrears"));
                }
                if (resultSet.getString("registeredStudent") != null) {
                    jsonObject.put("registeredStudent", resultSet.getString("registeredStudent"));
                }
                if (resultSet.getString("courseRequirements") != null) {
                    jsonObject.put("courseRequirements", resultSet.getString("courseRequirements"));
                }
                if (resultSet.getString("researchProgress") != null) {
                    jsonObject.put("researchProgress", resultSet.getString("researchProgress"));
                }
                if (resultSet.getString("DRCReport") != null) {
                    jsonObject.put("DRCReport", resultSet.getString("DRCReport"));
                }
                if (resultSet.getString("comments") != null) {
                    jsonObject.put("comments", resultSet.getString("comments"));
                }
                if (resultSet.getTimestamp("dateCertification") != null) {
                    jsonObject.put("dateCertification", resultSet.getTimestamp("dateCertification").toString());
                }
            }
        }
        return jsonObject;
    }

    private JSONObject getCandidateApprovalInfo(String candidateRegNumber, String jdbcUrl, String dbUser, String dbPassword) throws SQLException {
        JSONObject jsonObject = new JSONObject();

        try (Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword)) {
            String query = "SELECT candidate_file_approval, proposer_file_approval, seconder_file_approval, dob_proof_file_approval, attendance_file_approval, category_file_approval, comment "
                    + "FROM candidate_approval "
                    + "WHERE nominationId = (SELECT id FROM candidate_nomination WHERE election_id = (SELECT election_id FROM elections ORDER BY created_at DESC LIMIT 1) AND registration_number = ?)";

            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, candidateRegNumber);

            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                jsonObject.put("candidate_file_approval", resultSet.getString("candidate_file_approval"));
                jsonObject.put("proposer_file_approval", resultSet.getString("proposer_file_approval"));
                jsonObject.put("seconder_file_approval", resultSet.getString("seconder_file_approval"));
                jsonObject.put("dob_proof_file_approval", resultSet.getString("dob_proof_file_approval"));
                jsonObject.put("attendance_file_approval", resultSet.getString("attendance_file_approval"));
                jsonObject.put("category_file_approval", resultSet.getString("category_file_approval"));
                jsonObject.put("comment", resultSet.getString("comment"));
            }
        }
        return jsonObject;
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        String candidateRegNumber = "";

        if (session != null && session.getAttribute("username") != null) {
            candidateRegNumber = (String) session.getAttribute("username");
        }

        Properties props = getConnectionData();
        String jdbcUrl = props.getProperty("db.url");
        String dbUser = props.getProperty("db.username");
        String dbPassword = props.getProperty("db.password");

        String requestStatus = request.getParameter("status");

        JSONObject jsonObject;
        try {
            if (requestStatus != null && requestStatus.equals("3.5")) {
                jsonObject = getProposerAndSeconderRejectedCandidates(candidateRegNumber, jdbcUrl, dbUser, dbPassword);
            }
            else if(requestStatus != null && requestStatus.equals("4.5")){
                jsonObject = getDeanRejectReasons(candidateRegNumber, jdbcUrl, dbUser, dbPassword);
            }
            else if(requestStatus != null && requestStatus.equals("5.5")){
                jsonObject = getCandidateApprovalInfo(candidateRegNumber, jdbcUrl, dbUser, dbPassword);
            }
            else {
                jsonObject = new JSONObject();
            }
        } catch (SQLException e) {
            Logger lgr = Logger.getLogger(RejectedCandidatesServlet.class.getName());
            lgr.log(Level.SEVERE, e.getMessage(), e);
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            return;
        }

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print(jsonObject);
    }
}

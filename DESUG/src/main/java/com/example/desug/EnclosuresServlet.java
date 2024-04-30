package com.example.desug;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Properties;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "submitEnclosures", value = "/submitEnclosures")
@MultipartConfig
public class EnclosuresServlet extends HttpServlet {

    private static Properties getConnectionData() {
        Properties props = new Properties();
        try {
            InputStream inputStream = EnclosuresServlet.class.getClassLoader().getResourceAsStream("db.properties");
            props.load(inputStream);
        } catch (IOException ioe) {
            Logger lgr = Logger.getLogger(EnclosuresServlet.class.getName());
            lgr.log(Level.SEVERE, ioe.getMessage(), ioe);
        }
        return props;
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        String student = session.getAttribute("username").toString();

        String UPLOAD_DIRECTORY = "C:\\Users\\anant\\Downloads\\Nominations";
//        String UPLOAD_DIRECTORY = "C:\\Users\\Srivatsa\\Downloads\\Nominations";

        Properties props = getConnectionData();

        // Database connection parameters
        String jdbcUrl = props.getProperty("db.url");
        String dbUser = props.getProperty("db.username");
        String dbPassword = props.getProperty("db.password");

        try {
            // Establishing connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

            // SQL query to insert data into uploaded_files table
            String sql = "INSERT INTO uploaded_files (nomination_id, candidate_file_path, proposer_file_path, seconder_file_path, dob_proof_file_path, attendance_file_path, category_file_path) VALUES ((select id from candidate_nomination where election_id = (select election_id from elections order by created_at desc limit 1)  and registration_number= ?), ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);

            // Set the nomination_id
            stmt.setString(1, student);

            // Handle the file uploads
            String[] fileFields = {"candidateSemesterRegistrationCard", "proposerSemesterRegistrationCard", "seconderSemesterRegistrationCard", "proofOfDob", "certificateOfAttendanceAcademicRecord", "categoryCertificate"};
            for (int i = 0; i < fileFields.length; i++) {
                Part filePart = request.getPart(fileFields[i]);
                if (filePart != null && filePart.getSize() > 0) {
                    String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                    String uniqueFileName = UUID.randomUUID() + "_" + fileName;
                    String savePath = UPLOAD_DIRECTORY + File.separator + uniqueFileName;

                    try (InputStream fileContent = filePart.getInputStream()) {
                        Files.copy(fileContent, Paths.get(savePath), StandardCopyOption.REPLACE_EXISTING);
                    }

                    // Set the file path in the PreparedStatement
                    stmt.setString(i + 2, savePath);
                } else {
                    stmt.setString(i + 2, null);
                }
            }

            // Execute the update
            int rowsInserted = stmt.executeUpdate();

            if (rowsInserted > 0) {
                // If the insert was successful, update the nomination_status table
                String updateSql = "UPDATE nomination_status SET status = '2' WHERE nomination_id = (SELECT id FROM candidate_nomination WHERE election_id = (SELECT election_id FROM elections ORDER BY created_at DESC LIMIT 1) AND registration_number = ?)";
                PreparedStatement updateStmt = conn.prepareStatement(updateSql);
                updateStmt.setString(1, student);
                updateStmt.executeUpdate();

                String checkSql = "SELECT proposer_status, seconder_status FROM nomination_status WHERE nomination_id = (SELECT id FROM candidate_nomination WHERE election_id = (SELECT election_id FROM elections ORDER BY created_at DESC LIMIT 1) AND registration_number = ?)";
                PreparedStatement checkStmt = conn.prepareStatement(checkSql);
                checkStmt.setString(1, student); // Set nomination ID here
                ResultSet resultSet = checkStmt.executeQuery();

                String proposerStatus = null;
                String seconderStatus = null;
                if (resultSet.next()) {
                    proposerStatus = resultSet.getString("proposer_status");
                    seconderStatus = resultSet.getString("seconder_status");
                }
                if ((proposerStatus != null && proposerStatus.equals("yes")) && (seconderStatus != null && seconderStatus.equals("yes"))) {
                    // Both proposer and seconder statuses are "yes", update status to 3
                    String updateStatusSql = "UPDATE nomination_status SET status = '3' WHERE nomination_id = (SELECT id FROM candidate_nomination WHERE election_id = (SELECT election_id FROM elections ORDER BY created_at DESC LIMIT 1) AND registration_number = ?)";
                    PreparedStatement updateStatusStmt = conn.prepareStatement(updateStatusSql);
                    updateStatusStmt.setString(1, student); // Set nomination ID here
                    updateStatusStmt.executeUpdate();
                }
            }

            response.sendRedirect("candidateRegistration.jsp");

        } catch (Exception e) {
            Logger lgr = Logger.getLogger(EnclosuresServlet.class.getName());
            lgr.log(Level.SEVERE, e.getMessage(), e);
        }
    }
}

package com.example.desug;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/certifyCandidate")
public class CertifyCandidateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static Properties getConnectionData() {
        Properties props = new Properties();
        try {
            InputStream inputStream = CertifyCandidateServlet.class.getClassLoader().getResourceAsStream("db.properties");
            props.load(inputStream);
        } catch (IOException ioe) {
            Logger lgr = Logger.getLogger(CertifyCandidateServlet.class.getName());
            lgr.log(Level.SEVERE, ioe.getMessage(), ioe);
        }
        return props;
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get form data
        String registrationNumber = request.getParameter("registrationNumber");
        String attendance = request.getParameter("attendance");
        String academicArrears = request.getParameter("academicArrears");
        String registeredPhd = request.getParameter("registeredPhd");
        String courseRequirements = request.getParameter("courseRequirements");
        String researchProgress = request.getParameter("researchProgress");
        String DRCReport = request.getParameter("DRCReport");
        String comments = request.getParameter("comments");
        String dateCertification = request.getParameter("dateCertification");

        // JDBC variables
        Connection conn = null;
        PreparedStatement stmt = null;

        Properties props = getConnectionData();

        // Database connection parameters
        String jdbcUrl = props.getProperty("db.url");
        String dbUser = props.getProperty("db.username");
        String dbPassword = props.getProperty("db.password");

        try {
            // Establish database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

            // Set auto-commit to false
            conn.setAutoCommit(false);

            // SQL query to insert data into table
            String sql = "INSERT INTO certification_data (registrationNumber, attendance, academicArrears, registeredStudent, courseRequirements, researchProgress, DRCReport, comments, dateCertification, nominationId) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, (SELECT id FROM candidate_nomination WHERE election_id = (SELECT election_id FROM elections ORDER BY created_at DESC LIMIT 1) AND registration_number = ?))";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, registrationNumber);
            stmt.setString(2, attendance);
            stmt.setString(3, academicArrears);
            stmt.setString(4, registeredPhd);
            stmt.setString(5, courseRequirements);
            stmt.setString(6, researchProgress);
            stmt.setString(7, DRCReport);
            stmt.setString(8, comments);
            stmt.setString(9, dateCertification);
            stmt.setString(10, registrationNumber);

            // Add the prepared statement to the batch
            stmt.addBatch();
            int[] rowsAffected = stmt.executeBatch();

            // Check if any input is 'no'
            if (!"no".equalsIgnoreCase(attendance) && !"no".equalsIgnoreCase(academicArrears) &&
                    !"no".equalsIgnoreCase(registeredPhd) && !"no".equalsIgnoreCase(courseRequirements) &&
                    !"no".equalsIgnoreCase(researchProgress) && !"no".equalsIgnoreCase(DRCReport) && rowsAffected[0]>0) {

                // Update nomination_status
                String sqlUpdate = "UPDATE nomination_status SET status = '4' WHERE nomination_id = (SELECT id FROM candidate_nomination WHERE election_id = (SELECT election_id FROM elections ORDER BY created_at DESC LIMIT 1) AND registration_number = ?)";
                stmt = conn.prepareStatement(sqlUpdate);
                stmt.setString(1, registrationNumber);

                // Add the prepared statement to the batch
                stmt.addBatch();

                // Send response
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.println("<html><body>");
                out.println("<h2>Record inserted and status updated successfully!</h2>");
                out.println("</body></html>");
            }
            else{
                String sqlUpdate = "UPDATE nomination_status SET status = '4.5' WHERE nomination_id = (SELECT id FROM candidate_nomination WHERE election_id = (SELECT election_id FROM elections ORDER BY created_at DESC LIMIT 1) AND registration_number = ?)";
                stmt = conn.prepareStatement(sqlUpdate);
                stmt.setString(1, registrationNumber);
                stmt.executeUpdate();

                stmt.addBatch();

                // Send response
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.println("<html><body>");
                out.println("<h2>Record inserted and status updated successfully!</h2>");
                out.println("</body></html>");
            }


            // Add the prepared statement to the batch
            stmt.addBatch();

            // Execute the batch
            stmt.executeBatch();

            // Commit the transaction
            conn.commit();

            // Send response
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<html><body>");
            out.println("<script>alert('Record inserted and status updated successfully!');</script>");
            out.println("</body></html>");

            response.sendRedirect("certifyCandidates.jsp");
        } catch (ClassNotFoundException | SQLException e) {
            Logger lgr = Logger.getLogger(CertifyCandidateServlet.class.getName());
            lgr.log(Level.SEVERE, e.getMessage(), e);
            try {
                if (conn != null) {
                    // Rollback the transaction in case of an exception
                    conn.rollback();
                }
            } catch (SQLException sql) {
                lgr = Logger.getLogger(CertifyCandidateServlet.class.getName());
                lgr.log(Level.SEVERE, sql.getMessage(), sql);
            }
        } finally {
            // Close resources
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                Logger lgr = Logger.getLogger(CertifyCandidateServlet.class.getName());
                lgr.log(Level.SEVERE, e.getMessage(), e);
            }
        }
    }
}

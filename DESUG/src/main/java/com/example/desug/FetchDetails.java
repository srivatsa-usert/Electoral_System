package com.example.desug;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/fetchDetails")
public class FetchDetails extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static Properties getConnectionData() {
        Properties props = new Properties();
        try {
            InputStream inputStream = FetchDetails.class.getClassLoader().getResourceAsStream("db.properties");
            props.load(inputStream);
        } catch (IOException ioe) {
            Logger lgr = Logger.getLogger(FetchDetails.class.getName());
            lgr.log(Level.SEVERE, ioe.getMessage(), ioe);
        }
        return props;
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String registrationNumber = request.getParameter("registrationNumber");
        String withdrawForm = null;
        if (request.getParameter("withdrawForm") != null) {
            withdrawForm = request.getParameter("withdrawForm");
        }

        Properties props = getConnectionData();

        // Database connection parameters
        String jdbcUrl = props.getProperty("db.url");
        String dbUser = props.getProperty("db.username");
        String dbPassword = props.getProperty("db.password");

        // JDBC variables
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // Establishing connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

            // SQL query to fetch details based on registration number including DOB
            String sql = "SELECT name, department, course, subject, DOB, semester, student_type FROM student WHERE roll_number = ?";
            if (withdrawForm != null && withdrawForm.equals("yes")) {
                sql = "SELECT student.name, student.department, student.course, student.subject, student.DOB, student.semester, student.student_type, candidate_nomination.position " +
                        "FROM student JOIN candidate_nomination ON student.roll_number = candidate_nomination.registration_number " +
                        "WHERE student.roll_number = ? AND candidate_nomination.election_id = (SELECT election_id FROM elections ORDER BY created_at DESC LIMIT 1)";
            }
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, registrationNumber);
            rs = stmt.executeQuery();

            // Writing JSON response
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            if (rs.next()) {
                String name = rs.getString("name");
                String department = rs.getString("department");
                String course = rs.getString("course");
                String subject = rs.getString("subject");
                Date dob = java.sql.Date.valueOf(rs.getString("DOB"));
                int semester = rs.getInt("semester");
                String studentType = rs.getString("student_type");
                String position = null;
                if (withdrawForm != null && withdrawForm.equals("yes")) {
                    position = rs.getString("position");
                }

                out.println("{");
                out.println("\"name\": \"" + name + "\",");
                out.println("\"department\": \"" + department + "\",");
                out.println("\"course\": \"" + course + "\",");
                out.println("\"subject\": \"" + subject + "\",");
                out.println("\"dob\": \"" + dob + "\",");
                out.println("\"semester\": " + semester + ",");
                out.println("\"studentType\": \"" + studentType + "\"");
                if (position != null) {
                    out.println(",\"position\": \"" + position + "\"");
                }
                out.println("}");
            } else {
                // If no record found
                out.println("{}");
            }
        } catch (SQLException | ClassNotFoundException e) {
            Logger lgr = Logger.getLogger(FetchDetails.class.getName());
            lgr.log(Level.SEVERE, e.getMessage(), e);
        } finally {
            // Closing resources
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                Logger lgr = Logger.getLogger(FetchDetails.class.getName());
                lgr.log(Level.SEVERE, e.getMessage(), e);
            }
        }
    }
}

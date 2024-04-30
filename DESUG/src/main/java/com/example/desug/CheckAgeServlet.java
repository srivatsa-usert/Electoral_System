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

@WebServlet("/checkAge")
public class CheckAgeServlet extends HttpServlet {
    // Method to load database connection properties
    private Properties getConnectionData() throws IOException {
        Properties props = new Properties();
        try {
            InputStream inputStream = getClass().getClassLoader().getResourceAsStream("db.properties");
            props.load(inputStream);
        } catch (IOException e) {
            Logger lgr = Logger.getLogger(CheckAgeServlet.class.getName());
            lgr.log(Level.SEVERE, e.getMessage(), e);
        }
        return props;
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Retrieve age parameter from request
        int age = 0; // Default age value
        String ageParam = request.getParameter("age");

        HttpSession session = request.getSession();

        // Get the value of the session variable named "variableName"
        String roll = (String)session.getAttribute("username");


        // Check if ageParam is not null and not empty before parsing
        if (ageParam != null && !ageParam.isEmpty()) {
            age = Integer.parseInt(ageParam);
        }

        // Retrieve academic program (student_type) from the student table
        String academicProgram = getAcademicProgram(roll);

        // Perform eligibility check
        boolean isEligible = checkEligibility(age, academicProgram);

        // Prepare response
        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();
        // System.out.println(isEligible);
        out.print(isEligible); // Send true or false indicating eligibility
    }

    // Method to check eligibility based on age and academic program
    private boolean checkEligibility(int age, String academicProgram) {
        // Retrieve age rules from the database
        Integer minAge = null;
        Integer maxAge = null;

        try {
            // Load database connection properties
            Properties props = getConnectionData();
            // Establish database connection
            Connection conn = DriverManager.getConnection(props.getProperty("db.url"), props.getProperty("db.username"), props.getProperty("db.password"));

            // Prepare SQL query to fetch age rules based on academic program
            String sql = "SELECT minimum_age, maximum_age FROM age_rule WHERE academic_programme = ? AND election_id = (SELECT election_id FROM elections ORDER BY created_at DESC LIMIT 1)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, academicProgram);
            ResultSet rs = stmt.executeQuery();

            // If a record is found, retrieve minimum_age and maximum_age
            if (rs.next()) {
                // Handle NULL values for minimum_age and maximum_age
                minAge = rs.getInt("minimum_age");
                if (rs.wasNull()) {
                    minAge = 0;
                }
                maxAge = rs.getInt("maximum_age");
                if (rs.wasNull()) {
                    maxAge = 999;
                }
            }

            // Close resources
            rs.close();
            stmt.close();
            conn.close();
        } catch (SQLException | IOException e) {
            Logger lgr = Logger.getLogger(CheckAgeServlet.class.getName());
            lgr.log(Level.SEVERE, e.getMessage(), e);
        }

        // Perform eligibility check based on retrieved age rules
        // System.out.println("Age: " + age + " MaxAge: " + maxAge + " MinAge: " + minAge);
        // Check if age is within the range or if there are no age restrictions
        return (minAge == null || age >= minAge) && (maxAge == null || age <= maxAge);
    }

    // Method to retrieve academic program from student table
    private String getAcademicProgram(String username) {
        String academicProgram = "";

        try {
            // Load database connection properties
            Properties props = getConnectionData();
            // Establish database connection
            Connection conn = DriverManager.getConnection(props.getProperty("db.url"), props.getProperty("db.username"), props.getProperty("db.password"));

            // Prepare SQL query to fetch academic program based on username
            String sql = "SELECT student_type FROM student WHERE roll_number = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            // If a record is found, retrieve academic program
            if (rs.next()) {
                academicProgram = rs.getString("student_type");
            }

            // Close resources
            rs.close();
            stmt.close();
            conn.close();
        } catch (SQLException | IOException e) {
            Logger lgr = Logger.getLogger(CheckAgeServlet.class.getName());
            lgr.log(Level.SEVERE, e.getMessage(), e);
        }

        switch (academicProgram) {
            case "PG":
                academicProgram = "PG";
                break;
            case "UG":
                academicProgram = "UG";
                break;
            case "Research":
                academicProgram = "Research";
                break;
        }
        // System.out.println(academicProgram);
        return academicProgram;
    }
}

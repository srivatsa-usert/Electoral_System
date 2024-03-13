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
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

import jakarta.servlet.ServletException;
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
            throws ServletException, IOException {
        String registrationNumber = request.getParameter("registrationNumber");

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
            String sql = "SELECT name, department, course, subject, DOB, semester FROM student WHERE roll_number = ?";
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

                out.println("{");
                out.println("\"name\": \"" + name + "\",");
                out.println("\"department\": \"" + department + "\",");
                out.println("\"course\": \"" + course + "\",");
                out.println("\"subject\": \"" + subject + "\",");
                out.println("\"dob\": \"" + dob + "\",");
                out.println("\"semester\": " + semester);
                out.println("}");
            } else {
                // If no record found
                out.println("{}");
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            // Closing resources
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}

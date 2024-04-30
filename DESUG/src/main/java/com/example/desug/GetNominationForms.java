package com.example.desug;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.JSONArray;
import org.json.JSONObject;


@WebServlet("/getCandidateList")
public class GetNominationForms extends HttpServlet {
    private static Properties getConnectionData() {
        Properties props = new Properties();
        try {
            InputStream inputStream = GetNominationForms.class.getClassLoader().getResourceAsStream("db.properties");
            props.load(inputStream);
        } catch (IOException ioe) {
            Logger lgr = Logger.getLogger(GetNominationForms.class.getName());
            lgr.log(Level.SEVERE, ioe.getMessage(), ioe);
        }
        return props;
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String status = request.getParameter("status");

        Properties props = getConnectionData();

        // Database connection parameters
        String jdbcUrl = props.getProperty("db.url");
        String dbUser = props.getProperty("db.username");
        String dbPassword = props.getProperty("db.password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

            JSONArray candidateList = new JSONArray();

            if (status.equals("all")) {
                // Query to fetch details of candidates with any nomination status
                String sql = "SELECT * " +
                        "FROM candidate_nomination cn " +
                        "JOIN nomination_status ns ON cn.id = ns.nomination_id "+
                        "JOIN student s ON cn.registration_number = s.roll_number";
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery();

                // Prepare JSON array to hold candidate objects
                // Build JSON array with fetched data
                while (rs.next()) {
                    JSONObject candidate = new JSONObject();
                    candidate.put("registrationNumber", rs.getString("registration_number"));
                    candidate.put("name", rs.getString("name"));
                    candidate.put("position", rs.getString("position"));
                    candidate.put("category", rs.getString("category"));
                    candidate.put("status", rs.getString("status"));
                    candidate.put("department", rs.getString("department"));
                    candidate.put("subject", rs.getString("subject"));
                    candidate.put("course", rs.getString("course"));
                    candidateList.put(candidate);
                }

                // Close resources
                rs.close();
                stmt.close();
            }
            else{
                // Query to fetch details of candidates whose nomination status is specified
                String sql = "SELECT cn.registration_number, cn.name_on_ballot_paper AS name, cn.position " +
                        "FROM candidate_nomination cn " +
                        "JOIN nomination_status ns ON cn.id = ns.nomination_id " +
                        "WHERE ns.status = ? AND cn.election_id = (SELECT election_id FROM elections ORDER BY election_id DESC LIMIT 1)";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1,status);
                ResultSet rs = stmt.executeQuery();

                // Prepare JSON array to hold candidate objects

                // Build JSON array with fetched data
                while (rs.next()) {
                    JSONObject candidate = new JSONObject();
                    candidate.put("registrationNumber", rs.getString("registration_number"));
                    candidate.put("Name", rs.getString("name"));
                    candidate.put("Position", rs.getString("position"));
                    candidateList.put(candidate);
                }

                // Close resources
                rs.close();
                stmt.close();
            }


            conn.close();

            // Send JSON response
            PrintWriter out = response.getWriter();
            out.print(candidateList);
            out.flush();

        } catch (Exception e) {
            Logger lgr = Logger.getLogger(GetNominationForms.class.getName());
            lgr.log(Level.SEVERE, e.getMessage(), e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}

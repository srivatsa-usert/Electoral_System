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
            InputStream inputStream = AddNewElectionServlet.class.getClassLoader().getResourceAsStream("db.properties");
            props.load(inputStream);
        } catch (IOException ioe) {
            Logger lgr = Logger.getLogger(AddNewElectionServlet.class.getName());
            lgr.log(Level.SEVERE, ioe.getMessage(), ioe);
        }
        return props;
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        int status = Integer.parseInt(request.getParameter("status"));

        Properties props = getConnectionData();

        // Database connection parameters
        String jdbcUrl = props.getProperty("db.url");
        String dbUser = props.getProperty("db.username");
        String dbPassword = props.getProperty("db.password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

            // Query to fetch registration number, name, and position of candidates with nomination status = 3
            String sql = "SELECT cn.registration_number, cn.name_on_ballot_paper AS name, cn.position " +
                    "FROM candidate_nomination cn " +
                    "JOIN nomination_status ns ON cn.id = ns.nomination_id " +
                    "WHERE ns.status = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1,status);
            ResultSet rs = stmt.executeQuery();

            // Prepare JSON array to hold candidate objects
            JSONArray candidateList = new JSONArray();

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
            conn.close();

            // Send JSON response
            PrintWriter out = response.getWriter();
            out.print(candidateList);
            out.flush();

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}

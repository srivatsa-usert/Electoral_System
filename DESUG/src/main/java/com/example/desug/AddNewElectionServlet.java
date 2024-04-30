package com.example.desug;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/addNewElectionServlet")
public class AddNewElectionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

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

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Election details
        String electionName = request.getParameter("election-name");
        String nominationStartDateTime = request.getParameter("nomination-start-date-time");
        String nominationEndDateTime = request.getParameter("nomination-end-date-time");
        String scrutinyListDateTime = request.getParameter("scrutiny-list-date-time");
        String withdrawalStartDateTime = request.getParameter("withdrawal-start-date-time");
        String withdrawalEndDateTime = request.getParameter("withdrawal-end-date-time");
        String finalListDateTime = request.getParameter("final-list-date-time");
        String campaignStartDate = request.getParameter("campaign-start-date");
        String campaignEndDate = request.getParameter("campaign-end-date");
        String pollingAgentsDateTime = request.getParameter("polling-counting-agents-date-time");
        String noCampaignDateTime = request.getParameter("no-campaign-date-time");
        String pollingDate = request.getParameter("polling-date");
        String pollingStartTime = request.getParameter("polling-start-time");
        String pollingEndTime = request.getParameter("polling-end-time");
        String resultsDateTime = request.getParameter("results-date-time");

        // Office Bearers details
        List<String> officeBearerPositions = new ArrayList<>();

        // Retrieve all dynamically added office bearers
        for (String paramName : request.getParameterMap().keySet()) {
            if (paramName.startsWith("office-bearers-")) {
                String position = request.getParameter(paramName);

                if("other".equals(position)) {
                    position = request.getParameter("other-position-" + paramName.split("-")[2]);
                }

                officeBearerPositions.add(position);
            }
        }

        // School Board Members and Councillors details
        List<String> schoolNames = new ArrayList<>();
        List<Integer> numberOfMembersList = new ArrayList<>();
        List<Integer> numberOfCouncillorsList = new ArrayList<>();

        // Retrieve all dynamically added school board members and councillors
        for (String paramName : request.getParameterMap().keySet()) {
            if (paramName.startsWith("name-of-school-")) {
                String schoolName = request.getParameter(paramName);
                int numberOfMembers = Integer.parseInt(request.getParameter("number-of-school-board-members-" + paramName.split("-")[3]));
                int numberOfCouncillors = Integer.parseInt(request.getParameter("number-of-councillors-" + paramName.split("-")[3]));

                if ("other".equals(schoolName)) {
                    schoolName = request.getParameter("other-school-name-" + paramName.split("-")[3]);
                }

                schoolNames.add(schoolName);
                numberOfMembersList.add(numberOfMembers);
                numberOfCouncillorsList.add(numberOfCouncillors);
            }
        }

        // Age Rule values
        String minAgeUG = request.getParameter("min-age-ug");
        String maxAgeUG = request.getParameter("max-age-ug");
        String minAgePG = request.getParameter("min-age-pg");
        String maxAgePG = request.getParameter("max-age-pg");
        String minAgeResearch = request.getParameter("min-age-research");
        String maxAgeResearch = request.getParameter("max-age-research");

        Properties props = getConnectionData();

        // Database connection parameters
        String jdbcUrl = props.getProperty("db.url");
        String dbUser = props.getProperty("db.username");
        String dbPassword = props.getProperty("db.password");

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs;
        boolean success = false;

        try {
            // Establishing connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

            // Begin transaction
            conn.setAutoCommit(false);

            // SQL query to insert data into elections table
            String sql = "INSERT INTO elections (election_name, nomination_start_datetime, nomination_end_datetime, scrutiny_list_datetime, withdrawal_start_datetime, withdrawal_end_datetime, final_list_datetime, campaign_start_date, campaign_end_date, polling_agents_datetime, no_campaign_datetime, polling_date, polling_start_time, polling_end_time, results_datetime, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setString(1, electionName);
            stmt.setString(2, nominationStartDateTime);
            stmt.setString(3, nominationEndDateTime);
            stmt.setString(4, scrutinyListDateTime);
            stmt.setString(5, withdrawalStartDateTime);
            stmt.setString(6, withdrawalEndDateTime);
            stmt.setString(7, finalListDateTime);
            stmt.setString(8, campaignStartDate);
            stmt.setString(9, campaignEndDate);
            stmt.setString(10, pollingAgentsDateTime);
            stmt.setString(11, noCampaignDateTime);
            stmt.setString(12, pollingDate);
            stmt.setString(13, pollingStartTime);
            stmt.setString(14, pollingEndTime);
            stmt.setString(15, resultsDateTime);

            LocalDateTime createdAt = LocalDateTime.now();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            stmt.setString(16,createdAt.format(formatter));

            int rowsInserted = stmt.executeUpdate();

            if (rowsInserted > 0) {
                // Data inserted successfully
                // Get the generated election ID
                rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    int electionId = rs.getInt(1);

                    // Insert office bearers data
                    for (String position : officeBearerPositions) {
                        String insertOfficeBearerSql = "INSERT INTO office_bearers (election_id, position) VALUES (?, ?)";
                        PreparedStatement officeBearerStmt = conn.prepareStatement(insertOfficeBearerSql);
                        officeBearerStmt.setInt(1, electionId);
                        officeBearerStmt.setString(2, position);
                        officeBearerStmt.executeUpdate();
                    }

                    // Insert school board members and councillors data
                    for (int i = 0; i < schoolNames.size(); i++) {
                        String insertMembersSql = "INSERT INTO school_boards_councillors (election_id, school_name, num_board_members, num_councillors) VALUES (?, ?, ?, ?)";
                        PreparedStatement membersStmt = conn.prepareStatement(insertMembersSql);
                        membersStmt.setInt(1, electionId);
                        membersStmt.setString(2, schoolNames.get(i));
                        membersStmt.setInt(3, numberOfMembersList.get(i));
                        membersStmt.setInt(4, numberOfCouncillorsList.get(i));
                        membersStmt.executeUpdate();
                    }

                    // Insert age rule values
                    String insertAgeRuleSql = "INSERT INTO age_rule (election_id, academic_programme, minimum_age, maximum_age) VALUES (?, ?, ?, ?), (?, ?, ?, ?), (?, ?, ?, ?)";
                    PreparedStatement ageRuleStmt = conn.prepareStatement(insertAgeRuleSql);
                    ageRuleStmt.setInt(1, electionId);
                    ageRuleStmt.setString(2, "UG");
                    ageRuleStmt.setString(3, minAgeUG);
                    ageRuleStmt.setString(4, maxAgeUG);
                    ageRuleStmt.setInt(5, electionId);
                    ageRuleStmt.setString(6, "PG");
                    ageRuleStmt.setString(7, minAgePG);
                    ageRuleStmt.setString(8, maxAgePG);
                    ageRuleStmt.setInt(9, electionId);
                    ageRuleStmt.setString(10, "Research");
                    ageRuleStmt.setString(11, minAgeResearch);
                    ageRuleStmt.setString(12, maxAgeResearch);
                    ageRuleStmt.executeUpdate();

                    // Commit transaction
                    conn.commit();
                    success = true;

                    // Show success message
                    PrintWriter out = response.getWriter();
                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('New election added successfully');");
                    out.println("location='electionChairHome.jsp';");
                    out.println("</script>");
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            Logger lgr = Logger.getLogger(AddNewElectionServlet.class.getName());
            lgr.log(Level.SEVERE, e.getMessage(), e);
        } finally {
            // Closing resources and handling transaction
            try {
                if (stmt != null) stmt.close();
                if (conn != null) {
                    if (!success) {
                        conn.rollback(); // Rollback if not successful
                    }
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (SQLException e) {
                Logger lgr = Logger.getLogger(AddNewElectionServlet.class.getName());
                lgr.log(Level.SEVERE, e.getMessage(), e);
            }
        }
    }
}

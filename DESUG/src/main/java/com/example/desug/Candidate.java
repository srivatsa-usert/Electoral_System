package com.example.desug;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Candidate {

    private final String rollNumber;
    private final String electionPosition;
    private final String manifesto;
    private final String electionStatus;
    private final String proposer;
    private final String seconder;

    public Candidate(String rollNumber, String electionPosition, String manifesto, String electionStatus, String proposer, String seconder) {
        this.rollNumber = rollNumber;
        this.electionPosition = electionPosition;
        this.manifesto = manifesto;
        this.electionStatus = electionStatus;
        this.proposer = proposer;
        this.seconder = seconder;
    }

    private static Properties getConnectionData() {
        Properties props = new Properties();
        String fileName = "S:\\Coding '-'\\Software Engineering\\SE_Lab\\DESUG\\src\\main\\java\\com\\example\\desug\\db.properties";
        try (FileInputStream fis = new FileInputStream(fileName)) {
            props.load(fis);
        } catch (IOException ioe) {
            Logger lgr = Logger.getLogger(Candidate.class.getName());
            lgr.log(Level.SEVERE, ioe.getMessage(), ioe);
        }
        return props;
    }

    public static List<Candidate> getCandidatesList() {
        List<Candidate> candidates = new ArrayList<>();
        Properties props = getConnectionData();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch(ClassNotFoundException cnfe) {
            System.out.println(cnfe);
        }

        String url = props.getProperty("db.url");
        String user = props.getProperty("db.user");
        String password = props.getProperty("db.password");

        try (Connection conn = DriverManager.getConnection(url, user, password)) {
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM candidate");
            while (rs.next()) {
                candidates.add(new Candidate(rs.getString("roll_number"), rs.getString("election_position"), rs.getString("manifesto"), rs.getString("election_status"), rs.getString("proposer"), rs.getString("seconder")));
            }
        } catch (SQLException sqle) {
            Logger lgr = Logger.getLogger(Candidate.class.getName());
            lgr.log(Level.SEVERE, sqle.getMessage(), sqle);
        }
        return candidates;
    }

    public String getRollNumber() {
        return this.rollNumber;
    }

    public String getElectionPosition() {
        return this.electionPosition;
    }

    public String getManifesto() {
        return this.manifesto;
    }

    public String getElectionStatus() {
        return this.electionStatus;
    }

    public String getProposer() {
        return this.proposer;
    }

    public String getSeconder() {
        return this.seconder;
    }
}

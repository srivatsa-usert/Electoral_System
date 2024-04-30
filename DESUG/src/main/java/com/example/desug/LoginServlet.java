package com.example.desug;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
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

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static Properties getConnectionData() {
        Properties props = new Properties();
        try {
            InputStream inputStream = LoginServlet.class.getClassLoader().getResourceAsStream("db.properties");
            props.load(inputStream);
        } catch (IOException ioe) {
            Logger lgr = Logger.getLogger(LoginServlet.class.getName());
            lgr.log(Level.SEVERE, ioe.getMessage(), ioe);
        }
        return props;
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        String passwordHash = hashPassword(password);

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

            // SQL query to check credentials
            String sql = "SELECT username, type FROM login WHERE username = ? and password = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, passwordHash);
            rs = stmt.executeQuery();

            if (rs.next()) {
                // If user exists, retrieve the name, roll number, and type
                String rollNumber = rs.getString("username");
                String userType = rs.getString("type");

                // Create a session and store name and roll number
                HttpSession session = request.getSession();
                session.setAttribute("username", rollNumber);

                // Redirect based on user type
                switch (userType) {
                    case "Student":
                        response.sendRedirect("home.jsp");
                        break;
                    case "Dean":
                    case "Hod":
                        response.sendRedirect("deanHome.jsp");
                        break;
                    case "ElectionChair":
                        response.sendRedirect("electionChairHome.jsp");
                        break;
                }
            } else {
                // If user does not exist, show error message
                PrintWriter out = response.getWriter();
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Invalid username or password');");
                out.println("location='home.jsp';");
                out.println("</script>");
            }
        } catch (SQLException | ClassNotFoundException e) {
            Logger lgr = Logger.getLogger(LoginServlet.class.getName());
            lgr.log(Level.SEVERE, e.getMessage(), e);
        } finally {
            // Closing resources
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                Logger lgr = Logger.getLogger(LoginServlet.class.getName());
                lgr.log(Level.SEVERE, e.getMessage(), e);
            }
        }
    }


    private String hashPassword(String password) {
        try {
            // Create MessageDigest instance for MD5
            MessageDigest md = MessageDigest.getInstance("MD5");

            // Add password bytes to digest
            md.update(password.getBytes());

            // Get the hash's bytes
            byte[] bytes = md.digest();

            // These bytes[] has bytes in decimal format;
            // Convert it to hexadecimal format
            StringBuilder sb = new StringBuilder();
            for (byte b : bytes) {
                sb.append(Integer.toString((b & 0xff) + 0x100, 16).substring(1));
            }

            // Return the hashed password
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            Logger lgr = Logger.getLogger(LoginServlet.class.getName());
            lgr.log(Level.SEVERE, e.getMessage(), e);
            return null;
        }
    }
}
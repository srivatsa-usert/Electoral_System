package com.example.desug;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/file") // Annotation to map the servlet to a URL pattern
public class FileServlet extends HttpServlet {

    private static Properties getConnectionData() {
        Properties props = new Properties();
        try {
            InputStream inputStream = FileServlet.class.getClassLoader().getResourceAsStream("db.properties");
            props.load(inputStream);
        } catch (IOException ioe) {
            Logger lgr = Logger.getLogger(FileServlet.class.getName());
            lgr.log(Level.SEVERE, ioe.getMessage(), ioe);
        }
        return props;
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getParameter("registrationId") != null && request.getParameter("filePathKey") != null) {
            String registrationId = request.getParameter("registrationId");
            String file = request.getParameter("filePathKey");
            String filepath = getFilename(registrationId, file);

            response.setContentType("application/json");
            PrintWriter out = response.getWriter();

            if (filepath != null) {
                // Escape backslashes in the filepath
                filepath = filepath.replace("\\", "/");
                out.println("{");
                out.println("\"filepath\": \"" + filepath + "\"");
                out.println("}");
            }
            else {
                out.println("{}");
            }
        }
        else {
            String filePath = request.getParameter("filepath");
            filePath = filePath.replace("/", "\\");
            File file = new File(filePath);

            if (file.exists()) {
                String contentType = getContentType(file.getName());
                response.setContentType(contentType);
                response.setHeader("Content-Disposition", "inline; filename=" + file.getName());

                FileInputStream fis = new FileInputStream(file);
                byte[] buffer = new byte[1024];
                int bytesRead;

                while ((bytesRead = fis.read(buffer)) != -1) {
                    response.getOutputStream().write(buffer, 0, bytesRead);
                }
                fis.close();
            } else {
                response.getWriter().println("File not found");
            }
        }
    }

    private String getContentType(String fileName) {
        if (fileName.endsWith(".pdf")) {
            return "application/pdf";
        } else if (fileName.endsWith(".doc") || fileName.endsWith(".docx")) {
            return "application/msword";
        } else if (fileName.endsWith(".xls") || fileName.endsWith(".xlsx")) {
            return "application/vnd.ms-excel";
        } else if (fileName.endsWith(".ppt") || fileName.endsWith(".pptx")) {
            return "application/vnd.ms-powerpoint";
        } else if (fileName.endsWith(".png")) {
            return "image/png";
        } else if (fileName.endsWith(".jpg") || fileName.endsWith(".jpeg")) {
            return "image/jpeg";
        } else if (fileName.endsWith(".gif")) {
            return "image/gif";
        } else if (fileName.endsWith(".txt")) {
            return "text/plain";
        } else {
            return "application/octet-stream"; // Default content type for other file types
        }
    }

    private static String getFilename(String registrationId, String file) {
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
            String sql = "SELECT " + file + " FROM uploaded_files WHERE nomination_id = (SELECT id FROM candidate_nomination WHERE election_id = (SELECT election_id FROM elections ORDER BY created_at DESC LIMIT 1) AND registration_number = ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, registrationId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getString(file);
            }
        } catch (Exception e) {
            Logger lgr = Logger.getLogger(FileServlet.class.getName());
            lgr.log(Level.SEVERE, e.getMessage(), e);
        }

        return null;
    }
}

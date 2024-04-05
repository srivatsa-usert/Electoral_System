package com.example.desug;

import java.io.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.util.UUID;

@WebServlet("/submitEnclosures")
@MultipartConfig
public class EnclosuresServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String uploadPath = "D:\\sem 6\\SE Lab\\SE_Lab\\DESUG\\src\\main\\java\\com\\example\\desug\\enclosures";

        // Create the upload directory if it doesn't exist
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        // Get the files from the request
        Part candidatePart = request.getPart("candidateSemesterRegistrationCard");
        Part proposerPart = request.getPart("proposerSemesterRegistrationCard");
        Part seconderPart = request.getPart("seconderSemesterRegistrationCard");
        Part dobProofPart = request.getPart("proofOfDob");
        Part attendancePart = request.getPart("certificateOfAttendanceAcademicRecord");
        Part categoryPart = request.getPart("categoryCertificate");

        // Generate UUID
        String uuid = UUID.randomUUID().toString();

        // Save files with UUID appended to filename
        saveFile(candidatePart, uploadPath, uuid);
        saveFile(proposerPart, uploadPath, uuid);
        saveFile(seconderPart, uploadPath, uuid);
        saveFile(dobProofPart, uploadPath, uuid);
        saveFile(attendancePart, uploadPath, uuid);
        saveFile(categoryPart, uploadPath, uuid);

        // Store file paths with UUID in the database
        // Code for storing file paths in the database goes here

        // Redirect or send response
        response.sendRedirect("candidateRegistration.jsp");
    }

    private void saveFile(Part part, String uploadPath, String uuid) throws IOException {
        String fileName = uuid + "_" + getFileName(part);
        part.write(uploadPath + File.separator + fileName);
    }

    private String getFileName(Part part) {
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
}

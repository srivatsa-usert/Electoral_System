//package com.example.desug;
//
//import java.io.File;
//import java.io.IOException;
//import java.util.List;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.MultipartConfig;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import org.apache.commons.fileupload.FileItem;
//import org.apache.commons.fileupload.disk.DiskFileItemFactory;
//import org.apache.commons.fileupload.servlet.ServletFileUpload;
//
//@WebServlet("/submitEnclosures")
//@MultipartConfig
//public class EnclosuresServlet extends HttpServlet {
//    private static final long serialVersionUID = 1L;
//
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        String uploadFolder = "D:/sem 6/SE Lab/SE_Lab/DESUG/src/main/java/com/example/desug/enclosures";
//
//        // Check that we have a file upload request
//        boolean isMultipart = ServletFileUpload.isMultipartContent(request);
//        if (!isMultipart) {
//            response.getWriter().println("No file uploaded");
//            return;
//        }
//
//        // Create a factory for disk-based file items
//        DiskFileItemFactory factory = new DiskFileItemFactory();
//
//        // Set factory constraints
//        factory.setSizeThreshold(4096); // Threshold size for temporarily stored files (4KB)
//        factory.setRepository(new File(System.getProperty("java.io.tmpdir"))); // Set temporary directory
//
//        // Create a new file upload handler
//        ServletFileUpload upload = new ServletFileUpload(factory);
//
//        try {
//            // Parse the request
//            List<FileItem> items = upload.parseRequest(request);
//            for (FileItem item : items) {
//                // Process only file upload - discard form fields
//                if (!item.isFormField()) {
//                    String fileName = new File(item.getName()).getName();
//                    String filePath = uploadFolder + File.separator + fileName;
//                    File storeFile = new File(filePath);
//
//                    // Save the file to disk
//                    item.write(storeFile);
//                }
//            }
//            response.getWriter().println("Files uploaded successfully");
//        } catch (Exception e) {
//            response.getWriter().println("File upload failed due to: " + e);
//        }
//    }
//}
//

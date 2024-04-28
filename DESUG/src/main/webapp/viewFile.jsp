<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    session = request.getSession();

    // Check if session is not null and if username attribute is present
    if (session != null && session.getAttribute("username") != null) {
        // do nothing
    } else {
        // Redirect to home page if session is null or username attribute is not present
        response.sendRedirect("home.jsp?loginRequired=true");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>File Viewer</title>
</head>

<body class="flex flex-col min-h-screen">
    <%
        if (request.getParameter("filepath") != null) {
            String filepath = request.getParameter("filepath");
    %>
            <h2 class="text-center">Requested File:</h2>
            <iframe src="file?filepath=<%= filepath %>" width="100%" height="600px"></iframe>
    <%
        }
        else {
    %>
            <h1> File not available/found. </h1>
    <%
        }
    %>
</body>
</html>

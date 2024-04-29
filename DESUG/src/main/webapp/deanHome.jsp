<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    session = request.getSession();

    // Check if session is not null and if username attribute is present
    if (session != null && session.getAttribute("username") != null) {
        // do nothing
    }
    else {
        // Redirect to home page if session is null or username attribute is not present
        response.sendRedirect("home.jsp?loginRequired=true");
    }
%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home Page</title>
</head>

<body class="flex flex-col min-h-screen">
    <!-- Header -->
    <%@ include file="header.jsp" %>

    <!-- Main Content -->
    <div class="flex-grow p-6 bg-white dark:bg-gray-800">
        <div class="max-w-screen-xl mx-auto p-4">
            <div class="grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-3">
                <div class="p-6 bg-white rounded-lg shadow dark:bg-gray-800">
                    <h2 class="text-lg font-semibold text-gray-800 dark:text-white">Certify Candidate</h2>
                    <p class="mt-2 text-sm text-gray-500 dark:text-gray-400">Certify a candidate with the attendance and academic record.</p>
                    <a href="certifyCandidates.jsp" class="block mt-4 text-sm font-semibold text-blue-600 dark:text-blue-400 hover:underline">Certify Candidate</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <%@ include file="footer.jsp" %>
</body>
</html>

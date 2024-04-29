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
                    <h2 class="text-lg font-semibold text-gray-800 dark:text-white">Approve Candidates</h2>
                    <p class="mt-2 text-sm text-gray-500 dark:text-gray-400">Approve the candidates who have applied for the election.</p>
                    <a href="approveCandidates.jsp" class="block mt-4 text-sm font-semibold text-blue-600 dark:text-blue-400 hover:underline">Approve Candidates</a>
                </div>
                <div class="p-6 bg-white rounded-lg shadow dark:bg-gray-800">
                    <h2 class="text-lg font-semibold text-gray-800 dark:text-white">Election Management</h2>
                    <p class="mt-2 text-sm text-gray-500 dark:text-gray-400">Manage the election process, add schedule, positions, schools, and age criteria.</p>
                    <a href="manageElection.jsp" class="block mt-4 text-sm font-semibold text-blue-600 dark:text-blue-400 hover:underline">Manage Election</a>
                </div>
                <%--<div class="p-6 bg-white rounded-lg shadow dark:bg-gray-800">
                    <h2 class="text-lg font-semibold text-gray-800 dark:text-white">Delegate Work</h2>
                    <p class="mt-2 text-sm text-gray-500 dark:text-gray-400">Delegate work to the election committee members.</p>
                    <a href="delegateWork.jsp" class="block mt-4 text-sm font-semibold text-blue-600 dark:text-blue-400 hover:underline">Delegate Work</a>
                </div>--%>
                <div class="p-6 bg-white rounded-lg shadow dark:bg-gray-800">
                    <h2 class="text-lg font-semibold text-gray-800 dark:text-white">View Candidates</h2>
                    <p class="mt-2 text-sm text-gray-500 dark:text-gray-400">View all the candidates who have applied for the election.</p>
                    <a href="viewCandidates.jsp" class="block mt-4 text-sm font-semibold text-blue-600 dark:text-blue-400 hover:underline">View Candidates</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <%@ include file="footer.jsp" %>
</body>
</html>

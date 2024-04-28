<%--
  Created by IntelliJ IDEA.
  User: Srivatsa
  Date: 03-04-2024
  Time: 11:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
        <h1 class="text-4xl font-bold mb-8 text-gray-800 dark:text-white">Welcome to the University Electoral System</h1>

        <p class="text-lg mb-6 text-gray-800 dark:text-gray-400">
            Elections to the Students' Union for the year 20XX - 20XX will be conducted as per the details mentioned below:
        </p>
        <p class="text-lg mb-6 text-gray-800 dark:text-gray-400">
            Elections will take place for the positions of President, Vice-President, General Secretary,
            Joint Secretary', Cultural Secretary, Sports Secretary, Councillors from respective Schools
            and School Board Members.
            While all eligible voters will vote for Office Bearers and the students of respective
            schools will vote for positions of Councillors and School Board Members of
            respective Schools.
        </p>

        <a href="https://uohyd.ac.in/" class="bg-blue-500 hover:bg-blue-600 text-white font-bold py-2 px-4 rounded">Learn More...</a>
    </div>

    <!-- Footer -->
    <%@ include file="footer.jsp" %>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" %>
<%
    session = request.getSession();
    String voterRegNumber = "";

    // Check if session is not null and if username attribute is present
    if (session != null && session.getAttribute("username") != null) {
        // Get the registration number from session attribute "username"
        voterRegNumber = (String) session.getAttribute("username");
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
    <title>Cast Vote</title>
    <style>
        .candidate-box {
            border: 1px solid #ccc;
            padding: 10px;
            margin: 10px;
            width: 200px;
            display: inline-block;
            text-align: center;
        }
    </style>
</head>

<body class="flex flex-col min-h-screen">
    <!-- Header -->
    <%@ include file="header.jsp" %>

    <!-- Main Content -->
    <div  class="flex-grow p-6 bg-white dark:bg-gray-800">
        <h1>Cast Your Vote</h1>
        <div id="castVoteDiv">
            <h2>Choose Candidate</h2>
            <%@ page import="java.util.List" %>
            <%@ page import="com.example.desug.Candidate" %>
            <form id="castVoteForm" name="castVoteForm" action="">
                <div id="selectCandidatesDiv">
                    <% List<Candidate> candidates = com.example.desug.Candidate.getCandidatesList(); %>
                    <% for (Candidate candidate : candidates) { %>
                    <div class="candidate-box">
                        <p><%= candidate.getElectionPosition() %></p>
                        <p><%= candidate.getRollNumber() %></p>
                        <button type="submit" name="selectedCandidate" value="<%= candidate.getRollNumber() %>">Vote</button>
                    </div>
                    <% } %>
                </div>
            </form>
        </div>
    </div>

    <!-- Footer -->
    <%@ include file="footer.jsp" %>
</body>
</html>

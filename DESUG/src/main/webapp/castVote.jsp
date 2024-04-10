<%--
    Created by IntelliJ IDEA.
    User: anant
    Date: 17-02-2024
    Time: 17:35
    To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
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

    <!-- Footer -->
    <%@ include file="footer.jsp" %>
</body>
</html>

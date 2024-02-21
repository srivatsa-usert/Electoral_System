<%--
  Created by IntelliJ IDEA.
  User: anant
  Date: 17-02-2024
  Time: 17:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Cast Vote</title>
</head>
<body>
<h1> Cast Your Vote </h1>
<div id="castVoteDiv">
    <h2>Cast Your Vote</h2>
    <%@ page import="java.util.List" %>
    <%@ page import="com.example.desug.Candidate" %>
    <form id="castVoteForm" name="castVoteForm">
        <div id="selectCandidatesDiv">
            <label for="candidates">Select Candidate:</label>
            <select id="candidates" name="candidates">
                <%-- Fetch candidates' details from the server-side --%>
                <% List<Candidate> candidates = com.example.desug.Candidate.getCandidatesList(); %>
                <% for (Candidate candidate : candidates) { %>
                <option value="<%= candidate.getRollNumber() %>">
                    <%= candidate.getElectionPosition() %> - <%= candidate.getRollNumber() %>
                </option>
                <% } %>
            </select>
        </div>
        <div id="reviewAndSubmitDiv">
            <div id="reviewDiv">

            </div>
            <input type="submit" name="submit" value="Confirm">
        </div>
    </form>
</div>
</body>
</html>

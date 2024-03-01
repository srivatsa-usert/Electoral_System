<%--
  Created by IntelliJ IDEA.
  User: anant
  Date: 29-02-2024
  Time: 21:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Candidate Registration</title>
    <style>
        h1 {
            text-align: center;
        }
        #nominationForm {
            text-align: center;
        }
    </style>
</head>
<body>
    <h1> Nomination Form </h1>

    <form id="nominationForm" name="nominationForm">
        <div class="nomination form">
            <label for="nameOfThePosition">Name of the Position:</label>
            <select id="nameOfThePosition" name="nameofThePosition">
                <option selected disabled>--position--</option>
                <option value="president">President</option>
                <option value="vice-president">Vice-President</option>
                <option value="general-secretary">General Secretary</option>
                <option value="joint-secretary">Joint Secretary</option>
                <option value="cultural-secretary">Cultural Secretary</option>
                <option value="sports-secretary">Sports Secretary</option>
                <option value="school-board-member">School Board Member</option>
                <option value="councillor">Councillor</option>
            </select>
            <br>
            <label for="candidateRegistrationNumber">Registration Number:</label>
            <input id="candidateRegistrationNumber" name="candidateRegistrationNumber" type="text" minlength="8" maxlength="8" disabled>
            <br>
            <label for="candidateName">Name of the Candidate in BLOCK LETTERS<i>(as displayed on the Reg./ Semester ID Card)</i>:</label>
            <input id="candidateName" name="candidateName" type="text" disabled>
            <br>
            <label for="nameOnBallotPaper"><b>Name of the Candidate to be displayed on the Ballot Paper in BLOCK LETTERS:</b></label>
            <input id="nameOnBallotPaper" name="nameOnBallotPaper" type="text">
            <br>
            <label for="dateOfBirth">Date of Birth</label>
            <input id="dateOfBirth" name="dateOfBirth" type="date">
            <br>
            <label for="age">Age</label>
            <input id="age" name="age" type="number" min="17" max="28">
            <br>
            <label for="categoryOfTheCandidate">Category of the Candidate:</label>
            <select id="categoryOfTheCandidate" name="categoryOfTheCandidate">
                <option selected disabled>--category--</option>
                <option value="gen">General</option>
                <option value="obc">OBC</option>
                <option value="ews">EWS</option>
                <option value="sc">SC</option>
                <option value="st">ST</option>
                <option value="pwd">PWD</option>
            </select>
            <br>
            <label for="fathersName">Father's Name:</label>
            <input id="fathersName" name="fathersName" type="text">
            <br>
            <label for="candidatesDepartment">Department/School:</label>
            <input id="candidatesDepartment" name="candidatesDepartment" type="text" disabled>
            <br>
            <label for="candidatesCourseAndSubject">Course &amp; Subject:</label>
            <input id="candidatesCourseAndSubject" name="candidatesCourseAndSubject" type="text" disabled>
            <br>
            <label for="semesterNumber">Semester Number:</label>
            <input id="semesterNumber" name="semesterNumber" type="number" disabled>
            <br>
            <label for="mobileNumber">Mobile Number:</label>
            <input id="mobileNumber" name="mobileNumber" type="number" minlength="10" maxlength="10" disabled>
            <br>
            <label for="email">Email ID:</label>
            <input id="email" name="email" type="text" disabled>
            <br>
            <label for="residentialAddress">Residential Address:</label>
            <textarea id="residentialAddress" name="residentialAddress" rows="3" cols="50"></textarea>
            <br>
            <label for="proposerName">Name of the PROPOSER:</label>
            <input id="proposerName" name="proposerName" type="text" disabled>
            <br>
            <label for="proposerRegistrationNumber">PROPOSER'S Registration Number:</label>
            <input id="proposerRegistrationNumber" name="proposerRegistrationNumber" type="text" minlength="8" maxlength="8">
            <br>
            <label for="proposersDepartment">PROPOSER's Department/School:</label>
            <input id="proposersDepartment" name="proposersDepartment" type="text" disabled>
            <br>
            <label for="proposersCourseAndSubject">PROPOSER's Course &amp; Subject:</label>
            <input id="proposersCourseAndSubject" name="proposersCourseAndSubject" type="text" disabled>
            <!-- signature of proposer -->
            <br>
            <label for="seconderName">Name of the SECONDER:</label>
            <input id="seconderName" name="seconderName" type="text" disabled>
            <br>
            <label for="seconderRegistrationNumber">SECONDER'S Registration Number:</label>
            <input id="seconderRegistrationNumber" name="seconderRegistrationNumber" type="text" minlength="8" maxlength="8">
            <br>
            <label for="secondersDepartment">SECONDER's Department/School:</label>
            <input id="secondersDepartment" name="secondersDepartment" type="text" disabled>
            <br>
            <label for="secondersCourseAndSubject">SECONDER's Course &amp; Subject:</label>
            <input id="secondersCourseAndSubject" name="secondersCourseAndSubject" type="text" disabled>
            <!-- signature of seconder -->
        </div>
    </form>
</body>
</html>

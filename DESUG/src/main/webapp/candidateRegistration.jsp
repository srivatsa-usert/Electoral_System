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
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">
<h1 class="text-3xl font-bold text-center mt-8">Nomination Form</h1>

<form id="nominationForm" name="nominationForm" class="mx-auto max-w-lg mt-8 bg-white p-8 rounded-lg shadow-lg">
    <div class="nomination form">
        <label for="nameOfThePosition" class="block mt-4">Name of the Position:</label>
        <select id="nameOfThePosition" name="nameofThePosition" class="block w-full mt-1 border-black-300 rounded-md shadow-sm focus:border-blue-300 focus:ring focus:ring-blue-200 focus:ring-opacity-50">
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
        <label for="candidateRegistrationNumber" class="block mt-4">Registration Number:</label>
        <input id="candidateRegistrationNumber" name="candidateRegistrationNumber" type="text" minlength="8" maxlength="8" class="block w-full mt-1 border-black-300 rounded-md shadow-sm focus:border-blue-300 focus:ring focus:ring-blue-200 focus:ring-opacity-50" disabled>
        <br>
        <label for="candidateName" class="block mt-4">Name of the Candidate in BLOCK LETTERS<i>(as displayed on the Reg./ Semester ID Card)</i>:</label>
        <input id="candidateName" name="candidateName" type="text" class="block w-full mt-1 border-black-300 rounded-md shadow-sm focus:border-blue-300 focus:ring focus:ring-blue-200 focus:ring-opacity-50" disabled>
        <br>
        <label for="nameOnBallotPaper" class="block mt-4"><b>Name of the Candidate to be displayed on the Ballot Paper in BLOCK LETTERS:</b></label>
        <input id="nameOnBallotPaper" name="nameOnBallotPaper" type="text" class="block w-full mt-1 border-black-300 rounded-md shadow-sm focus:border-blue-300 focus:ring focus:ring-blue-200 focus:ring-opacity-50">
        <br>
        <label for="dateOfBirth" class="block mt-4">Date of Birth</label>
        <input id="dateOfBirth" name="dateOfBirth" type="date" class="block w-full mt-1 border-black-300 rounded-md shadow-sm focus:border-blue-300 focus:ring focus:ring-blue-200 focus:ring-opacity-50">
        <br>
        <label for="age" class="block mt-4">Age</label>
        <input id="age" name="age" type="number" min="17" max="28" class="block w-full mt-1 border-black-300 rounded-md shadow-sm focus:border-blue-300 focus:ring focus:ring-blue-200 focus:ring-opacity-50">
        <br>
        <label for="categoryOfTheCandidate" class="block mt-4">Category of the Candidate:</label>
        <select id="categoryOfTheCandidate" name="categoryOfTheCandidate" class="block w-full mt-1 border-black-300 rounded-md shadow-sm focus:border-blue-300 focus:ring focus:ring-blue-200 focus:ring-opacity-50">
            <option selected disabled>--category--</option>
            <option value="gen">General</option>
            <option value="obc">OBC</option>
            <option value="ews">EWS</option>
            <option value="sc">SC</option>
            <option value="st">ST</option>
            <option value="pwd">PWD</option>
        </select>
        <br>
        <label for="fathersName" class="block mt-4">Father's Name:</label>
        <input id="fathersName" name="fathersName" type="text" class="block w-full mt-1 border-black-300 rounded-md shadow-sm focus:border-blue-300 focus:ring focus:ring-blue-200 focus:ring-opacity-50">
        <br>
        <label for="candidatesDepartment" class="block mt-4">Department/School:</label>
        <input id="candidatesDepartment" name="candidatesDepartment" type="text" class="block w-full mt-1 border-black-300 rounded-md shadow-sm focus:border-blue-300 focus:ring focus:ring-blue-200 focus:ring-opacity-50" disabled>
        <br>
        <label for="candidatesCourseAndSubject" class="block mt-4">Course &amp; Subject:</label>
        <input id="candidatesCourseAndSubject" name="candidatesCourseAndSubject" type="text" class="block w-full mt-1 border-black-300 rounded-md shadow-sm focus:border-blue-300 focus:ring focus:ring-blue-200 focus:ring-opacity-50" disabled>
        <br>
        <label for="semesterNumber" class="block mt-4">Semester Number:</label>
        <input id="semesterNumber" name="semesterNumber" type="number" class="block w-full mt-1 border-black-300 rounded-md shadow-sm focus:border-blue-300 focus:ring focus:ring-blue-200 focus:ring-opacity-50" disabled>
        <br>
        <label for="mobileNumber" class="block mt-4">Mobile Number:</label>
        <input id="mobileNumber" name="mobileNumber" type="number" minlength="10" maxlength="10" class="block w-full mt-1 border-black-300 rounded-md shadow-sm focus:border-blue-300 focus:ring focus:ring-blue-200 focus:ring-opacity-50">
        <br>
        <label for="email" class="block mt-4">Email ID:</label>
        <input id="email" name="email" type="text" class="block w-full mt-1 border-black-300 rounded-md shadow-sm focus:border-blue-300 focus:ring focus:ring-blue-200 focus:ring-opacity-50">
        <br>
        <label for="residentialAddress" class="block mt-4">Residential Address:</label>
        <textarea id="residentialAddress" name="residentialAddress" rows="3" cols="50" class="block w-full mt-1 border-black-300 rounded-md shadow-sm focus:border-blue-300 focus:ring focus:ring-blue-200 focus:ring-opacity-50"></textarea>
        <br>
        <label for="proposerName" class="block mt-4">Name of the PROPOSER:</label>
        <input id="proposerName" name="proposerName" type="text" class="block w-full mt-1 border-black-300 rounded-md shadow-sm focus:border-blue-300 focus:ring focus:ring-blue-200 focus:ring-opacity-50" disabled>
        <br>
        <label for="proposerRegistrationNumber" class="block mt-4">PROPOSER'S Registration Number:</label>
        <input id="proposerRegistrationNumber" name="proposerRegistrationNumber" type="text" minlength="8" maxlength="8" class="block w-full mt-1 border-black-300 rounded-md shadow-sm focus:border-blue-300 focus:ring focus:ring-blue-200 focus:ring-opacity-50">
        <br>
        <label for="proposersDepartment" class="block mt-4">PROPOSER's Department/School:</label>
        <input id="proposersDepartment" name="proposersDepartment" type="text" class="block w-full mt-1 border-black-300 rounded-md shadow-sm focus:border-blue-300 focus:ring focus:ring-blue-200 focus:ring-opacity-50" disabled>
        <br>
        <label for="proposersCourseAndSubject" class="block mt-4">PROPOSER's Course &amp; Subject:</label>
        <input id="proposersCourseAndSubject" name="proposersCourseAndSubject" type="text" class="block w-full mt-1 border-black-300 rounded-md shadow-sm focus:border-blue-300 focus:ring focus:ring-blue-200 focus:ring-opacity-50" disabled>
        <br>
        <!-- signature of proposer -->
        <br>
        <label for="seconderName" class="block mt-4">Name of the SECONDER:</label>
        <input id="seconderName" name="seconderName" type="text" class="block w-full mt-1 border-black-300 rounded-md shadow-sm focus:border-blue-300 focus:ring focus:ring-blue-200 focus:ring-opacity-50" disabled>
        <br>
        <label for="seconderRegistrationNumber" class="block mt-4">SECONDER'S Registration Number:</label>
        <input id="seconderRegistrationNumber" name="seconderRegistrationNumber" type="text" minlength="8" maxlength="8" class="block w-full mt-1 border-black-300 rounded-md shadow-sm focus:border-blue-300 focus:ring focus:ring-blue-200 focus:ring-opacity-50">
        <br>
        <label for="secondersDepartment" class="block mt-4">SECONDER's Department/School:</label>
        <input id="secondersDepartment" name="secondersDepartment" type="text" class="block w-full mt-1 border-black-300 rounded-md shadow-sm focus:border-blue-300 focus:ring focus:ring-blue-200 focus:ring-opacity-50" disabled>
        <br>
        <label for="secondersCourseAndSubject" class="block mt-4">SECONDER's Course &amp; Subject:</label>
        <input id="secondersCourseAndSubject" name="secondersCourseAndSubject" type="text" class="block w-full mt-1 border-black-300 rounded-md shadow-sm focus:border-blue-300 focus:ring focus:ring-blue-200 focus:ring-opacity-50" disabled>
        <!-- signature of seconder -->
    </div>
</form>
</body>
</html>

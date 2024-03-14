<%--
  Created by IntelliJ IDEA.
  User: anant
  Date: 29-02-2024
  Time: 21:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    session = request.getSession();
    String candidateRegNumber = "";

    // Check if session is not null and if username attribute is present
    if (session != null && session.getAttribute("username") != null) {
        // Get the registration number from session attribute "username"
        candidateRegNumber = (String) session.getAttribute("username");
    }
%>
<html>
<head>
    <title>Candidate Registration</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<script>
    window.addEventListener('DOMContentLoaded', function () {
        fetchCandidateDetails('<%= candidateRegNumber %>');
        console.log('<%= session %>');
    });

    function fetchCandidateDetails(candidateRegNumber) {
        // AJAX request to fetch details
        const xhr = new XMLHttpRequest();
        xhr.open("GET", "fetchDetails?registrationNumber=" + candidateRegNumber, true);
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                let response = JSON.parse(xhr.responseText);
                // Populate form fields with candidate details
                document.getElementById("candidateRegistrationNumber").value = "<%= candidateRegNumber %>";
                document.getElementById("candidateName").value = response.name;
                document.getElementById("nameOnBallotPaper").value = response.name;
                document.getElementById("candidatesDepartment").value = response.department;
                document.getElementById("dateOfBirth").value = response.dob;
                document.getElementById("dateOfBirth").disabled = true;
                document.getElementById("candidatesCourseAndSubject").value = response.course + "-" + response.subject;
                document.getElementById("semesterNumber").value = response.semester;

                let dob = response.dob;

                // Calculate the age
                let today = new Date();
                let birthDate = new Date(dob);
                let age = today.getFullYear() - birthDate.getFullYear();
                let monthDiff = today.getMonth() - birthDate.getMonth();

                // If the birth month is greater than the current month or if it's the same month but the birth date is greater, subtract one year
                if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < birthDate.getDate())) {
                    age--;
                }

                // Set the calculated age in the Age field
                document.getElementById("age").value = age;
            }
        };
        xhr.send();
    }
</script>
<body class="bg-gray-100">
<h1 class="text-3xl font-bold text-center mt-8">Nomination Form</h1>

<form id="nominationForm" name="nominationForm" class="mx-auto max-w-lg mt-8 bg-white p-8 rounded-lg shadow-lg">
    <div class="nomination_form">
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
        <input id="dateOfBirth" name="dateOfBirth" type="date" class="block w-full mt-1 border-black-300 rounded-md shadow-sm focus:border-blue-300 focus:ring focus:ring-blue-200 focus:ring-opacity-50" disabled>
        <br>
        <label for="age" class="block mt-4">Age</label>
        <input id="age" name="age" type="number" min="17" max="28" class="block w-full mt-1 border-black-300 rounded-md shadow-sm focus:border-blue-300 focus:ring focus:ring-blue-200 focus:ring-opacity-50" disabled>
        <br>
        <label for="categoryOfTheCandidate" class="block mt-4">Category of the Candidate:</label>
        <select id="categoryOfTheCandidate" name="categoryOfTheCandidate" class="block w-full mt-1 border-black-300 rounded-md shadow-sm focus:border-blue-300 focus:ring focus:ring-blue-200 focus:ring-opacity-50" >
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
        <input id="proposerRegistrationNumber" name="proposerRegistrationNumber" type="text" minlength="8" maxlength="8" class="block w-full mt-1 border-black-300 rounded-md shadow-sm focus:border-blue-300 focus:ring focus:ring-blue-200 focus:ring-opacity-50 " onchange="fetchProposerDetails()">
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
        <input id="seconderRegistrationNumber" name="seconderRegistrationNumber" type="text" minlength="8" maxlength="8" class="block w-full mt-1 border-black-300 rounded-md shadow-sm focus:border-blue-300 focus:ring focus:ring-blue-200 focus:ring-opacity-50" onchange="fetchSeconderDetails()">
        <br>
        <label for="secondersDepartment" class="block mt-4">SECONDER's Department/School:</label>
        <input id="secondersDepartment" name="secondersDepartment" type="text" class="block w-full mt-1 border-black-300 rounded-md shadow-sm focus:border-blue-300 focus:ring focus:ring-blue-200 focus:ring-opacity-50" disabled>
        <br>
        <label for="secondersCourseAndSubject" class="block mt-4">SECONDER's Course &amp; Subject:</label>
        <input id="secondersCourseAndSubject" name="secondersCourseAndSubject" type="text" class="block w-full mt-1 border-black-300 rounded-md shadow-sm focus:border-blue-300 focus:ring focus:ring-blue-200 focus:ring-opacity-50" disabled>
        <!-- signature of seconder -->
    </div>

    <button id="proceedButton" type="button" onclick="proceed()" class="block w-full mt-4 px-4 py-2 bg-blue-500 text-white rounded-md shadow-sm focus:outline-none focus:bg-blue-600">Proceed</button>

    <div id="undertakingModal" class="hidden fixed inset-0 bg-black bg-opacity-50 flex justify-center items-center">
        <div class="bg-white rounded-lg p-8">
            <h2 class="text-2xl font-bold mb-4">UNDERTAKING BY THE CANDIDATE FILING THE NOMINATION</h2>
                Registration Number:
                have filed my nomination for the
                Course / Subject:
                post of
                I hereby undertake :
                That the Proposer & Seconder Of my nomination are full-time duly registered students Of the
                1.
                University,
                2.
                That I do not have any criminal case filed against me in any police station / criminal record
                and have not been subjected to any disciplinary action by the University.
                That I have 75% of attendance upto 3 October, 2023 and that academic arrears if
                3.
                any, are as per the norms Of the university,
                That I am not pursuing a second programme / course in this University at the same level.
                4.
                That I will diligently follow without fail all regulations issued down by the Returning
                5.
                Officers from time to time.
                That my supporters or I shall not cause any disturbance on the University campus or outside
                6.
                in any manner during the entire election process.
                That my supporters & I shall follow the Code of Conduct in letter & spirit.
                7.
                That my supporters or I shall not stall any officials involved in the election process from
                8.
                carrying out his/ her duties.
                That I shall follow all regulations issued in connection with a) Campaigning b) Open
                9.
                Dais c) Polling & d) Counting of votes.
                IO. That I will personally ensure that any campaign materials belonging to me are removed
                soon after polling of votes & before the counting begins.
                11. That I Shall limit spending on campaigning to Rs. 7,000/- only.
                12. That I shall not resort to any unfair means or inducements during the entire election
                process to attract votes.
                13. That I shall not contain myself and my supporters from consumption of intoxicating
                substances in any form during the entire election process.
                14. That I shall submit detailed accounts with bills duly audited to the Office of the Dean of
                Students' Welfare within two weeks from the declaration of results.
                15. That the details furnished by me are true in respect of all details.
                I fully understand that I would be held responsible and my candidature and / or election
                to office, would be nullified for failing to follow norms laid down by the Returning
                Officers. The Returning Officers have the authority to cancel my candidature/ nullify my
                election to office if any Of the information furnished is found to be incorrect.
            <br>
            <label for="agreeCheckbox">I agree to the terms and conditions</label>
            <input type="checkbox" id="agreeCheckbox" onchange="toggleCheckbox()">
        </div>
    </div>
</form>

<script>
    const nomination = document.getElementById("nomination");
    const undertaking = document.getElementById("undertaking");

    function fetchProposerDetails() {
        let proposerRegNumber = document.getElementById("proposerRegistrationNumber").value;

        // AJAX request
        const xhr = new XMLHttpRequest();
        xhr.open("GET", "fetchDetails?registrationNumber=" + proposerRegNumber, true);
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                let response = JSON.parse(xhr.responseText);
                document.getElementById("proposerName").value = response.name;
                document.getElementById("proposersDepartment").value = response.department;
                document.getElementById("proposersCourseAndSubject").value = response.course + "-" + response.subject;
            }
        };
        xhr.send();
    }

    function fetchSeconderDetails() {
        let seconderRegNumber = document.getElementById("seconderRegistrationNumber").value;

        // AJAX request
        const xhr = new XMLHttpRequest();
        xhr.open("GET", "fetchDetails?registrationNumber=" + seconderRegNumber, true);
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                let response = JSON.parse(xhr.responseText);
                document.getElementById("seconderName").value = response.name;
                document.getElementById("secondersDepartment").value = response.department;
                document.getElementById("secondersCourseAndSubject").value = response.course + "-" + response.subject;
            }
        };
        xhr.send();
    }

    function proceed() {
        // Display the modal
        document.getElementById("undertakingModal").classList.remove('hidden');
    }

    function closeModal() {
        document.getElementById("undertakingModal").classList.add('hidden');
    }

    function toggleCheckbox() {
        var modal = document.getElementById("undertakingModal");
        var checkbox = document.getElementById("agreeCheckbox");
        if (modal.scrollTop === (modal.scrollHeight - modal.offsetHeight)) {
            checkbox.disabled = false;
        } else {
            checkbox.disabled = true;
        }
    }

    // Event listener for scrolling in the modal
    document.getElementById("undertakingModal").addEventListener("scroll", toggleCheckbox);
</script>

</body>
</html>

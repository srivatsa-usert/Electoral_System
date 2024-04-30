<%@ page contentType="text/html;charset=UTF-8" %>
<%
    session = request.getSession();
    String candidateRegNumber = "";

    // Check if session is not null and if username attribute is present
    if (session != null && session.getAttribute("username") != null) {
        // Get the registration number from session attribute "username"
        candidateRegNumber = (String) session.getAttribute("username");
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
    <title>File Nomination</title>

    <style>
        /* Style for scrollbar */
        .undertaking-scroll-container {
            overflow-y: auto;
            max-height: 300px; /* Adjust max-height as needed */
        }

        /* Additional CSS styles */
        #undertaking-modal ol {
            padding-left: 20px;
            list-style-type: decimal;
            margin-bottom: 10px; /* Add margin to separate list from checkbox and submit button */
        }

        /* Custom styles for form fields */
        .form-input {
            max-width: 500px; /* Set the maximum width for form fields */
            width: 100%; /* Make sure the input fields take the full width of their container */
        }

        /* Custom styles for the select dropdown */
        .form-select {
            max-width: 500px; /* Set the maximum width for the select dropdown */
            width: 100%; /* Make sure the select dropdown takes the full width of its container */
        }
    </style>
</head>

<script>
    window.addEventListener('DOMContentLoaded', function () {
        fetchCandidateDetails('<%= candidateRegNumber %>');
        /*console.log('<%= session %>');*/
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

                // If the birth month is greater than the current month or if it's the same month but the birthdate is greater, subtract one year
                if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < birthDate.getDate())) {
                    age--;
                }

                // Set the calculated age in the Age field
                document.getElementById("age").value = age;

                checkCandidateEligibility(age);
            }
        };
        xhr.send();
    }

    document.addEventListener("DOMContentLoaded", function() {
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "getCandidateStatus", true);
            xhr.onreadystatechange = function() {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    if (xhr.status === 200) {
                        const response = JSON.parse(xhr.responseText);
                        let status = response.status;
                        // Update CSS classes based on status
                        updateCircleStyles(status);
                    } else {
                        console.error("Error occurred while fetching candidate status: " + xhr.status);
                    }
                }
            };
            xhr.send();
    });

    function updateCircleStyles(status) {
        let url;
        let xhr;
        const circle1 = document.getElementById("circle1");
        const circle2 = document.getElementById("circle2");
        const circle3 = document.getElementById("circle3");
        const circle4 = document.getElementById("circle4");
        const circle5 = document.getElementById("circle5");
        const line1 = document.getElementById("line1");
        const line2 = document.getElementById("line2");
        const line3 = document.getElementById("line3");
        const line4 = document.getElementById("line4");


        // Update CSS classes based on status
        if (status >= 1) {
            circle1.classList.remove('bg-gray-200','dark:bg-gray-700');
            circle1.classList.add('bg-blue-700','dark:bg-blue-600');
            line1.classList.remove('bg-gray-200','dark:bg-gray-700');
            line1.classList.add('bg-blue-700','dark:bg-blue-600');
            document.getElementById("nominationsFormContainer").classList.add('hidden');
            document.getElementById("enclosuresFormContainer").classList.remove('hidden');
        }
        if (status >= 2) {
            circle2.classList.remove('bg-gray-200','dark:bg-gray-700');
            circle2.classList.add('bg-blue-700','dark:bg-blue-600');
            line2.classList.remove('bg-gray-200','dark:bg-gray-700');
            line2.classList.add('bg-blue-700','dark:bg-blue-600');
            document.getElementById("enclosuresFormContainer").classList.add('hidden');
            document.getElementById("proposerSeconderApprovalFormContainer").classList.remove('hidden');
        }
        if (status >= 3) {
            circle3.classList.remove('bg-gray-200','dark:bg-gray-700');
            circle3.classList.add('bg-blue-700','dark:bg-blue-600');
            line3.classList.remove('bg-gray-200','dark:bg-gray-700');
            line3.classList.add('bg-blue-700','dark:bg-blue-600');
            document.getElementById("proposerSeconderApprovalFormContainer").classList.add('hidden');
            document.getElementById("deanApprovalFormContainer").classList.remove('hidden');

            if(status >3.4 && status < 3.6){
                circle3.classList.remove('bg-blue-700','dark:bg-blue-600');
                circle3.classList.add('bg-red-700','dark:bg-red-600');
                document.getElementById("tick3").classList.add('hidden');
                document.getElementById("cross3").classList.remove('hidden');
                line3.classList.remove('bg-blue-700','dark:bg-blue-600');
                line3.classList.add('bg-gray-200','dark:bg-gray-700');
                document.getElementById("proposerSeconderApprovalFormContainer").classList.remove('hidden');
                document.getElementById("deanApprovalFormContainer").classList.add('hidden');

                xhr = new XMLHttpRequest();
                url = 'rejectedCandidates?status=3.5'; // Set request parameter to 3.5
                xhr.open('GET', url, true);
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === XMLHttpRequest.DONE) {
                        if (xhr.status === 200) {
                            // Request successful, parse JSON response
                            var response = JSON.parse(xhr.responseText);

                            // Construct HTML for rejected candidates list
                            var html = '<h1 class="text-2xl font-bold text-gray-900 dark:text-white">Rejected by Candidates:</h1>';
                            if (Object.keys(response).length === 0) {
                                // If no rejected candidates, display appropriate message
                                html += '<p>No candidates have been rejected.</p>';
                            } else {
                                // Add proposer and seconder registration numbers to the list
                                html += '<ul class="space-y-4 text-gray-500 list-disc list-inside dark:text-gray-400">';
                                if (response.hasOwnProperty('proposer_registration_number')) {
                                    html += '<li>Proposer Registration Number: ' + response.proposer_registration_number + '</li>';
                                }
                                if (response.hasOwnProperty('seconder_registration_number')) {
                                    html += '<li>Seconder Registration Number: ' + response.seconder_registration_number + '</li>';
                                }
                                html += '</ul>';
                            }

                            // Update proposerSeconderApprovalFormContainer with the constructed HTML
                            document.getElementById("proposerSeconderApprovalFormContainer").innerHTML = html;
                        } else {
                            // Request failed, handle error
                            console.error('Failed to fetch rejected candidates.');
                        }
                    }
                };

                // Send the XMLHttpRequest
                xhr.send();
            }
        }
        if (status >= 4) {
            circle4.classList.remove('bg-gray-200','dark:bg-gray-700');
            circle4.classList.add('bg-blue-700','dark:bg-blue-600');
            line4.classList.remove('bg-gray-200','dark:bg-gray-700');
            line4.classList.add('bg-blue-700','dark:bg-blue-600');
            document.getElementById("deanApprovalFormContainer").classList.add('hidden');
            document.getElementById("electionChairApprovalFormContainer").classList.remove('hidden');

            if (status > 4.4 && status < 4.6) {
                circle4.classList.remove('bg-blue-700', 'dark:bg-blue-600');
                circle4.classList.add('bg-red-700', 'dark:bg-red-600');
                document.getElementById("tick4").classList.add('hidden');
                document.getElementById("cross4").classList.remove('hidden');
                line4.classList.remove('bg-blue-700', 'dark:bg-blue-600');
                line4.classList.add('bg-gray-200', 'dark:bg-gray-700');
                document.getElementById("deanApprovalFormContainer").classList.remove('hidden');
                document.getElementById("electionChairApprovalFormContainer").classList.add('hidden');

                // Set up the XMLHttpRequest and send the request
                xhr = new XMLHttpRequest();
                url = 'rejectedCandidates?status=4.5'; // Set request parameter to 4.5
                xhr.open('GET', url, true);
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === XMLHttpRequest.DONE) {
                        if (xhr.status === 200) {
                            // Request successful, parse JSON response
                            var response = JSON.parse(xhr.responseText);

                            // Process the response
                            if (Object.keys(response).length > 0) {
                                // If there are rejected candidates, construct the list
                                var html = '<h1 class="text-2xl font-bold text-gray-900 dark:text-white">Deans Form details:</h1><ul class="space-y-4 text-gray-500 list-disc list-inside dark:text-gray-400">';

                                // Iterate through the rejected candidates and add them to the list
                                if (response.hasOwnProperty('attendance')) {
                                    html += '<li>Attendance: ' + response.attendance + '</li>';
                                }
                                if (response.hasOwnProperty('academicArrears')) {
                                    html += '<li>Academic Arrears: ' + response.academicArrears + '</li>';
                                }
                                if (response.hasOwnProperty('registeredStudent')) {
                                    html += '<li>Registered Student: ' + response.registeredStudent + '</li>';
                                }
                                if (response.hasOwnProperty('courseRequirements')) {
                                    html += '<li>Cleared Course Requirements : ' + response.courseRequirements + '</li>';
                                }
                                if (response.hasOwnProperty('researchProgress')) {
                                    html += '<li>Is Students Research Progress Satisfactory: ' + response.researchProgress + '</li>';
                                }
                                if (response.hasOwnProperty('DRCReport')) {
                                    html += '<li>Is the latest DRC report attached: ' + response.DRCReport + '</li>';
                                }

                                html += '</ul>';

                                // Update the container with the constructed HTML
                                document.getElementById("deanApprovalFormContainer").innerHTML = html;
                            } else {
                                // If there are no rejected candidates, display a message
                                document.getElementById("deanApprovalFormContainer").innerHTML = '<h1 class="text-2xl font-bold text-gray-900 dark:text-white">No candidates have been rejected.</h1>';
                            }
                        } else {
                            // Request failed, handle error
                            console.error('Failed to fetch rejected candidates.');
                        }
                    }
                };

                // Send the XMLHttpRequest
                xhr.send();
            }
        }
        if (status >= 5) {
            circle5.classList.remove('bg-gray-200','dark:bg-gray-700');
            circle5.classList.add('bg-blue-700','dark:bg-blue-600');
            document.getElementById("electionChairApprovalFormContainer").classList.add('hidden');
            document.getElementById("finalStatusContainer").classList.remove('hidden');

            if (status > 5.4 && status < 5.6) {
                circle5.classList.remove('bg-blue-700', 'dark:bg-blue-600');
                circle5.classList.add('bg-red-700', 'dark:bg-red-600');
                document.getElementById("tick5").classList.add('hidden');
                document.getElementById("cross5").classList.remove('hidden');
                document.getElementById("electionChairApprovalFormContainer").classList.remove('hidden');
                document.getElementById("finalStatusContainer").classList.add('hidden');

                // Create an XMLHttpRequest object
                xhr = new XMLHttpRequest();
                url = 'rejectedCandidates?status=5.5'; // Set request parameter to 5.5
                xhr.open('GET', url, true);

                // Define the callback function to handle the response
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === XMLHttpRequest.DONE) {
                        if (xhr.status === 200) {
                            // Request successful, parse JSON response
                            var response = JSON.parse(xhr.responseText);

                            // Process the response
                            // Update the HTML content based on the response
                            // For example, assuming the response contains properties 'candidate_file_approval' and 'proposer_file_approval':
                            var html = '<h1 class="text-2xl font-bold text-gray-900 dark:text-white">Approval Information:</h1>' +
                                '<ul class="space-y-4 text-gray-700 dark:text-gray-400">';

                            // Add fields to HTML only if they are defined in the response
                            if (response.candidate_file_approval !== undefined) {
                                html += '<li>Candidate File: ' + response.candidate_file_approval + '</li>';
                            }
                            if (response.proposer_file_approval !== undefined) {
                                html += '<li>Proposer File: ' + response.proposer_file_approval + '</li>';
                            }
                            if (response.seconder_file_approval !== undefined) {
                                html += '<li>Seconder File: ' + response.seconder_file_approval + '</li>';
                            }
                            if (response.dob_proof_file_approval !== undefined) {
                                html += '<li>DOB Proof: ' + response.dob_proof_file_approval + '</li>';
                            }
                            if (response.attendance_file_approval !== undefined) {
                                html += '<li>Attendance/Academic Report: ' + response.attendance_file_approval + '</li>';
                            }
                            if (response.category_file_approval !== undefined) {
                                html += '<li>Category File: ' + response.category_file_approval + '</li>';
                            }
                            if (response.comment !== undefined) {
                                html += '<li>Comments: ' + response.comment + '</li>';
                            }

                            html += '</ul>';

                            // Update the content of electionChairApprovalFormContainer
                            document.getElementById("electionChairApprovalFormContainer").innerHTML = html;
                        } else {
                            // Request failed, handle error
                            console.error('Failed to fetch approval information.');
                        }
                    }
                };

                // Send the XMLHttpRequest
                xhr.send();
            }


        }
    }
</script>

<body class="flex flex-col min-h-screen">
    <!-- Header -->
    <%@ include file="header.jsp" %>

    <!-- Main content -->
    <div class="flex-grow p-6 bg-white dark:bg-gray-800">

        <%--<h1 class="text-3xl font-bold text-gray-900 dark:text-white">File Nomination</h1> <br>--%>
        <%--   for blue region     <div class="z-10 flex items-center justify-center w-9 h-9 bg-blue-700 rounded-full dark:bg-blue-600 shrink-0">--%>
        <%--   for grey region     <div class="z-10 flex items-center justify-center w-9 h-9 bg-gray-200 rounded-full dark:bg-gray-700 shrink-0">--%>

        <!-- Progress bar -->
        <ol class="flex items-center justify-center">
            <li class="relative w-full mb-6">
                <div class="flex items-center">
                    <div id="circle1" class="z-10 flex items-center justify-center w-9 h-9 bg-gray-200 rounded-full dark:bg-gray-700 shrink-0">
                        <svg class="w-6 h-6 " aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 16 12">
                            <path stroke="white" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M1 5.917 5.724 10.5 15 1.5"> </path>
                        </svg>
                    </div>

                    <div id="line1" class="flex w-full bg-gray-200 h-0.5 dark:bg-gray-700"></div>
                </div>
                <div class="mt-3">
                    <h3 class="font-medium text-gray-900 dark:text-white">File Nomination</h3>
                </div>
            </li>
            <li class="relative w-full mb-6">
                <div class="flex items-center">
                    <div id="circle2" class="z-10 flex items-center justify-center w-9 h-9 bg-gray-200 rounded-full dark:bg-gray-700 shrink-0">
                        <svg class="w-6 h-6 " aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 16 12">
                            <path stroke="white" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M1 5.917 5.724 10.5 15 1.5"> </path>
                        </svg>
                    </div>
                    <div id="line2" class="flex w-full bg-gray-200 h-0.5 dark:bg-gray-700"></div>
                </div>
                <div class="mt-3">
                    <h3 class="font-medium text-gray-900 dark:text-white">Upload Enclosures</h3>
                </div>
            </li>
            <li class="relative w-full mb-6">
                <div class="flex items-center">
                    <div id="circle3" class="z-10 flex items-center justify-center w-9 h-9 bg-gray-200 rounded-full dark:bg-gray-700 shrink-0">
                        <svg id="tick3" class="w-6 h-6 " aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 16 12">
                            <path stroke="white" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M1 5.917 5.724 10.5 15 1.5"> </path>
                        </svg>
                        <svg id = "cross3" class="w-6 h-6 text-gray-800 dark:text-white hidden" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24">
                            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18 17.94 6M18 18 6.06 6"></path>
                        </svg>
                    </div>
                    <div id="line3" class="flex w-full bg-gray-200 h-0.5 dark:bg-gray-700"></div>
                </div>
                <div class="mt-3">
                    <h3 class="font-medium text-gray-900 dark:text-white">Proposer & Seconder Approval</h3>
                </div>
            </li>
            <li class="relative w-full mb-6">
                <div class="flex items-center">
                    <div id="circle4" class="z-10 flex items-center justify-center w-9 h-9 bg-gray-200 rounded-full dark:bg-gray-700 shrink-0">
                        <svg id="tick4" class="w-6 h-6 " aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 16 12">
                            <path stroke="white" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M1 5.917 5.724 10.5 15 1.5"> </path>
                        </svg>
                        <svg id = "cross4" class="w-6 h-6 text-gray-800 dark:text-white hidden" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24">
                            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18 17.94 6M18 18 6.06 6"></path>
                        </svg>
                    </div>
                    <div id="line4" class="flex w-full bg-gray-200 h-0.5 dark:bg-gray-700"></div>
                </div>
                <div class="mt-3">
                    <h3 class="font-medium text-gray-900 dark:text-white">Dean Approval</h3>
                </div>
            </li>
            <li class="relative w-full mb-6">
                <div class="flex items-center">
                    <div id="circle5" class="z-10 flex items-center justify-center w-9 h-9 bg-gray-200 rounded-full dark:bg-gray-700 shrink-0">
                        <svg id="tick5" class="w-6 h-6 " aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 16 12">
                            <path stroke="white" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M1 5.917 5.724 10.5 15 1.5"> </path>
                        </svg>
                        <svg id = "cross5" class="w-6 h-6 text-gray-800 dark:text-white hidden" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24">
                            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18 17.94 6M18 18 6.06 6"></path>
                        </svg>
                    </div>
                </div>
                <div class="mt-3">
                    <h3 class="font-medium text-gray-900 dark:text-white">Election Chair Approval</h3>
                </div>
            </li>
        </ol>

        <!-- Nomination Form -->
        <div id="nominationsFormContainer" class="">
            <h1 class="text-2xl font-bold text-gray-900 dark:text-white">Nomination Form</h1>
            <hr class="mb-4">
            <p class="text-gray-900 dark:text-white">Fill in the details below to file your nomination.</p>
            <br>
            <form id="nominationForm" name="nominationForm" method="post" action="submitNomination" >
                <div class="nomination_form">
                    <label for="nameOfThePosition" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Name of the Position:</label>
                    <select id="nameOfThePosition" name="nameofThePosition" class="form-select bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required>
                        <option value="" selected disabled>--position--</option>
                    </select>
                    <br>
                    <label for="candidateRegistrationNumber" class="block mt-3 mb-2 text-sm font-medium text-gray-900 dark:text-white">Registration Number:</label>
                    <input id="candidateRegistrationNumber" name="candidateRegistrationNumber" type="text" minlength="8" maxlength="8" class="form-input bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" readonly>
                    <br>
                    <label for="candidateName" class="block mt-3 mb-2 text-sm font-medium text-gray-900 dark:text-white">Name of the Candidate in BLOCK LETTERS<i>(as displayed on the Reg./ Semester ID Card)</i>:</label>
                    <input id="candidateName" name="candidateName" type="text" class="form-input bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" readonly>
                    <br>
                    <label for="nameOnBallotPaper" class="block mt-3 mb-2 text-sm font-medium text-gray-900 dark:text-white">Name of the Candidate to be displayed on the Ballot Paper in BLOCK LETTERS:</label>
                    <input id="nameOnBallotPaper" name="nameOnBallotPaper" type="text" class="form-input bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required>
                    <br>
                    <label for="dateOfBirth" class="block mt-3 mb-2 text-sm font-medium text-gray-900 dark:text-white">Date of Birth:</label>
                    <input id="dateOfBirth" name="dateOfBirth" type="date" class="form-input bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" readonly>
                    <br>
                    <label for="age" class="block mt-3 mb-2 text-sm font-medium text-gray-900 dark:text-white">Age:</label>
                    <input id="age" name="age" type="number" min="17" max="28" class="form-input bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" readonly>
                    <br>
                    <label for="categoryOfTheCandidate" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Category of the Candidate:</label>
                    <select id="categoryOfTheCandidate" name="categoryOfTheCandidate" class="form-select bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required>
                        <option value="" selected disabled>--category--</option>
                        <option value="gen">General</option>
                        <option value="obc">OBC</option>
                        <option value="ews">EWS</option>
                        <option value="sc">SC</option>
                        <option value="st">ST</option>
                        <option value="pwd">PWD</option>
                    </select>
                    <br>
                    <label for="fathersName" class="block mt-3 mb-2 text-sm font-medium text-gray-900 dark:text-white">Father's Name:</label>
                    <input id="fathersName" name="fathersName" type="text" class="form-input bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required>
                    <br>
                    <label for="candidatesDepartment" class="block mt-3 mb-2 text-sm font-medium text-gray-900 dark:text-white">Department/School:</label>
                    <input id="candidatesDepartment" name="candidatesDepartment" type="text" class="form-input bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" readonly>
                    <br>
                    <label for="candidatesCourseAndSubject" class="block mt-3 mb-2 text-sm font-medium text-gray-900 dark:text-white">Course &amp; Subject:</label>
                    <input id="candidatesCourseAndSubject" name="candidatesCourseAndSubject" type="text" class="form-input bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" readonly>
                    <br>
                    <label for="semesterNumber" class="block mt-3 mb-2 text-sm font-medium text-gray-900 dark:text-white">Semester Number:</label>
                    <input id="semesterNumber" name="semesterNumber" type="number" class="form-input bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" readonly>
                    <br>
                    <label for="mobileNumber" class="block mt-3 mb-2 text-sm font-medium text-gray-900 dark:text-white">Mobile Number:</label>
                    <input id="mobileNumber" name="mobileNumber" type="number" minlength="10" maxlength="10" class="form-input bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required>
                    <br>
                    <label for="email" class="block mt-3 mb-2 text-sm font-medium text-gray-900 dark:text-white">Email ID:</label>
                    <input id="email" name="email" type="email" class="form-input bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required>
                    <br>
                    <label for="residentialAddress" class="block mt-3 mb-2 text-sm font-medium text-gray-900 dark:text-white">Residential Address:</label>
                    <textarea id="residentialAddress" name="residentialAddress" rows="3" cols="50" class="form-input bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required></textarea>
                    <br>
                    <label for="proposerName" class="block mt-3 mb-2 text-sm font-medium text-gray-900 dark:text-white">Name of the PROPOSER:</label>
                    <input id="proposerName" name="proposerName" type="text" class="form-input bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" readonly>
                    <br>
                    <label for="proposerRegistrationNumber" class="block mt-3 mb-2 text-sm font-medium text-gray-900 dark:text-white">PROPOSER'S Registration Number:</label>
                    <input id="proposerRegistrationNumber" name="proposerRegistrationNumber" type="text" minlength="8" maxlength="8" class="form-input bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" onchange="fetchProposerDetails()" required>
                    <br>
                    <label for="proposersDepartment" class="block mt-3 mb-2 text-sm font-medium text-gray-900 dark:text-white">PROPOSER's Department/School:</label>
                    <input id="proposersDepartment" name="proposersDepartment" type="text" class="form-input bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" readonly>
                    <br>
                    <label for="proposersCourseAndSubject" class="block mt-3 mb-2 text-sm font-medium text-gray-900 dark:text-white">PROPOSER's Course &amp; Subject:</label>
                    <input id="proposersCourseAndSubject" name="proposersCourseAndSubject" type="text" class="form-input bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" readonly>
                    <br>
                    <!-- signature of proposer -->
                    <br>
                    <label for="seconderName" class="block mt-3 mb-2 text-sm font-medium text-gray-900 dark:text-white">Name of the SECONDER:</label>
                    <input id="seconderName" name="seconderName" type="text" class="form-input bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" readonly>
                    <br>
                    <label for="seconderRegistrationNumber" class="block mt-3 mb-2 text-sm font-medium text-gray-900 dark:text-white">SECONDER'S Registration Number:</label>
                    <input id="seconderRegistrationNumber" name="seconderRegistrationNumber" type="text" minlength="8" maxlength="8" class="form-input bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" onchange="fetchSeconderDetails()" required>
                    <br>
                    <label for="secondersDepartment" class="block mt-3 mb-2 text-sm font-medium text-gray-900 dark:text-white">SECONDER's Department/School:</label>
                    <input id="secondersDepartment" name="secondersDepartment" type="text" class="form-input bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" readonly>
                    <br>
                    <label for="secondersCourseAndSubject" class="block mt-3 mb-2 text-sm font-medium text-gray-900 dark:text-white">SECONDER's Course &amp; Subject:</label>
                    <input id="secondersCourseAndSubject" name="secondersCourseAndSubject" type="text" class="form-input bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" readonly>
                    <!-- signature of seconder -->
                    <br>
                    <button type="button" data-modal-target="undertaking-modal" data-modal-toggle="undertaking-modal" class="text-white bg-gradient-to-r from-blue-500 via-blue-600 to-blue-700 hover:bg-gradient-to-br font-medium rounded-lg text-sm px-5 py-2.5 text-center me-2 mb-2">
                        Proceed
                    </button>
                </div>

                <!-- Undertaking Modal -->
                <div id="undertaking-modal" tabindex="-1" aria-hidden="true" class="hidden overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50 justify-center items-center w-full md:inset-0 h-[calc(100%-1rem)] max-h-full">
                    <div class="relative p-4 w-full max-w-2xl max-h-full">
                        <!-- Modal content -->
                        <div class="relative bg-white rounded-lg shadow dark:bg-gray-700">
                            <!-- Modal header -->
                            <div class="flex items-center justify-between p-4 md:p-5 border-b rounded-t dark:border-gray-600">
                                <h3 class="text-xl font-semibold dark:text-white">
                                    UNDERTAKING BY THE CANDIDATE FILING THE NOMINATION
                                </h3>
                                <button type="button" data-modal-hide="undertaking-modal" class="text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm w-8 h-8 ms-auto inline-flex justify-center items-center dark:hover:bg-gray-600 dark:hover:text-white">
                                    <svg class="w-3 h-3" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 14 14">
                                        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6"> </path>
                                    </svg>
                                    <span class="sr-only">Close modal</span>
                                </button>
                            </div>
                            <!-- Undertaking content -->
                            <div class="p-4 md:p-5 space-y-4">
                                <div class="undertaking-scroll-container">
                                    <!-- Add conditional classes for text color -->
                                    <p class="dark:text-white">
                                        <strong> I, _____, Registration Number: ________ Course/Subject: ________ have filed my nomination </strong> for the post of ________
                                    </p>
                                    <strong class="dark:text-white"> I hereby undertake: </strong>
                                    <ol class="ml-4 mr-4 dark:text-white list-decimal list-inside">
                                        <li>That the Proposer & Seconder Of my nomination are full-time duly registered students Of the University.</li>
                                        <li>That I do not have any criminal case filed against me in any police station / criminal record and have not been subjected to any disciplinary action by the University.</li>
                                        <li>That I have 75% of attendance upto 3 October 2023 and that academic arrears if any, are as per the norms Of the university.</li>
                                        <li>That I am not pursuing a second programme / course in this University at the same level.</li>
                                        <li>That I will diligently follow without fail all regulations issued down by the Returning Officers from time to time.</li>
                                        <li>That my supporters or I shall not cause any disturbance on the University campus or outside in any manner during the entire election process.</li>
                                        <li>That my supporters & I shall follow the Code of Conduct in letter & spirit.</li>
                                        <li>That my supporters or I shall not stall any officials involved in the election process from carrying out his/ her duties.</li>
                                        <li>That I shall follow all regulations issued in connection with a) Campaigning b) Open Dais c) Polling & d) Counting of votes.</li>
                                        <li>That I will personally ensure that any campaign materials belonging to me are removed soon after polling of votes & before the counting begins.</li>
                                        <li>That I Shall limit spending on campaigning to Rs. 7,000/- only.</li>
                                        <li>That I shall not resort to any unfair means or inducements during the entire election process to attract votes.</li>
                                        <li>That I shall not contain myself and my supporters from consumption of intoxicating substances in any form during the entire election process.</li>
                                        <li>That I shall submit detailed accounts with bills duly audited to the Office of the Dean of Students' Welfare within two weeks from the declaration of results.</li>
                                        <li>That the details furnished by me are true in respect of all details.</li>
                                    </ol>
                                </div>
                            </div>
                            <!-- Modal footer -->
                            <div class="items-center p-4 md:p-5 border-t border-gray-200 rounded-b dark:border-gray-600">
                                <p class="dark:text-white">
                                    <strong>"I fully understand that I would be held responsible and my candidature and / or election to office, would be nullified for failing to follow norms laid down by the Returning Officers. The Returning Officers have the authority to cancel my candidature / nullify my election to office if any of the information furnished is found to be incorrect."</strong>
                                </p>
                                <!-- Checkbox for agreement -->
                                <label for="agreeCheckbox" class="dark:text-white">
                                    <strong>I AGREE TO THE TERMS AND CONDITIONS</strong>
                                </label>
                                <input type="checkbox" id="agreeCheckbox" onchange="toggleCheckbox()" required>
                                <button id="submitButton" type="submit" class="text-white bg-gradient-to-r from-blue-500 via-blue-600 to-blue-700 hover:bg-gradient-to-br font-medium rounded-lg text-sm px-5 py-2.5 text-center me-2 mb-2">Submit</button>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>

        <!-- Enclosures -->
        <div id="enclosuresFormContainer" class="hidden">
            <h1 class="text-2xl font-bold text-gray-900 dark:text-white">Enclosures</h1>
            <hr class="mb-4">
            <p class="text-gray-900 dark:text-white">Upload the following documents:</p>
            <br>
            <form id="enclosuresForm" name="enclosuresForm" method="post" action="submitEnclosures" enctype="multipart/form-data">
                <div class="enclosures_form">
                    <div class="p-5 border border-b-0 border-gray-200 dark:border-gray-700">
                        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white" for="candidateSemesterRegistrationCard">Upload Candidate Semester Registration Card</label>
                        <input required class="form-input block w-full text-sm text-gray-900 border border-gray-300 rounded-lg cursor-pointer bg-gray-50 dark:text-gray-400 focus:outline-none dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400" id="candidateSemesterRegistrationCard" name="candidateSemesterRegistrationCard" type="file" accept=".pdf">
                    </div>
                    <div class="p-5 border border-b-0 border-gray-200 dark:border-gray-700">
                        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white" for="proposerSemesterRegistrationCard">Upload Proposer Semester Registration Card</label>
                        <input required class="form-input block w-full text-sm text-gray-900 border border-gray-300 rounded-lg cursor-pointer bg-gray-50 dark:text-gray-400 focus:outline-none dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400" id="proposerSemesterRegistrationCard" name="proposerSemesterRegistrationCard" type="file" accept=".pdf">
                    </div>
                    <div class="p-5 border border-b-0 border-gray-200 dark:border-gray-700">
                        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white" for="seconderSemesterRegistrationCard">Upload Seconder Semester Registration Card</label>
                        <input required class="form-input block w-full text-sm text-gray-900 border border-gray-300 rounded-lg cursor-pointer bg-gray-50 dark:text-gray-400 focus:outline-none dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400" id="seconderSemesterRegistrationCard" name="seconderSemesterRegistrationCard" type="file" accept=".pdf">
                    </div>
                    <div class="p-5 border border-b-0 border-gray-200 dark:border-gray-700">
                        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white" for="proofOfDob">Upload Proof for Date of Birth</label>
                        <input required class="form-input block w-full text-sm text-gray-900 border border-gray-300 rounded-lg cursor-pointer bg-gray-50 dark:text-gray-400 focus:outline-none dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400" id="proofOfDob" name="proofOfDob" type="file" accept=".pdf">
                    </div>
                    <div class="p-5 border border-b-0 border-gray-200 dark:border-gray-700">
                        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white" for="certificateOfAttendanceAcademicRecord">Upload Certificate of Attendance & Academic Record</label>
                        <input class="form-input block w-full text-sm text-gray-900 border border-gray-300 rounded-lg cursor-pointer bg-gray-50 dark:text-gray-400 focus:outline-none dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400" id="certificateOfAttendanceAcademicRecord" name="certificateOfAttendanceAcademicRecord" type="file" accept=".pdf">
                    </div>
                    <div class="p-5 border border-b-0 border-gray-200 dark:border-gray-700">
                        <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white" for="categoryCertificate">Upload Certificate of Category</label>
                        <input class="form-input block w-full text-sm text-gray-900 border border-gray-300 rounded-lg cursor-pointer bg-gray-50 dark:text-gray-400 focus:outline-none dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400" id="categoryCertificate" name="categoryCertificate" type="file" accept=".pdf">
                    </div>
                </div>
                <button id="submitEnclosuresButton" type="submit" class="text-white bg-gradient-to-r from-blue-500 via-blue-600 to-blue-700 hover:bg-gradient-to-br font-medium rounded-lg text-sm px-5 py-2.5 text-center me-2 mb-2">Submit</button>
            </form>
        </div>

        <!-- Proposer Seconder Approval -->
        <div id="proposerSeconderApprovalFormContainer" class="hidden">
            <h1 class="text-2xl font-bold text-gray-900 dark:text-white">Your Nomination needs to be approved by the Proposer and the Seconder.</h1>
        </div>

        <!-- Dean Approval -->
        <div id="deanApprovalFormContainer" class="hidden">
            <h1 class="text-2xl font-bold text-gray-900 dark:text-white">Your Nomination is under Deans Approval process.</h1>
        </div>

        <!-- Election Chair Approval -->
        <div id="electionChairApprovalFormContainer" class="hidden">
            <h1 class="text-2xl font-bold text-gray-900 dark:text-white">Your Nomination is under Election Chair's Approval process.</h1>
        </div>

        <!-- Final Status Div -->
        <div id="finalStatusContainer" class="hidden">
            <h1 class="text-2xl font-bold text-gray-900 dark:text-white">Your Nomination has been approved! Congratulations!!</h1>
        </div>

    </div>

    <!-- Footer -->
    <%@ include file="footer.jsp" %>

    <script>
        const nomination = document.getElementById("nomination");
        const undertaking = document.getElementById("undertaking");
        const candidateRegistrationNumber = "<%= candidateRegNumber %>";

        function fetchProposerDetails() {
            const proposerRegNumber = document.getElementById("proposerRegistrationNumber").value;

            if (proposerRegNumber !== candidateRegistrationNumber && proposerRegNumber !== document.getElementById("seconderRegistrationNumber").value) {
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
            else {
                showRegNumberMismatchAlert("Proposer's and Candidate's Registration numbers cannot be the same.");
                document.getElementById("proposerRegistrationNumber").value = '';
            }
        }

        function fetchSeconderDetails() {
            let seconderRegNumber = document.getElementById("seconderRegistrationNumber").value;

            if (seconderRegNumber !== candidateRegistrationNumber && seconderRegNumber !== document.getElementById("proposerRegistrationNumber").value) {
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
            else {
                showRegNumberMismatchAlert("Seconder's and Candidate's Registration numbers cannot be the same.");
                document.getElementById("seconderRegistrationNumber").value = '';
            }
        }

        function showRegNumberMismatchAlert() {
            const alertDiv = document.createElement("div");
            alertDiv.classList.add("fixed", "inset-0", "flex", "items-center", "justify-center", "bg-black", "bg-opacity-50");

            alertDiv.innerHTML = `
                    <div class="bg-white p-8 rounded-lg shadow-lg">
                        <h2 class="text-2xl font-bold mb-4">Alert</h2>
                        <p>Same Registration numbers are allowed.</p>
                        <div class="mt-4 flex justify-center space-x-4">
                            <button id="okButton" class="px-4 py-2 bg-blue-500 text-white rounded-md shadow-sm focus:outline-none focus:bg-blue-600">OK</button>
                        </div>
                    </div>
                `;
            document.body.appendChild(alertDiv);

            const okButton = document.getElementById("okButton");
            okButton.addEventListener("click", function() {
                alertDiv.remove();
            });
        }

        function proceed() {
            document.getElementById("undertaking-modal").classList.remove('hidden');
        }

        function closeModal() {
            document.getElementById("undertaking-modal").classList.add('hidden');
            document.getElementById("agreeCheckbox").checked = false;
            event.preventDefault();
        }

        function toggleCheckbox() {
            let modal = document.getElementById("undertaking-modal");
            let checkbox = document.getElementById("agreeCheckbox");
            checkbox.disabled = modal.scrollTop !== (modal.scrollHeight - modal.offsetHeight);
        }

        // Event listener for scrolling in the modal
        document.getElementById("undertaking-modal").addEventListener("scroll", toggleCheckbox);

        function checkCandidateEligibility(age) {
            // AJAX request to the CheckAgeServlet
            let xhr = new XMLHttpRequest();
            xhr.open("GET", "checkAge?age="+age, true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

            // Define the callback function to handle the response
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    // Parse the response (true/false indicating eligibility)
                    let isEligible = JSON.parse(xhr.responseText);

                    // Update UI based on eligibility
                    if (isEligible) {
                        // Eligible: Update UI accordingly (e.g., display a success message)
                        console.log("Candidate is eligible.");
                    } else {
                        // Not eligible: Update UI accordingly (e.g., display an error message)
                        console.log("Candidate is not eligible.");
                        showAlert();
                        disableSubmitButton();
                    }
                }
            };

            // Send the AJAX request with the age parameter
            xhr.send();
        }

        function showAlert() {
            const alertDiv = document.createElement("div");
            alertDiv.classList.add("fixed", "inset-0", "flex", "items-center", "justify-center", "bg-black", "bg-opacity-50");

            alertDiv.innerHTML = `
                <div class="bg-white p-8 rounded-lg shadow-lg">
                    <h2 class="text-2xl font-bold mb-4">Age Regulation</h2>
                    <p>The Age in the form not eligible for nomination.</p>
                    <div class="mt-4 flex justify-center space-x-4">
                        <button class="px-4 py-2 bg-blue-500 text-white rounded-md shadow-sm focus:outline-none focus:bg-blue-600" onclick="redirectToHome()">Go to Home</button>
                    </div>
                </div>
            `;
            document.body.appendChild(alertDiv);
        }

        function disableSubmitButton() {
            const submitButton = document.getElementById("submitButton");
            submitButton.disabled = true;
        }

        function redirectToHome() {
            window.location.href = "home.jsp";
        }
    </script>

    <script>
        // Create a new XMLHttpRequest object
        const xhr = new XMLHttpRequest();

        // Configure the request
        xhr.open('GET', 'positions', true);

        // Set up event handler for when the request completes
        xhr.onload = function() {
            if (xhr.status >= 200 && xhr.status < 300) {
                // Parse JSON response
                const data = JSON.parse(xhr.responseText);

                // Get the select element
                const select = document.getElementById('nameOfThePosition');

                // Add options to the select element
                data.forEach(position => {
                    const option = document.createElement('option');
                    option.value = position;
                    option.text = position;
                    select.appendChild(option);
                });
            } else {
                console.error('Request failed with status:', xhr.status);
            }
        };

        // Set up event handler for when an error occurs
        xhr.onerror = function() {
            console.error('Request failed');
        };

        // Send the request
        xhr.send();

        document.addEventListener("DOMContentLoaded", function() {
            document.getElementById("submitButton").addEventListener("click", function() {
                // Check form validation
                if (validateForm()) {
                    // Disable the button
                    document.getElementById("submitButton").disabled = true;

                    // Change the button content to indicate loading
                    document.getElementById("submitButton").innerHTML = '<svg aria-hidden="true" role="status" class="inline w-4 h-4 me-3 text-gray-200 animate-spin dark:text-gray-600" viewBox="0 0 100 101" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M100 50.5908C100 78.2051 77.6142 100.591 50 100.591C22.3858 100.591 0 78.2051 0 50.5908C0 22.9766 22.3858 0.59082 50 0.59082C77.6142 0.59082 100 22.9766 100 50.5908ZM9.08144 50.5908C9.08144 73.1895 27.4013 91.5094 50 91.5094C72.5987 91.5094 90.9186 73.1895 90.9186 50.5908C90.9186 27.9921 72.5987 9.67226 50 9.67226C27.4013 9.67226 9.08144 27.9921 9.08144 50.5908Z" fill="currentColor"/><path d="M93.9676 39.0409C96.393 38.4038 97.8624 35.9116 97.0079 33.5539C95.2932 28.8227 92.871 24.3692 89.8167 20.348C85.8452 15.1192 80.8826 10.7238 75.2124 7.41289C69.5422 4.10194 63.2754 1.94025 56.7698 1.05124C51.7666 0.367541 46.6976 0.446843 41.7345 1.27873C39.2613 1.69328 37.813 4.19778 38.4501 6.62326C39.0873 9.04874 41.5694 10.4717 44.0505 10.1071C47.8511 9.54855 51.7191 9.52689 55.5402 10.0491C60.8642 10.7766 65.9928 12.5457 70.6331 15.2552C75.2735 17.9648 79.3347 21.5619 82.5849 25.841C84.9175 28.9121 86.7997 32.2913 88.1811 35.8758C89.083 38.2158 91.5421 39.6781 93.9676 39.0409Z" fill="#1C64F2"/></svg>Loading...';
                    document.getElementById("nominationForm").submit();
                } else {
                    // Form validation failed, prevent form submission
                    event.preventDefault();
                    alert("Please fill in all required fields and checkboxes.");
                }
            });
        });

        /*function validateForm() {
            // Get all the required input fields
            const requiredInputs = document.querySelectorAll('input[required], select[required], textarea[required]');
            const agreeCheckbox = document.getElementById('agreeCheckbox');
            // Initialize a flag to track if all required fields are filled
            let allFieldsFilled = true;

            // Loop through each required input field
            requiredInputs.forEach(input => {
                // Check if the input field is empty
                if (!input.value.trim()) {
                    // If it's empty, set the flag to false
                    allFieldsFilled = false;
                    // Optionally, you can add a class to highlight the empty field
                    input.classList.add('is-invalid');
                } else {
                    // If it's not empty, remove any existing invalid class
                    input.classList.remove('is-invalid');
                }
            });

            if (!agreeCheckbox.checked) {
                // If it's not checked, set the flag to false
                allFieldsFilled = false;
            }

            // Return true if all required fields are filled, otherwise false
            return allFieldsFilled;
        }*/
    </script>
</body>
</html>

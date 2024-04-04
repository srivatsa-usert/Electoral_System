<%--
  Created by IntelliJ IDEA.
  User: anant
  Date: 29-02-2024
  Time: 21:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    session = request.getSession();
    String candidateRegNumber = "";

    // Check if session is not null and if username attribute is present
    if (session != null && session.getAttribute("username") != null) {
        // Get the registration number from session attribute "username"
        candidateRegNumber = (String) session.getAttribute("username");
    }<%--
  Created by IntelliJ IDEA.
  User: anant
  Date: 29-02-2024
  Time: 21:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

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
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>File Nomination</title>
    <!-- Tailwind and Flowbite -->
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.3.0/flowbite.min.css" rel="stylesheet" />

    <!-- Script to check for device color scheme -->
    <script>
        if (localStorage.getItem('color-theme') === 'dark' || (!('color-theme' in localStorage) && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
            document.documentElement.classList.add('dark');
        } else {
            document.documentElement.classList.remove('dark')
        }
    </script>

    <style>
        /* Style for scrollbar */
        .undertaking-scroll-container {
            overflow-y: auto;
            max-height: 300px; /* Adjust max-height as needed */
        }

        /* Additional CSS styles */
        #undertakingModal ol {
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
</script>

<body class="flex flex-col min-h-screen">
<!-- Header -->
<nav class="bg-white border-gray-200 dark:bg-gray-900">
    <div class="max-w-screen-xl flex flex-wrap items-center justify-between mx-auto p-4">
        <a href="#" class="flex items-center space-x-3 rtl:space-x-reverse">
            <img src="${pageContext.request.contextPath}/Images/UoH_Logo.png" class="w-10 h-10 rounded-full" alt="UoH Logo" />
            <span class="self-center text-2xl font-semibold whitespace-nowrap dark:text-white">University of Hyderabad</span>
        </a>
        <div class="flex items-center md:order-2 space-x-3 md:space-x-0 rtl:space-x-reverse">
            <button id='loginButton' data-modal-target="authentication-modal" data-modal-toggle="authentication-modal" class="block text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800" type="button">
                Login
            </button>
            <button type="button" id="user-menu-button" class="hidden flex text-sm bg-gray-800 rounded-full md:me-0 focus:ring-4 focus:ring-gray-300 dark:focus:ring-gray-600" aria-expanded="false" data-dropdown-toggle="user-dropdown" data-dropdown-placement="bottom">
                <span class="sr-only">Open user menu</span>
                <img class="w-8 h-8 rounded-full" src="/docs/images/people/profile-picture-3.jpg" alt="user photo">
            </button>
            <!-- Dropdown menu -->
            <div class="z-50 hidden my-4 text-base list-none bg-white divide-y divide-gray-100 rounded-lg shadow dark:bg-gray-700 dark:divide-gray-600" id="user-dropdown">
                <div class="px-4 py-3">
                    <span class="block text-sm text-gray-900 dark:text-white">Bonnie Green</span>
                    <span class="block text-sm  text-gray-500 truncate dark:text-gray-400">name@flowbite.com</span>
                </div>
                <ul class="py-2" aria-labelledby="user-menu-button">
                    <li>
                        <a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 dark:hover:bg-gray-600 dark:text-gray-200 dark:hover:text-white">Dashboard</a>
                    </li>
                    <li>
                        <a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 dark:hover:bg-gray-600 dark:text-gray-200 dark:hover:text-white">Settings</a>
                    </li>
                    <li>
                        <a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 dark:hover:bg-gray-600 dark:text-gray-200 dark:hover:text-white">Earnings</a>
                    </li>
                    <li>
                        <a href="logout" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 dark:hover:bg-gray-600 dark:text-gray-200 dark:hover:text-white">Sign out</a>
                    </li>
                </ul>
            </div>
            <button data-collapse-toggle="navbar-user" type="button" class="inline-flex items-center p-2 w-10 h-10 justify-center text-sm text-gray-500 rounded-lg md:hidden hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-gray-200 dark:text-gray-400 dark:hover:bg-gray-700 dark:focus:ring-gray-600" aria-controls="navbar-user" aria-expanded="false">
                <span class="sr-only">Open main menu</span>
                <svg class="w-5 h-5" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 17 14">
                    <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M1 1h15M1 7h15M1 13h15"> </path>
                </svg>
            </button>
        </div>
        <div class="items-center justify-between hidden w-full md:flex md:w-auto md:order-1" id="navbar-user">
            <ul class="flex flex-col font-medium p-4 md:p-0 mt-4 border border-gray-100 rounded-lg bg-gray-50 md:space-x-8 rtl:space-x-reverse md:flex-row md:mt-0 md:border-0 md:bg-white dark:bg-gray-800 md:dark:bg-gray-900 dark:border-gray-700">
                <li>
                    <a href="home.jsp" class="block py-2 px-3 text-gray-900 rounded hover:bg-gray-100 md:hover:bg-transparent md:hover:text-blue-700 md:p-0 dark:text-white md:dark:hover:text-blue-500 dark:hover:bg-gray-700 dark:hover:text-white md:dark:hover:bg-transparent dark:border-gray-700">Home</a>
                </li>
                <li>
                    <a href="candidateRegistration.jsp" class="block py-2 px-3 text-white bg-blue-700 rounded md:bg-transparent md:text-blue-700 md:p-0 md:dark:text-blue-500" aria-current="page">File Nomination</a>
                </li>
                <%--<li>
                    <a href="#" class="block py-2 px-3 text-gray-900 rounded hover:bg-gray-100 md:hover:bg-transparent md:hover:text-blue-700 md:p-0 dark:text-white md:dark:hover:text-blue-500 dark:hover:bg-gray-700 dark:hover:text-white md:dark:hover:bg-transparent dark:border-gray-700">#</a>
                </li>
                <li>
                    <a href="#" class="block py-2 px-3 text-gray-900 rounded hover:bg-gray-100 md:hover:bg-transparent md:hover:text-blue-700 md:p-0 dark:text-white md:dark:hover:text-blue-500 dark:hover:bg-gray-700 dark:hover:text-white md:dark:hover:bg-transparent dark:border-gray-700">#</a>
                </li>--%>
            </ul>
            <button id="theme-toggle" type="button" class="text-gray-500 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-700 rounded-lg text-sm py-2 px-3 mx-5">
                <svg id="theme-toggle-dark-icon" class="hidden w-5 h-5" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path d="M17.293 13.293A8 8 0 016.707 2.707a8.001 8.001 0 1010.586 10.586z"></path></svg>
                <svg id="theme-toggle-light-icon" class="hidden w-5 h-5" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path d="M10 2a1 1 0 011 1v1a1 1 0 11-2 0V3a1 1 0 011-1zm4 8a4 4 0 11-8 0 4 4 0 018 0zm-.464 4.95l.707.707a1 1 0 001.414-1.414l-.707-.707a1 1 0 00-1.414 1.414zm2.12-10.607a1 1 0 010 1.414l-.706.707a1 1 0 11-1.414-1.414l.707-.707a1 1 0 011.414 0zM17 11a1 1 0 100-2h-1a1 1 0 100 2h1zm-7 4a1 1 0 011 1v1a1 1 0 11-2 0v-1a1 1 0 011-1zM5.05 6.464A1 1 0 106.465 5.05l-.708-.707a1 1 0 00-1.414 1.414l.707.707zm1.414 8.486l-.707.707a1 1 0 01-1.414-1.414l.707-.707a1 1 0 011.414 1.414zM4 11a1 1 0 100-2H3a1 1 0 000 2h1z" fill-rule="evenodd" clip-rule="evenodd"></path></svg>
            </button>
        </div>
    </div>
</nav>

<!-- Script to toggle the user menu -->
<script>
    const loginButton = document.getElementById('loginButton');
    const loginModal = document.getElementById('authentication-modal');
    const userMenuButton = document.getElementById('user-menu-button');

    window.addEventListener('load', function() {
        let username = '<%= session.getAttribute("username") %>';
        console.log(username);

        if (username && username !== "null" && username !== "NULL") {
            // User is logged in, then hide login button and show user menu button
            loginButton.classList.add('hidden');
            userMenuButton.classList.remove('hidden');
            // userMenuButton.innerText = username;
        }
    });
</script>

<!-- Main content -->
<div class="flex-grow p-6 bg-white dark:bg-gray-800">

    <%--<h1 class="text-3xl font-bold text-gray-900 dark:text-white">File Nomination</h1> <br>--%>
    <!-- Progress bar -->
    <ol class="flex items-center justify-center">
        <li class="relative w-full mb-6">
            <div class="flex items-center">
                <div class="z-10 flex items-center justify-center w-9 h-9 bg-blue-700 rounded-full dark:bg-blue-600 shrink-0">
                    <svg class="w-6 h-6 text-blue-700 dark:text-blue-600" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 16 12">
                        <path stroke="white" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M1 5.917 5.724 10.5 15 1.5"> </path>
                    </svg>
                </div>
                <div class="flex w-full bg-gray-200 h-0.5 dark:bg-gray-700"></div>
            </div>
            <div class="mt-3">
                <h3 class="font-medium text-gray-900 dark:text-white">File Nomination</h3>
            </div>
        </li>
        <li class="relative w-full mb-6">
            <div class="flex items-center">
                <div class="z-10 flex items-center justify-center w-9 h-9 bg-blue-700 rounded-full dark:bg-blue-600 shrink-0">
                    <svg class="w-6 h-6 text-blue-700 dark:text-blue-600" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 16 12">
                        <path stroke="white" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M1 5.917 5.724 10.5 15 1.5"> </path>
                    </svg>
                </div>
                <div class="flex w-full bg-gray-200 h-0.5 dark:bg-gray-700"></div>
            </div>
            <div class="mt-3">
                <h3 class="font-medium text-gray-900 dark:text-white">Upload Enclosures</h3>
            </div>
        </li>
        <li class="relative w-full mb-6">
            <div class="flex items-center">
                <div class="z-10 flex items-center justify-center w-9 h-9 bg-gray-200 rounded-full dark:bg-gray-700 shrink-0">
                    <svg class="w-6 h-6 text-gray-900 dark:text-white" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 16 12">
                        <path stroke="white" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M1 5.917 5.724 10.5 15 1.5"> </path>
                    </svg>
                </div>
                <div class="flex w-full bg-gray-200 h-0.5 dark:bg-gray-700"></div>
            </div>
            <div class="mt-3">
                <h3 class="font-medium text-gray-900 dark:text-white">Dean Approval</h3>
            </div>
        </li>
        <li class="relative w-full mb-6">
            <div class="flex items-center">
                <div class="z-10 flex items-center justify-center w-9 h-9 bg-gray-200 rounded-full dark:bg-gray-700 shrink-0">
                    <svg class="w-6 h-6 text-gray-900 dark:text-white" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 16 12">
                        <path stroke="white" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M1 5.917 5.724 10.5 15 1.5"> </path>
                    </svg>
                </div>
            </div>
            <div class="mt-3">
                <h3 class="font-medium text-gray-900 dark:text-white">Election Chair Approval</h3>
            </div>
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
                <input id="candidateRegistrationNumber" name="candidateRegistrationNumber" type="text" minlength="8" maxlength="8" class="form-input bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" disabled>
                <br>
                <label for="candidateName" class="block mt-3 mb-2 text-sm font-medium text-gray-900 dark:text-white">Name of the Candidate in BLOCK LETTERS<i>(as displayed on the Reg./ Semester ID Card)</i>:</label>
                <input id="candidateName" name="candidateName" type="text" class="form-input bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" disabled>
                <br>
                <label for="nameOnBallotPaper" class="block mt-3 mb-2 text-sm font-medium text-gray-900 dark:text-white">Name of the Candidate to be displayed on the Ballot Paper in BLOCK LETTERS:</label>
                <input id="nameOnBallotPaper" name="nameOnBallotPaper" type="text" class="form-input bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required>
                <br>
                <label for="dateOfBirth" class="block mt-3 mb-2 text-sm font-medium text-gray-900 dark:text-white">Date of Birth:</label>
                <input id="dateOfBirth" name="dateOfBirth" type="date" class="form-input bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" disabled>
                <br>
                <label for="age" class="block mt-3 mb-2 text-sm font-medium text-gray-900 dark:text-white">Age:</label>
                <input id="age" name="age" type="number" min="17" max="28" class="form-input bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" disabled>
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
                <input id="candidatesDepartment" name="candidatesDepartment" type="text" class="form-input bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" disabled>
                <br>
                <label for="candidatesCourseAndSubject" class="block mt-3 mb-2 text-sm font-medium text-gray-900 dark:text-white">Course &amp; Subject:</label>
                <input id="candidatesCourseAndSubject" name="candidatesCourseAndSubject" type="text" class="form-input bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" disabled>
                <br>
                <label for="semesterNumber" class="block mt-3 mb-2 text-sm font-medium text-gray-900 dark:text-white">Semester Number:</label>
                <input id="semesterNumber" name="semesterNumber" type="number" class="form-input bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" disabled>
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
                <input id="proposerName" name="proposerName" type="text" class="form-input bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" disabled>
                <br>
                <label for="proposerRegistrationNumber" class="block mt-3 mb-2 text-sm font-medium text-gray-900 dark:text-white">PROPOSER'S Registration Number:</label>
                <input id="proposerRegistrationNumber" name="proposerRegistrationNumber" type="text" minlength="8" maxlength="8" class="form-input bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" onchange="fetchProposerDetails()" required>
                <br>
                <label for="proposersDepartment" class="block mt-3 mb-2 text-sm font-medium text-gray-900 dark:text-white">PROPOSER's Department/School:</label>
                <input id="proposersDepartment" name="proposersDepartment" type="text" class="form-input bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" disabled>
                <br>
                <label for="proposersCourseAndSubject" class="block mt-3 mb-2 text-sm font-medium text-gray-900 dark:text-white">PROPOSER's Course &amp; Subject:</label>
                <input id="proposersCourseAndSubject" name="proposersCourseAndSubject" type="text" class="form-input bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" disabled>
                <br>
                <!-- signature of proposer -->
                <br>
                <label for="seconderName" class="block mt-3 mb-2 text-sm font-medium text-gray-900 dark:text-white">Name of the SECONDER:</label>
                <input id="seconderName" name="seconderName" type="text" class="form-input bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" disabled>
                <br>
                <label for="seconderRegistrationNumber" class="block mt-3 mb-2 text-sm font-medium text-gray-900 dark:text-white">SECONDER'S Registration Number:</label>
                <input id="seconderRegistrationNumber" name="seconderRegistrationNumber" type="text" minlength="8" maxlength="8" class="form-input bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" onchange="fetchSeconderDetails()" required>
                <br>
                <label for="secondersDepartment" class="block mt-3 mb-2 text-sm font-medium text-gray-900 dark:text-white">SECONDER's Department/School:</label>
                <input id="secondersDepartment" name="secondersDepartment" type="text" class="form-input bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" disabled>
                <br>
                <label for="secondersCourseAndSubject" class="block mt-3 mb-2 text-sm font-medium text-gray-900 dark:text-white">SECONDER's Course &amp; Subject:</label>
                <input id="secondersCourseAndSubject" name="secondersCourseAndSubject" type="text" class="form-input bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" disabled>
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
                                <strong>I AGREE &lt;%&ndash;TO THE TERMS AND CONDITIONS&ndash;%&gt;</strong>
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
                    <input class="form-input block w-full text-sm text-gray-900 border border-gray-300 rounded-lg cursor-pointer bg-gray-50 dark:text-gray-400 focus:outline-none dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400" id="candidateSemesterRegistrationCard" type="file">
                </div>
                <div class="p-5 border border-b-0 border-gray-200 dark:border-gray-700">
                    <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white" for="proposerSemesterRegistrationCard">Upload Proposer Semester Registration Card</label>
                    <input class="form-input block w-full text-sm text-gray-900 border border-gray-300 rounded-lg cursor-pointer bg-gray-50 dark:text-gray-400 focus:outline-none dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400" id="proposerSemesterRegistrationCard" type="file">
                </div>
                <div class="p-5 border border-b-0 border-gray-200 dark:border-gray-700">
                    <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white" for="seconderSemesterRegistrationCard">Upload Seconder Semester Registration Card</label>
                    <input class="form-input block w-full text-sm text-gray-900 border border-gray-300 rounded-lg cursor-pointer bg-gray-50 dark:text-gray-400 focus:outline-none dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400" id="seconderSemesterRegistrationCard" type="file">
                </div>
                <div class="p-5 border border-b-0 border-gray-200 dark:border-gray-700">
                    <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white" for="proofOfDob">Upload Proof for Date of Birth</label>
                    <input class="form-input block w-full text-sm text-gray-900 border border-gray-300 rounded-lg cursor-pointer bg-gray-50 dark:text-gray-400 focus:outline-none dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400" id="proofOfDob" type="file">
                </div>
                <div class="p-5 border border-b-0 border-gray-200 dark:border-gray-700">
                    <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white" for="certificateOfAttendanceAcademicRecord">Upload Certificate of Attendance & Academic Record</label>
                    <input class="form-input block w-full text-sm text-gray-900 border border-gray-300 rounded-lg cursor-pointer bg-gray-50 dark:text-gray-400 focus:outline-none dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400" id="certificateOfAttendanceAcademicRecord" type="file">
                </div>
                <div class="p-5 border border-b-0 border-gray-200 dark:border-gray-700">
                    <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white" for="categoryCertificate">Upload Certificate of Category</label>
                    <input class="form-input block w-full text-sm text-gray-900 border border-gray-300 rounded-lg cursor-pointer bg-gray-50 dark:text-gray-400 focus:outline-none dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400" id="categoryCertificate" type="file">
                </div>
            </div>
            <button id="submitEnclosuresButton" type="submit" class="text-white bg-gradient-to-r from-blue-500 via-blue-600 to-blue-700 hover:bg-gradient-to-br font-medium rounded-lg text-sm px-5 py-2.5 text-center me-2 mb-2">Submit</button>
        </form>
    </div>
</div>

<!-- Footer -->
<footer class="bg-white shadow dark:bg-gray-800">
    <div class="w-full mx-auto max-w-screen-xl p-4 md:flex md:items-center md:justify-between">
            <span class="text-sm text-gray-500 sm:text-center dark:text-gray-400">© 2023 <a href="https://flowbite.com/" class="hover:underline">Flowbite™</a>. All Rights Reserved.
            </span>
        <ul class="flex flex-wrap items-center mt-3 text-sm font-medium text-gray-500 dark:text-gray-400 sm:mt-0">
            <li>
                <a href="#" class="hover:underline me-4 md:me-6">About</a>
            </li>
            <li>
                <a href="#" class="hover:underline me-4 md:me-6">Privacy Policy</a>
            </li>
            <li>
                <a href="#" class="hover:underline me-4 md:me-6">Licensing</a>
            </li>
            <li>
                <a href="#" class="hover:underline">Contact</a>
            </li>
        </ul>
    </div>
</footer>

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
        document.getElementById("undertakingModal").classList.remove('hidden');
    }

    function closeModal() {
        document.getElementById("undertakingModal").classList.add('hidden');
        document.getElementById("agreeCheckbox").checked = false;
        event.preventDefault();
    }

    function toggleCheckbox() {
        let modal = document.getElementById("undertakingModal");
        let checkbox = document.getElementById("agreeCheckbox");
        checkbox.disabled = modal.scrollTop !== (modal.scrollHeight - modal.offsetHeight);
    }

    // Event listener for scrolling in the modal
    document.getElementById("undertakingModal").addEventListener("scroll", toggleCheckbox);

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

<!-- Script to toggle between light and dark mode -->
<script>
    let themeToggleDarkIcon = document.getElementById('theme-toggle-dark-icon');
    let themeToggleLightIcon = document.getElementById('theme-toggle-light-icon');

    // Change the icons inside the button based on previous settings
    if (localStorage.getItem('color-theme') === 'dark') {
        themeToggleLightIcon.classList.remove('hidden');
    } else {
        themeToggleDarkIcon.classList.remove('hidden');
    }

    let themeToggleBtn = document.getElementById('theme-toggle');

    themeToggleBtn.addEventListener('click', function() {

        // toggle icons inside button
        themeToggleDarkIcon.classList.toggle('hidden');
        themeToggleLightIcon.classList.toggle('hidden');

        // if set via local storage previously
        if (document.documentElement.classList.contains('dark')) {
            document.documentElement.classList.remove('dark');
            localStorage.setItem('color-theme', 'light');
        } else {
            document.documentElement.classList.add('dark');
            localStorage.setItem('color-theme', 'dark');
        }
    });
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
</script>

<%--<script>
    document.addEventListener("DOMContentLoaded", function() {
        // Get all accordion buttons
        const accordionButtons = document.querySelectorAll('[data-accordion-target]');

        // Add click event listener to each accordion button
        accordionButtons.forEach(button => {
            button.addEventListener('click', function() {
                // Get the target accordion body
                const targetId = button.getAttribute('data-accordion-target');
                const accordionBody = document.querySelector(targetId);

                // Toggle the visibility of the accordion body
                accordionBody.classList.toggle('hidden');

                // Update the aria-expanded attribute to reflect the current state
                const isExpanded = accordionBody.classList.contains('hidden') ? 'false' : 'true';
                button.setAttribute('aria-expanded', isExpanded);
            });
        });
    });
</script>--%>

<!-- Flowbite -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.3.0/flowbite.min.js"></script>

</body>
</html>
%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>File Nomination</title>
    <!-- Tailwind and Flowbite -->
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.3.0/flowbite.min.css" rel="stylesheet" />

    <!-- Script to check for device color scheme -->
    <script>
        if (localStorage.getItem('color-theme') === 'dark' || (!('color-theme' in localStorage) && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
            document.documentElement.classList.add('dark');
        } else {
            document.documentElement.classList.remove('dark')
        }
    </script>

</head>
<style>
    /* Style for scrollbar */
    .undertaking-scroll-container {
        overflow-y: auto;
        max-height: 300px; /* Adjust max-height as needed */
    }

    /* Additional CSS styles */
    #undertakingModal ol {
        padding-left: 20px;
        list-style-type: decimal;
        margin-bottom: 10px; /* Add margin to separate list from checkbox and submit button */
    }
</style>

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
</script>

<body class="flex flex-col min-h-screen">
    <!-- Header -->
    <nav class="bg-white border-gray-200 dark:bg-gray-900">
        <div class="max-w-screen-xl flex flex-wrap items-center justify-between mx-auto p-4">
            <a href="#" class="flex items-center space-x-3 rtl:space-x-reverse">
                <img src="${pageContext.request.contextPath}/Images/UoH_Logo.png" class="w-10 h-10 rounded-full" alt="UoH Logo" />
                <span class="self-center text-2xl font-semibold whitespace-nowrap dark:text-white">University of Hyderabad</span>
            </a>
            <div class="flex items-center md:order-2 space-x-3 md:space-x-0 rtl:space-x-reverse">
                <button id='loginButton' data-modal-target="authentication-modal" data-modal-toggle="authentication-modal" class="block text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800" type="button">
                    Login
                </button>
                <button type="button" id="user-menu-button" class="hidden flex text-sm bg-gray-800 rounded-full md:me-0 focus:ring-4 focus:ring-gray-300 dark:focus:ring-gray-600" aria-expanded="false" data-dropdown-toggle="user-dropdown" data-dropdown-placement="bottom">
                    <span class="sr-only">Open user menu</span>
                    <img class="w-8 h-8 rounded-full" src="/docs/images/people/profile-picture-3.jpg" alt="user photo">
                </button>
                <!-- Dropdown menu -->
                <div class="z-50 hidden my-4 text-base list-none bg-white divide-y divide-gray-100 rounded-lg shadow dark:bg-gray-700 dark:divide-gray-600" id="user-dropdown">
                    <div class="px-4 py-3">
                        <span class="block text-sm text-gray-900 dark:text-white">Bonnie Green</span>
                        <span class="block text-sm  text-gray-500 truncate dark:text-gray-400">name@flowbite.com</span>
                    </div>
                    <ul class="py-2" aria-labelledby="user-menu-button">
                        <li>
                            <a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 dark:hover:bg-gray-600 dark:text-gray-200 dark:hover:text-white">Dashboard</a>
                        </li>
                        <li>
                            <a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 dark:hover:bg-gray-600 dark:text-gray-200 dark:hover:text-white">Settings</a>
                        </li>
                        <li>
                            <a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 dark:hover:bg-gray-600 dark:text-gray-200 dark:hover:text-white">Earnings</a>
                        </li>
                        <li>
                            <a href="logout" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 dark:hover:bg-gray-600 dark:text-gray-200 dark:hover:text-white">Sign out</a>
                        </li>
                    </ul>
                </div>
                <button data-collapse-toggle="navbar-user" type="button" class="inline-flex items-center p-2 w-10 h-10 justify-center text-sm text-gray-500 rounded-lg md:hidden hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-gray-200 dark:text-gray-400 dark:hover:bg-gray-700 dark:focus:ring-gray-600" aria-controls="navbar-user" aria-expanded="false">
                    <span class="sr-only">Open main menu</span>
                    <svg class="w-5 h-5" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 17 14">
                        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M1 1h15M1 7h15M1 13h15"/>
                    </svg>
                </button>
            </div>
            <div class="items-center justify-between hidden w-full md:flex md:w-auto md:order-1" id="navbar-user">
                <ul class="flex flex-col font-medium p-4 md:p-0 mt-4 border border-gray-100 rounded-lg bg-gray-50 md:space-x-8 rtl:space-x-reverse md:flex-row md:mt-0 md:border-0 md:bg-white dark:bg-gray-800 md:dark:bg-gray-900 dark:border-gray-700">
                    <li>
                        <a href="home.jsp" class="block py-2 px-3 text-gray-900 rounded hover:bg-gray-100 md:hover:bg-transparent md:hover:text-blue-700 md:p-0 dark:text-white md:dark:hover:text-blue-500 dark:hover:bg-gray-700 dark:hover:text-white md:dark:hover:bg-transparent dark:border-gray-700">Home</a>
                    </li>
                    <li>
                        <a href="candidateRegistration.jsp" class="block py-2 px-3 text-white bg-blue-700 rounded md:bg-transparent md:text-blue-700 md:p-0 md:dark:text-blue-500" aria-current="page">File Nomination</a>
                    </li>
                    <%--<li>
                        <a href="#" class="block py-2 px-3 text-gray-900 rounded hover:bg-gray-100 md:hover:bg-transparent md:hover:text-blue-700 md:p-0 dark:text-white md:dark:hover:text-blue-500 dark:hover:bg-gray-700 dark:hover:text-white md:dark:hover:bg-transparent dark:border-gray-700">#</a>
                    </li>
                    <li>
                        <a href="#" class="block py-2 px-3 text-gray-900 rounded hover:bg-gray-100 md:hover:bg-transparent md:hover:text-blue-700 md:p-0 dark:text-white md:dark:hover:text-blue-500 dark:hover:bg-gray-700 dark:hover:text-white md:dark:hover:bg-transparent dark:border-gray-700">#</a>
                    </li>--%>
                </ul>
                <button id="theme-toggle" type="button" class="text-gray-500 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-700 rounded-lg text-sm py-2 px-3 mx-5">
                    <svg id="theme-toggle-dark-icon" class="hidden w-5 h-5" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path d="M17.293 13.293A8 8 0 016.707 2.707a8.001 8.001 0 1010.586 10.586z"></path></svg>
                    <svg id="theme-toggle-light-icon" class="hidden w-5 h-5" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path d="M10 2a1 1 0 011 1v1a1 1 0 11-2 0V3a1 1 0 011-1zm4 8a4 4 0 11-8 0 4 4 0 018 0zm-.464 4.95l.707.707a1 1 0 001.414-1.414l-.707-.707a1 1 0 00-1.414 1.414zm2.12-10.607a1 1 0 010 1.414l-.706.707a1 1 0 11-1.414-1.414l.707-.707a1 1 0 011.414 0zM17 11a1 1 0 100-2h-1a1 1 0 100 2h1zm-7 4a1 1 0 011 1v1a1 1 0 11-2 0v-1a1 1 0 011-1zM5.05 6.464A1 1 0 106.465 5.05l-.708-.707a1 1 0 00-1.414 1.414l.707.707zm1.414 8.486l-.707.707a1 1 0 01-1.414-1.414l.707-.707a1 1 0 011.414 1.414zM4 11a1 1 0 100-2H3a1 1 0 000 2h1z" fill-rule="evenodd" clip-rule="evenodd"></path></svg>
                </button>
            </div>
        </div>
    </nav>

    <!-- Script to toggle the user menu -->
    <script>
        const loginButton = document.getElementById('loginButton');
        const loginModal = document.getElementById('authentication-modal');
        const userMenuButton = document.getElementById('user-menu-button');

        window.addEventListener('load', function() {
            let username = '<%= session.getAttribute("username") %>';
            console.log(username);

            if (username && username !== "null" && username !== "NULL") {
                // User is logged in, then hide login button and show user menu button
                loginButton.classList.add('hidden');
                userMenuButton.classList.remove('hidden');
                // userMenuButton.innerText = username;
            }
        });
    </script>

    <!-- Main content -->
    <div class="flex-grow p-6 bg-white dark:bg-gray-800">


        <h1 class="text-4xl font-bold mb-8 dark:text-white">File Nomination</h1>


        <div id="accordion-collapse" data-accordion="collapse">
            <h2 id="accordion-collapse-heading-1">
                <button  type="button" class="flex items-center justify-between w-full p-5 font-medium rtl:text-right text-gray-500 border border-b-0 border-gray-200 rounded-t-xl focus:ring-4 focus:ring-gray-200 dark:focus:ring-gray-800 dark:border-gray-700 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-800 gap-3" data-accordion-target="#accordion-collapse-body-1" aria-expanded="true" aria-controls="accordion-collapse-body-1">
                    <span>Nomination Form</span>
                    <svg data-accordion-icon class="w-3 h-3 rotate-180 shrink-0" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 10 6">
                        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5 5 1 1 5"/>
                    </svg>
                </button>
            </h2>
            <div id="accordion-collapse-body-1" class="hidden" aria-labelledby="accordion-collapse-heading-1">
                <div class="p-5 border border-b-0 border-gray-200 dark:border-gray-700 dark:bg-gray-900">
                    <!-- Nomination Form -->
                    <form id="nominationForm" name="nominationForm" method="post" action="submitNomination" >
                        <div class="nomination_form">
                            <label for="nameOfThePosition" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Name of the Position:</label>
                            <select id="nameOfThePosition" name="nameofThePosition" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required>
                                <option value="" selected disabled>--position--</option>
                            </select>
                            <br>
                            <label for="candidateRegistrationNumber" class="block mt-3 mb-2 text-sm font-medium text-gray-900 dark:text-white">Registration Number:</label>
                            <input id="candidateRegistrationNumber" name="candidateRegistrationNumber" type="text" minlength="8" maxlength="8" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" disabled>
                            <br>
                            <label for="candidateName" class="block mt-3 mb-2 text-sm font-medium text-gray-900 dark:text-white">Name of the Candidate in BLOCK LETTERS<i>(as displayed on the Reg./ Semester ID Card)</i>:</label>
                            <input id="candidateName" name="candidateName" type="text" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" disabled>
                            <br>
                            <label for="nameOnBallotPaper" class="block mt-3 mb-2 text-sm font-medium text-gray-900 dark:text-white">Name of the Candidate to be displayed on the Ballot Paper in BLOCK LETTERS:</label>
                            <input id="nameOnBallotPaper" name="nameOnBallotPaper" type="text" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required>
                            <br>
                            <label for="dateOfBirth" class="block mt-3 mb-2 text-sm font-medium text-gray-900 dark:text-white">Date of Birth:</label>
                            <input id="dateOfBirth" name="dateOfBirth" type="date" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" disabled>
                            <br>
                            <label for="age" class="block mt-3 mb-2 text-sm font-medium text-gray-900 dark:text-white">Age:</label>
                            <input id="age" name="age" type="number" min="17" max="28" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" disabled>
                            <br>
                            <label for="categoryOfTheCandidate" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Category of the Candidate:</label>
                            <select id="categoryOfTheCandidate" name="categoryOfTheCandidate" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required>
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
                            <input id="fathersName" name="fathersName" type="text" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required>
                            <br>
                            <label for="candidatesDepartment" class="block mt-3 mb-2 text-sm font-medium text-gray-900 dark:text-white">Department/School:</label>
                            <input id="candidatesDepartment" name="candidatesDepartment" type="text" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" disabled>
                            <br>
                            <label for="candidatesCourseAndSubject" class="block mt-3 mb-2 text-sm font-medium text-gray-900 dark:text-white">Course &amp; Subject:</label>
                            <input id="candidatesCourseAndSubject" name="candidatesCourseAndSubject" type="text" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" disabled>
                            <br>
                            <label for="semesterNumber" class="block mt-3 mb-2 text-sm font-medium text-gray-900 dark:text-white">Semester Number:</label>
                            <input id="semesterNumber" name="semesterNumber" type="number" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" disabled>
                            <br>
                            <label for="mobileNumber" class="block mt-3 mb-2 text-sm font-medium text-gray-900 dark:text-white">Mobile Number:</label>
                            <input id="mobileNumber" name="mobileNumber" type="number" minlength="10" maxlength="10" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required>
                            <br>
                            <label for="email" class="block mt-3 mb-2 text-sm font-medium text-gray-900 dark:text-white">Email ID:</label>
                            <input id="email" name="email" type="email" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required>
                            <br>
                            <label for="residentialAddress" class="block mt-3 mb-2 text-sm font-medium text-gray-900 dark:text-white">Residential Address:</label>
                            <textarea id="residentialAddress" name="residentialAddress" rows="3" cols="50" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required></textarea>
                            <br>
                            <label for="proposerName" class="block mt-3 mb-2 text-sm font-medium text-gray-900 dark:text-white">Name of the PROPOSER:</label>
                            <input id="proposerName" name="proposerName" type="text" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" disabled>
                            <br>
                            <label for="proposerRegistrationNumber" class="block mt-3 mb-2 text-sm font-medium text-gray-900 dark:text-white">PROPOSER'S Registration Number:</label>
                            <input id="proposerRegistrationNumber" name="proposerRegistrationNumber" type="text" minlength="8" maxlength="8" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" onchange="fetchProposerDetails()" required>
                            <br>
                            <label for="proposersDepartment" class="block mt-3 mb-2 text-sm font-medium text-gray-900 dark:text-white">PROPOSER's Department/School:</label>
                            <input id="proposersDepartment" name="proposersDepartment" type="text" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" disabled>
                            <br>
                            <label for="proposersCourseAndSubject" class="block mt-3 mb-2 text-sm font-medium text-gray-900 dark:text-white">PROPOSER's Course &amp; Subject:</label>
                            <input id="proposersCourseAndSubject" name="proposersCourseAndSubject" type="text" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" disabled>
                            <br>
                            <!-- signature of proposer -->
                            <br>
                            <label for="seconderName" class="block mt-3 mb-2 text-sm font-medium text-gray-900 dark:text-white">Name of the SECONDER:</label>
                            <input id="seconderName" name="seconderName" type="text" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" disabled>
                            <br>
                            <label for="seconderRegistrationNumber" class="block mt-3 mb-2 text-sm font-medium text-gray-900 dark:text-white">SECONDER'S Registration Number:</label>
                            <input id="seconderRegistrationNumber" name="seconderRegistrationNumber" type="text" minlength="8" maxlength="8" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" onchange="fetchSeconderDetails()" required>
                            <br>
                            <label for="secondersDepartment" class="block mt-3 mb-2 text-sm font-medium text-gray-900 dark:text-white">SECONDER's Department/School:</label>
                            <input id="secondersDepartment" name="secondersDepartment" type="text" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" disabled>
                            <br>
                            <label for="secondersCourseAndSubject" class="block mt-3 mb-2 text-sm font-medium text-gray-900 dark:text-white">SECONDER's Course &amp; Subject:</label>
                            <input id="secondersCourseAndSubject" name="secondersCourseAndSubject" type="text" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" disabled>

                            <button id="proceedButton" type="button" onclick="proceed()" class="text-white bg-gradient-to-r from-blue-500 via-blue-600 to-blue-700 hover:bg-gradient-to-br font-medium rounded-lg text-sm px-5 py-2.5 text-center me-2 mb-2">Proceed</button>
                            <!-- signature of seconder -->
                        </div>

                        <!-- Undertaking Modal -->
                        <div id="undertakingModal" class="hidden fixed inset-0 bg-black bg-opacity-50 flex justify-center items-center">
                            <div class="bg-white rounded-lg p-2 max-w-md mx-4 overflow-y-auto max-h-[80vh]">
                                <h2 class="text-2xl font-bold mb-4">UNDERTAKING BY THE CANDIDATE FILING THE NOMINATION</h2>
                                <!-- Close button -->
                                <button class="absolute top-0 right-0 m-4 text-gray-600 hover:text-gray-900" onclick="closeModal(event)">
                                    <svg class="h-6 w-6 fill-current" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                        <path fill-rule="evenodd" d="M10 0C4.477 0 0 4.477 0 10s4.477 10 10 10 10-4.477 10-10S15.523 0 10 0zM5 5a.75.75 0 011.061 1.061L6.061 6l3.938 3.939L13.937 6l.002-.001a.75.75 0 111.06 1.061l-.001.002L10.06 10l3.939 3.938a.75.75 0 11-1.061 1.061L9 11.062l-3.938 3.939a.75.75 0 01-1.061-1.061L7.062 10 3.124 6.062A.748.748 0 013 5.999L3 6l.001-.001A.75.75 0 015 5z" clip-rule="evenodd"></path>
                                    </svg>
                                </button>
                                <hr>
                                <!-- Undertaking content -->
                                <div class="undertaking-scroll-container">
                                    <p> <strong> I, _____, Registration Number: ________ Course/Subject: ________ have filed my nomination </strong> for the post of ________ </p>
                                    <h3> I hereby undertake: </h3>
                                    <ol class="ml-4 mr-4">
                                        <li>That the Proposer & Seconder Of my nomination are full-time duly registered students Of the University,</li>
                                        <li>That I do not have any criminal case filed against me in any police station / criminal record and have not been subjected to any disciplinary action by the University.</li>
                                        <li>That I have 75% of attendance upto 3 October 2023 and that academic arrears if any, are as per the norms Of the university,</li>
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
                                    <hr>
                                    <p><strong>"I fully understand that I would be held responsible and my candidature and / or election to office, would be nullified for failing to follow norms laid down by the Returning Officers. The Returning Officers have the authority to cancel my candidature / nullify my election to office if any of the information furnished is found to be incorrect."</strong></p>
                                    <!-- Checkbox for agreement -->
                                    <label for="agreeCheckbox"><strong>I AGREE <%--TO THE TERMS AND CONDITIONS--%></strong></label>
                                    <input type="checkbox" id="agreeCheckbox" onchange="toggleCheckbox()" required>
                                    <hr>
                                    <button id="submitButton" type="submit" class="text-white bg-gradient-to-r from-blue-500 via-blue-600 to-blue-700 hover:bg-gradient-to-br font-medium rounded-lg text-sm px-5 py-2.5 text-center me-2 mb-2">Submit</button>
                                </div>
                                <hr>
                            </div>
                        </div>
                    </form>
                </div>
                </div>
            </div>

            <!-- Enclosures -->
            <h2 id="accordion-collapse-heading-2">
                <button type="button" class="flex items-center justify-between w-full p-5 font-medium rtl:text-right text-gray-500 border border-b-0 border-gray-200 focus:ring-4 focus:ring-gray-200 dark:focus:ring-gray-800 dark:border-gray-700 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-800 gap-3" data-accordion-target="#accordion-collapse-body-2" aria-expanded="false" aria-controls="accordion-collapse-body-2">
                    <span>Enclosures</span>
                    <svg data-accordion-icon class="w-3 h-3 rotate-180 shrink-0" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 10 6">
                        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5 5 1 1 5"/>
                    </svg>
                </button>
            </h2>
            <div id="accordion-collapse-body-2" class="hidden" aria-labelledby="accordion-collapse-heading-2">
                <div class="p-5 border border-b-0 border-gray-200 dark:border-gray-700">
                    <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white" for="candidateSemesterRegistrationCard">Upload Candidate Semester Registration Card</label>
                    <input class="block w-full text-sm text-gray-900 border border-gray-300 rounded-lg cursor-pointer bg-gray-50 dark:text-gray-400 focus:outline-none dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400" id="candidateSemesterRegistrationCard" type="file">
                </div>
                <div class="p-5 border border-b-0 border-gray-200 dark:border-gray-700">
                    <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white" for="proposerSemesterRegistrationCard">Upload Proposer Semester Registration Card</label>
                    <input class="block w-full text-sm text-gray-900 border border-gray-300 rounded-lg cursor-pointer bg-gray-50 dark:text-gray-400 focus:outline-none dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400" id="proposerSemesterRegistrationCard" type="file">
                </div>
                <div class="p-5 border border-b-0 border-gray-200 dark:border-gray-700">
                    <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white" for="seconderSemesterRegistrationCard">Upload Seconder Semester Registration Card</label>
                    <input class="block w-full text-sm text-gray-900 border border-gray-300 rounded-lg cursor-pointer bg-gray-50 dark:text-gray-400 focus:outline-none dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400" id="seconderSemesterRegistrationCard" type="file">
                </div>
                <div class="p-5 border border-b-0 border-gray-200 dark:border-gray-700">
                    <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white" for="proofOfDob">Upload Proof for Date of Birth</label>
                    <input class="block w-full text-sm text-gray-900 border border-gray-300 rounded-lg cursor-pointer bg-gray-50 dark:text-gray-400 focus:outline-none dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400" id="proofOfDob" type="file">
                </div>
                <div class="p-5 border border-b-0 border-gray-200 dark:border-gray-700">
                    <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white" for="certificateOfAttendanceAcademicRecord">Upload Certificate of Attendance & Academic Record</label>
                    <input class="block w-full text-sm text-gray-900 border border-gray-300 rounded-lg cursor-pointer bg-gray-50 dark:text-gray-400 focus:outline-none dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400" id="certificateOfAttendanceAcademicRecord" type="file">
                </div>
                <div class="p-5 border border-b-0 border-gray-200 dark:border-gray-700">
                    <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white" for="categoryCertificate">Upload Certificate of Category</label>
                    <input class="block w-full text-sm text-gray-900 border border-gray-300 rounded-lg cursor-pointer bg-gray-50 dark:text-gray-400 focus:outline-none dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400" id="categoryCertificate" type="file">
                </div>


            </div>
            <h2 id="accordion-collapse-heading-3">
                <button type="button" class="flex items-center justify-between w-full p-5 font-medium rtl:text-right text-gray-500 border border-gray-200 focus:ring-4 focus:ring-gray-200 dark:focus:ring-gray-800 dark:border-gray-700 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-800 gap-3" data-accordion-target="#accordion-collapse-body-3" aria-expanded="false" aria-controls="accordion-collapse-body-3">
                    <span>What are the differences between Flowbite and Tailwind UI?</span>
                    <svg data-accordion-icon class="w-3 h-3 rotate-180 shrink-0" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 10 6">
                        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5 5 1 1 5"/>
                    </svg>
                </button>
            </h2>
            <div id="accordion-collapse-body-3" class="hidden" aria-labelledby="accordion-collapse-heading-3">
                <div class="p-5 border border-t-0 border-gray-200 dark:border-gray-700">
                    <p class="mb-2 text-gray-500 dark:text-gray-400">The main difference is that the core components from Flowbite are open source under the MIT license, whereas Tailwind UI is a paid product. Another difference is that Flowbite relies on smaller and standalone components, whereas Tailwind UI offers sections of pages.</p>
                    <p class="mb-2 text-gray-500 dark:text-gray-400">However, we actually recommend using both Flowbite, Flowbite Pro, and even Tailwind UI as there is no technical reason stopping you from using the best of two worlds.</p>
                    <p class="mb-2 text-gray-500 dark:text-gray-400">Learn more about these technologies:</p>
                    <ul class="ps-5 text-gray-500 list-disc dark:text-gray-400">
                        <li><a href="https://flowbite.com/pro/" class="text-blue-600 dark:text-blue-500 hover:underline">Flowbite Pro</a></li>
                        <li><a href="https://tailwindui.com/" rel="nofollow" class="text-blue-600 dark:text-blue-500 hover:underline">Tailwind UI</a></li>
                    </ul>
                </div>
            </div>
        </div>


    <!-- Footer -->
    <footer class="bg-white shadow dark:bg-gray-800">
        <div class="w-full mx-auto max-w-screen-xl p-4 md:flex md:items-center md:justify-between">
            <span class="text-sm text-gray-500 sm:text-center dark:text-gray-400">© 2023 <a href="https://flowbite.com/" class="hover:underline">Flowbite™</a>. All Rights Reserved.
            </span>
            <ul class="flex flex-wrap items-center mt-3 text-sm font-medium text-gray-500 dark:text-gray-400 sm:mt-0">
                <li>
                    <a href="#" class="hover:underline me-4 md:me-6">About</a>
                </li>
                <li>
                    <a href="#" class="hover:underline me-4 md:me-6">Privacy Policy</a>
                </li>
                <li>
                    <a href="#" class="hover:underline me-4 md:me-6">Licensing</a>
                </li>
                <li>
                    <a href="#" class="hover:underline">Contact</a>
                </li>
            </ul>
        </div>
    </footer>

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
                document.getElementById("undertakingModal").classList.remove('hidden');
        }

        function closeModal() {
            document.getElementById("undertakingModal").classList.add('hidden');
            document.getElementById("agreeCheckbox").checked = false;
            event.preventDefault();
        }

        function toggleCheckbox() {
            let modal = document.getElementById("undertakingModal");
            let checkbox = document.getElementById("agreeCheckbox");
            checkbox.disabled = modal.scrollTop !== (modal.scrollHeight - modal.offsetHeight);
        }

        // Event listener for scrolling in the modal
        document.getElementById("undertakingModal").addEventListener("scroll", toggleCheckbox);

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

    <!-- Script to toggle between light and dark mode -->
    <script>
        let themeToggleDarkIcon = document.getElementById('theme-toggle-dark-icon');
        let themeToggleLightIcon = document.getElementById('theme-toggle-light-icon');

        // Change the icons inside the button based on previous settings
        if (localStorage.getItem('color-theme') === 'dark') {
            themeToggleLightIcon.classList.remove('hidden');
        } else {
            themeToggleDarkIcon.classList.remove('hidden');
        }

        let themeToggleBtn = document.getElementById('theme-toggle');

        themeToggleBtn.addEventListener('click', function() {

            // toggle icons inside button
            themeToggleDarkIcon.classList.toggle('hidden');
            themeToggleLightIcon.classList.toggle('hidden');

            // if set via local storage previously
            if (document.documentElement.classList.contains('dark')) {
                document.documentElement.classList.remove('dark');
                localStorage.setItem('color-theme', 'light');
            } else {
                document.documentElement.classList.add('dark');
                localStorage.setItem('color-theme', 'dark');
            }
        });
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
    </script>
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            // Get all accordion buttons
            const accordionButtons = document.querySelectorAll('[data-accordion-target]');

            // Add click event listener to each accordion button
            accordionButtons.forEach(button => {
                button.addEventListener('click', function() {
                    // Get the target accordion body
                    const targetId = button.getAttribute('data-accordion-target');
                    const accordionBody = document.querySelector(targetId);

                    // Toggle the visibility of the accordion body
                    accordionBody.classList.toggle('hidden');

                    // Update the aria-expanded attribute to reflect the current state
                    const isExpanded = accordionBody.classList.contains('hidden') ? 'false' : 'true';
                    button.setAttribute('aria-expanded', isExpanded);
                });
            });
        });
    </script>

</body>
</html>

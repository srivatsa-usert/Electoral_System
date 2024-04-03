<%--
  Created by IntelliJ IDEA.
  User: anant
  Date: 30-03-2024
  Time: 10:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Certify Candidate</title>
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
<body class="flex flex-col min-h-screen">
<!-- Header -->
<nav class="bg-white border-gray-200 dark:bg-gray-900">
    <div class="max-w-screen-xl flex flex-wrap items-center justify-between mx-auto p-4">
        <a href="#" class="flex items-center space-x-3 rtl:space-x-reverse">
            <img src="${pageContext.request.contextPath}/Images/UoH_Logo.png" class="w-10 h-10 rounded-full" alt="UoH Logo" />
            <span class="self-center text-2xl font-semibold whitespace-nowrap dark:text-white">University of Hyderabad</span>
        </a>
        <div class="flex items-center md:order-2 space-x-3 md:space-x-0 rtl:space-x-reverse">
            <button type="button" class="flex text-sm bg-gray-800 rounded-full md:me-0 focus:ring-4 focus:ring-gray-300 dark:focus:ring-gray-600" id="user-menu-button" aria-expanded="false" data-dropdown-toggle="user-dropdown" data-dropdown-placement="bottom">
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
                        <a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 dark:hover:bg-gray-600 dark:text-gray-200 dark:hover:text-white">Sign out</a>
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
                    <a href="deanHome.jsp" class="block py-2 px-3 text-gray-900 rounded hover:bg-gray-100 md:hover:bg-transparent md:hover:text-blue-700 md:p-0 dark:text-white md:dark:hover:text-blue-500 dark:hover:bg-gray-700 dark:hover:text-white md:dark:hover:bg-transparent dark:border-gray-700">Home</a>
                </li>
                <li>
                    <a href="certifyCandidate.jsp" class="block py-2 px-3 text-white bg-blue-700 rounded md:bg-transparent md:text-blue-700 md:p-0 md:dark:text-blue-500" aria-current="page">Certify Candidate</a>
                </li>
                <li>
                    <a href="#" class="block py-2 px-3 text-gray-900 rounded hover:bg-gray-100 md:hover:bg-transparent md:hover:text-blue-700 md:p-0 dark:text-white md:dark:hover:text-blue-500 dark:hover:bg-gray-700 dark:hover:text-white md:dark:hover:bg-transparent dark:border-gray-700">Hola!</a>
                </li>
            </ul>
            <button id="theme-toggle" type="button" class="text-gray-500 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-700 focus:outline-none focus:ring-4 focus:ring-gray-200 dark:focus:ring-gray-700 rounded-lg text-sm py-2 px-3 mx-5">
                <svg id="theme-toggle-dark-icon" class="hidden w-5 h-5" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path d="M17.293 13.293A8 8 0 016.707 2.707a8.001 8.001 0 1010.586 10.586z"></path></svg>
                <svg id="theme-toggle-light-icon" class="hidden w-5 h-5" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path d="M10 2a1 1 0 011 1v1a1 1 0 11-2 0V3a1 1 0 011-1zm4 8a4 4 0 11-8 0 4 4 0 018 0zm-.464 4.95l.707.707a1 1 0 001.414-1.414l-.707-.707a1 1 0 00-1.414 1.414zm2.12-10.607a1 1 0 010 1.414l-.706.707a1 1 0 11-1.414-1.414l.707-.707a1 1 0 011.414 0zM17 11a1 1 0 100-2h-1a1 1 0 100 2h1zm-7 4a1 1 0 011 1v1a1 1 0 11-2 0v-1a1 1 0 011-1zM5.05 6.464A1 1 0 106.465 5.05l-.708-.707a1 1 0 00-1.414 1.414l.707.707zm1.414 8.486l-.707.707a1 1 0 01-1.414-1.414l.707-.707a1 1 0 011.414 1.414zM4 11a1 1 0 100-2H3a1 1 0 000 2h1z" fill-rule="evenodd" clip-rule="evenodd"></path></svg>
            </button>
        </div>
    </div>
</nav>

<!-- Main Content -->
<div class="flex-grow p-6 bg-white dark:bg-gray-800">
    <!-- form to certify candidate with attendance and academic record -->
    <h1 class="text-2xl font-semibold mb-4 text-gray-900 dark:text-white">Certify Candidate</h1>
    <form action="processForm.jsp" method="POST" class="space-y-4">
        <div class="flex flex-col">
            <label for="name" class="mb-1 text-gray-800 dark:text-white">Name:</label>
            <input type="text" id="name" name="name" class="border border-gray-300 rounded-md p-2 dark:bg-gray-700 dark:text-gray-200" required>
        </div>
        <div class="flex flex-col">
            <label for="registrationNumber" class="mb-1 text-gray-800 dark:text-white">Registration Number:</label>
            <input type="text" id="registrationNumber" name="registrationNumber" class="border border-gray-300 rounded-md p-2 dark:bg-gray-700 dark:text-gray-200" required>
        </div>
        <div class="flex flex-col">
            <label for="programmeOfStudy" class="mb-1 text-gray-800 dark:text-white">Programme of Study:</label>
            <select id="programmeOfStudy" name="programmeOfStudy" class="border border-gray-300 rounded-md p-2 dark:bg-gray-700 dark:text-gray-200" required>
                <option value="B.Tech">B.Tech</option>
                <option value="B.Sc">B.Sc</option>
                <option value="M.Tech">M.Tech</option>
                <!-- Add more options as needed -->
            </select>
        </div>
        <div class="flex flex-col">
            <label for="subject" class="mb-1 text-gray-800 dark:text-white">Subject:</label>
            <select id="subject" name="subject" class="border border-gray-300 rounded-md p-2 dark:bg-gray-700 dark:text-gray-200" required>
                <option value="Mathematics">Mathematics</option>
                <option value="Physics">Physics</option>
                <option value="Chemistry">Chemistry</option>
                <!-- Add more options as needed -->
            </select>
        </div>
        <div class="flex flex-col">
            <label for="semester" class="mb-1 text-gray-800 dark:text-white">Semester:</label>
            <select id="semester" name="semester" class="border border-gray-300 rounded-md p-2 dark:bg-gray-700 dark:text-gray-200" required>
                <option value="Semester 1">Semester 1</option>
                <option value="Semester 2">Semester 2</option>
                <option value="Semester 3">Semester 3</option>
                <!-- Add more options as needed -->
            </select>
        </div>

        <!-- Subheading for Integrated/PG & MPhil Students -->
        <div class="mt-6 mb-4">
            <h2 class="text-lg font-semibold text-gray-800 dark:text-white">FOR INTEGRATED/PG & MPHIL STUDENTS</h2>
        </div>
        <div class="flex flex-col space-y-2">
            <label class="text-gray-800 dark:text-white">
                Is she/he a registered student?
            </label>
            <div class="flex space-x-4">
                <label>
                    <input type="radio" name="registeredStudent" value="yes" required>
                    Yes
                </label>
                <label>
                    <input type="radio" name="registeredStudent" value="no" required>
                    No
                </label>
            </div>
        </div>
        <div class="flex flex-col space-y-2">
            <label class="text-gray-800 dark:text-white">
                Does the student have 75% attendance in the current semester as on <span class="underline">[date]</span>?
            </label>
            <div class="flex space-x-4">
                <label>
                    <input type="radio" name="attendance" value="yes" required>
                    Yes
                </label>
                <label>
                    <input type="radio" name="attendance" value="no" required>
                    No
                </label>
            </div>
        </div>
        <div class="flex flex-col space-y-2">
            <label class="text-gray-800 dark:text-white">
                The student's academic arrears/backlogs are as per the University norms?
            </label>
            <div class="flex space-x-4">
                <label>
                    <input type="radio" name="academicArrears" value="yes" required>
                    Yes
                </label>
                <label>
                    <input type="radio" name="academicArrears" value="no" required>
                    No
                </label>
            </div>
        </div>

        <!-- Subheading for Ph.D. Scholars -->
        <div class="mt-6 mb-4">
            <h2 class="text-lg font-semibold text-gray-800 dark:text-white">FOR Ph.D. SCHOLARS</h2>
        </div>
        <div class="flex flex-col space-y-2">
            <label class="text-gray-800 dark:text-white">
                Is she/he a registered student?
            </label>
            <div class="flex space-x-4">
                <label>
                    <input type="radio" name="registeredPhd" value="yes" required>
                    Yes
                </label>
                <label>
                    <input type="radio" name="registeredPhd" value="no" required>
                    No
                </label>
            </div>
        </div>
        <div class="flex flex-col space-y-2">
            <label class="text-gray-800 dark:text-white">
                Has the student cleared the course requirements?
            </label>
            <div class="flex space-x-4">
                <label>
                    <input type="radio" name="courseRequirements" value="yes" required>
                    Yes
                </label>
                <label>
                    <input type="radio" name="courseRequirements" value="no" required>
                    No
                </label>
            </div>
        </div>
        <div class="flex flex-col space-y-2">
            <label class="text-gray-800 dark:text-white">
                Is the student's research progress satisfactory?
            </label>
            <div class="flex space-x-4">
                <label>
                    <input type="radio" name="researchProgress" value="yes" required>
                    Yes
                </label>
                <label>
                    <input type="radio" name="researchProgress" value="no" required>
                    No
                </label>
            </div>
        </div>
        <div class="flex flex-col space-y-2">
            <label class="text-gray-800 dark:text-white">
                Is the latest DRC report attached?
            </label>
            <div class="flex space-x-4">
                <label>
                    <input type="radio" name="DRCReport" value="yes" required>
                    Yes
                </label>
                <label>
                    <input type="radio" name="DRCReport" value="no" required>
                    No
                </label>
            </div>
        </div>

        <div class="flex flex-col">
            <label for="comments" class="mb-1 text-gray-800 dark:text-white">Comments if any, HoD/Dean:</label>
            <textarea id="comments" name="comments" rows="4" class="border border-gray-300 rounded-md p-2 dark:bg-gray-700 dark:text-gray-200"></textarea>
        </div>
        <div class="flex flex-col">
            <label for="dateCertification" class="mb-1 text-gray-800 dark:text-white">Date of certification:</label>
            <input type="date" id="dateCertification" name="dateCertification" class="border border-gray-300 rounded-md p-2 dark:bg-gray-700 dark:text-gray-200" required>
        </div>

        <button type="submit" class="bg-blue-700 text-white rounded-md px-4 py-2 hover:bg-blue-600 dark:bg-blue-500 dark:hover:bg-blue-600">Submit</button>
    </form>
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

<!-- Flowbite -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.3.0/flowbite.min.js"></script>
</body>
</html>

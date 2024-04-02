<%--
  Created by IntelliJ IDEA.
  User: anant
  Date: 29-03-2024
  Time: 15:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Election</title>
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
                    <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M1 1h15M1 7h15M1 13h15"></path>
                </svg>
            </button>
        </div>
        <div class="items-center justify-between hidden w-full md:flex md:w-auto md:order-1" id="navbar-user">
            <ul class="flex flex-col font-medium p-4 md:p-0 mt-4 border border-gray-100 rounded-lg bg-gray-50 md:space-x-8 rtl:space-x-reverse md:flex-row md:mt-0 md:border-0 md:bg-white dark:bg-gray-800 md:dark:bg-gray-900 dark:border-gray-700">
                <li>
                    <a href="electionChairHome.jsp" class="block py-2 px-3 text-gray-900 rounded hover:bg-gray-100 md:hover:bg-transparent md:hover:text-blue-700 md:p-0 dark:text-white md:dark:hover:text-blue-500 dark:hover:bg-gray-700 dark:hover:text-white md:dark:hover:bg-transparent dark:border-gray-700">Home</a>
                </li>
                <li>
                    <a href="manageElection.jsp" class="block py-2 px-3 text-white bg-blue-700 rounded md:bg-transparent md:text-blue-700 md:p-0 md:dark:text-blue-500" aria-current="page">Manage Election</a>
                </li>
                <li>
                    <a href="delegateWork.jsp" class="block py-2 px-3 text-gray-900 rounded hover:bg-gray-100 md:hover:bg-transparent md:hover:text-blue-700 md:p-0 dark:text-white md:dark:hover:text-blue-500 dark:hover:bg-gray-700 dark:hover:text-white md:dark:hover:bg-transparent dark:border-gray-700">Delegate Work</a>
                </li>
                <li>
                    <a href="#" class="block py-2 px-3 text-gray-900 rounded hover:bg-gray-100 md:hover:bg-transparent md:hover:text-blue-700 md:p-0 dark:text-white md:dark:hover:text-blue-500 dark:hover:bg-gray-700 dark:hover:text-white md:dark:hover:bg-transparent dark:border-gray-700">Hola!</a>
                </li>
            </ul>
            <button id="theme-toggle" type="button" class="text-gray-500 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-700 rounded-lg text-sm py-2 px-3 mx-5">
                <svg id="theme-toggle-dark-icon" class="hidden w-5 h-5" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path d="M17.293 13.293A8 8 0 016.707 2.707a8.001 8.001 0 1010.586 10.586z"></path></svg>
                <svg id="theme-toggle-light-icon" class="hidden w-5 h-5" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path d="M10 2a1 1 0 011 1v1a1 1 0 11-2 0V3a1 1 0 011-1zm4 8a4 4 0 11-8 0 4 4 0 018 0zm-.464 4.95l.707.707a1 1 0 001.414-1.414l-.707-.707a1 1 0 00-1.414 1.414zm2.12-10.607a1 1 0 010 1.414l-.706.707a1 1 0 11-1.414-1.414l.707-.707a1 1 0 011.414 0zM17 11a1 1 0 100-2h-1a1 1 0 100 2h1zm-7 4a1 1 0 011 1v1a1 1 0 11-2 0v-1a1 1 0 011-1zM5.05 6.464A1 1 0 106.465 5.05l-.708-.707a1 1 0 00-1.414 1.414l.707.707zm1.414 8.486l-.707.707a1 1 0 01-1.414-1.414l.707-.707a1 1 0 011.414 1.414zM4 11a1 1 0 100-2H3a1 1 0 000 2h1z" fill-rule="evenodd" clip-rule="evenodd"></path></svg>
            </button>
        </div>
    </div>
</nav>

<!-- Main Content -->
<div class="flex-grow p-6 bg-white dark:bg-gray-800">
    <div class="flex items-center justify-between m-10">
        <h1 class="text-2xl font-semibold text-gray-900 dark:text-gray-500">Manage Election</h1>
        <button id="createElectionButton" type="button" class="text-white bg-gradient-to-r from-blue-500 via-blue-600 to-blue-700 hover:bg-gradient-to-br font-medium rounded-lg text-sm px-5 py-2.5 text-center me-2 mb-2">Add Election</button>
    </div>

    <!-- form to create election -->
    <div id="newElectionForm" class="hidden m-30">
        <form action="addNewElectionServlet" method="post">
            <div id="accordion-collapse" data-accordion="collapse">
                <!-- election schedule -->
                <h2 id="accordion-collapse-heading-1">
                    <button type="button" class="flex items-center justify-between w-full p-5 font-medium rtl:text-right text-gray-500 border border-b-0 border-gray-200 rounded-t-xl focus:ring-4 focus:ring-gray-200 dark:focus:ring-gray-800 dark:border-gray-700 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-800 gap-3" data-accordion-target="#accordion-collapse-body-1" aria-expanded="true" aria-controls="accordion-collapse-body-1">
                        <span>Election Schedule</span>
                        <svg data-accordion-icon class="w-3 h-3 rotate-180 shrink-0" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 10 6">
                            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5 5 1 1 5"/>
                        </svg>
                    </button>
                </h2>
                <div id="accordion-collapse-body-1" class="hidden" aria-labelledby="accordion-collapse-heading-1">
                    <div class="p-5 border border-b-0 border-gray-200 dark:border-gray-700 dark:bg-gray-900">
                        <!-- election name -->
                        <div class="mb-5">
                            <label for="election-name" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Election Name: </label>
                            <input type="text" id="election-name" name="election-name" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required>
                        </div>
                        <!-- nomination start date and time -->
                        <div class="mb-5">
                            <label for="nomination-start-date-time" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Nomination Start Date & Time: </label>
                            <input type="datetime-local" id="nomination-start-date-time" name="nomination-start-date-time" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required>
                        </div>
                        <!-- nomination end date and time -->
                        <div class="mb-5">
                            <label for="nomination-end-date-time" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Nomination End Date & Time: </label>
                            <input type="datetime-local" id="nomination-end-date-time" name="nomination-end-date-time" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required>
                        </div>
                        <!-- scrutiny & list of valid nominations date and time -->
                        <div class="mb-5">
                            <label for="scrutiny-list-date-time" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Scrutiny & List of Valid Nominations Date & Time: </label>
                            <input type="datetime-local" id="scrutiny-list-date-time" name="scrutiny-list-date-time" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required>
                        </div>
                        <!-- withdrawal of nominations start date and time -->
                        <div class="mb-5">
                            <label for="withdrawal-start-date-time" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Withdrawal of Nominations Start Date & Time: </label>
                            <input type="datetime-local" id="withdrawal-start-date-time" name="withdrawal-start-date-time" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required>
                        </div>
                        <!-- withdrawal of nominations end date and time -->
                        <div class="mb-5">
                            <label for="withdrawal-end-date-time" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Withdrawal of Nominations End Date & Time: </label>
                            <input type="datetime-local" id="withdrawal-end-date-time" name="withdrawal-end-date-time" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required>
                        </div>
                        <!-- announcement of final list of candidates date and time -->
                        <div class="mb-5">
                            <label for="final-list-date-time" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Announcement of Final List of Candidates Date & Time: </label>
                            <input type="datetime-local" id="final-list-date-time" name="final-list-date-time" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required>
                        </div>
                        <!-- campaigning start date -->
                        <div class="mb-5">
                            <label for="campaign-start-date" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Campaigning Start Date: </label>
                            <input type="date" id="campaign-start-date" name="campaign-start-date" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required>
                        </div>
                        <!-- campaigning end date -->
                        <div class="mb-5">
                            <label for="campaign-end-date" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Campaigning End Date: </label>
                            <input type="date" id="campaign-end-date" name="campaign-end-date" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required>
                        </div>
                        <!-- last date and time for submission of details of polling and counting agents -->
                        <div class="mb-5">
                            <label for="polling-counting-agents-date-time" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Last Date & Time for Submission of Details of Polling and Counting Agents: </label>
                            <input type="datetime-local" id="polling-counting-agents-date-time" name="polling-counting-agents-date-time" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required>
                        </div>
                        <!-- no campaign date and time -->
                        <div class="mb-5">
                            <label for="no-campaign-date-time" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">No Campaign Date & Time: </label>
                            <input type="datetime-local" id="no-campaign-date-time" name="no-campaign-date-time" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required>
                        </div>
                        <!-- polling date -->
                        <div class="mb-5">
                            <label for="polling-date" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Polling Date: </label>
                            <input type="date" id="polling-date" name="polling-date" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required>
                        </div>
                        <!-- polling start time -->
                        <div class="mb-5">
                            <label for="polling-start-time" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Polling Start Time: </label>
                            <input type="time" id="polling-start-time" name="polling-start-time" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required>
                        </div>
                        <!-- polling end time -->
                        <div class="mb-5">
                            <label for="polling-end-time" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Polling End Time: </label>
                            <input type="time" id="polling-end-time" name="polling-end-time" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required>
                        </div>
                        <!-- results date and time -->
                        <div class="mb-5">
                            <label for="results-date-time" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Results Date & Time: </label>
                            <input type="datetime-local" id="results-date-time" name="results-date-time" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required>
                        </div>
                    </div>
                </div>

                <!-- office bearers -->
                <h2 id="accordion-collapse-heading-2">
                    <button type="button" class="flex items-center justify-between w-full p-5 font-medium rtl:text-right text-gray-500 border border-gray-200 focus:ring-4 focus:ring-gray-200 dark:focus:ring-gray-800 dark:border-gray-700 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-800 gap-3" data-accordion-target="#accordion-collapse-body-2" aria-expanded="false" aria-controls="accordion-collapse-body-2">
                        <span>Office Bearers</span>
                        <svg data-accordion-icon class="w-3 h-3 rotate-180 shrink-0" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 10 6">
                            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5 5 1 1 5"/>
                        </svg>
                    </button>
                </h2>
                <div id="accordion-collapse-body-2" class="hidden" aria-labelledby="accordion-collapse-heading-2">
                    <div class="p-5 border border-b-0 border-gray-200 dark:border-gray-700">
                        <div id="office-bearers-container">
                            <div class="office-bearer-input mb-3">
                                <label for="office-bearers-0" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Select an option</label>
                                <select id="office-bearers-0" name="office-bearers-0" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required>
                                    <option value="" selected disabled>Choose an option</option>
                                    <option value="president">President</option>
                                    <option value="vice-president">Vice President</option>
                                    <option value="general-secretary">General Secretary</option>
                                    <option value="joint-secretary">Joint Secretary</option>
                                    <option value="cultural-secretary">Cultural Secretary</option>
                                    <option value="sports-secretary">Sports Secretary</option>
                                    <option value="other">Other</option>
                                </select>
                                <input type="text" id="other-position-0" name="other-position-0" class="hidden other-input bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder="Enter other position">
                            </div>
                        </div>
                        <button id="add-btn1" class="add-btn bg-blue-500 text-white px-4 py-2 rounded-md ml-2">+</button>
                    </div>
                </div>

                <!-- school board members & councillors -->
                <h2 id="accordion-collapse-heading-3">
                    <button type="button" class="flex items-center justify-between w-full p-5 font-medium rtl:text-right text-gray-500 border border-gray-200 focus:ring-4 focus:ring-gray-200 dark:focus:ring-gray-800 dark:border-gray-700 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-800 gap-3" data-accordion-target="#accordion-collapse-body-3" aria-expanded="false" aria-controls="accordion-collapse-body-3">
                        <span>School Board Members & Councillors</span>
                        <svg data-accordion-icon class="w-3 h-3 rotate-180 shrink-0" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 10 6">
                            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5 5 1 1 5"/>
                        </svg>
                    </button>
                </h2>
                <div id="accordion-collapse-body-3" class="hidden" aria-labelledby="accordion-collapse-heading-3">
                    <div class="p-5 border border-t-0 border-gray-200 dark:border-gray-700">
                        <div id="school-board-members-councillors-container">
                            <div class="school-board-members-councillors-input mb-3">
                                <label for="name-of-school-0" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Select an option</label>
                                <select id="name-of-school-0" name="name-of-school-0" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required>
                                    <option value="" selected disabled>Choose an option</option>
                                    <option value="school-of-life-sciences">School of Life Sciences</option>
                                    <option value="school-of-engineering-science-and-technology">School of Engineering Science and Technology</option>
                                    <option value="school-of-medical-science">School of Medical Science</option>
                                    <option value="school-of-management-studies">School of Management Studies</option>
                                    <option value="school-of-social-science">School of Social Science</option>
                                    <option value="school-of-economics">School of Economics</option>
                                    <option value="school-of-humanities">School of Humanities</option>
                                    <option value="school-of-mathematics-and-statistics">School of Mathematics and Statistics</option>
                                    <option value="school-of-computer-and-information-sciences">School of Computer and Information Sciences</option>
                                    <option value="school-of-physics">School of Physics</option>
                                    <option value="school-of-chemistry">School of Chemistry</option>
                                    <option value="school-of-arts-and-communication">School of Arts and Communication</option>
                                    <option value="college-for-integrated-studies">College for Integrated Studies</option>
                                    <option value="other">Other</option>
                                </select>
                                <input type="text" id="other-school-name-0" name="other-school-name-0" class="hidden other-input bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder="Enter other school">
                                <label for="number-of-school-board-members-0" class="block mt-3 mb-2 text-sm font-medium text-gray-900 dark:text-white">Number of School Board Members: </label>
                                <input type="number" id="number-of-school-board-members-0" name="number-of-school-board-members-0" min="0" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required>
                                <label for="number-of-councillors-0" class="block mt-3 mb-2 text-sm font-medium text-gray-900 dark:text-white">Number of Councillors: </label>
                                <input type="number" id="number-of-councillors-0" name="number-of-councillors-0" min="0" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required>
                            </div>
                        </div>
                        <button id="add-btn2" class="add-btn bg-blue-500 text-white px-4 py-2 rounded-md ml-2">+</button>
                    </div>
                </div>
            </div>

            <div class="flex items-center justify-between mt-5">
                <button type="submit" class="text-white bg-gradient-to-r from-blue-500 via-blue-600 to-blue-700 hover:bg-gradient-to-br font-medium rounded-lg text-sm px-5 py-2.5 text-center me-2 mb-2">Add New Election</button>
            </div>
        </form>
    </div>

    <!-- table to display elections -->
    <div class="relative overflow-x-auto shadow-md sm:rounded-lg m-10">
        <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
            <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                <tr>
                    <th scope="col" class="px-6 py-3">
                        Election Name
                    </th>
                    <th scope="col" class="px-6 py-3">
                        Start Date
                    </th>
                    <th scope="col" class="px-6 py-3">
                        End Date
                    </th>
                    <th scope="col" class="px-6 py-3">
                        Status
                    </th>
                    <th scope="col" class="px-6 py-3">
                        Actions
                    </th>
                </tr>
            </thead>
            <tbody>
                <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600">
                    <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                        Students Union Election - 2024
                    </th>
                    <td class="px-6 py-4">
                        01-11-2024
                    </td>
                    <td class="px-6 py-4">
                        10-11-2024
                    </td>
                    <td class="px-6 py-4">
                        Active
                    </td>
                    <td class="flex items-center px-6 py-4">
                        <a href="#" class="font-medium text-blue-600 dark:text-blue-500 hover:underline">Edit</a>
                        <a href="#" class="font-medium text-red-600 dark:text-red-500 hover:underline ms-3">Remove</a>
                    </td>
                </tr>
            </tbody>
        </table>
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

<!-- Script to hide/show new election form -->
<script>
    let createElectionButton = document.getElementById('createElectionButton');
    let newElectionForm = document.getElementById('newElectionForm');

    createElectionButton.addEventListener('click', function() {
        newElectionForm.classList.toggle('hidden');
    });
</script>

<!-- Script to add new office bearers input -->
<script>
    const container1 = document.getElementById('office-bearers-container');
    const addBtn1 = document.getElementById('add-btn1');

    let officeBearerIndex = 1; // Counter for dynamic field names

    addBtn1.addEventListener('click', function(event) {
        event.preventDefault();
        const newInput = container1.querySelector('.office-bearer-input').cloneNode(true);

        // Set unique names for select and input elements
        const selectElement = newInput.querySelector('select');
        const inputElement = newInput.querySelector('input');

        selectElement.name = `office-bearers-${officeBearerIndex}`;
        inputElement.name = `other-position-${officeBearerIndex}`;

        // Increment index for the next set of fields
        officeBearerIndex++;

        // Clear the selected value
        selectElement.selectedIndex = 0;

        // Append the new input to the container
        container1.appendChild(newInput);
    });
</script>

<!-- Script to show other input field when other is selected in office bearers dropdown -->
<%--<script>
    const container = document.getElementById('office-bearers-container');
    const otherInput = container.querySelector('.other-input');

    container.addEventListener('change', function(event) {
        if (event.target.value === 'other') {
            otherInput.classList.remove('hidden');
        } else {
            otherInput.classList.add('hidden');
        }
    });
</script>--%>

<!-- Script to add new school board members & councillors input -->
<script>
    const container2 = document.getElementById('school-board-members-councillors-container');
    const addBtn2 = document.getElementById('add-btn2');

    let schoolBoardMemberIndex = 1; // Counter for dynamic field names

    addBtn2.addEventListener('click', function(event) {
        event.preventDefault();
        const newInput = container2.querySelector('.school-board-members-councillors-input').cloneNode(true);

        // Set unique names for select and input elements
        const selectElement = newInput.querySelector('select');
        const inputElement = newInput.querySelector('input');
        const inputElement2 = newInput.querySelector('input');
        const inputElement3 = newInput.querySelector('input');

        selectElement.name = `name-of-school-${schoolBoardMemberIndex}`;
        inputElement.name = `number-of-school-board-members-${schoolBoardMemberIndex}`;
        inputElement2.name = `number-of-councillors-${schoolBoardMemberIndex}`;
        inputElement3.name = `other-school-${schoolBoardMemberIndex}`;

        // Increment index for the next set of fields
        schoolBoardMemberIndex++;

        // Clear the selected value
        selectElement.selectedIndex = 0;

        // Append the new input to the container
        container2.appendChild(newInput);
    });
</script>

<!-- Script to show other input field when other is selected in school board members & councillors dropdown -->
<%--<script>
    const container = document.getElementById('school-board-members-councillors-container');
    const otherInput = container.querySelector('.other-input');

    container.addEventListener('change', function(event) {
        if (event.target.value === 'other') {
            otherInput.classList.remove('hidden');
        } else {
            otherInput.classList.add('hidden');
        }
    });
</script>--%>

<!-- Script to toggle between light and dark mode -->
<script>
    let themeToggleDarkIcon = document.getElementById('theme-toggle-dark-icon');
    let themeToggleLightIcon = document.getElementById('theme-toggle-light-icon');

    // Change the icons inside the button based on previous settings
    if (localStorage.getItem('color-theme') === 'dark' || (!('color-theme' in localStorage) && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
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
        if (localStorage.getItem('color-theme')) {
            if (localStorage.getItem('color-theme') === 'light') {
                document.documentElement.classList.add('dark');
                localStorage.setItem('color-theme', 'dark');
            } else {
                document.documentElement.classList.remove('dark');
                localStorage.setItem('color-theme', 'light');
            }

            // if NOT set via local storage previously
        } else {
            if (document.documentElement.classList.contains('dark')) {
                document.documentElement.classList.remove('dark');
                localStorage.setItem('color-theme', 'light');
            } else {
                document.documentElement.classList.add('dark');
                localStorage.setItem('color-theme', 'dark');
            }
        }

    });
</script>

<!-- Flowbite -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.3.0/flowbite.min.js"></script>
</body>
</html>

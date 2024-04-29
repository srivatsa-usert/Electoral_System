<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Header</title>
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

    <%
        String username = "";
        if (session.getAttribute("username") != null) {
            username = (String) session.getAttribute("username");
        }
    %>
</head>

<body>
    <!-- Header -->
    <nav class="bg-white border-gray-200 dark:bg-gray-800">
        <div class="max-w-screen-xl flex flex-wrap items-center justify-between mx-auto p-4">
            <a href="#" class="flex items-center space-x-3 rtl:space-x-reverse">
                <img src="${pageContext.request.contextPath}/Images/UoH_Logo.png" class="w-10 h-10 rounded-full" alt="UoH Logo" />
                <span class="self-center text-2xl font-semibold whitespace-nowrap text-gray-800 dark:text-white">University of Hyderabad</span>
            </a>
            <div class="flex items-center md:order-2 space-x-3 md:space-x-0 rtl:space-x-reverse">
                <button id='loginButton' data-modal-target="authentication-modal" data-modal-toggle="authentication-modal" class="block text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800" type="button">
                    Login
                </button>
                <button type="button" id="user-menu-button" class="hidden flex text-sm bg-gray-800 rounded-full md:me-0 focus:ring-4 focus:ring-gray-300 dark:focus:ring-gray-600" aria-expanded="false" data-dropdown-toggle="user-dropdown" data-dropdown-placement="bottom">
                    <span class="sr-only">Open user menu</span>
                    <img class="w-8 h-8 rounded-full" src="${pageContext.request.contextPath}/Images/Profile_Logo.jpg" alt="user photo">
                </button>
                <!-- Dropdown menu -->
                <div class="z-50 hidden my-4 text-base list-none bg-white divide-y divide-gray-100 rounded-lg shadow dark:bg-gray-700 dark:divide-gray-600" id="user-dropdown">
                    <div class="px-4 py-3">
                        <span class="block text-sm text-gray-900 dark:text-white"><%= username %></span>
                        <%--<span class="block text-sm  text-gray-500 truncate dark:text-gray-400">name@flowbite.com</span>--%>
                    </div>
                    <ul class="py-2" aria-labelledby="user-menu-button">
                        <%--<li>
                            <a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 dark:hover:bg-gray-600 dark:text-gray-200">Dashboard</a>
                        </li>
                        <li>
                            <a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 dark:hover:bg-gray-600 dark:text-gray-200">Settings</a>
                        </li>--%>
                        <li>
                            <a href="changePassword.jsp" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 dark:hover:bg-gray-600 dark:text-gray-200">Change Password</a>
                        </li>
                        <li>
                            <a href="logout" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 dark:hover:bg-gray-600 dark:text-gray-200">Sign out</a>
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
                <ul class="flex flex-col font-medium p-4 md:p-0 mt-4 border border-gray-100 rounded-lg bg-gray-50 md:space-x-8 rtl:space-x-reverse md:flex-row md:mt-0 md:border-0 md:bg-white dark:bg-gray-800 md:dark:bg-gray-800 dark:border-gray-700">
                    <% if (username.startsWith("ec")) { %>
                        <li>
                            <a href="electionChairHome.jsp" aria-current="<%= request.getRequestURI().endsWith("electionChairHome.jsp") ? "page" : "" %>">Home</a>
                        </li>
                        <li>
                            <a href="approveCandidates.jsp" aria-current="<%= request.getRequestURI().endsWith("approveCandidates.jsp") ? "page" : "" %>">Approve Candidate</a>
                        </li>
                        <li>
                            <a href="manageElection.jsp" aria-current="<%= request.getRequestURI().endsWith("manageElection.jsp") ? "page" : "" %>">Manage Election</a>
                        </li>
                        <li>
                            <a href="viewCandidates.jsp" aria-current="<%= request.getRequestURI().endsWith("viewCandidates.jsp") ? "page" : "" %>">View Candidates</a>
                        </li>
                        <%--<li>
                            <a href="delegateWork.jsp" aria-current="<%= request.getRequestURI().endsWith("delegateWork.jsp") ? "page" : "" %>">Delegate Work</a>
                        </li>--%>
                    <% }
                    else if (username.startsWith("dean")) { %>
                        <li>
                            <a href="deanHome.jsp" aria-current="<%= request.getRequestURI().endsWith("deanHome.jsp") ? "page" : "" %>">Home</a>
                        </li>
                        <li>
                            <a href="certifyCandidates.jsp" aria-current="<%= request.getRequestURI().endsWith("certifyCandidates.jsp") ? "page" : "" %>">Certify Candidate</a>
                        </li>
                    <% }
                    else { %>
                        <li>
                            <a href="home.jsp" aria-current="<%= request.getRequestURI().endsWith("home.jsp") ? "page" : "" %>">Home</a>
                        </li>
                        <li>
                            <a href="candidateRegistration.jsp" aria-current="<%= request.getRequestURI().endsWith("candidateRegistration.jsp") ? "page" : "" %>">File Nomination</a>
                        </li>
                        <li>
                            <a href="nominationWithdrawal.jsp" aria-current="<%= request.getRequestURI().endsWith("nominationWithdrawal.jsp") ? "page" : "" %>">Withdraw Nomination</a>
                        </li>
                        <%--<li>
                            <a href="assignAgents.jsp" aria-current="<%= request.getRequestURI().endsWith("assignAgents.jsp") ? "page" : "" %>">Assign Agents</a>
                        </li>--%>
                    <% } %>
                    <%-- old list items --%>
                    <%--<li>
                        <a href="home.jsp" class="block py-2 px-3 text-white bg-blue-700 rounded md:bg-transparent md:text-blue-700 md:p-0 md:dark:text-blue-500" aria-current="page">Home</a>
                    </li>
                    <li>
                        <a href="candidateRegistration.jsp" data-modal-target="authentication-modal" data-modal-toggle="authentication-modal" class="block py-2 px-3 text-gray-900 rounded hover:bg-gray-100 md:hover:bg-transparent md:hover:text-blue-700 md:p-0 dark:text-white md:dark:hover:text-blue-500 dark:hover:bg-gray-700 dark:hover:text-white md:dark:hover:bg-transparent dark:border-gray-700">File Nomination</a>
                    </li>
                    <li>
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
        <hr class="h-1 mx-auto bg-gray-300 border-0 rounded dark:bg-gray-700">
    </nav>

    <!-- Login modal -->
    <div id="authentication-modal" tabindex="-1" aria-hidden="true" class="hidden overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50 justify-center items-center w-full md:inset-0 h-[calc(100%-1rem)] max-h-full">
        <div class="relative p-4 w-full max-w-md max-h-full">
            <!-- Modal content -->
            <div class="relative bg-white rounded-lg shadow dark:bg-gray-700">
                <!-- Modal header -->
                <div class="flex items-center justify-between p-4 md:p-5 border-b rounded-t dark:border-gray-600">
                    <h3 class="text-xl font-semibold text-gray-900 dark:text-white">
                        Sign In
                    </h3>
                    <button type="button" class="end-2.5 text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm w-8 h-8 ms-auto inline-flex justify-center items-center dark:hover:bg-gray-600 dark:hover:text-white" data-modal-hide="authentication-modal">
                        <svg class="w-3 h-3" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 14 14">
                            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6"></path>
                        </svg>
                        <span class="sr-only">Close modal</span>
                    </button>
                </div>
                <!-- Modal body -->
                <div class="p-4 md:p-5">
                    <form class="space-y-4" action="LoginServlet" method="post">
                        <div>
                            <label for="username" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Username</label>
                            <input type="text" name="username" id="username" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white" placeholder="##XXXX##" required />
                        </div>
                        <div>
                            <label for="password" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Password</label>
                            <input type="password" name="password" id="password" placeholder="••••••••" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white" required />
                        </div>
                        <div class="flex justify-between">
                            <%--<div class="flex items-start">
                                <div class="flex items-center h-5">
                                    <input id="remember" type="checkbox" value="" class="w-4 h-4 border border-gray-300 rounded bg-gray-50 focus:ring-3 focus:ring-blue-300 dark:bg-gray-600 dark:border-gray-500 dark:focus:ring-blue-600 dark:ring-offset-gray-800 dark:focus:ring-offset-gray-800"/>
                                </div>
                                <label for="remember" class="ms-2 text-sm font-medium text-gray-900 dark:text-gray-300">Remember me</label>
                            </div>--%>
                            <a href="forgotPassword.jsp" class="text-sm text-blue-700 hover:underline dark:text-blue-500">Forgot Password?</a>
                        </div>
                        <button type="submit" class="w-full text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800">Login to your account</button>
                        <%--<div class="text-sm font-medium text-gray-500 dark:text-gray-300">
                            Not registered? <a href="#" class="text-blue-700 hover:underline dark:text-blue-500">Create account</a>
                        </div>--%>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Script to add classes to anchor tags based on aria-current attribute in specific div in nav -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const navbarUser = document.getElementById('navbar-user');
            const anchorTags = navbarUser.querySelectorAll('a[aria-current="page"]');
            anchorTags.forEach(tag => {
                tag.classList.add('block', 'py-2', 'px-3', 'text-white', 'bg-blue-700', 'rounded', 'md:bg-transparent', 'md:text-blue-700', 'md:p-0', 'md:dark:text-blue-500');
            });

            const otherAnchorTags = navbarUser.querySelectorAll('a:not([aria-current="page"])');
            otherAnchorTags.forEach(tag => {
                tag.classList.add('block', 'py-2', 'px-3', 'text-gray-900', 'rounded', 'hover:bg-gray-100', 'md:hover:bg-transparent', 'md:hover:text-blue-700', 'md:p-0', 'dark:text-white', 'md:dark:hover:text-blue-500', 'dark:hover:bg-gray-700', 'dark:hover:text-white', 'md:dark:hover:bg-transparent', 'dark:border-gray-700');
            });
        });
    </script>

    <!-- Script to toggle the user menu -->
    <script>
        const loginButton = document.getElementById('loginButton');
        const loginModal = document.getElementById('authentication-modal');
        // const fileRegistrationLink = document.querySelector('a[href="candidateRegistration.jsp"]');
        const userMenuButton = document.getElementById('user-menu-button');

        /*fileRegistrationLink.addEventListener('click', (event) => {
            event.preventDefault(); // Prevent default behavior of link
            let username = '<%= session.getAttribute("username") %>';
            // console.log(username);

            if (username && username !== "null" && username !== "NULL") {
                // User is logged in, allow file registration
                window.location.href = "candidateRegistration.jsp";
            } else {
                // User is not logged in, do nothing (the modal will be triggered)
                // loginModal.classList.remove('hidden');
            }
        });*/

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

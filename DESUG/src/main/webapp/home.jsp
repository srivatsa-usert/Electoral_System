<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home Page</title>
    <!-- Tailwind CSS -->
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>

<style>
    /* Style The Dropdown Button */
    .dropbtn {
        cursor: pointer;
    }

    /* The container <div> - needed to position the dropdown content */
    .dropdown {
        position: relative;
        display: inline-block;
    }

    /* Dropdown Content (Hidden by Default) */
    .dropdown-content {
        display: none;
        position: absolute;
        background-color: #f9f9f9;
        min-width: 160px;
        box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
        z-index: 1;
        right: 0;
    }

    /* Links inside the dropdown */
    .dropdown-content a {
        color: black;
        padding: 12px 16px;
        text-decoration: none;
        display: block;
    }

    /* Change color of dropdown links on hover */
    .dropdown-content a:hover {background-color: #f1f1f1}

    /* Show the dropdown menu on hover */
    .dropdown:hover .dropdown-content {
        display: block;
    }

    /* Fill the window */
    html, body {
        height: 100%;
    }

    body {
        display: flex;
        flex-direction: column;
    }

    main {
        flex: 1;
    }

</style>

<body class="bg-black font-sans text-white">

<!-- Navigation -->
<nav class="bg-gray-800 p-6 flex justify-between items-center">
    <div>
        <a href="#" class="text-white font-bold text-xl">Your Logo</a>
        <ul class="flex mt-4">
            <li class="mr-6"><a href="home.jsp" class="text-white hover:text-gray-200">Home</a></li>
            <li class="mr-6"><a href="#" class="text-white hover:text-gray-200">About</a></li>
            <li class="mr-6"><a href="candidateRegistration.jsp" class="text-white hover:text-gray-200">File Nominations</a></li>
            <li class="mr-6"><a href="forYou.jsp" class="text-white hover:text-gray-200">For You</a></li>
        </ul>
    </div>
    <div>
        <button id="loginButton" class="text-white hover:text-gray-200">Login</button>
        <div class="dropdown">
            <button id="otherButton" class="dropbtn hidden ml-4 bg-gray-500 hover:bg-gray-600 text-white font-bold py-2 px-4 rounded"></button>
            <div class="dropdown-content">
                <a href="#">Profile</a>
                <a href="getNotifications">Notifications</a>
                <a href="logout" >Logout</a>
            </div>
        </div>
    </div>
</nav>

<!-- Login Modal -->
<div id="loginModal" class="hidden fixed inset-0 bg-black bg-opacity-50 flex justify-center items-center">
    <div class="bg-gray-800 rounded-lg p-8">
        <h2 class="text-2xl font-bold mb-4">Login</h2>
        <form method="post" action="LoginServlet">
            <div class="mb-4">
                <label for="username" class="block text-white">Username</label>
                <input type="text" id="username" name="username" class="block w-full bg-gray-700 border border-gray-600 rounded-md p-2 text-white" required>
            </div>
            <div class="mb-4">
                <label for="password" class="block text-white">Password</label>
                <input type="password" id="password" name="password" class="block w-full bg-gray-700 border border-gray-600 rounded-md p-2 text-white" required>
            </div>
            <div class="text-right">
                <button type="submit" class="bg-blue-500 hover:bg-blue-600 text-white font-bold py-2 px-4 rounded">Login</button>
            </div>
        </form>
    </div>
</div>

<!-- Main Content -->
<main class="flex-grow max-w-7xl mx-auto px-4 py-12">

    <h1 class="text-4xl font-bold mb-8">Welcome to Our Website</h1>

    <p class="text-lg mb-6">
        Elections to the Students' Union for the year 20XX - 20XX will be conducted as per the details mentioned below:
    </p>
    <p class="text-lg mb-6">
        Elections will take place for the positions of President, Vice-President, General Secretary,
        Joint Secretary', Cultural Secretary, Sports Secretary, Councillors from respective Schools
        and School Board Members.
        While all eligible voters will vote for Office Bearers and the students of respective
        schools will vote for positions of Councillors and School Board Members of
        respective Schools.
    </p>

    <a href="#" class="bg-blue-500 hover:bg-blue-600 text-white font-bold py-2 px-4 rounded">Learn More</a>

</main>

<!-- Footer -->
<footer class="bg-gray-900 text-white py-6">
    <div class="max-w-7xl mx-auto text-center">
        <p>&copy; 2024 Your Company. All rights reserved.</p>
    </div>
</footer>

<script>
    const loginButton = document.getElementById('loginButton');
    const loginModal = document.getElementById('loginModal');
    const fileRegistrationLink = document.querySelector('a[href="candidateRegistration.jsp"]');
    const otherButton = document.getElementById('otherButton');

    loginButton.addEventListener('click', () => {
        loginModal.classList.remove('hidden');
    });

    // Close the modal when clicking outside of it
    window.addEventListener('click', (event) => {
        if (event.target === loginModal) {
            loginModal.classList.add('hidden');
        }
    });

    fileRegistrationLink.addEventListener('click', (event) => {
        event.preventDefault(); // Prevent default behavior of link
        let username = '<%= session.getAttribute("username") %>';
        console.log(username);

        if (username && username !== "null" && username !== "NULL") {
            // User is logged in, allow file registration
            window.location.href = "candidateRegistration.jsp";
        } else {
            // User is not logged in, open login modal
            loginModal.classList.remove('hidden');
        }
    });

    window.addEventListener('load', function() {
        let username = '<%= session.getAttribute("username") %>';
        console.log(username);

        if (username && username !== "null" && username !== "NULL") {
            // User is logged in
            loginButton.classList.add('hidden');
            otherButton.classList.remove('hidden');
            otherButton.innerText = username;
        }
    });
</script>


</body>

</html>

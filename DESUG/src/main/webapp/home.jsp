<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home Page</title>
    <!-- Include Tailwind CSS -->
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>

<body class="bg-black font-sans text-white">

<!-- Navigation -->
<nav class="bg-gray-800 p-6 flex justify-between items-center">
    <div>
        <a href="#" class="text-white font-bold text-xl">Your Logo</a>
        <ul class="flex mt-4">
            <li class="mr-6"><a href="#" class="text-white hover:text-gray-200">Home</a></li>
            <li class="mr-6"><a href="#" class="text-white hover:text-gray-200">About</a></li>
            <li class="mr-6"><a href="candidateRegistration.jsp" class="text-white hover:text-gray-200">File Nominations</a></li>
            <li><a href="#" class="text-white hover:text-gray-200">Contact</a></li>
        </ul>
    </div>
    <div>
        <button id="loginButton" class="text-white hover:text-gray-200">Login</button>
    </div>
</nav>

<!-- Modal -->
<div id="loginModal" class="hidden fixed inset-0 bg-black bg-opacity-50 flex justify-center items-center">
    <div class="bg-gray-800 rounded-lg p-8">
        <h2 class="text-2xl font-bold mb-4">Login</h2>
        <form>
            <div class="mb-4">
                <label for="username" class="block text-white">Username</label>
                <input type="text" id="username" name="username" class="block w-full bg-gray-700 border border-gray-600 rounded-md p-2 text-white">
            </div>
            <div class="mb-4" hidden>
                <label for="password" class="block text-white">Password</label>
                <input type="password" id="password" name="password" class="block w-full bg-gray-700 border border-gray-600 rounded-md p-2 text-white">
            </div>
            <div class="text-right">
                <button type="submit" class="bg-blue-500 hover:bg-blue-600 text-white font-bold py-2 px-4 rounded">Login</button>
            </div>
        </form>
    </div>
</div>

<script>
    const loginButton = document.getElementById('loginButton');
    const loginModal = document.getElementById('loginModal');

    loginButton.addEventListener('click', () => {
        loginModal.classList.remove('hidden');
    });

    // Close the modal when clicking outside of it
    window.addEventListener('click', (event) => {
        if (event.target === loginModal) {
            loginModal.classList.add('hidden');
        }
    });
</script>

<!-- Main Content -->
<div class="max-w-7xl mx-auto px-4 py-12">

    <h1 class="text-4xl font-bold mb-8">Welcome to Our Website</h1>

    <p class="text-lg mb-6">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et mauris nec nisi
        ultricies blandit. Cras euismod dolor ut nisi faucibus lacinia. Donec vestibulum, orci in tempor
        consectetur, nulla enim fermentum odio, ac dictum nisi nulla nec nisi.</p>

    <p class="text-lg mb-6">Nullam eget lectus magna. Sed ac odio vel nisl efficitur auctor. Suspendisse sit amet
        pretium ipsum. Ut consequat libero eget nunc vehicula, non volutpat enim sodales.</p>

    <a href="#" class="bg-blue-500 hover:bg-blue-600 text-white font-bold py-2 px-4 rounded">Learn More</a>

</div>

<!-- Footer -->
<footer class="bg-gray-900 text-white py-6">
    <div class="max-w-7xl mx-auto text-center">
        <p>&copy; 2024 Your Company. All rights reserved.</p>
    </div>
</footer>

</body>

</html>
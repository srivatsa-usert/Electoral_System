<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <!-- Tailwind CSS -->
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 flex justify-center items-center h-screen">
<div class="bg-white p-8 rounded shadow-md w-96">
    <h2 class="text-2xl mb-4">Login</h2>
    <form action="LoginServlet" method="post">
        <label>
            <input type="text" name="username" placeholder="Username" required class="w-full px-4 py-2 mb-4 border border-gray-300 rounded">
        </label>
        <label>
            <input type="password" name="password" placeholder="Password" class="w-full px-4 py-2 mb-4 border border-gray-300 rounded" hidden>
        </label>
        <button type="submit" class="w-full bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600">Login</button>
    </form>
</div>
</body>
</html>

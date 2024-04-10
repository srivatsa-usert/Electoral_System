<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Change Password</title>
</head>

<body class="bg-gray-100">
    <!-- Header -->
    <%@ include file="header.jsp" %>

    <!-- Main Content -->
    <div class="container mx-auto px-4 py-8">
        <h1 class="text-2xl font-bold mb-4">Change Password</h1>
        <form action="changePasswordServlet" method="post">
            <div class="mb-4">
                <label for="currentPassword" class="block text-gray-700 font-bold mb-2">Current Password</label>
                <input type="password" id="currentPassword" name="currentPassword" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" required>
            </div>
            <div class="mb-4">
                <label for="newPassword" class="block text-gray-700 font-bold mb-2">New Password</label>
                <input type="password" id="newPassword" name="newPassword" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" required>
            </div>
            <div class="mb-6">
                <label for="confirmPassword" class="block text-gray-700 font-bold mb-2">Confirm New Password</label>
                <input type="password" id="confirmPassword" name="confirmPassword" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" required>
            </div>
            <div class="flex items-center justify-between">
                <button type="submit" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline">
                    Change Password
                </button>
            </div>
        </form>
    </div>

    <!-- Footer -->
    <%@ include file="footer.jsp" %>
</body>
</html>

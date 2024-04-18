<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password</title>

    <!-- Include jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        $(document).ready(function() {
            $("#getVerification").click(function() {
                let regNumber = $("#registrationNumber").val();
                if (regNumber.trim() === "") {
                    alert("Please enter registration number first.");
                    return;
                }
                // AJAX post request to send mail
                $.ajax({
                    type: "POST",
                    url: "sendForgotMailServlet", // Replace with your servlet URL
                    data: {
                        regNumber: regNumber
                    },
                    success: function(response) {
                        alert("Verification code sent to your registered email. Please check your email for the code. Note: The code expires in 5 minutes.");
                    },
                    error: function(xhr, status, error) {
                        alert("Error: " + xhr.responseText);
                    }
                });
            });

            // Password confirmation check before form submission
            $("form").submit(function(event) {
                let newPassword = $("#newPassword").val();
                let confirmPassword = $("#confirmPassword").val();

                if (newPassword !== confirmPassword) {
                    alert("Passwords do not match. Please make sure your passwords match.");
                    event.preventDefault(); // Prevent form submission
                }
            });
        });
    </script>
</head>

<body class="flex flex-col min-h-screen">
    <!-- Header -->
    <%@ include file="header.jsp" %>

    <!-- Main Content -->
    <div class="flex-grow p-6 bg-white dark:bg-gray-800">
        <h1 class="text-2xl font-semibold mb-4 text-gray-900 dark:text-white">Forgot Password</h1>
        <form action="forgotPasswordServlet" method="post">
            <div class="mb-6">
                <label for="registrationNumber" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Registration Number</label>
                <input type="text" id="registrationNumber" name="registrationNumber" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder="" required>
            </div>
            <div class="mb-6">
                <label for="newPassword" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">New Password</label>
                <input type="password" id="newPassword" name="newPassword" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder="•••••••••" required>
            </div>
            <div class="mb-6">
                <label for="confirmPassword" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Confirm Password</label>
                <input type="password" id="confirmPassword" name="confirmPassword" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder="•••••••••" required>
            </div>
            <div class="mb-6">
                <label for="verificationCode" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Verification Code</label>
                <input type="text" id="verificationCode" name="verificationCode" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder="" required>
                <a href="#" id="getVerification" class="text-blue-500 hover:underline">Get Code</a>
            </div>

            <button type="submit" class="bg-blue-700 text-white rounded-md px-4 py-2 hover:bg-blue-600 dark:bg-blue-500 dark:hover:bg-blue-600">Submit</button>
        </form>
    </div>

    <!-- Footer -->
    <%@ include file="footer.jsp" %>
</body>
</html>

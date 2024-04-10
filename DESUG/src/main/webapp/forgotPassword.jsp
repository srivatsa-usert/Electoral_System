<!DOCTYPE html>
<html lang="en">

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
    <div class="max-w-md mx-auto bg-white rounded p-8 shadow-md">
        <h2 class="text-2xl font-bold mb-4">Forgot Password</h2>
        <form action="forgotPasswordServlet" method="post">
            <div class="mb-4">
                <label for="registrationNumber" class="block">Registration Number:</label>
                <input required type="text" id="registrationNumber" name="registrationNumber" class="form-input mt-1 block w-full">
            </div>

            <div class="mb-4">
                <label for="newPassword" class="block">New Password:</label>
                <input required type="password" id="newPassword" name="newPassword" class="form-input mt-1 block w-full">
            </div>

            <div class="mb-4">
                <label for="confirmPassword" class="block">Confirm Password:</label>
                <input required type="password" id="confirmPassword" name="confirmPassword" class="form-input mt-1 block w-full">
            </div>

            <div class="mb-4">
                <label for="verificationCode" class="block">Verification Code:</label>
                <input required type="text" id="verificationCode" name="verificationCode" class="form-input mt-1 block w-full">
                <a href="#" id="getVerification" class="text-blue-500 hover:underline">Get Code</a>
            </div>

            <button type="submit" class="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600">Submit</button>
        </form>
    </div>

    <!-- Footer -->
    <%@ include file="footer.jsp" %>
</body>
</html>

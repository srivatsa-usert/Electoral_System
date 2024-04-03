<!DOCTYPE html>
<html>
<head>
    <title>Forgot Password</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        $(document).ready(function () {
            $("#getVerification").click(function () {
                var regNumber = $("#registrationNumber").val();
                if (regNumber.trim() === "") {
                    alert("Please enter registration number first.");
                    return;
                }
                // AJAX post request to send mail
                $.ajax({
                    type: "POST",
                    url: "sendForgotMailServlet", // Replace with your servlet URL
                    data: {regNumber: regNumber},
                    success: function (response) {
                        alert("Verification code sent to your registered email. Please check your email for the code. Note: The code expires in 5 minutes.");
                    },
                    error: function (xhr, status, error) {
                        alert("Error: " + xhr.responseText);
                    }
                });
            });

            // Password confirmation check before form submission
            $("form").submit(function(event) {
                var newPassword = $("#newPassword").val();
                var confirmPassword = $("#confirmPassword").val();

                if (newPassword !== confirmPassword) {
                    alert("Passwords do not match. Please make sure your passwords match.");
                    event.preventDefault(); // Prevent form submission
                }
            });
        });
    </script>
</head>
<body>
<h2>Forgot Password</h2>
<form action="forgotPasswordServlet" method="post" >
    <label for="registrationNumber">Registration Number:</label><br>
    <input required type="text" id="registrationNumber" name="registrationNumber"><br><br>

    <label for="newPassword">New Password:</label><br>
    <input required type="password" id="newPassword" name="newPassword"><br><br>

    <label for="confirmPassword">Confirm Password:</label><br>
    <input required type="password" id="confirmPassword" name="confirmPassword"><br><br>

    <label for="verificationCode">Verification Code:</label><br>
    <input required type="text" id="verificationCode" name="verificationCode">
    <a href="#" id="getVerification">Get Code</a><br><br>

    <input type="submit" value="Submit">
</form>
</body>
</html>

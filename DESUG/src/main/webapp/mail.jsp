<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Email Form</title>
</head>
<body>
<h2>Send Email</h2>
<form action="emailServlet" method="post">
    <label for="to">To:</label><br>
    <input type="email" id="to" name="to" required><br>

    <label for="subject">Subject:</label><br>
    <input type="text" id="subject" name="subject" required><br>

    <label for="message">Message:</label><br>
    <textarea id="message" name="message" rows="4" cols="50" required></textarea><br>

    <input type="submit" value="Send Email">
</form>
</body>
</html>

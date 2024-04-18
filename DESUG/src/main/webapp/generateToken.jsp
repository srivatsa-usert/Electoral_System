<%@ page contentType="text/html;charset=UTF-8" %>
<%
    session = request.getSession();

    // Check if session is not null and if username attribute is present
    if (session != null && session.getAttribute("username") != null) {
        // do nothing
    }
    else {
        // Redirect to home page if session is null or username attribute is not present
        response.sendRedirect("home.jsp?loginRequired=true");
    }
%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Generate Token</title>

    <script>
        function generateToken() {
            let xhr = new XMLHttpRequest();
            xhr.open('GET', 'generateToken', true);
            xhr.onreadystatechange = function() {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    if (xhr.status === 200) {
                        let token = xhr.responseText;
                        alert('Your token is: ' + token + '\nCopied to clipboard. Please save it.');
                        let tempTextArea = document.createElement('textarea');
                        tempTextArea.value = token;
                        document.body.appendChild(tempTextArea);
                        tempTextArea.select();
                        document.execCommand('copy');
                        document.body.removeChild(tempTextArea);
                        // Redirect to castVote.jsp after displaying the alert
                        window.location.href = 'castVote.jsp';
                    } else {
                        // Error handling
                        alert('Error generating token');
                    }
                }
            };
            xhr.send();
        }
    </script>
</head>
<body class="flex flex-col min-h-screen">
    <!-- Header -->
    <%@ include file="header.jsp" %>

    <!-- Main Content -->
    <div id="generateTokenDiv" class="flex-grow p-6 bg-white dark:bg-gray-800">
        <h2>Generate Token</h2>
        <button onclick="generateToken()">Generate & Continue</button>
    </div>

    <!-- Footer -->
    <%@ include file="footer.jsp" %>
</body>
</html>

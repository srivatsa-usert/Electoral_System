<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
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
<body>
<div id="generateTokenDiv">
    <h2>Generate Token</h2>
    <button onclick="generateToken()">Generate & Continue</button>
</div>
</body>
</html>

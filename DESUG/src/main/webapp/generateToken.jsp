<%--
  Created by IntelliJ IDEA.
  User: anant
  Date: 17-02-2024
  Time: 19:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Generate Token</title>
</head>
<body>
    <div id="generateTokenDiv">
        <h2>Generate Token</h2>
        <form id="generateTokenForm" name="generateTokenForm">
            <input type="submit" name="generate" value="Generate">
        </form>
    </div>
    <div id="enterTokenDiv">
        <h2>Enter Token</h2>
        <p>Token is sent to your registered university email.</p>
        <form id="enterTokenForm" name="enterTokenForm">
            <label for="token">Enter Token:</label>
            <input type="text" id="token" name="token">
            <br> <br>
            <input type="submit" name="submit" value="Submit">
        </form>
    </div>
</body>
</html>

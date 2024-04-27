<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error Page</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>

<body class="bg-gray-100 flex flex-col justify-center items-center h-screen">
    <% String errorMessage = request.getParameter("error"); %>
    <%
        if (errorMessage != null && errorMessage.equals("already_confirmed")) {
    %>
            <div class="text-red-500 text-9xl mb-8">&#10008;</div>
            <h1 class="text-3xl font-bold mb-4">Error!</h1>
            <p class="text-lg">You have already responded.</p>
    <%
        }
        else if (errorMessage != null && errorMessage.equals("exception")) {
    %>
            <div class="text-red-500 text-9xl mb-8">&#10008;</div>
            <h1 class="text-3xl font-bold mb-4">Error!</h1>
            <p class="text-lg">Your action is unsuccessful. Please try again.</p>
            <p class="text-lg">If problem persists, contact the admin.</p>
    <%
        }
    %>
</body>
</html>

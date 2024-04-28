<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    session = request.getSession();

    // Check if session is not null and if username attribute is present
    if (session != null && session.getAttribute("username") != null) {
        // do nothing
    } else {
        // Redirect to home page if session is null or username attribute is not present
        response.sendRedirect("home.jsp?loginRequired=true");
    }
%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Certify Candidate</title>
    <!-- Include jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>

<body class="flex flex-col min-h-screen">
<!-- Header -->
<%@ include file="header.jsp" %>

<!-- Main Content -->
<div class="flex-grow p-6 bg-white dark:bg-gray-800">
    <!-- table to display elections -->
    <div class="relative overflow-x-auto shadow-md sm:rounded-lg m-10">
        <table id="candidateTable" class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
            <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                <tr>
                    <th scope="col" class="px-6 py-3">
                        Registration Number
                    </th>
                    <th scope="col" class="px-6 py-3">
                        Student Name
                    </th>
                    <th scope="col" class="px-6 py-3">
                        Position
                    </th>
                    <th scope="col" class="px-6 py-3">
                        Actions
                    </th>
                </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
</div>

<!-- Footer -->
<%@ include file="footer.jsp" %>

<script>
    // Function to fetch candidate list using AJAX
    function fetchCandidateList() {
        $.ajax({
            url: "getCandidateList?status=3",
            type: "GET",
            dataType: "json",
            success: function(response) {
                // Clear existing table rows
                $("#candidateTable tbody").empty();

                // Populate table with fetched data
                $.each(response, function(index, candidate) {
                    var row = "<tr>" +
                        "<td class='px-6 py-4'>" + candidate.registrationNumber + "</td>" +
                        "<td class='px-6 py-4'>" + candidate.Name + "</td>" +
                        "<td class='px-6 py-4'>" + candidate.Position + "</td>" +
                        "<td class='px-6 py-4'><a href='certifyCandidateForm.jsp?registrationId=" + candidate.registrationNumber + "' class='font-medium text-blue-600 dark:text-blue-500 hover:underline'>Certify Candidate</a></td>" +
                        "</tr>";
                    $("#candidateTable tbody").append(row);
                });
            },
            error: function(xhr, status, error) {
                console.error("Error fetching candidate list: " + error);
            }
        });
    }

    // Call the function on page load
    $(document).ready(function() {
        fetchCandidateList();
    });
</script>
</body>
</html>

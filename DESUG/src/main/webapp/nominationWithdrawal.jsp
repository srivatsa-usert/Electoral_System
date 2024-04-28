<%@ page contentType="text/html;charset=UTF-8" %>
<%
    session = request.getSession();
    String candidateRegNumber = "";
    String status = "0";

    // Check if session is not null and if username attribute is present
    if (session != null && session.getAttribute("username") != null) {
        // Get the registration number from session attribute "username"
        candidateRegNumber = (String) session.getAttribute("username");
        status = (String) session.getAttribute("status");
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
    <title>Withdraw Nomination</title>
</head>

<script>
    window.addEventListener('DOMContentLoaded', function () {
        fetchCandidateDetails('<%= candidateRegNumber %>');
    });

    function fetchCandidateDetails(candidateRegNumber) {
        // AJAX request to fetch details
        const xhr = new XMLHttpRequest();
        xhr.open("GET", "fetchDetails?registrationNumber=" + candidateRegNumber, true);
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                let response = JSON.parse(xhr.responseText);
                // Populate form fields with candidate details
                document.getElementById("candidateRegistrationNumber").value = "<%= candidateRegNumber %>";
                document.getElementById("candidateName").value = response.name;
                document.getElementById("nameOnBallotPaper").value = response.name;
                document.getElementById("candidatesDepartment").value = response.department;
            }
        };
        xhr.send();
    }

    document.addEventListener("DOMContentLoaded", function() {
        var xhr = new XMLHttpRequest();
        xhr.open("GET", "getCandidateStatus", true);
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) {
                    const response = JSON.parse(xhr.responseText);
                    let status = response.status;
                    // Update CSS classes based on status
                    updateCircleStyles(status);
                } else {
                    console.error("Error occurred while fetching candidate status: " + xhr.status);
                }
            }
        };
        xhr.send();
    });
</script>

<body class="flex flex-col min-h-screen">
    <!-- Header -->
    <%@ include file="header.jsp" %>

    <!-- Main content -->
    <div class="flex-grow p-6 bg-white dark:bg-gray-800">

        <!-- Withdrawal of Nomination Form -->
        <div id="withdrawalFormContainer" class="">
            <h1 class="text-2xl font-bold text-gray-900 dark:text-white">Withdrawal of Nomination</h1>
            <hr class="mb-4">
            <br>
            <form id="withdrawalForm" name="withdrawalForm" method="post" action="submitNomination" >
                <div class="withdrawal_form">
                    <p class="text-base text-gray-900 dark:text-white">I</p>
                    <input id="candidateName" name="candidateName" type="text" class="form-input bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" readonly>
                    <p class="text-base text-gray-900 dark:text-white">(</p>
                    <input id="nameOnBallotPaper" name="nameOnBallotPaper" type="text" class="form-input bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required>
                    <p class="text-base text-gray-900 dark:text-white">), Reg. No.</p>
                    <input id="candidateRegistrationNumber" name="candidateRegistrationNumber" type="text" minlength="8" maxlength="8" class="form-input bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" readonly>
                    <p class="text-base text-gray-900 dark:text-white">, Department / School / College</p>
                    <input id="candidatesDepartment" name="candidatesDepartment" type="text" class="form-input bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" readonly>
                    <p class="text-base text-gray-900 dark:text-white">, do hereby withdraw my nomination voluntarily for the Position of </p>
                    <input id="nameOfThePosition" name="nameOfThePosition" type="text" class="form-input bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" readonly>
                    <br>
                    <div id="semesterCard">
                        <!-- Uploaded Semester Card at the time of nomination will be displayed here -->
                    </div>
                    <button type="submit" class="text-white bg-gradient-to-r from-blue-500 via-blue-600 to-blue-700 hover:bg-gradient-to-br font-medium rounded-lg text-sm px-5 py-2.5 text-center me-2 mb-2">Withdraw</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Footer -->
    <%@ include file="footer.jsp" %>

    <!-- JavaScript for AJAX -->
    <script>
        // Function to check filepath using AJAX
        function checkFilePath(filePathKey, registrationId) {
            let text;
            if (filePathKey === "candidate_file_path") {
                text = "Uploaded Semester Card";
            }

            let xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function() {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    if (xhr.status === 200) {
                        let response = JSON.parse(xhr.responseText);
                        let filepath = response.filepath;
                        if (filepath) {
                            let fileLinksDiv = document.getElementById('semesterCard');
                            let htmlToAdd = '<div class="flex items-center space-x-2 mt-4">' +
                                '<a href="viewFile.jsp?filepath=' + filepath + '" target="_blank" ' +
                                'class="text-base text-blue-700 hover:underline dark:text-blue-500 dark:hover:underline">' + text + '</a>' +
                                '</div><br>';
                            fileLinksDiv.innerHTML += htmlToAdd;
                        } else {
                            console.error('Empty filepath received.');
                        }
                    } else {
                        console.error('Error checking filepath: ' + xhr.status);
                    }
                }
            };
            xhr.open('GET', 'file?registrationId=' + registrationId + '&filePathKey=' + filePathKey, true);
            xhr.send();
        }

        checkFilePath('candidate_file_path', '<%= request.getParameter("registrationId") %>');
    </script>
</body>
</html>

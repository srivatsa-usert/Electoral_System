<%@ page contentType="text/html;charset=UTF-8" %>
<%
    session = request.getSession();
    String candidateRegNumber = "";

    // Check if session is not null and if username attribute is present
    if (session != null && session.getAttribute("username") != null) {
        // Get the registration number from session attribute "username"
        candidateRegNumber = (String) session.getAttribute("username");
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
        xhr.open("GET", "fetchDetails?registrationNumber=" + candidateRegNumber + "&withdrawForm=yes", true);
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                let response = JSON.parse(xhr.responseText);
                // Populate form fields with candidate details
                document.getElementById("candidateRegistrationNumber").textContent = "<%= candidateRegNumber %>";
                document.getElementById("candidateName").textContent = response.name;
                document.getElementById("candidatesDepartment").textContent = response.department;
                document.getElementById("nameOfThePosition").textContent = response.position;
            }
        };
        xhr.send();
    }

    let status = "0";
    document.addEventListener("DOMContentLoaded", function() {
        let xhr = new XMLHttpRequest();
        xhr.open("GET", "getCandidateStatus", true);
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) {
                    const response = JSON.parse(xhr.responseText);
                    status = response.status;
                    // Check if the candidate is approved
                    if (status === "5") {
                        checkFilePath('candidate_file_path', '<%= candidateRegNumber %>');
                        document.getElementById("withdrawalForm").classList.remove("hidden");
                        document.getElementById("message").classList.add("hidden");
                        document.getElementById("nominationWithdrawn").classList.add("hidden");
                    } else if (status === "-1") {
                        document.getElementById("nominationWithdrawn").classList.remove("hidden");
                        document.getElementById("message").classList.add("hidden");
                        document.getElementById("withdrawalForm").classList.add("hidden");
                    } else {
                        document.getElementById("message").classList.remove("hidden");
                        document.getElementById("withdrawalForm").classList.add("hidden");
                        document.getElementById("nominationWithdrawn").classList.add("hidden");
                    }
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
            <form id="withdrawalForm" name="withdrawalForm" method="post" action="submitWithdrawal" class="hidden">
                <div class="flex">
                    <p class="text-base text-gray-900 dark:text-white">I "</p>
                    <p id="candidateName" class="text-base text-gray-900 dark:text-white font-bold"></p>
                    <p class="text-base text-gray-900 dark:text-white">", Reg. No. "</p>
                    <p id="candidateRegistrationNumber" class="text-base text-gray-900 dark:text-white font-bold"></p>
                    <p class="text-base text-gray-900 dark:text-white">", Department/School/College "</p>
                    <p id="candidatesDepartment" class="text-base text-gray-900 dark:text-white font-bold"></p>
                    <p class="text-base text-gray-900 dark:text-white">", do </p>
                </div>
                <br>
                <div class="flex">
                    <p class="text-base text-gray-900 dark:text-white">hereby withdraw my nomination voluntarily for the Position of "</p>
                    <p id="nameOfThePosition" class="text-base text-gray-900 dark:text-white font-bold"></p>
                    <p class="text-base text-gray-900 dark:text-white">" in the Students' Union Election.</p>
                </div>
                <br>
                <div id="semesterCard">
                    <!-- Uploaded Semester Card at the time of nomination will be displayed here -->
                </div>
                <button type="submit" class="text-white bg-gradient-to-r from-blue-500 via-blue-600 to-blue-700 hover:bg-gradient-to-br font-medium rounded-lg text-sm px-5 py-2.5 text-center me-2 mb-2">Withdraw</button>
            </form>
            <div id="message" class="hidden text-gray-900 dark:text-white">
                You are not approved as a candidate. You cannot withdraw your nomination.
            </div>
            <div id="nominationWithdrawn" class="hidden text-gray-900 dark:text-white">
                Your nomination has been withdrawn successfully.
            </div>
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
    </script>
</body>
</html>

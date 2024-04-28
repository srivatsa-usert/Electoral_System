<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <title>Approve Candidate</title>
</head>

<body class="flex flex-col min-h-screen">
    <%@ page import="com.example.desug.FileServlet" %>

    <!-- Header -->
    <%@ include file="header.jsp" %>

    <!-- Main Content -->
    <div class="flex-grow p-6 bg-white dark:bg-gray-800">
        <!-- links to view documents of the candidate -->
        <div id="fileLinks">
            <!-- AJAX responses will be inserted here -->
        </div>

        <!-- checkbox to validate certificate -->
        <div class="flex items-center space-x-2 mt-4">
            <input type="checkbox" id="validateDocuments" class="form-checkbox h-5 w-5 text-blue-600 dark:text-blue-500">
            <label for="validateDocuments" class="text-gray-800 dark:text-white">I hereby certify that the documents are valid.</label>
        </div>

        <!-- disabled submit button -->
        <button disabled id="submitButton" class="px-4 py-2 bg-blue-500 text-white rounded-md hover:bg-blue-600 mt-4">Submit</button>

        <!-- modal to show when submit is clicked -->
        <div id="modal" class="hidden fixed inset-0 z-50 flex items-center justify-center bg-gray-800 bg-opacity-75">
            <div class="dark:bg-gray-900 p-6 rounded-lg shadow-lg w-1/2">
                <form action="approveCandidate" method="post">
                    <h2 class="text-xl font-semibold text-gray-800 dark:text-white">Approve Candidate</h2>
                    <p class="text-gray-800 dark:text-white">Are you sure you want to approve this candidate?</p>
                    <div class="flex justify-end mt-4">
                        <input hidden type="text" id="registrationNumber" name="registrationNumber" value="<%= request.getParameter("registrationId") %>">
                        <button type="submit" id="approveButton" class="px-4 py-2 bg-blue-500 text-white rounded-md hover:bg-blue-600">Approve</button>
                        <%--<button type="submit" id="rejectButton" class="px-4 py-2 bg-red-500 text-white rounded-md hover:bg-red-600 ml-2">Reject</button>--%>
                    </div>
                </form>
            </div>
        </div>

    </div>

    <!-- Footer -->
    <%@ include file="footer.jsp" %>

    <!-- Script for enabling submit button -->
    <script>
        // Get the checkbox and submit button
        let validateDocuments = document.getElementById('validateDocuments');
        let submitButton = document.getElementById('submitButton');

        // Enable submit button when checkbox is checked
        validateDocuments.addEventListener('change', function() {
            if (validateDocuments.checked) {
                submitButton.removeAttribute('disabled');
            } else {
                submitButton.setAttribute('disabled', 'disabled');
            }
        });
    </script>

    <!-- Script for displaying modal -->
    <script>
        // Get the modal and buttons
        let modal = document.getElementById('modal');
        let approveButton = document.getElementById('approveButton');
        let cancelButton = document.getElementById('cancelButton');

        // Show modal when submit button is clicked
        submitButton.addEventListener('click', function() {
            modal.classList.remove('hidden');
        });
    </script>

    <!-- JavaScript for AJAX -->
    <script>
        // Function to check filepaths using AJAX
        function checkFilePath(filePathKey, registrationId) {
            let text;
            if (filePathKey === "candidate_file_path") {
                text = "View Candidate's Semester Card";
            }
            else if (filePathKey === "proposer_file_path") {
                text = "View Proposer's Semester Card";
            }
            else if (filePathKey === "seconder_file_path") {
                text = "View Seconder's Semester Card";
            }
            else if (filePathKey === "dob_proof_file_path") {
                text = "View Candidate's DoB Proof";
            }
            else if (filePathKey === "attendance_file_path") {
                text = "View Candidate's Certificate of Attendance & Academic Record";
            }
            else if (filePathKey === "category_file_path") {
                text = "View Candidate's Category Certificate";
            }

            let xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function() {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    if (xhr.status === 200) {
                        let response = JSON.parse(xhr.responseText);
                        let filepath = response.filepath;
                        if (filepath) {
                            let fileLinksDiv = document.getElementById('fileLinks');
                            let htmlToAdd = '<div class="flex items-center space-x-2 mt-4">' +
                                '<a href="viewFile.jsp?filepath=' + filepath + '" target="_blank" ' +
                                'class="text-blue-700 hover:underline dark:text-blue-500 dark:hover:underline">' + text + '</a>' +
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

        // Call checkFilePath for each filepath
        checkFilePath('candidate_file_path', '<%= request.getParameter("registrationId") %>');
        checkFilePath('proposer_file_path', '<%= request.getParameter("registrationId") %>');
        checkFilePath('seconder_file_path', '<%= request.getParameter("registrationId") %>');
        checkFilePath('dob_proof_file_path', '<%= request.getParameter("registrationId") %>');
        checkFilePath('attendance_file_path', '<%= request.getParameter("registrationId") %>');
        checkFilePath('category_file_path', '<%= request.getParameter("registrationId") %>');
    </script>

</body>
</html>

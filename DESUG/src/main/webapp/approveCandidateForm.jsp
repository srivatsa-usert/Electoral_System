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
    <!-- Header -->
    <%@ include file="header.jsp" %>

    <!-- Main Content -->
    <div class="flex-grow p-6 bg-white dark:bg-gray-800">
        <!-- Form for approval -->
        <form id="approvalForm" action="approveCandidate" method="post">
            <input type="text" readonly hidden id="registrationNumber" name="registrationNumber" value="<%= request.getParameter("registrationId") %>">

            <!-- Table for document links and accept/reject radio buttons -->
            <div class="overflow-x-auto shadow-md sm:rounded-lg">
                <table class="w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400">
                    <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                    <tr>
                        <th scope="col" class="px-8 py-3"> <!-- Adjusted width for the first column -->
                            Document Name
                        </th>
                        <th scope="col" class="px-6 py-3"> <!-- Adjusted width for the second column -->
                            File Link
                        </th>
                        <th scope="col" class="px-8 py-3"> <!-- Adjusted width for the third column -->
                            Accept/Reject
                        </th>

                    </tr>
                    </thead>
                    <tbody id="documentLinks">
                    <!-- AJAX responses will be inserted here -->
                    </tbody>
                </table>
            </div>
            <hr class="h-px my-8 bg-gray-200 border-0 dark:bg-gray-700">

            <!-- Checkbox to validate certificate -->
            <div class="flex items-start mb-5">
                <div class="flex items-center h-5">
                    <input id="validateDocuments" type="checkbox" value="" class="w-4 h-4 border border-gray-300 rounded bg-gray-50 focus:ring-3 focus:ring-blue-300 dark:bg-gray-700 dark:border-gray-600 dark:focus:ring-blue-600 dark:ring-offset-gray-800 dark:focus:ring-offset-gray-800" required />
                </div>
                <label for="validateDocuments" class="ms-2 text-sm font-medium text-gray-900 dark:text-gray-300">I hereby confirm my declaration against each document provided by the Student.</label>
            </div>

            <!-- Comment box -->
            <div class="mt-4">
                <label for="comment" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Comment</label>
                <textarea id="comment" name="comment" rows="4" class="block p-2.5 w-full text-sm text-gray-900 bg-gray-50 rounded-lg border border-gray-300 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder="Write your comments here..."></textarea>
            </div>


            <!-- Submit button -->
            <button type="submit" id="approveButton" class="px-4 py-2 bg-blue-500 text-white rounded-md hover:bg-blue-600 mt-4" disabled>Approve</button>
        </form>
    </div>

    <!-- Footer -->
    <%@ include file="footer.jsp" %>

    <!-- Script for enabling submit button -->
    <script>
        // Get the checkbox and submit button
        let validateDocuments = document.getElementById('validateDocuments');
        let submitButton = document.getElementById('approveButton');

        // Enable submit button when checkbox is checked
        validateDocuments.addEventListener('change', function() {
            if (validateDocuments.checked) {
                submitButton.removeAttribute('disabled');
            } else {
                submitButton.setAttribute('disabled', 'disabled');
            }
        });
    </script>

    <!-- JavaScript for AJAX -->
    <script>
        // Function to check filepaths using AJAX
        function checkFilePath(filePathKey, registrationId) {
            let text;
            if (filePathKey === "candidate_file_path") {
                text = "Candidate's Semester Card";
            }
            else if (filePathKey === "proposer_file_path") {
                text = "Proposer's Semester Card";
            }
            else if (filePathKey === "seconder_file_path") {
                text = "Seconder's Semester Card";
            }
            else if (filePathKey === "dob_proof_file_path") {
                text = "Candidate's DoB Proof";
            }
            else if (filePathKey === "attendance_file_path") {
                text = "Candidate's Certificate of Attendance & Academic Record";
            }
            else if (filePathKey === "category_file_path") {
                text = "Candidate's Category Certificate";
            }

            let xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function() {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    if (xhr.status === 200) {
                        let response = JSON.parse(xhr.responseText);
                        let filepath = response.filepath;
                        if (filepath) {
                            let documentLinksTable = document.getElementById('documentLinks');
                            let newRow = documentLinksTable.insertRow();
                            newRow.className = "bg-white border-b dark:bg-gray-800 dark:border-gray-700"

                            let cell1 = newRow.insertCell(0);
                            let cell2 = newRow.insertCell(1);
                            let cell3 = newRow.insertCell(2);

                            cell1.className = "px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white";
                            cell2.className = "px-6 py-4"; // Apply styling to the second cell
                            cell3.className = "px-6 py-4"; // Apply styling to the third cell

                            cell1.innerHTML = text;
                            cell2.innerHTML = '<a href="viewFile.jsp?filepath=' + filepath + '" target="_blank" class="text-blue-700 hover:underline dark:text-blue-500 dark:hover:underline">' +
                                '<svg class="w-[41px] h-[41px] text-gray-800 dark:text-white hover:text-blue-500" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24">' +
                                '<path stroke="currentColor" stroke-linejoin="round" stroke-width="1.6" d="M10 3v4a1 1 0 0 1-1 1H5m14-4v16a1 1 0 0 1-1 1H6a1 1 0 0 1-1-1V7.914a1 1 0 0 1 .293-.707l3.914-3.914A1 1 0 0 1 9.914 3H18a1 1 0 0 1 1 1Z" class="hover:stroke-blue-500" />' +
                                '</svg>' +
                                '</a>';
                            cell3.innerHTML = '<input type="radio" name="' + filePathKey + 'AcceptReject" value="accept" id="' + filePathKey + 'Accept" required />' +
                                '<label for="' + filePathKey + 'Accept">Accept</label>' +
                                '<span style="margin: 0 8px;"></span>' +
                                '<input type="radio" name="' + filePathKey + 'AcceptReject" value="reject" id="' + filePathKey + 'Reject" required />' +
                                '<label for="' + filePathKey + 'Reject">Reject</label>';
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

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
    <title>Certify Candidate</title>
</head>

<body class="flex flex-col min-h-screen">
    <%@ page import="com.example.desug.FileServlet" %>

    <!-- Header -->
    <%@ include file="header.jsp" %>

    <!-- Main Content -->
    <div class="flex-grow p-6 bg-white dark:bg-gray-800">
        <!-- link to view certificate, if uploaded by the candidate -->
        <div id="fileLinks" class="flex items-center space-x-2 mt-4">
            <!-- AJAX responses will be inserted here -->
            <div id="checkBoxDiv" class="hidden flex items-center space-x-2 mt-4">
                <input type="checkbox" id="validateCertificate" class="form-checkbox h-5 w-5 text-blue-600 dark:text-blue-500">
                <label for="validateCertificate" class="text-gray-800 dark:text-white">I hereby certify that the uploaded certificate is valid.</label>
            </div>;
        </div>
        <br>

        <!-- alert box to show when check box is ticked -->
        <div class="hidden flex bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative" role="alert" id="alertBox">
            <strong class="font-bold">All fields are filled on successful certificate validation.</strong>
            <span class="block sm:inline"> Add comments and change fields, if necessary.</span>
            <br>
        </div>

        <!-- form to certify candidate with attendance and academic record -->
        <h1 class="text-2xl font-semibold mb-4 text-gray-900 dark:text-white">Certify Candidate</h1>
        <form action="certifyCandidate" method="POST" class="space-y-4">
            <div class="flex flex-col">
                <label for="name" class="mb-1 text-gray-800 dark:text-white">Name:</label>
                <input type="text" id="name" name="name" class="border border-gray-300 rounded-md p-2 dark:bg-gray-700 dark:text-gray-200" required readonly>
            </div>
            <div class="flex flex-col">
                <label for="registrationNumber" class="mb-1 text-gray-800 dark:text-white">Registration Number:</label>
                <input type="text" id="registrationNumber" name="registrationNumber" class="border border-gray-300 rounded-md p-2 dark:bg-gray-700 dark:text-gray-200" required readonly>
            </div>
            <div class="flex flex-col">
                <label for="programmeOfStudy" class="mb-1 text-gray-800 dark:text-white">Programme of Study:</label>
                <input type="text" id="programmeOfStudy" name="programmeOfStudy" class="border border-gray-300 rounded-md p-2 dark:bg-gray-700 dark:text-gray-200" required readonly>
            </div>
            <div class="flex flex-col">
                <label for="subject" class="mb-1 text-gray-800 dark:text-white">Subject:</label>
                <input type="text" id="subject" name="subject" class="border border-gray-300 rounded-md p-2 dark:bg-gray-700 dark:text-gray-200" required readonly>
            </div>
            <div class="flex flex-col">
                <label for="semester" class="mb-1 text-gray-800 dark:text-white">Semester:</label>
                <input type="text" id="semester" name="semester" class="border border-gray-300 rounded-md p-2 dark:bg-gray-700 dark:text-gray-200" required readonly>
            </div>

            <!-- Subheading for Integrated/PG & MPhil Students -->
            <div class="pgStudents hidden">
                <div class="mt-6 mb-4">
                    <h2 class="text-lg font-semibold text-gray-800 dark:text-white">FOR INTEGRATED/PG & MPHIL STUDENTS</h2>
                </div>
                <div class="flex flex-col space-y-2">
                    <label class="text-gray-800 dark:text-white">
                        Is she/he a registered student?
                    </label>
                    <div class="flex space-x-4">
                        <label class="text-gray-800 dark:text-white">
                            <input type="radio" name="registeredStudent" value="yes">
                            Yes
                        </label>
                        <label class="text-gray-800 dark:text-white">
                            <input type="radio" name="registeredStudent" value="no">
                            No
                        </label>
                    </div>
                </div>
                <div class="flex flex-col space-y-2">
                    <label class="text-gray-800 dark:text-white">
                        Does the student have 75% attendance in the current semester as on <span class="underline">[date]</span>?
                    </label>
                    <div class="flex space-x-4">
                        <label class="text-gray-800 dark:text-white">
                            <input type="radio" name="attendance" value="yes">
                            Yes
                        </label>
                        <label class="text-gray-800 dark:text-white">
                            <input type="radio" name="attendance" value="no">
                            No
                        </label>
                    </div>
                </div>
                <div class="flex flex-col space-y-2">
                    <label class="text-gray-800 dark:text-white">
                        The student's academic arrears/backlogs are as per the University norms?
                    </label>
                    <div class="flex space-x-4">
                        <label class="text-gray-800 dark:text-white">
                            <input type="radio" name="academicArrears" value="yes">
                            Yes
                        </label>
                        <label class="text-gray-800 dark:text-white">
                            <input type="radio" name="academicArrears" value="no">
                            No
                        </label>
                    </div>
                </div>
            </div>


            <!-- Subheading for Ph.D. Scholars -->
            <div class="phdStudents hidden">
                <div class="mt-6 mb-4">
                    <h2 class="text-lg font-semibold text-gray-800 dark:text-white">FOR Ph.D. SCHOLARS</h2>
                </div>
                <div class="flex flex-col space-y-2">
                    <label class="text-gray-800 dark:text-white">
                        Is she/he a registered student?
                    </label>
                    <div class="flex space-x-4">
                        <label class="text-gray-800 dark:text-white">
                            <input type="radio" name="registeredPhd" value="yes">
                            Yes
                        </label>
                        <label class="text-gray-800 dark:text-white">
                            <input type="radio" name="registeredPhd" value="no">
                            No
                        </label>
                    </div>
                </div>
                <div class="flex flex-col space-y-2">
                    <label class="text-gray-800 dark:text-white">
                        Has the student cleared the course requirements?
                    </label>
                    <div class="flex space-x-4">
                        <label class="text-gray-800 dark:text-white">
                            <input type="radio" name="courseRequirements" value="yes">
                            Yes
                        </label>
                        <label class="text-gray-800 dark:text-white">
                            <input type="radio" name="courseRequirements" value="no">
                            No
                        </label>
                    </div>
                </div>
                <div class="flex flex-col space-y-2">
                    <label class="text-gray-800 dark:text-white">
                        Is the student's research progress satisfactory?
                    </label>
                    <div class="flex space-x-4">
                        <label class="text-gray-800 dark:text-white">
                            <input type="radio" name="researchProgress" value="yes">
                            Yes
                        </label>
                        <label class="text-gray-800 dark:text-white">
                            <input type="radio" name="researchProgress" value="no">
                            No
                        </label>
                    </div>
                </div>
                <div class="flex flex-col space-y-2">
                    <label class="text-gray-800 dark:text-white">
                        Is the latest DRC report attached?
                    </label>
                    <div class="flex space-x-4">
                        <label class="text-gray-800 dark:text-white">
                            <input type="radio" name="DRCReport" value="yes">
                            Yes
                        </label>
                        <label class="text-gray-800 dark:text-white">
                            <input type="radio" name="DRCReport" value="no">
                            No
                        </label>
                    </div>
                </div>
            </div>


            <div class="flex flex-col">
                <label for="comments" class="mb-1 text-gray-800 dark:text-white">Comments if any, HoD/Dean:</label>
                <textarea id="comments" name="comments" rows="4" class="border border-gray-300 rounded-md p-2 dark:bg-gray-700 dark:text-gray-200"></textarea>
            </div>
            <div class="flex flex-col">
                <label for="dateCertification" class="mb-1 text-gray-800 dark:text-white">Date of certification:</label>
                <input type="datetime-local" id="dateCertification" name="dateCertification" class="border border-gray-300 rounded-md p-2 dark:bg-gray-700 dark:text-gray-200" required>
            </div>

            <button type="submit" class="bg-blue-700 text-white rounded-md px-4 py-2 hover:bg-blue-600 dark:bg-blue-500 dark:hover:bg-blue-600">Submit</button>
        </form>
    </div>

    <!-- Footer -->
    <%@ include file="footer.jsp" %>

    <!-- script to show/hide sections based on student type -->
    <script>
        window.addEventListener('DOMContentLoaded', function () {
            fetchCandidateDetails('<%= request.getParameter("registrationId") %>');
        });

        function fetchCandidateDetails(candidateRegNumber) {
            // AJAX request to fetch details
            const xhr = new XMLHttpRequest();
            xhr.open("GET", "fetchDetails?registrationNumber=" + candidateRegNumber, true);
            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    let response = JSON.parse(xhr.responseText);
                    // Populate form fields with candidate details
                    document.getElementById("registrationNumber").value = candidateRegNumber;
                    document.getElementById("name").value = response.name;
                    document.getElementById("programmeOfStudy").value = response.course;
                    document.getElementById("subject").value = response.subject;
                    document.getElementById("semester").value = response.semester;

                    // Remove 'hidden' class based on student type
                    if (response.studentType === "PG") {
                        document.querySelector(".pgStudents").classList.remove("hidden");
                        // Add 'required' attribute to radio buttons in pgStudents section
                        document.querySelectorAll(".pgStudents input[type='radio']").forEach(function(radioButton) {
                            radioButton.setAttribute("required", "required");
                        });
                        // Remove 'required' attribute from radio buttons in phdStudents section
                        document.querySelectorAll(".phdStudents input[type='radio']").forEach(function(radioButton) {
                            radioButton.removeAttribute("required");
                        });
                    } else if (response.studentType === "Research") {
                        document.querySelector(".phdStudents").classList.remove("hidden");
                        // Add 'required' attribute to radio buttons in phdStudents section
                        document.querySelectorAll(".phdStudents input[type='radio']").forEach(function(radioButton) {
                            radioButton.setAttribute("required", "required");
                        });
                        // Remove 'required' attribute from radio buttons in pgStudents section
                        document.querySelectorAll(".pgStudents input[type='radio']").forEach(function(radioButton) {
                            radioButton.removeAttribute("required");
                        });
                    }

                }
            };
            xhr.send();
        }
    </script>

    <!-- script to select 'Yes' in visible radio buttons and fill current datetime in date of certification automatically, when check box is ticked -->
    <script>
        document.getElementById("validateCertificate").addEventListener("change", function() {
            if (this.checked) {
                document.getElementById("dateCertification").value = new Date().toISOString().slice(0, 16);
                document.querySelectorAll("input[type='radio']").forEach(function(radioButton) {
                    if (radioButton.value === "yes") {
                        radioButton.checked = true;
                    }
                });
            }
            else {
                document.getElementById("dateCertification").value = "";
                document.querySelectorAll("input[type='radio']").forEach(function(radioButton) {
                    radioButton.checked = false;
                });
            }
        });
    </script>

    <!-- script to show alert box when check box is ticked -->
    <script>
        document.getElementById("validateCertificate").addEventListener("change", function() {
            if (this.checked) {
                document.getElementById("alertBox").classList.remove("hidden");
            } else {
                document.getElementById("alertBox").classList.add("hidden");
            }
        });
    </script>

    <!-- script to show uploaded certificate link using AJAX -->
    <script>
        // Function to check filepath using AJAX
        function checkFilePath(filePathKey, registrationId) {
            let text;
            if (filePathKey === "attendance_file_path") {
                text = "View Candidate's Certificate of Attendance & Academic Record";
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
                                '</div>';
                            // Insert the new HTML at the start of fileLinksDiv
                            fileLinksDiv.insertAdjacentHTML('afterbegin', htmlToAdd);

                            // Remove the hidden div of checkbox
                            let hiddenDiv = document.getElementById('checkBoxDiv');
                            hiddenDiv.classList.remove('hidden');
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

        checkFilePath('attendance_file_path', '<%= request.getParameter("registrationId") %>');
    </script>

</body>
</html>

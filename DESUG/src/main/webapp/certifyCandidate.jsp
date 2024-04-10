<%--
  Created by IntelliJ IDEA.
  User: anant
  Date: 30-03-2024
  Time: 10:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Certify Candidate</title>
</head>

<body class="flex flex-col min-h-screen">
    <!-- Header -->
    <%@ include file="header.jsp" %>

    <!-- Main Content -->
    <div class="flex-grow p-6 bg-white dark:bg-gray-800">
        <!-- form to certify candidate with attendance and academic record -->
        <h1 class="text-2xl font-semibold mb-4 text-gray-900 dark:text-white">Certify Candidate</h1>
        <form action="processForm.jsp" method="POST" class="space-y-4">
            <div class="flex flex-col">
                <label for="name" class="mb-1 text-gray-800 dark:text-white">Name:</label>
                <input type="text" id="name" name="name" class="border border-gray-300 rounded-md p-2 dark:bg-gray-700 dark:text-gray-200" required>
            </div>
            <div class="flex flex-col">
                <label for="registrationNumber" class="mb-1 text-gray-800 dark:text-white">Registration Number:</label>
                <input type="text" id="registrationNumber" name="registrationNumber" class="border border-gray-300 rounded-md p-2 dark:bg-gray-700 dark:text-gray-200" required>
            </div>
            <div class="flex flex-col">
                <label for="programmeOfStudy" class="mb-1 text-gray-800 dark:text-white">Programme of Study:</label>
                <select id="programmeOfStudy" name="programmeOfStudy" class="border border-gray-300 rounded-md p-2 dark:bg-gray-700 dark:text-gray-200" required>
                    <option value="B.Tech">B.Tech</option>
                    <option value="B.Sc">B.Sc</option>
                    <option value="M.Tech">M.Tech</option>
                    <!-- Add more options as needed -->
                </select>
            </div>
            <div class="flex flex-col">
                <label for="subject" class="mb-1 text-gray-800 dark:text-white">Subject:</label>
                <select id="subject" name="subject" class="border border-gray-300 rounded-md p-2 dark:bg-gray-700 dark:text-gray-200" required>
                    <option value="Mathematics">Mathematics</option>
                    <option value="Physics">Physics</option>
                    <option value="Chemistry">Chemistry</option>
                    <!-- Add more options as needed -->
                </select>
            </div>
            <div class="flex flex-col">
                <label for="semester" class="mb-1 text-gray-800 dark:text-white">Semester:</label>
                <select id="semester" name="semester" class="border border-gray-300 rounded-md p-2 dark:bg-gray-700 dark:text-gray-200" required>
                    <option value="Semester 1">Semester 1</option>
                    <option value="Semester 2">Semester 2</option>
                    <option value="Semester 3">Semester 3</option>
                    <!-- Add more options as needed -->
                </select>
            </div>

            <!-- Subheading for Integrated/PG & MPhil Students -->
            <div class="mt-6 mb-4">
                <h2 class="text-lg font-semibold text-gray-800 dark:text-white">FOR INTEGRATED/PG & MPHIL STUDENTS</h2>
            </div>
            <div class="flex flex-col space-y-2">
                <label class="text-gray-800 dark:text-white">
                    Is she/he a registered student?
                </label>
                <div class="flex space-x-4">
                    <label>
                        <input type="radio" name="registeredStudent" value="yes" required>
                        Yes
                    </label>
                    <label>
                        <input type="radio" name="registeredStudent" value="no" required>
                        No
                    </label>
                </div>
            </div>
            <div class="flex flex-col space-y-2">
                <label class="text-gray-800 dark:text-white">
                    Does the student have 75% attendance in the current semester as on <span class="underline">[date]</span>?
                </label>
                <div class="flex space-x-4">
                    <label>
                        <input type="radio" name="attendance" value="yes" required>
                        Yes
                    </label>
                    <label>
                        <input type="radio" name="attendance" value="no" required>
                        No
                    </label>
                </div>
            </div>
            <div class="flex flex-col space-y-2">
                <label class="text-gray-800 dark:text-white">
                    The student's academic arrears/backlogs are as per the University norms?
                </label>
                <div class="flex space-x-4">
                    <label>
                        <input type="radio" name="academicArrears" value="yes" required>
                        Yes
                    </label>
                    <label>
                        <input type="radio" name="academicArrears" value="no" required>
                        No
                    </label>
                </div>
            </div>

            <!-- Subheading for Ph.D. Scholars -->
            <div class="mt-6 mb-4">
                <h2 class="text-lg font-semibold text-gray-800 dark:text-white">FOR Ph.D. SCHOLARS</h2>
            </div>
            <div class="flex flex-col space-y-2">
                <label class="text-gray-800 dark:text-white">
                    Is she/he a registered student?
                </label>
                <div class="flex space-x-4">
                    <label>
                        <input type="radio" name="registeredPhd" value="yes" required>
                        Yes
                    </label>
                    <label>
                        <input type="radio" name="registeredPhd" value="no" required>
                        No
                    </label>
                </div>
            </div>
            <div class="flex flex-col space-y-2">
                <label class="text-gray-800 dark:text-white">
                    Has the student cleared the course requirements?
                </label>
                <div class="flex space-x-4">
                    <label>
                        <input type="radio" name="courseRequirements" value="yes" required>
                        Yes
                    </label>
                    <label>
                        <input type="radio" name="courseRequirements" value="no" required>
                        No
                    </label>
                </div>
            </div>
            <div class="flex flex-col space-y-2">
                <label class="text-gray-800 dark:text-white">
                    Is the student's research progress satisfactory?
                </label>
                <div class="flex space-x-4">
                    <label>
                        <input type="radio" name="researchProgress" value="yes" required>
                        Yes
                    </label>
                    <label>
                        <input type="radio" name="researchProgress" value="no" required>
                        No
                    </label>
                </div>
            </div>
            <div class="flex flex-col space-y-2">
                <label class="text-gray-800 dark:text-white">
                    Is the latest DRC report attached?
                </label>
                <div class="flex space-x-4">
                    <label>
                        <input type="radio" name="DRCReport" value="yes" required>
                        Yes
                    </label>
                    <label>
                        <input type="radio" name="DRCReport" value="no" required>
                        No
                    </label>
                </div>
            </div>

            <div class="flex flex-col">
                <label for="comments" class="mb-1 text-gray-800 dark:text-white">Comments if any, HoD/Dean:</label>
                <textarea id="comments" name="comments" rows="4" class="border border-gray-300 rounded-md p-2 dark:bg-gray-700 dark:text-gray-200"></textarea>
            </div>
            <div class="flex flex-col">
                <label for="dateCertification" class="mb-1 text-gray-800 dark:text-white">Date of certification:</label>
                <input type="date" id="dateCertification" name="dateCertification" class="border border-gray-300 rounded-md p-2 dark:bg-gray-700 dark:text-gray-200" required>
            </div>

            <button type="submit" class="bg-blue-700 text-white rounded-md px-4 py-2 hover:bg-blue-600 dark:bg-blue-500 dark:hover:bg-blue-600">Submit</button>
        </form>
    </div>

    <!-- Footer -->
    <%@ include file="footer.jsp" %>
</body>
</html>

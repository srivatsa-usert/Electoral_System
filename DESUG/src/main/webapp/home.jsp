<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home Page</title>
    <style>
        #toast-warning {
            position: fixed;
            z-index: 99;
            top: 15%;
            left: 85%;
            transform: translate(-50%, -50%);
        }
    </style>
</head>

<body class="flex flex-col min-h-screen">
    <!-- Header -->
    <%@ include file="header.jsp" %>

    <!-- Main Content -->
    <div class="flex-grow p-6 bg-white dark:bg-gray-800">
        <!-- login required -->
        <%
            if (request.getParameter("loginRequired") != null && request.getParameter("loginRequired").equals("true")) {
        %>
            <div id="toast-warning" class="flex items-center w-full max-w-xs p-4 text-gray-500 bg-white rounded-lg shadow dark:text-gray-400 dark:bg-gray-800" role="alert">
                <div class="inline-flex items-center justify-center flex-shrink-0 w-8 h-8 text-orange-500 bg-orange-100 rounded-lg dark:bg-orange-700 dark:text-orange-200">
                    <svg class="w-5 h-5" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 20 20">
                        <path d="M10 .5a9.5 9.5 0 1 0 9.5 9.5A9.51 9.51 0 0 0 10 .5ZM10 15a1 1 0 1 1 0-2 1 1 0 0 1 0 2Zm1-4a1 1 0 0 1-2 0V6a1 1 0 0 1 2 0v5Z"></path>
                    </svg>
                    <span class="sr-only">Warning icon</span>
                </div>
                <div class="ms-3 text-base font-normal">Please login to continue.</div>
                <button type="button" class="ms-auto -mx-1.5 -my-1.5 bg-white text-gray-400 hover:text-gray-900 rounded-lg focus:ring-2 focus:ring-gray-300 p-1.5 hover:bg-gray-100 inline-flex items-center justify-center h-8 w-8 dark:text-gray-500 dark:hover:text-white dark:bg-gray-800 dark:hover:bg-gray-700" data-dismiss-target="#toast-warning" aria-label="Close">
                    <span class="sr-only">Close</span>
                    <svg class="w-3 h-3" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 14 14">
                        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6"></path>
                    </svg>
                </button>
            </div>
        <%
            }
        %>

        <h1 class="text-4xl font-bold mb-8 text-gray-800 dark:text-white">Welcome to the University Electoral System</h1>

        <div class="flex m-10 space-x-20">
            <div id="default-carousel" class="relative w-full bg-gray-200 dark:bg-gray-600 max-w-screen-md" data-carousel="slide">
                <!-- Carousel wrapper -->
                <div class="relative h-56 overflow-hidden rounded-lg md:h-96 place-items-center">
                    <!-- Item 1 -->
                    <div class="hidden duration-700 ease-in-out mt-12" data-carousel-item>
                        <img src="${pageContext.request.contextPath}/Images/UoH_Entrance.jpg" class="relative block max-h-full w-auto rounded-lg mx-auto" alt="...">
                    </div>
                    <!-- Item 2 -->
                    <div class="hidden duration-700 ease-in-out" data-carousel-item>
                        <img src="${pageContext.request.contextPath}/Images/Desug2.jpg" class="relative block max-h-full w-auto rounded-lg mx-auto" alt="...">
                    </div>
                    <!-- Item 3 -->
                    <div class="hidden duration-700 ease-in-out" data-carousel-item>
                        <img src="${pageContext.request.contextPath}/Images/vote-quote-1.jpg" class="relative block max-h-full w-auto rounded-lg mx-auto" alt="...">
                    </div>
                    <!-- Item 4 -->
                    <div class="hidden duration-700 ease-in-out" data-carousel-item>
                        <img src="${pageContext.request.contextPath}/Images/elections-logo-2024.png" class="relative block max-h-full w-auto rounded-lg mx-auto" alt="...">
                    </div>
                    <!-- Item 5 -->
                    <div class="hidden duration-700 ease-in-out" data-carousel-item>
                        <img src="${pageContext.request.contextPath}/Images/vote-quote-2.jpg" class="relative block max-h-full w-auto rounded-lg mx-auto" alt="...">
                    </div>
                    <!-- Item 6 -->
                    <div class="hidden duration-700 ease-in-out" data-carousel-item>
                        <img src="${pageContext.request.contextPath}/Images/Desug4.jpg" class="relative block max-h-full w-auto rounded-lg mx-auto" alt="...">
                    </div>
                    <!-- Item 7 -->
                    <div class="hidden duration-700 ease-in-out mt-8" data-carousel-item>
                        <img src="${pageContext.request.contextPath}/Images/student-elections-event.jpg" class="relative block max-h-full w-auto rounded-lg mx-auto" alt="...">
                    </div>
                </div>
                <!-- Slider indicators -->
                <div class="absolute z-30 flex -translate-x-1/2 bottom-5 left-1/2 space-x-3 rtl:space-x-reverse">
                    <button type="button" class="w-3 h-3 rounded-full" aria-current="true" aria-label="Slide 1" data-carousel-slide-to="0"></button>
                    <button type="button" class="w-3 h-3 rounded-full" aria-current="false" aria-label="Slide 2" data-carousel-slide-to="1"></button>
                    <button type="button" class="w-3 h-3 rounded-full" aria-current="false" aria-label="Slide 3" data-carousel-slide-to="2"></button>
                    <button type="button" class="w-3 h-3 rounded-full" aria-current="false" aria-label="Slide 4" data-carousel-slide-to="3"></button>
                    <button type="button" class="w-3 h-3 rounded-full" aria-current="false" aria-label="Slide 5" data-carousel-slide-to="4"></button>
                    <button type="button" class="w-3 h-3 rounded-full" aria-current="false" aria-label="Slide 6" data-carousel-slide-to="5"></button>
                    <button type="button" class="w-3 h-3 rounded-full" aria-current="false" aria-label="Slide 7" data-carousel-slide-to="6"></button>
                </div>
                <!-- Slider controls -->
                <button type="button" class="absolute top-0 start-0 z-30 flex items-center justify-center h-full px-4 cursor-pointer group focus:outline-none" data-carousel-prev>
                    <span class="inline-flex items-center justify-center w-10 h-10 rounded-full bg-white/30 dark:bg-gray-800/30 group-hover:bg-white/50 dark:group-hover:bg-gray-800/60 group-focus:ring-4 group-focus:ring-white dark:group-focus:ring-gray-800/70 group-focus:outline-none">
                        <svg class="w-4 h-4 text-white dark:text-gray-800 rtl:rotate-180" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 6 10">
                            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 1 1 5l4 4"></path>
                        </svg>
                        <span class="sr-only">Previous</span>
                    </span>
                </button>
                <button type="button" class="absolute top-0 end-0 z-30 flex items-center justify-center h-full px-4 cursor-pointer group focus:outline-none" data-carousel-next>
                    <span class="inline-flex items-center justify-center w-10 h-10 rounded-full bg-white/30 dark:bg-gray-800/30 group-hover:bg-white/50 dark:group-hover:bg-gray-800/60 group-focus:ring-4 group-focus:ring-white dark:group-focus:ring-gray-800/70 group-focus:outline-none">
                        <svg class="w-4 h-4 text-white dark:text-gray-800 rtl:rotate-180" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 6 10">
                            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m1 9 4-4-4-4"></path>
                        </svg>
                        <span class="sr-only">Next</span>
                    </span>
                </button>
            </div>

            <div class="max-w-screen-md">
                <p class="text-lg mb-6 text-gray-800 dark:text-gray-400">
                    Elections to the Students' Union for the year 20XX - 20XX will be conducted as per the details mentioned below:
                </p>
                <p class="text-lg mb-6 text-gray-800 dark:text-gray-400">
                    Elections will take place for the positions of President, Vice-President, General Secretary,
                    Joint Secretary', Cultural Secretary, Sports Secretary, Councillors from respective Schools
                    and School Board Members.
                    While all eligible voters will vote for Office Bearers and the students of respective
                    schools will vote for positions of Councillors and School Board Members of
                    respective Schools.
                </p>

                <a href="https://uohyd.ac.in/" target="_blank" class="bg-blue-500 hover:bg-blue-600 text-white font-bold py-2 px-4 rounded">Learn More...</a>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <%@ include file="footer.jsp" %>
</body>
</html>

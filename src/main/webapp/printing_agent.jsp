<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="java.util.*" %>
<%@ page import="model.Subject" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Printing Agent Dashboard</title>
    <!-- Favicon-->
    <link rel="icon" type="image/x-icon" href="https://icongr.am/devicon/java-original.svg?size=128&color=currentColor" />
    <!-- Font Awesome icons (free version)-->
    <script src="https://use.fontawesome.com/releases/v5.15.4/js/all.js"
        crossorigin="anonymous"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/material-design-iconic-font/2.2.0/css/material-design-iconic-font.min.css">
        <link rel="stylesheet" href="path/to/material-design-iconic-font/css/material-design-iconic-font.min.css">

    <!-- Google fonts-->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700"
        rel="stylesheet" type="text/css" />
    <link
        href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic"
        rel="stylesheet" type="text/css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  
  <style>
    body {
        font-family: 'Montserrat', sans-serif;
    }
      .dropbtn {
          background-color: #04AA6D;
          color: white;
          padding: 16px;
          font-size: 16px;
          border: none;
        }
        
        .dropdown {
          position: relative;
          display: inline-block;
        }
        
        .dropdown-content {
          display: none;
          position: absolute;
          background-color: #fff;
          min-width: 160px;
          box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
          z-index: 1;
          
        }
        
        .dropdown-content a {
          color: #212529;
          padding: 12px 16px;
          text-decoration: none;
          display: block;
        }
        
        .dropdown-content a:hover {background-color: #ddd;}
        
        .dropdown:hover .dropdown-content {display: block;}
        
        .dropdown:hover .dropbtn {background-color: #3e8e41;}
  </style>
</head>
<body>

	<!-- Navigation-->
	<nav
		class="navbar navbar-expand-lg bg-dark text-uppercase fixed-top"
		id="mainNav">
		<div class="container">
			<a class="navbar-brand text-white fw-bolder" href="/JEE_Project">Printing agent Dashboard</a>
			<button
				class="navbar-toggler text-uppercase font-weight-bold bg-primary text-white rounded"
				type="button" data-bs-toggle="collapse"
				data-bs-target="#navbarResponsive" aria-controls="navbarResponsive"
				aria-expanded="false" aria-label="Toggle navigation">
				Menu <i class="fas fa-bars"></i>
			</button>
			<div class="collapse navbar-collapse" id="navbarResponsive">
				<ul class="navbar-nav ms-auto">
					<li class="nav-item mx-0 mx-lg-1"><a
						class="nav-link text-white py-3 px-0 px-lg-3 rounded" href="#about">About</a></li>
					<li class="nav-item mx-0 mx-lg-1"><a
						class="nav-link text-white py-3 px-0 px-lg-3 rounded" href="#contact">Contact</a></li>
                    <li class="nav-item mx-0 mx-lg-1"><a
                            class="nav-link text-white py-3 px-0 px-lg-3 rounded" href="#about">About</a></li>
					<li class="nav-item mx-0 mx-lg-2"></li>
					<li class="nav-item mx-0 mx-lg-2" style="margin-top: 7.9px;">
						<div class="dropdown">
							<a class="nav-link py-2 fw-semibold px-0 px-lg-3 dropbtn" style="background-color: #fff; color: #1abc9c;" href="">
								<i style="font-size: 20px; margin-bottom: 0;" class="zmdi zmdi-account"></i> &nbsp;
								<%= session.getAttribute("name") %>
							</a>
							<div class="dropdown-content text-dark fw-semibold">
                                <a href="/Projet_JEE/printing_agent">Dashboard</a>
							  <a href="#">Profile</a>
							  <a href="logout" style="color: red;">Logout</a>
							</div>
						</div>
					</li>
				</ul>
			</div>
		</div>
	</nav>
<div style="height: 10vh;"></div>
    <div class="container mt-5">      
        <div class="d-flex justify-content-between border-bottom">
            <h3>Your Print Requests</h3>
        </div>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Subject</th>
                    <th>Teacher</th>
                    <th>Document</th>
                    <th>Number of Prints</th>
                    <th>Date</th>
                    <th>Completed</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="printRequest" items="${printRequests}">
                    <tr>
                        <td>${printRequest.id}</td>
                        <td>${printRequest.subject.subjectName}</td>
                        <td>${printRequest.teacher.name}</td>
                        
                        <td>
                            <form action="${pageContext.request.contextPath}/downloadFile" method="post">
		                        <input type="hidden" name="filePath" value="${printRequest.document}" />
		                        <button type="submit" class="btn btn-link p-0">${printRequest.fileName}</button>
		                    </form>
                        </td>
                        <td>${printRequest.numberOfPrints}</td>
                        <td>${printRequest.date}</td>
                        <td>${printRequest.completed ? "Yes" : "No"}</td>
                        <td>
                            <form action="${pageContext.request.contextPath}/completeTask" method="post">
                                <input type="text" name="requestId" id="" hidden value="${printRequest.id}">
                            	<button type="submit" class="btn btn-success">
	                            	<i class="zmdi zmdi-check me-1"></i>
	                            	Complete
                            	</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <script>
        const manageSubjectsDialog = document.querySelector("#manageSubjects");
        const showButton1 = document.querySelector("#btn1");
        const closeButton1 = document.querySelector("#close1");

        // "Show the dialog" button opens the dialog modally
        showButton1.addEventListener("click", () => {
            manageSubjectsDialog.showModal();
        });

        // "Close" button closes the dialog
        closeButton1.addEventListener("click", () => {
            manageSubjectsDialog.close();
        });

        const addPrintRequestDialog = document.querySelector("#addPrintRequest");
        const showButton2 = document.querySelector("#btn2");
        const closeButton2 = document.querySelector("#close2");

        // "Show the dialog" button opens the dialog modally
        showButton2.addEventListener("click", () => {
            console.log("show dialog");
            addPrintRequestDialog.showModal();
        });

        // "Close" button closes the dialog
        closeButton2.addEventListener("click", () => {
            addPrintRequestDialog.close();
        });


    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>

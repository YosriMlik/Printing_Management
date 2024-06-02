<%@ page import="java.util.*" %>
<%@ page import="model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Admin Panel</title>
    <!-- Favicon-->
    <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
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
			<a class="navbar-brand text-white fw-bolder" href="/JEE_Project">Admin Dashboard</a>
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
						<div class="dropdown fw-semibold">
							<a class="nav-link py-2  px-0 px-lg-3 dropbtn" style="background-color: #fff; color: #1abc9c;" href="">
								<i style="font-size: 20px; margin-bottom: 0;" class="zmdi zmdi-account"></i> &nbsp;
								<%= session.getAttribute("name") %>
							</a>
							<div class="dropdown-content">
							  <a href="#">Profile</a>
							  <a href="/Projet_JEE/admin">Dashboard</a>
							  <a href="logout" style="color: red;">Logout</a>
							</div>
						</div>
					</li>
				</ul>
			</div>
		</div>
	</nav>
<div style="height: 10vh;"></div>
  <!-- Page Content -->
  <div class="container-fluid mt-5">
      <!-- Main Content -->
      <main role="main" class="px-md-4 mt-5">
        <% List<User> AdminsList = (List<User>) request.getAttribute("admins"); %>
            <h2>Admins</h2>
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Status</th>
                            <th>Activation</th>
                            <!-- Add more table headers as needed -->
                        </tr>
                    </thead>
                    <tbody class="table-group-divider">
                    <% if (AdminsList != null){ %>
                        <% if (AdminsList.size() > 0){ %>
                            <% for (User a : AdminsList) { %>
                                <% if (a != null) { %>
                                    <tr>
                                        <th scope="row"><%= a.getId() %></th>
                                        <td><%= a.getName() %></td>
                                        <td><%= a.getEmail() %></td>
                                        <% if (a.isActivated()) { %>
                                        <td class="text-success">Activated</td>
                                        <td>
                                            <button class="btn btn-danger rounded-1" onclick="setUser('d',<%= a.getId() %>, '<%= request.getContextPath() %>')">Disable</button>
                                        </td>
                                        <% } else{ %>
                                        <td class="text-danger">Not activated</td>
                                        <td>
                                            <button class="btn btn-success rounded-1" onclick="setUser('a',<%= a.getId() %>, '<%= request.getContextPath() %>')">Activate</button>
                                        </td>
                                        <% } %>

                                    </tr>
                                <% } %>
                            <% } %>
                        <% } else { %>
                            <tr><th>No Admins available.</th></tr>
                        <% } %>
                    <% } %>
                    </tbody>
                </table>
            </div>

            <% List<User> TeachersList = (List<User>) request.getAttribute("teachers"); %>
            <h2 class="mt-5">Teachers</h2>
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Status</th>
                            <th>Activation</th>
                            <!-- Add more table headers as needed -->
                        </tr>
                    </thead>
                    <tbody class="table-group-divider">
                    <% if (TeachersList != null){ %>
                        <% if (TeachersList.size() > 0){ %>
                            <% for (User t : TeachersList) { %>
                                <% if (t != null) { %>
                                    <tr>
                                        <th scope="row"><%= t.getId() %></th>
                                        <td><%= t.getName() %></td>
                                        <td><%= t.getEmail() %></td>
                                        <% if (t.isActivated()) { %>
                                        <td class="text-success">Activated</td>
                                        <td>
                                            <button class="btn btn-danger rounded-1" onclick="setUser('d',<%= t.getId() %>, '<%= request.getContextPath() %>')">Disable</button>
                                        </td>
                                        <% } else{ %>
                                        <td class="text-danger">Not activated</td>
                                        <td>
                                            <button class="btn btn-success rounded-1" onclick="setUser('a',<%= t.getId() %>, '<%= request.getContextPath() %>')">Activate</button>
                                        </td>
                                        <% } %>

                                    </tr>
                                <% } %>
                            <% } %>
                        <% } else { %>
                            <tr><th>No Teachers available.</th></tr>
                        <% } %>
                    <% } %>
                    </tbody>
                </table>
            </div>


            <% List<User> PrintingAgentsList = (List<User>) request.getAttribute("print_agents"); %>
            <h2 class="mt-5">Printing Agents</h2>
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Status</th>
                            <th>Activation</th>
                            <!-- Add more table headers as needed -->
                        </tr>
                    </thead>
                    <tbody class="table-group-divider">
                    <% if (PrintingAgentsList != null){ %>
                        <% if (PrintingAgentsList.size() > 0){ %>
                            <% for (User pa : PrintingAgentsList) { %>
                                <% if (pa != null) { %>
                                    <tr>
                                        <th scope="row"><%= pa.getId() %></th>
                                        <td><%= pa.getName() %></td>
                                        <td><%= pa.getEmail() %></td>
                                        <% if (pa.isActivated()) { %>
                                        <td class="text-success">Activated</td>
                                        <td>
                                            <button class="btn btn-danger rounded-1" onclick="setUser('d',<%= pa.getId() %>, '<%= request.getContextPath() %>')">Disable</button>
                                        </td>
                                        <% } else{ %>
                                        <td class="text-danger">Not activated</td>
                                        <td>
											<button class="btn btn-success rounded-1" onclick="setUser('a',<%= pa.getId() %>, '<%= request.getContextPath() %>')">Activate</button>
                                        </td>
                                        <% } %>

                                    </tr>
                                <% } %>
                            <% } %>
                        <% } else { %>
                            <tr><th>No Printing Agents available.</th></tr>
                        <% } %>
                    <% } %>
                    </tbody>
                </table>
            </div>

      </main>
  </div>

  <script type="text/javascript">
  	function setUser(act, userId, cp) {
	   
	    var xhr = new XMLHttpRequest();
	    
	    // Configure the request
	    xhr.open('POST', cp+'/changeUser', true);
	    xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
	    
	    // Define the callback function
	    xhr.onreadystatechange = function() {
	        if (xhr.readyState === XMLHttpRequest.DONE) {
	        	if (xhr.status === 200) {
	                // Request completed successfully, perform actions
	                console.log('Request completed successfully');
	                // Reload the page after request is completed
	                window.location.reload();
	            } else {
	                // Request failed, handle error
	                console.error('Request failed with status:', xhr.status);
	            }
	        }
	    };
	    
	    var data = 'userId=' + userId + '&act='+act;
	    console.log(data);
	    // Send the request with user ID and action as data
	    xhr.send(data);
	}

  </script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>

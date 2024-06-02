<!DOCTYPE html>
<html lang="en">
<head>
<title>Sign Up Form by Colorlib</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/material-design-iconic-font/2.2.0/css/material-design-iconic-font.min.css">

<link rel="icon" type="image/x-icon" href="https://icongr.am/devicon/java-original.svg?size=128&color=currentColor" />
<!-- Font Awesome icons (free version)-->
<script src="https://use.fontawesome.com/releases/v5.15.4/js/all.js" crossorigin="anonymous"></script>
<!-- Google fonts-->
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700"	rel="stylesheet" type="text/css" />
<link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css" />
<style type="text/css">
	<%@include file="/css/style.css"%>
</style>

<style>
	select, option{
		width: 100% !important;
	}
	.roles label{
		position: relative;
		margin-bottom: 3px;
	}
	.roles input{
		position: relative;
		display: inline !important;
		width: auto;
		margin-top: 10px;
	}
</style>
</head>
<body>
	<input type="hidden" id="status" value="<%= request.getAttribute("status") %>" />
	<div class="main">

		<!-- Sign up form -->
		<section class="signup">
			<div class="container">
				<div class="signup-content">
					<div class="signup-form">
						<h2 class="form-title">Sign up</h2>
					
						<form method="post" action="${pageContext.request.contextPath}/register" class="register-form"
							id="register-form">
							<div class="form-group">
								<label for="name"><i class="zmdi zmdi-account material-icons-name"></i></label>
								<input required maxlength="50" type="text" name="name" id="name" placeholder="Your Name" />
							</div>
							<div class="form-group">
								<label for="email"><i class="zmdi zmdi-email"></i></label>
								<input required maxlength="30" type="email" name="email" id="email" placeholder="Your Email" />
							</div>
							<div style="position: relative; overflow: hidden;">
								<label for="pass"><i class="zmdi zmdi-lock"></i></label>
								<input required maxlength="30" type="password" name="password" id="password" placeholder="Password" />
							</div>
							<div class="form-group">
								<div class="roles">
									<p for="role" style="color: #6c757d; margin-top: 19px;">Select a role</p>
									<input type="radio" id="teacher" name="role" value="teacher">
									<label for="teacher">Teacher</label><br>
									<input type="radio" id="printing_agent" name="role" value="printing_agent">
									<label for="printing_agent">Printing agent</label>
								</div>
							</div>
							<div class="form-group">
								<input type="checkbox" name="agree-term" id="agree-term"
									class="agree-term" /> <label for="agree-term"
									class="label-agree-term"><span><span></span></span>I
									agree all statements in <a href="#" class="term-service">Terms
										of service</a></label>
							</div>
							<div class="form-group form-button">
								<input type="submit" name="signup" id="signup"
									class="form-submit" value="Register" />
							</div>
						</form>
					</div>
					<div class="signup-image">
						<figure>
							<img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR-7QVDEGMLf9MsF208WRZaK597DEUpFOVsko8x6kyn2nHbzq_B" alt="sing up image">

						</figure>
						<a href="login.jsp" class="signup-image-link">I am already
							member</a>
					</div>
				</div>
			</div>
		</section>


	</div>
	<!-- JS -->
	<script src="js/main.js"></script>
	<script src="js/sweetalert2.all.min.js"></script>
	
	<script>
		let status = document.getElementById("status").value;
		if(status == "success"){
			swal.fire({
				  title: "Success!",
				  text: "You have successfully registered",
				  icon: "success",
				  confirmButtonText: "Login Now!",
				}).then((result) => {
				  if (result.value) {
				    window.location.href = "login.jsp";
				  }
				});
		}else if(status == "failed"){
			swal.fire({
				  title: "Failed!",
				  text: "You have failed to register",
				  icon: "error",
				  button: "Ok",
				  timer: 3000
				}).then((result) => {
				  if (result.value) {
				    window.location.href = "login.jsp";
				  }
				});
		}
	</script>

</body>
</html>
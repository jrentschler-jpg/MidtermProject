<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css"
	integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2"
	crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<meta charset="UTF-8">
<script src='https://kit.fontawesome.com/a076d05399.js'></script>
<script src='https://kit.fontawesome.com/a076d05399.js'></script>
<script src='https://kit.fontawesome.com/a076d05399.js'></script>
<title>Create A New Account</title>
</head>
<body>
<hr>
<!--   <div class ="container">

      <nav class="navbar navbar-expand-lg navbar-light bg-light">
			<a class="navbar-brand" href="homePage.do"style="color:DarkRed"><strong>WineNot</strong> <i class='fas fa-wine-glass' style='font-size:24px'></i></a>
			<img src="https://images.squarespace-cdn.com/content/v1/5cf129c75bf4f50001c8b2f3/1588283318954-X25V1XW9WC42W3F8PHMJ/ke17ZwdGBToddI8pDm48kG0sXzLG2I85QyZp8ZpOahl7gQa3H78H3Y0txjaiv_0fDoOvxcdMmMKkDsyUqMSsMWxHk725yiiHCCLfrh8O1z4YTzHvnKhyp6Da-NYroOW3ZGjoBKy3azqku80C789l0vIHRucUU7a1Vci15HXS8HIyFOUrT9_OnKWFj0z76vvMsMQu7p6EAYImZh1X2UKwEQ/r1.jpg?format=1500w" style="width:200px;height:200px;">
			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>

			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav mr-auto">
					<li class="nav-item active">
						<a class="nav-link" href="homePage.do">Home <i class='fas fa-home'></i><span class="sr-only">(current)</span></a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="createUserForm.do">Log In <i class='fas fa-sign-in-alt'></i></a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="checkout.do?customerOrderId=1#">Order Wine <i class='fas fa-shopping-cart'></i></a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="wineList.do">Wine Cellar <i class='fas fa-wine-glass' style='font-size:18px;color:red'></i></a>
					</li>
					
					<li class="nav-item">
						<a class="nav-link" href="updateUserForm.do?id=1#">Account Profile <i class='fas fa-address-card'></i></a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="favoritesList.do?id=1#">Favorites List <i class='fas fa-list-alt'></i></a>
					</li>
			
				</ul>
			
			</div>
		</nav> -->
<hr>
    <div class ="container">

      <nav class="navbar navbar-expand-lg navbar-light bg-light">
			<a class="navbar-brand" href="homePage.do"style="color:DarkRed"><strong>WineNot</strong> <i class='fas fa-wine-glass' style='font-size:24px'></i></a>
			<img src="https://images.squarespace-cdn.com/content/v1/5cf129c75bf4f50001c8b2f3/1588283318954-X25V1XW9WC42W3F8PHMJ/ke17ZwdGBToddI8pDm48kG0sXzLG2I85QyZp8ZpOahl7gQa3H78H3Y0txjaiv_0fDoOvxcdMmMKkDsyUqMSsMWxHk725yiiHCCLfrh8O1z4YTzHvnKhyp6Da-NYroOW3ZGjoBKy3azqku80C789l0vIHRucUU7a1Vci15HXS8HIyFOUrT9_OnKWFj0z76vvMsMQu7p6EAYImZh1X2UKwEQ/r1.jpg?format=1500w" style="width:200px;height:200px;">
			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>

			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav mr-auto">
					<!-- <li class="nav-item active">
						<a class="nav-link" href="homePage.do">Home <i class='fas fa-home'></i><span class="sr-only">(current)</span></a>
					</li> -->
					<c:if test="${customer == null}">
					<li class="nav-item">
						<a class="nav-link" href="createUserForm.do">Log In <i class='fas fa-sign-in-alt'></i></a>
					</li>
					</c:if>
					<li class="nav-item">
						<a class="nav-link" href="wineList.do">Wine Cellar <i class='fas fa-wine-glass' style='font-size:18px;color:red'></i></a>
					</li>
					<c:if test = "${customer != null}">
					<li class="nav-item">
						<a class="nav-link" href="checkout.do">Order Wine <i class='fas fa-shopping-cart'></i></a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="updateUserForm.do">Account Profile <i class='fas fa-address-card'></i></a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="favoritesList.do">Favorites List <i class='fas fa-list-alt'></i></a>
					</li>
					<c:if test = "${customer.user.role == 'admin'}">
					<li class="nav-item">
						<a class="nav-link" href="admin.do">Administrative Controls<i class='fas fa-list-alt'></i></a>
					</li>
					</c:if>
					<li class="nav-item">
						<a class="nav-link" href="logOutOfAccount.do">Log Out<i class='fas fa-list-alt'></i></a>
					</li>
					</c:if>
			
				</ul>
			
			</div>
		</nav>
		<hr>
		<div class="container">
		<h1>Sign Up</h1>
    <p>Please fill in this form to create an account.</p>
     <hr>
	<form action="createCustomer.do" method=POST>
	<div>
		<form:label path="username">Username: </form:label>
		<input type="text" placeholder="Username" class="form-control" name="username" placeholder="Username" max="45" required/>
	</div>
	<div>
		<form:label path="email">Email: </form:label>
		<input type="email" placeholder="wineNot@winenot.com" class="form-control" name="email" placeholder="Email" max="45" required/>
	</div>
	
	Password: <input name="password" type="password" placeholder="Password" class="form-control validate" id="myInput" max="100" required>
<input type="checkbox" onclick="myFunction()">Show the Password
<script>
function myFunction() {
  var pass = document.getElementById("myInput");
  if (pass.type === "password") {
    pass.type = "text";
  } else {
    pass.type = "password";
  }
}
</script>
	
	<!-- <div class="md-form md-outline">
  <i class="fas fa-key prefix" aria-hidden="true"></i>
  <input type="password" name="password" id="input-password" class="form-control validate" placeholder="Password" max="100"required>
  <label data-error="wrong" data-success="right" for="input-password\">Password</label>
  <span toggle="input-password" type="checkbox"></span>
</div> -->
	
	<!-- <div>
		<form:label path="password">Password: </form:label>
		<i id="pass-status" class="fa fa-eye" aria-hidden="true"></i>
		<input type="password" name="password"  id="inputPassword" class="form-control" placeholder="Password" max="100" required/>
 		<label data-error="wrong" data-success="right" for="inputPassword\">Password</label>
 		<input type="text" onclick="myFunction()">Show Password 
 		<span toggle="#inputPassword" class="fa fa-fw fa-eye field-icon toggle-password"></span>
		
		
	</div> -->
	

			 
  <div class="form-row">
    <div class="form-group col-md-6">
      <label for="inputFName">First Name</label>
      <input type="text" class="form-control" name="firstName" placeholder="FirstName" max="45">
    </div>
    <div class="form-group col-md-6">
      <label for="inputLName">Last Name</label>
      <input type="text" class="form-control" name="lastName" placeholder="LastName" max="45">
    </div>
    <div class="form-group col-md-6">
      <label for="inputBirthdate">Date of Birth</label>
      <input type="date" class="form-control" name="date" placeholder="MM/DD/YYYY">
    </div>
 </div>
    <!-- </div> -->
    
    <!-- <div class="form-group">
    <label for="inputAddress">Address</label>
    <input type="text" class="form-control" name="inputAddress" placeholder="1234 Main St">
  </div>
  <div class="form-group">
    <label for="inputAddress2">Address 2</label>
    <input type="text" class="form-control" name="inputAddress2" placeholder="Apartment, studio, or floor">
  </div>
  <div class="form-row">
    <div class="form-group col-md-6">
      <label for="inputCity">City</label>
      <input type="text" class="form-control" name="inputCity">
    </div>
    <div class="form-group col-md-4">
      <label for="inputState">State</label>
      <select id="inputState" class="form-control">
        <option selected>Choose...</option>
        <option>...</option>
      </select>
    </div>
    <div class="form-group col-md-2">
      <label for="inputZip">Zip</label>
      <input type="text" class="form-control" id="inputZip">
    </div>
    <div class="clearfix">
      <button type="button" class="cancelbtn">Cancel</button>
      <button type="submit" class="signupbtn">Sign Up</button>
    </div> --> 
   <br>
	<button type="submit" class="btn btn-primary">Submit</button>
</form>
    
    
    <!-- <div class="form-group col-md-6">
      <label for="inputEmail">Email</label>
      <input type="email" class="form-control" name="inputEmail">
    </div>
    <div class="form-group col-md-6">
      <label for="inputPassword">Password</label>
      <input type="text" class="form-control" id="inputPassword">
    </div>
 <!--  </div> -->
  
<!-- </form> -->
</div>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css"
	integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<meta charset="UTF-8">
<script src='https://kit.fontawesome.com/a076d05399.js'></script>
<script src='https://kit.fontawesome.com/a076d05399.js'></script>
<script src='https://kit.fontawesome.com/a076d05399.js'></script>
<title>Update Address Information</title>
</head>
<body>
	<hr>
	<div class="container">

		<nav class="navbar navbar-expand-lg navbar-light bg-light">
			<a class="navbar-brand" href="homePage.do" style="color: DarkRed"><strong>WineNot</strong>
				<i class='fas fa-wine-glass' style='font-size: 24px'></i></a> <img
				src="https://images.squarespace-cdn.com/content/v1/5cf129c75bf4f50001c8b2f3/1588283318954-X25V1XW9WC42W3F8PHMJ/ke17ZwdGBToddI8pDm48kG0sXzLG2I85QyZp8ZpOahl7gQa3H78H3Y0txjaiv_0fDoOvxcdMmMKkDsyUqMSsMWxHk725yiiHCCLfrh8O1z4YTzHvnKhyp6Da-NYroOW3ZGjoBKy3azqku80C789l0vIHRucUU7a1Vci15HXS8HIyFOUrT9_OnKWFj0z76vvMsMQu7p6EAYImZh1X2UKwEQ/r1.jpg?format=1500w"
				style="width: 200px; height: 200px;">
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>

			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav mr-auto">
					<li class="nav-item active"><a class="nav-link"
						href="homePage.do">Home <i class='fas fa-home'></i><span
							class="sr-only">(current)</span></a></li>
					<li class="nav-item"><a class="nav-link"
						href="createUserForm.do">Log In <i class='fas fa-sign-in-alt'></i></a>
					</li>
					<li class="nav-item"><a class="nav-link"
						href="checkout.do?customerOrderId=1#">Order Wine <i
							class='fas fa-shopping-cart'></i></a></li>
					<li class="nav-item"><a class="nav-link" href="wineList.do">Wine
							Cellar <i class='fas fa-wine-glass'
							style='font-size: 18px; color: red'></i>
					</a></li>

					<li class="nav-item"><a class="nav-link"
						href="updateUserForm.do?id=1#">Account Profile <i
							class='fas fa-address-card'></i></a></li>
					<li class="nav-item"><a class="nav-link"
						href="favoritesList.do?id=1#">Favorites List <i
							class='fas fa-list-alt'></i></a></li>

				</ul>

			</div>
		</nav>

		<div class="container">

			<p>
				<%-- <tr>Username: <td>${user.username }</td> <form action= "updateUsernameForm.do">
			${user.username }
			<input type= "text" name="username" value="${user.username }"/>
			<button type= "submit">Change Username</button><br>
			</form></tr>
			<tr>Email: <td>${user.email }</td> <form action= "updateEmailForm.do">
			${user.username }
			<input type= "text" name="email" value="${user.email }"/>
			<button type= "submit">Change Email</button><br>
			</form></tr>
			<tr>Password: <td>${user.password }</td> <form action= "updatePasswordForm.do">
			${user.password }
			<input type= "hidden" name="pass" value="${user.password }"/>
			<button type= "submit">Change Password</button>
			</form></tr><br><br> --%>
			<form>
			<table>
			<tr> Street: <td>${address.street }</td> <form action = "updateAddressForm.do"></form>
			${address.street }
			<input type= "text" name="street" value="${address.street}"/>
			<!-- <button type= "submit">Update Street</button><br> -->
			</form></tr>
			 <tr>Street2: <td>${address.street2 }</td> <form action= "updateAddressForm.do">
			${address.street2 }
			<input type= "text" name="email" value="${address.street2 }"/>
			<!-- <button type= "submit">Change Email</button><br> -->
			</form></tr>
			 <tr>City: <td>${address.city }</td> <form action= "updateAddressForm.do">
			${address.city }
			<input type= "text" name="email" value="${address.city }"/>
			<!-- <button type= "submit">Change Email</button><br> -->
			</form></tr>
			 <tr>State: <td>${address.state }</td> <form action= "updateAddressForm.do">
			${address.state }
			<input type= "text" name="email" value="${address.state }"/>
			<!-- <button type= "submit">Change Email</button><br> -->
			</form></tr>
			<tr>Zip Code: <td>${address.zip }</td> <form action= "updateAddressForm.do">
			${address.zip }
			<input type= "hidden" name="pass" value="${address.zip }"/>
			<button type= "submit">Update Address</button>
			</form></tr><br><br>  
			</table>
			</form>

</body>
</html>
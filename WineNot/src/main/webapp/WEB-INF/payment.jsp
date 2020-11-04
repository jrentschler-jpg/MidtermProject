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
<title>Payment Menu</title>
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

<c:choose>
		<c:when test="${! empty payInfo}">
		<ul>
				<li><strong>Card Number: </strong>${payInfo.cardNumber}</li>
				<li><strong>Card Expiration: </strong>${payInfo.exprDate}</li>
				<li><strong>Street: </strong>${payInfo.address.street}</li>
				<li><strong>City: </strong>${payInfo.address.city}</li>
				<li><strong>State: </strong>${payInfo.address.state}</li>
				<li><strong>Zip: </strong>${payInfo.address.zip}</li>
				<li><strong>Country: </strong>${payInfo.address.country}</li>
		</ul>
				
				
			
		</c:when>
		<c:otherwise>
		<p>No payment Info found.</p>
		</c:otherwise>
	</c:choose> 


	<h3>Click to add your payment Information</h3>
	<form action="createPaymentInfo.do" method="POST">
	<div>
		<form:label path="cardNumber">Card Number: </form:label>
		<input type="text" class="form-control" required="required"
				name="cardNumber" placeholder="XXXX-XXXX-XXXX-XXXX" />
	</div>
	<div>
		<form:label path="exprDate">Expiration Date: </form:label>
		<input type="text" class="form-control" required="required"
				name="exprDate" placeholder="YYYY-MM-DD" />
	</div>
	<div>
		<form:label path="street">Street: </form:label>
		<input type="text" class="form-control" required="required"
				name="street" placeholder="Street" />
	</div>
	<div>
		<form:label path="street2">Street 2: </form:label>
		<input type="text" class="form-control"
				name="street2" placeholder="Street 2" />
	</div>
	<div>
		<form:label path="city">City: </form:label>
		<input type="text" class="form-control" required="required"
				name="city" placeholder="City" />
	</div>
	<div>
		<form:label path="state">State: </form:label>
		<input type="text" class="form-control" required="required"
				name="state" placeholder="State" />
	</div>
	<div>
		<form:label path="zip">Zip: </form:label>
		<input type="text" class="form-control" required="required"
				name="zip" placeholder="Zip" />
	</div>
	<div>
		<form:label path="country">Country: </form:label>
		<input type="text" class="form-control" required="required"
				name="country" placeholder="Country" />
	</div>
	

	
			<button type="submit">Submit Card Information</button>
	</form>
	
	
	
	
	<hr>




</body>
</html>
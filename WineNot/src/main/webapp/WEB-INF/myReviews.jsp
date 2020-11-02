<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css"
	integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2"
	crossorigin="anonymous">
<title>Past Reviews</title>
</head>
<body>
	<h1>User Reviews</h1>
	<hr>
	<div class="container">

		<nav class="navbar navbar-expand-lg navbar-light bg-light">
			<a class="navbar-brand" href="#">LOGO HERE</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>

			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav mr-auto">
					<li class="nav-item active"><a href="homePage.do" href="#">Home
							<span class="sr-only">(current)</span>
					</a></li>
					<li class="nav-item"><a href="ContactPage.jsp"> Contact us
					</a></li>
				</ul>
				<form class="form-inline my-2 my-lg-0">
					<input class="form-control mr-sm-2" type="search"
						placeholder="Search" aria-label="Search">
					<button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
				</form>
			</div>
		</nav>
		<div class="text-center">
			<img
				src="https://content.codecademy.com/courses/freelance-1/unit-2/explorer.jpeg" />
			<!-- #Imageid img{
			max-width: 72%;
			max-height: 22%;
			} -->
		</div>
		<hr>
		<h1>Your Reviews:</h1>

		<div class="container-fluid">
			<table>
<<<<<<< HEAD
			<ul>
				<c:forEach items="${reviews}" var="reviews">
					<li>
						${reviews.id } ${reviews.rating } ${reviews.review}
					</li>
=======
				<c:forEach items="${reviews}" var="review">
					<tr>
					<c:choose>
					<c:when test="${review.image != null}">
						<td><img src="${review.image}" alt="${review.wine.labelName}" style="width:50%;height:50%;">
					</c:when>
					<c:otherwise>
						<td>No image uploaded! Link an image from imgur or similar!</td>
					</c:otherwise>
					</c:choose>
						<td><a href="getWine.do?wid=${review.wine.id}">${review.wine.labelName}, ${review.wine.vineyard}, ${review.wine.vintageYear}</a></td>
						<td>${review.rating}</td>
						<td>${review.review}</td>
						<td>
						<form action = "updateReviewReview.do">
						<input type="hidden" name="custId" value="${review.id.customerId}"/>
						<input type="hidden" name="wineId" value="${review.id.wineId}"/>
						<input type="text" name ="reviewUpdate">
						<button type="submit">Update Review Content</button>
						</form>
						<form action = "updateReviewRating.do">
						<input type="hidden" name="custId" value="${review.id.customerId}"/>
						<input type="hidden" name="wineId" value="${review.id.wineId}"/>
						<input type="number" name ="rating">
						<button type="submit">Update Review Rating</button>
						</form>
						<form action = "updateReviewImage.do">
						<input type="hidden" name="custId" value="${review.id.customerId}"/>
						<input type="hidden" name="wineId" value="${review.id.wineId}"/>
						<input type="text" name ="image">
						<button type="submit">Update Review Image</button>
						</form>
						</td>
						<td><form action="removeReview.do">
						<input type="hidden" name="custId" value="${review.id.customerId}"/>
						<input type="hidden" name="wineId" value="${review.id.wineId}"/>
						<button type="submit">Delete Review</button>
						</form>
						</td>
					</tr>
>>>>>>> 074812c19600c50c99bc56025edfdd326aff308f
				</c:forEach>
			</table>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
		integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
		integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js"
		integrity="sha384-w1Q4orYjBQndcko6MimVbzY0tgp4pWB4lZ7lr30WKz0vr/aWKhXdBNmNb5D92v7s"
		crossorigin="anonymous"></script>
</body>
</html>
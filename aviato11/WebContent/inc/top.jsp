<%@page import="MemberAction.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<html lang="utf-8">
<head>

  <!-- Basic Page Needs
  ================================================== -->
  <meta charset="utf-8">
  <title>Aviato | E-commerce template</title>

  <!-- Mobile Specific Metas
  ================================================== -->
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="description" content="Construction Html5 Template">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=5.0">
  <meta name="author" content="Themefisher">
  <meta name="generator" content="Themefisher Constra HTML Template v1.0">
  
  <!-- Favicon -->
  <link rel="shortcut icon" type="image/x-icon" href="${contextPath}/images/favicon.png"/>
  
  <!-- Themefisher Icon font -->
  <link rel="stylesheet" href="${contextPath}/plugins/themefisher-font/style.css">
  <!-- bootstrap.min css -->
  <link rel="stylesheet" href="${contextPath}/plugins/bootstrap/css/bootstrap.min.css">
  
  <!-- Animate css -->
  <link rel="stylesheet" href="${contextPath}/plugins/animate/animate.css">
  <!-- Slick Carousel -->
  <link rel="stylesheet" href="${contextPath}/plugins/slick/slick.css">
  <link rel="stylesheet" href="${contextPath}/plugins/slick/slick-theme.css">
  
  <!-- Main Stylesheet -->
  <link rel="stylesheet" href="${contextPath}/css/style.css">

	
</head>

<body id="body">

<!-- Start Top Header Bar -->
<section class="top-header">
	<div class="container">
		<div class="row">
		
		<c:choose>
			<c:when test="${email eq null}">
				<div class="col-md-4 col-xs-12 col-sm-4">
				</div>
			</c:when>
			<c:otherwise>
				<div class="col-md-4 col-xs-12 col-sm-4">
				<p>${name}님 반갑습니다!</p>
				</div>
			</c:otherwise>
		</c:choose>
			<div class="col-md-4 col-xs-12 col-sm-4">
				<!-- Site Logo -->
				<div class="logo text-center">
					<a href="${contextPath}/index.jsp">
						<!-- replace logo here -->
						<svg width="135px" height="29px" viewBox="0 0 155 29" version="1.1" xmlns="http://www.w3.org/2000/svg"
							xmlns:xlink="http://www.w3.org/1999/xlink">
							<g id="Page-1" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd" font-size="40"
								font-family="AustinBold, Austin" font-weight="bold">
								<g id="Group" transform="translate(-108.000000, -297.000000)" fill="#000000">
									<text id="AVIATO">
										<tspan x="108.94" y="325">AVIATO</tspan>
									</text>
								</g>
							</g>
						</svg>
					</a>
				</div>
			</div>
			<div class="col-md-4 col-xs-12 col-sm-4">
				<!-- login -->
				<c:choose>
					<c:when test="${name eq null}">
						<ul class="top-menu text-center list-inline">
							<a href="${contextPath}/member/prevlogin.do">login</a> | <a href="${contextPath}/member/prevsignin.do">signin</a>
	            		</ul>
					</c:when>
					<c:otherwise>
					<ul class="top-menu text-center list-inline">
						<a href="${contextPath}/member/logout.do">logout</a> | <a href="${contextPath}/member/search.do">myinfo</a>
	            	</ul>
	            	</c:otherwise>
	            </c:choose>
            	
				<!-- Cart -->
					<ul class="top-menu text-right list-inline">
					<li class="dropdown cart-nav dropdown-slide">
						<a href="#!" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown"><i
								class="tf-ion-android-cart"></i>Cart</a>
						<div class="dropdown-menu cart-dropdown">
							<!-- Cart Item -->
							<div class="media">
								<a class="pull-left" href="#!">
									<img class="media-object" src="${contextPath}/images/shop/cart/cart-1.jpg" alt="image" />
								</a>
								<div class="media-body">
									<h4 class="media-heading"><a href="#!">Ladies Bag</a></h4>
									<div class="cart-price">
										<span>1 x</span>
										<span>1250.00</span>
									</div>
									<h5><strong>$1200</strong></h5>
								</div>
								<a href="#!" class="remove"><i class="tf-ion-close"></i></a>
							</div><!-- / Cart Item -->
							<!-- Cart Item -->
							<div class="media">
								<a class="pull-left" href="#!">
									<img class="media-object" src="${contextPath}/images/shop/cart/cart-2.jpg" alt="image" />
								</a>
								<div class="media-body">
									<h4 class="media-heading"><a href="#!">Ladies Bag</a></h4>
									<div class="cart-price">
										<span>1 x</span>
										<span>1250.00</span>
									</div>
									<h5><strong>$1200</strong></h5>
								</div>
								<a href="#!" class="remove"><i class="tf-ion-close"></i></a>
							</div><!-- / Cart Item -->

							<div class="cart-summary">
								<span>Total</span>
								<span class="total-price">$1799.00</span>
							</div>
							<ul class="text-center cart-buttons">
								<li><a href="${contextPath}/cart.jsp" class="btn btn-small">View Cart</a></li>
								<li><a href="${contextPath}/checkout.jsp" class="btn btn-small btn-solid-border">Checkout</a></li>
							</ul>
						</div>

					</li><!-- / Cart -->

				

					<!-- Languages -->
					<li class="commonSelect">
						<select class="form-control">
							<option>EN</option>
							<option>DE</option>
							<option>FR</option>
							<option>ES</option>
						</select>
					</li><!-- / Languages -->

				</ul><!-- / .nav .navbar-nav .navbar-right -->
			</div>
		</div>
	</div>
</section><!-- End Top Header Bar -->


<!-- Main Menu Section -->
<section class="menu">
	<nav class="navbar navigation">
		<div class="container">
			<div class="navbar-header">
				<h2 class="menu-title">Main Menu</h2>
				<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar"
					aria-expanded="false" aria-controls="navbar">
					<span class="sr-only">Toggle navigation</span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>

			</div><!-- / .navbar-header -->

			<!-- Navbar Links -->
			<div id="navbar" class="navbar-collapse collapse text-center">
				<ul class="nav navbar-nav">

					<!-- Home -->
					<li class="dropdown ">
						<a href="${contextPath}/index.jsp">Home</a>
					</li><!-- / Home -->


					<!-- Elements -->
					<li class="dropdown dropdown-slide">
						<a href="${contextPath}/shop/SelectCategory.do?option=all" class="dropdown-toggle" 
							role="button" aria-haspopup="true" aria-expanded="false">Shop <span
								class="tf-ion-ios-arrow-down"></span></a>
						
					</li><!-- / Elements -->


					<!-- Pages -->
					<li class="dropdown full-width dropdown-slide">
						<a href="#!" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="350"
							role="button" aria-haspopup="true" aria-expanded="false">Pages <span
								class="tf-ion-ios-arrow-down"></span></a>
						<div class="dropdown-menu">
							<div class="row">

								<!-- Introduction -->
								<div class="col-sm-3 col-xs-12">
									<ul>
										<li class="dropdown-header">Introduction</li>
										<li role="separator" class="divider"></li>
										<li><a href="${contextPath}/mailSend/contact.jsp">Contact Us</a></li>
										<li><a href="${contextPath}/about.jsp">About Us</a></li>
										<li><a href="${contextPath}/404.jsp">404 Page</a></li>
										<li><a href="${contextPath}/coming-soon.jsp">Coming Soon</a></li>
										<li><a href="${contextPath}/faq.jsp">FAQ</a></li>
									</ul>
								</div>

								<!-- Contact -->
								<div class="col-sm-3 col-xs-12">
									<ul>
										<li class="dropdown-header">Dashboard</li>
										<li role="separator" class="divider"></li>
										<li><a href="${contextPath}/dashboard.jsp">User Interface</a></li>
										<li><a href="${contextPath}/order.jsp">Orders</a></li>
										<li><a href="${contextPath}/address.jsp">Address</a></li>
										<li><a href="${contextPath}/profile-details.jsp">Profile Details</a></li>
									</ul>
								</div>

								<!-- Utility -->
								<div class="col-sm-3 col-xs-12">
									<ul>
										<li class="dropdown-header">Utility</li>
										<li role="separator" class="divider"></li>
										<li><a href="${contextPath}/forget-password.jsp">Forget Password</a></li>
									</ul>
								</div>

								<!-- Mega Menu -->
								<div class="col-sm-3 col-xs-12">
									<a href="${contextPath}/shop.jsp">
										<img class="img-responsive" src="${contextPath}/images/shop/header-img.jpg" alt="menu image" />
									</a>
								</div>
							</div><!-- / .row -->
						</div><!-- / .dropdown-menu -->
					</li><!-- / Pages -->



					<!-- Blog -->
					<li class="dropdown dropdown-slide">
						<a href="#!" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="350"
							role="button" aria-haspopup="true" aria-expanded="false">Blog <span
								class="tf-ion-ios-arrow-down"></span></a>
						<ul class="dropdown-menu">
							<li><a href="${contextPath}/blog-left-sidebar.jsp">Blog Left Sidebar</a></li>
							<li><a href="${contextPath}/blog-right-sidebar.jsp">Blog Right Sidebar</a></li>
							<li><a href="${contextPath}/blog-full-width.jsp">Blog Full Width</a></li>
							<li><a href="${contextPath}/blog-grid.jsp">Blog 2 Columns</a></li>
							<li><a href="${contextPath}/blog-single.jsp">Blog Single</a></li>
						</ul>
					</li><!-- / Blog -->

					<!-- Shop -->
					<li class="dropdown dropdown-slide">
						<a href="#!" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="350"
							role="button" aria-haspopup="true" aria-expanded="false">Elements <span
								class="tf-ion-ios-arrow-down"></span></a>
						<ul class="dropdown-menu">
							<li><a href="${contextPath}/typography.jsp">Typography</a></li>
							<li><a href="${contextPath}/buttons.jsp">Buttons</a></li>
							<li><a href="${contextPath}/alerts.jsp">Alerts</a></li>
						</ul>
					</li><!-- / Blog -->
				</ul><!-- / .nav .navbar-nav -->

			</div>
			<!--/.navbar-collapse -->
		</div><!-- / .container -->
	</nav>
</section>


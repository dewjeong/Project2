<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<jsp:include page="./inc/top.jsp"></jsp:include>

<section class="page-header">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="content">
					<h1 class="page-name">Dashboard</h1>
					<ol class="breadcrumb">
						<li><a href="index.jsp">Home</a></li>
						<li class="active">my account</li>
					</ol>
				</div>
			</div>
		</div>
	</div>
</section>


<section class="user-dashboard page-wrapper">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<ul class="list-inline dashboard-menu text-center">
					<li><a class="active" href="dashboard.jsp">Dashboard</a></li>
					<li><a href="order.jsp">Orders</a></li>
					<li><a href="address.jsp">Address</a></li>
					<li><a href="profile-details.jsp">Profile Details</a></li>
				</ul>
				<div class="dashboard-wrapper user-dashboard">
					<div class="media">
						<div class="pull-left">
							<img class="media-object user-img" src="images/avater.jpg" alt="Image">
						</div>
						<div class="media-body">
							<h2 class="media-heading">Welcome Adam Smith</h2>
							<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Unde, iure, est. Sit mollitia est maxime! Eos
								cupiditate tempore, tempora omnis. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Enim, nihil. </p>
						</div>
					</div>
					<div class="total-order mt-20">
						<h4>Total Orders</h4>
						<div class="table-responsive">
							<table class="table">
								<thead>
									<tr>
										<th>Order ID</th>
										<th>Date</th>
										<th>Items</th>
										<th>Total Price</th>
										<th></th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td><a href="#!">#252125</a></td>
										<td>Mar 25, 2016</td>
										<td>2</td>
										<td>$ 99.00</td>
									</tr>
									<tr>
										<td><a href="#!">#252125</a></td>
										<td>Mar 25, 2016</td>
										<td>2</td>
										<td>$ 99.00</td>
									</tr>
									<tr>
										<td><a href="#!">#252125</a></td>
										<td>Mar 25, 2016</td>
										<td>2</td>
										<td>$ 99.00</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>



<jsp:include page="./inc/bottom.jsp"></jsp:include>

    <!-- 
    Essential Scripts
    =====================================-->
    
    <!-- Main jQuery -->
    <script src="plugins/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap 3.1 -->
    <script src="plugins/bootstrap/js/bootstrap.min.js"></script>
    <!-- Bootstrap Touchpin -->
    <script src="plugins/bootstrap-touchspin/dist/jquery.bootstrap-touchspin.min.js"></script>
    <!-- Instagram Feed Js -->
    <script src="plugins/instafeed/instafeed.min.js"></script>
    <!-- Video Lightbox Plugin -->
    <script src="plugins/ekko-lightbox/dist/ekko-lightbox.min.js"></script>
    <!-- Count Down Js -->
    <script src="plugins/syo-timer/build/jquery.syotimer.min.js"></script>

    <!-- slick Carousel -->
    <script src="plugins/slick/slick.min.js"></script>
    <script src="plugins/slick/slick-animation.min.js"></script>

    <!-- Google Mapl -->
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCC72vZw-6tGqFyRhhg5CkF2fqfILn2Tsw"></script>
    <script type="text/javascript" src="plugins/google-map/gmap.js"></script>

    <!-- Main Js File -->
    <script src="js/script.js"></script>
    


  </body>
  </html>
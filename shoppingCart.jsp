<%@ page import="dao.UserDao"%>
<%@ page import="dao.CartDao"%>
<%@ page import="java.util.List"%>
<%@ page import="bean.CartBean"%>
<%@ page import="java.math.BigDecimal"%>

<%
// Ensure user is logged in
String email = (String) session.getAttribute("email");
if (email == null) {
	response.sendRedirect("log.jsp");
	return;
}

// Fetch user ID using email
UserDao userDao = new UserDao();
int userId = userDao.getUserIdByEmail(email);
// out.print(userId);
if (userId == 0) {
	out.println("<script>alert('Error: User not found. Please log in again.'); window.location='log.jsp';</script>");
	return;
}

// Fetch cart items for the user using CartDao
CartDao cartDao = new CartDao();
List<CartBean> cartItems = cartDao.getCartItemsByUserId(userId); // This is the correct method to fetch cart items

// Calculate cart summary
double subtotal = 0.0;
double taxRate = 0.10; // 10% tax
double shipping = 50.0; // Flat shipping rate
for (CartBean item : cartItems) {
	subtotal += item.getPrice();
}
double tax = subtotal * taxRate;
double totalPrice = subtotal + tax + shipping;
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Shopping Cart</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
footer {
	background-color: #f8f9fa;
	padding: 1rem 0;
	text-align: center;
}

.navbar .nav-item {
	padding-right: 20px;
}

.cart-table td, .cart-table th {
	vertical-align: middle;
}

.cart-table .product-img {
	width: 120px;
	height: auto;
}

.cart-summary {
	border-left: 2px solid #f1f1f1;
	padding-left: 20px;
}

.summary-item {
	display: flex;
	justify-content: space-between;
	margin-bottom: 10px;
}

.summary-item h5 {
	margin-bottom: 0;
}

.checkout-btn {
	background-color: #f8f9fa;
	border: 1px solid #ddd;
	width: 100%;
	padding: 12px;
	color: #0a0a0a;
}

.checkout-btn:hover {
	background-color: #007bff;
	color: white;
	border-color: #007bff;
}

.cart-total {
	font-weight: bold;
	font-size: 18px;
}
</style>
</head>
<body>
	<!-- Navbar -->
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container-fluid">
			<h3>Artevo</h3>
			<div class="collapse navbar-collapse" id="navbarNav">
				<ul class="navbar-nav ms-auto">
					<li class="nav-item"><a class="nav-link" href="home.jsp">Home</a></li>
					<li class="nav-item"><a class="nav-link active"
						href="shoppingCart.jsp">Shopping Cart</a></li>
					<li class="nav-item"><a class="nav-link" href="logout.jsp">Logout</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<!-- Shopping Cart Section -->
	<div class="container py-5">
		<h2 class="text-center mb-4">Your Shopping Cart</h2>
		<form action="payment.jsp" method="post">
			<div class="row">
				<!-- Cart Items Section -->
				<div class="col-md-8">
					<%-- 	<% 
    if (cartItems != null && !cartItems.isEmpty()) {
%>
					 --%>
					<%
					out.println("<p>cartItems list: " + cartItems + "</p>");
					if (cartItems == null || cartItems.isEmpty()) {
						out.println("<p>No items found in your cart!</p>");
					} else {
						out.println("<p>Cart items fetched successfully:</p>");
						for (CartBean item : cartItems) {
							out.println("<p>" + item.getTitle() + " - " + item.getPrice() + "</p>");
						}
					}
					%>


					<table class="table table-bordered cart-table">
						<thead>
							<tr>
								<th>Product</th>
								<th>Price</th>
								<th>Remove</th>
							</tr>
						</thead>
						<tbody>
							<%
							for (CartBean item : cartItems) {
							%>
							<tr>
								<td>
									<div class="d-flex">
										<img src="uploads/<%=item.getArtId()%>.jpg"
											alt="<%=item.getTitle()%>" class="product-img me-3">
										<div>
											<h5><%=item.getTitle()%></h5>
											<p class="text-muted"><%=item.getArtistName()%></p>
										</div>
									</div>
								</td>
								<td><b>&#8377;</b> <%=item.getPrice()%></td>
								<td><a
									href="removeFromCartAction.jsp?cartId=<%=item.getCartId()%>"
									class="btn btn-danger btn-sm">Remove</a></td>
							</tr>
							<%
							}
							%>
						</tbody>
					</table>
					<%-- 	<% 
    } else {
%> --%>
					<div class="alert alert-info">
						Your cart is empty! <a href="home.jsp">Browse items</a>.
					</div>
					<%-- 				<% 
    }
%>
 --%>
				</div>
				<!-- Cart Summary Section -->
				<div class="col-md-4 cart-summary">
					<h4>Cart Summary</h4>
					<div class="summary-item">
						<h5>Subtotal</h5>
						<span class="cart-total"><b>&#8377;</b> <%=subtotal%></span>
					</div>
					<div class="summary-item">
						<h5>Tax (10%)</h5>
						<span><b>&#8377;</b> <%=tax%></span>
					</div>
					<div class="summary-item">
						<h5>Shipping</h5>
						<span><b>&#8377;</b> <%=shipping%></span>
					</div>
					<hr>
					<div class="summary-item">
						<h5>Total</h5>
						<span class="cart-total"><b>&#8377;</b> <%=totalPrice%></span>
					</div>
					<!-- Checkout Button -->
					<div class="mt-4">
						<button type="submit" class="btn checkout-btn">Proceed to
							Checkout</button>
					</div>
				</div>
			</div>
		</form>
	</div>
	<footer class="text-center mt-5 py-3">
		<p>&copy; 2024 Artevo. All Rights Reserved.</p>
	</footer>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

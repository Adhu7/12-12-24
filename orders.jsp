<%-- <%@page import="bean.PaymentBean"%>
<%@page import="java.util.List"%>
<%@page import="dao.UserDao"%>
<%@page import="dao.PayementDao"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%
String email = (String) session.getAttribute("email");

if (email == null) {
	response.sendRedirect("log.jsp");

}
UserDao userDao = new UserDao();
int userId = userDao.getUserIdByEmail(email);
PayementDao paymentDao = new PayementDao();
List<PaymentBean> payments = paymentDao.getPaymentsByUserId( userId);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Orders</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style type="text/css">
        footer {
            background-color: #f8f9fa;
            padding: 1rem 0;
            text-align: center;
        }
        .navbar .nav-item {
            padding-right: 20px;
        }
        .orders-table td, .orders-table th {
            vertical-align: middle;
        }
        .order-details-btn {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            border: none;
            color: white;
            font-size: 16px;
            border-radius: 4px;
        }
        .order-details-btn:hover {
            background-color: #0056b3;
        }
        .orders-summary {
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
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid">
        <h3>Artevo</h3>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="home.jsp">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="logout.jsp">Logout</a>
                </li>
                <!-- User Dropdown -->
                <!-- <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        User
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="profile.jsp">Profile</a></li>
                        <li><a class="dropdown-item" href="orders.jsp">Orders</a></li>
                       
                    </ul>
                </li> -->
            </ul>
        </div>
    </div>
</nav>

<!-- Orders Section -->
<div class="container py-5">
    <h2 class="text-center mb-4">Your Orders</h2>
    
    <!-- Orders Table -->
    <table class="table table-bordered orders-table">
        <thead>
            <tr>
                <th>Product Name</th>
                <th>Date</th>
                <th>Total Price</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
            <%
                // Check if there are any orders
                if (payments != null && !payments.isEmpty()) {
                    for (PaymentBean payment : payments) {
            %>
                <tr>
                    <td><%= payment.getName() %></td> <!-- Assuming 'name' is the product name -->
                    <td><%= payment.getPaymentDate() %></td>
                    <td>&#8377; <%= payment.getAmount() %></td> <!-- Display total price -->
                    <td><%= payment.getPaymentStatus() %></td> <!-- Display payment status -->
                </tr>
            <%
                    }
                } else {
            %>
                <tr>
                    <td colspan="4" class="text-center">No orders found</td>
                </tr>
            <%
                }
            %>
        </tbody>
    </table>

    
</div>
<div style="height: 400px"></div>
<!-- Footer -->
<footer class="text-center mt-5 py-3">
    <p>&copy; 2024 Artevo. All Rights Reserved.</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> --%>
<%@page import="bean.PaymentBean"%>
<%@page import="java.util.List"%>
<%@page import="dao.UserDao"%>
<%@page import="dao.PayementDao"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%
    // Ensure the user is logged in
    String email = (String) session.getAttribute("email");

    if (email == null) {
        response.sendRedirect("log.jsp");
        return; // Stop further execution
    }

    // Fetch the user ID using the email
    UserDao userDao = new UserDao();
    int userId = userDao.getUserIdByEmail(email);

    if (userId == -1) {
        session.setAttribute("message", "Unable to fetch user details.");
        response.sendRedirect("home.jsp");
        return;
    }

    // Fetch the user's payment details
    PayementDao paymentDao = new PayementDao();
    List<PaymentBean> payments = paymentDao.getPaymentsByUserId(userId);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Orders</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        footer {
            background-color: #f8f9fa;
            padding: 1rem 0;
            text-align: center;
        }
        .navbar .nav-item {
            padding-right: 20px;
        }
        .orders-table td, .orders-table th {
            vertical-align: middle;
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
                <li class="nav-item"><a class="nav-link" href="logout.jsp">Logout</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- Orders Section -->
<div class="container py-5">
    <h2 class="text-center mb-4">Your Orders</h2>

    <!-- Orders Table -->
    <table class="table table-bordered orders-table">
        <thead>
            <tr>
                <th>Product Name</th>
                <th>Date</th>
                <th>Total Price</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
            <%
                // Check if there are any orders
                if (payments != null && !payments.isEmpty()) {
                    for (PaymentBean payment : payments) {
            %>
                <tr>
                    <td><%= payment.getName() %></td> <!-- Product name -->
                    <td><%= payment.getPaymentDate() %></td> <!-- Payment date -->
                    <td>&#8377; <%= payment.getAmount() %></td> <!-- Total price -->
                    <td><%= payment.getPaymentStatus() %></td> <!-- Payment status -->
                </tr>
            <%
                    }
                } else {
            %>
                <tr>
                    <td colspan="4" class="text-center">No orders found</td>
                </tr>
            <%
                }
            %>
        </tbody>
    </table>
</div>

<!-- Footer -->
<footer class="text-center mt-5 py-3">
    <p>&copy; 2024 Artevo. All Rights Reserved.</p>
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

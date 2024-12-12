<%@page import="bean.PaymentBean"%>
<%@page import="java.util.List"%>
<%@page import="dao.PayementDao"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%
String email = (String) session.getAttribute("email");

if (email == null) {
	response.sendRedirect("log.jsp");

}
PayementDao paymentDao = new PayementDao();
List<PaymentBean> payments = paymentDao.getAllPayments();	
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Management</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f4f6f9;
        }
        .sidebar {
            background-color: #0056b3;
            color: white;
            height: 100vh;
            position: fixed;
            top: 0;
            left: 0;
            width: 250px;
        }
        .sidebar a {
            color: white;
            padding: 15px;
            text-decoration: none;
            display: block;
            font-size: 16px;
        }
        .sidebar a:hover {
            background-color: #004085;
        }
        .main-content {
            margin-left: 260px;
            padding: 20px;
        }
        footer {
            background-color: #0056b3;
            color: white;
            padding: 10px;
            text-align: center;
            position: fixed;
            bottom: 0;
            width: 100%;
        }
    </style>
</head>
<body>

<!-- Sidebar -->
<div class="sidebar">
    <h2 class="text-center py-4">Artevo Admin</h2>
    <a href="adminDashboard.jsp">Dashboard</a>
    <a href="artistCategory.jsp">Artist Category</a>
    <a href="artistManage.jsp">Artist Management</a>
    <a href="artworkManage.jsp">Artwork Management</a>
    <a href="userManage.jsp">User Management</a>
    <a href="orderManage.jsp">Order Management</a>
    <a href="logout.jsp">Logout</a>
</div>

<!-- Main Content -->
<div class="main-content">
    <!-- Top Navbar -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">Admin Dashboard</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <h5>Order Management</h5>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Order Management Section -->
    <div class="container mt-4">
        <h2>Manage Orders</h2>
        <p>Track and manage all orders placed by customers. You can view the order details, update the order status, and more.</p>

        <!-- Order Table -->
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Order ID</th>
                    <th>Customer Name</th>
                    <th>Artwork Title</th>
                    <th>Category</th>
                    <th>Total Price</th>
                    <th>Status</th>
                    <th>Date</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (payments != null && !payments.isEmpty()) {
                        int count = 1;
                        for (PaymentBean payment : payments) {
                %>
                            <tr>
                                <td><%= count++ %></td>
                                <td><%= payment.getTransactionId() %></td>
                                <td><%= payment.getName() %></td>
                                <td><%= payment.getArtId() %></td>
                                <td><%= "Category Placeholder" %></td> <!-- Replace with logic to fetch category -->
                                <td>&#8377; <%= payment.getAmount() %></td>
                                <td><%= payment.getPaymentStatus() %></td>
                                <td><%= payment.getPaymentDate() %></td>
                            </tr>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="8" class="text-center">No orders found</td>
                    </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>

    

</div>

<!-- Footer -->
<footer>
    <p>&copy; 2024 Artevo. All Rights Reserved.</p>
    <p><a href="">Terms & Conditions</a> | <a href="">Privacy Policy</a></p>
</footer>

<!-- Bootstrap JS & Popper.js -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>


</body>
</html>


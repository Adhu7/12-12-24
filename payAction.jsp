
 <%@ page import="dao.PayementDao" %>
<%@ page import="bean.PaymentBean" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="java.io.*" %>

<html>
<head>
    <title>Payment Success</title>
</head>
<body>
<%
    String email = (String) session.getAttribute("email");
    if (email == null) {
        response.sendRedirect("log.jsp");
        return;
    }

    // Retrieve payment details from the request
    String paymentId = request.getParameter("razorpay_payment_id");
    int userId = Integer.parseInt(request.getParameter("userId"));
    int artId = Integer.parseInt(request.getParameter("artId"));
    String name = request.getParameter("name");
    String address = request.getParameter("address");
    String city = request.getParameter("city");
    String state = request.getParameter("state");
    String zip = request.getParameter("zip");
    String country = request.getParameter("country");
    String phone = request.getParameter("phone");
    double amount = Double.parseDouble(request.getParameter("amount"));
    String paymentStatus = "Success"; // Assuming success for this scenario

    // Create PaymentBean and insert payment details into the database
    PaymentBean payment = new PaymentBean();
    payment.setUserId(userId);
    payment.setTransactionId(paymentId);
    payment.setArtId(artId);
    payment.setName(name);
    payment.setAddress(address);
    payment.setCity(city);
    payment.setState(state);
    payment.setZip(zip);
    payment.setCountry(country);
    payment.setPhone(phone);
    payment.setAmount(amount);
    payment.setPaymentStatus(paymentStatus);

    PayementDao paymentDao = new PayementDao();
    boolean isInserted = paymentDao.insertPayment(payment);

    if (isInserted) {
        // Display success message and payment details
         response.sendRedirect("home.jsp");
%>

      
<%
    } else {
        // Display error message if insertion fails
%>
        <h2>Payment Failed!</h2>
        <p>There was an issue saving your payment details. Please contact support.</p>
<%
    }
%>
</body>
</html>
 
<%@ page import="dao.UserDao" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%
    String email = (String) session.getAttribute("email");
    if (email == null) {
        response.sendRedirect("log.jsp");
        return;
    }

    UserDao userDao = new UserDao();
    Integer userId = userDao.getUserIdByEmail(email);

    double amount = Double.parseDouble(request.getParameter("amount"));
    String artId = request.getParameter("artId");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
    <style>
.checkout-form {
	max-width: 600px;
	margin: auto;
	padding: 20px;
	background-color: #f9f9f9;
	border: 1px solid #ddd;
	border-radius: 8px;
}

.checkout-btn {
	background-color: #007bff;
	border: none;
	width: 100%;
	padding: 12px;
	color: white;
}

.checkout-btn:hover {
	background-color: #0056b3;
}

footer {
	background-color: #f8f9fa;
	padding: 1rem 0;
	text-align: center;
}
</style>
    <script>
        // Form validation using JavaScript
        function validateForm() {
            var name = document.getElementById("name").value;
            var address = document.getElementById("address").value;
            var city = document.getElementById("city").value;
            var state = document.getElementById("state").value;
            var zip = document.getElementById("zip").value;
            var country = document.getElementById("country").value;
            var phone = document.getElementById("phone").value;

            var namePattern = /^[a-zA-Z\s]+$/;
            var addressPattern = /^[\w\s,.#-]+$/;
            var cityPattern = /^[a-zA-Z\s]+$/;
            var statePattern = /^[a-zA-Z\s]+$/;
            var zipPattern = /^\d{5,6}$/;
            var countryPattern = /^[a-zA-Z\s]+$/;
            var phonePattern = /^[6-9]\d{9}$/;

            if (name=='') {
        		alert("Please enter your name");
        		document.getElementById("name").focus();
        		return false;
        	}
            if (!namePattern.test(name)) {
                alert("Invalid name. Only letters and spaces are allowed.");
                document.getElementById("name").focus();
                return false;
            }
            if (address=='') {
        		alert("Please enter your address");
        		document.getElementById("address").focus();
        		return false;
        	}
            if (!addressPattern.test(address)) {
                alert("Invalid address. Please provide a valid address.");
                document.getElementById("address").focus();
                return false;
            }
            if (city=='') {
        		alert("Please enter your city");
        		document.getElementById("city").focus();
        		return false;
        	}
            if (!cityPattern.test(city)) {
                alert("Invalid city. Only letters and spaces are allowed.");
                document.getElementById("city").focus();
                return false;
            }
            if (state=='') {
        		alert("Please enter your state");
        		document.getElementById("state").focus();
        		return false;
        	}
            if (!statePattern.test(state)) {
                alert("Invalid state. Only letters and spaces are allowed.");
                document.getElementById("state").focus();
                return false;
            }
            if (zip=='') {
        		alert("Please enter your zip");
        		document.getElementById("zip").focus();
        		return false;
        	}
            if (!zipPattern.test(zip)) {
                alert("Invalid ZIP code. Enter a 5 or 6 digit number.");
                document.getElementById("zip").focus();
                return false;
            }
            if (country=='') {
        		alert("Please enter your country");
        		document.getElementById("country").focus();
        		return false;
        	}
            if (!countryPattern.test(country)) {
                alert("Invalid country. Only letters and spaces are allowed.");
                document.getElementById("country").focus();
                return false;
            }
            if (phone=='') {
        		alert("Please enter your phone");
        		document.getElementById("phone").focus();
        		return false;
        	}
            if (!phonePattern.test(phone)) {
                alert("Invalid phone number. It must be a 10-digit number starting with 6-9.");
                document.getElementById("phone").focus();
                return false;
            }

            return true;
        }
        
    </script>
    
</head>
<body>
    <div class="container py-5">
        <h2 class="text-center">Checkout</h2>
        <form action="payAction.jsp" method="post" onsubmit="validateForm()">
            <input type="hidden" name="userId" value="<%= userId %>">
            <input type="hidden" name="artId" value="<%= artId %>">
            <input type="hidden" name="amount" value="<%= amount %>">
            <input type="hidden" name="razorpay_payment_id" id="razorpay_payment_id">
            
            <div class="form-group mb-3">
					<label for="name">Full Name</label> <input type="text" name="name"
						id="name" class="form-control" >
				</div>
				<div class="form-group mb-3">
					<label for="address">Address</label> <input type="text"
						name="address" id="address" class="form-control" >
				</div>
				<div class="form-group mb-3">
					<label for="city">City</label> <input type="text" name="city"
						id="city" class="form-control" >
				</div>
				<div class="form-group mb-3">
					<label for="state">State</label> <input type="text" name="state"
						id="state" class="form-control" >
				</div>
				<div class="form-group mb-3">
					<label for="zip">ZIP Code</label> <input type="text" name="zip"
						id="zip" class="form-control" >
				</div>
				<div class="form-group mb-3">
					<label for="country">Country</label> <input type="text"
						name="country" id="country" class="form-control" >
				</div>
				<div class="form-group mb-3">
					<label for="phone">Phone Number</label> <input type="text"
						name="phone" id="phone" class="form-control">
				</div>
            
            <h4>Order Summary</h4>
            <p><strong>Amount:</strong> &#8377; <%= amount %></p>
            
            <button type="button" id="payBtn" class="btn btn-success">Pay Now</button>
        </form>
    </div>

    <!-- Razorpay Integration Script -->
    <script>
        document.getElementById('payBtn').addEventListener('click', function() {
        	
        	 // First validate the form
            if (!validateForm()) {
                // If validation fails, return early
                return false;
            }
        	
            var options = {
                "key": "rzp_test_3FiYqdcHdWq0a2", // Replace with your Razorpay API key
                "amount": <%= (int)(amount * 100) %>, // Razorpay expects amount in paise
                "currency": "INR",
                "name": "Artevo",
                "description": "Artwork Purchase",
                "handler": function(response) {
                    // Set the Razorpay payment ID in the hidden field
                    document.getElementById('razorpay_payment_id').value = response.razorpay_payment_id;
                    // Submit the form after payment
                    document.forms[0].submit();
                },
                "prefill": {
                    "name": document.getElementById("name").value,
                    "email": "<%= email %>",
                    "contact": document.getElementById("phone").value
                },
                "theme": {
                    "color": "#3399cc"
                }
            };
            var rzp1 = new Razorpay(options);
            rzp1.open();
        });
    </script>
</body>
</html>
 
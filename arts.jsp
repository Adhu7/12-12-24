 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="bean.*, dao.*" %>
<%@ page import="java.util.List" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Featured Artworks</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        /* Card styling */
        .card {
            width: 100%;
            max-width: 400px;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .card img {
            height: 200px;
            object-fit: cover;
        }

        .card-body {
            background-color: #f8f9fa;
            padding: 20px;
            display: flex;
            flex-direction: column;
        }

        .card-title {
            margin-left: 0px;
            font-weight: bold;
            color: #333;
            margin-bottom: 10px;
            text-align: left;
        }

        .card-text {
            font-size: 14px;
            color: #555;
            margin-bottom: 10px;
        }

        /* Styling for the button */
        .card .btn-primary {
            margin-top: auto;
            width: 100%;
            font-size: 16px;
            font-weight: bold;
        }

        .card .btn-primary:hover {
            background-color: #0056b3;
            border-color: #0056b3;
        }

        /* Flexbox for controlling layout of text in card */
        .d-flex-space-between {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        /* Styling to align title and price in parallel */
        .title-price-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .title-price-container .card-title {
            margin-bottom: 0; /* Remove bottom margin to align with price */
        }

        .title-price-container .price {
          /*   font-weight: bold; */
            font-size: 16px;
            color: #333;
            margin-bottom: 2px;
        }

        /* Optional: Style to adjust button alignment */
        .card-body .btn-primary {
            margin-left: auto;
            width: auto;
            display: block;
        }
    </style>
</head>

<body>

    <%
        // Fetching artworks from the database
        ArtDao artDao = new ArtDao();
        List<ArtBean> artworks = artDao.getAllArtworks();
    %>

    <div class="container py-5">
        <h2 class="text-center mb-4">Explore Our Artworks</h2>
        <div class="row">
            <% if (artworks.isEmpty()) { %>
            <div class="col-12 text-center">
                <p class="text-muted">No artworks available at the moment. Please check back later!</p>
            </div>
            <% } else { %>
            <% for (ArtBean artwork : artworks) { %>
         
           <%--  <div class="col-md-4 d-flex align-items-stretch mb-4 py-3">
    <div class="card h-100" style="width: 100%; max-width: 390px;">
        <img src="uploads/<%= artwork.getUploadImage() %>" class="card-img-top" alt="<%= artwork.getArtTitle() %>" style="height: 200px; object-fit: cover;">
        <div class="card-body d-flex flex-column">
            <!-- Title and Price in parallel -->
            <div class="title-price-container d-flex justify-content-between mb-2">
                <h5 class="card-title mb-0"><%= artwork.getArtTitle() %></h5>
                <p class="price mb-0"><b>&#8377;</b> <%= artwork.getArtPrice() %></p>
            </div>

            <!-- Body content with left-aligned text -->
            <p class="card-text left-align mb-2"><strong>Artist:</strong> <%= artwork.getArtistName() %></p>

            <!-- Buttons aligned to the left and right -->
            <div class="mt-auto d-flex justify-content-between">
                <a href="AddtoCartAction.jsp?artId=<%= artwork.getArtId() %>&title=<%= artwork.getArtTitle() %>&artistName=<%= artwork.getArtistName() %>&category=<%= artwork.getArtGenre() %>&price=<%= artwork.getArtPrice() %>" class="btn btn-outline-primary">Add to Cart</a>

                <a href="payment.jsp?artId=<%= artwork.getArtId() %>" class="btn btn-outline-secondary btn-m">Buy Now</a>
            </div>
        </div>
    </div>
</div> --%>

            <div class="col-md-4 mb-4">
                <div class="card">
                    <img src="uploads/<%= artwork.getUploadImage() %>" class="card-img-top" alt="<%= artwork.getArtTitle() %>">
                    <div class="card-body">
                        <h5 class="card-title"><%= artwork.getArtTitle() %></h5>
                        <p class="card-text"><strong>Price:</strong> &#8377; <%= artwork.getArtPrice() %></p>
                        <p class="card-text"><strong>Artist:</strong> <%= artwork.getArtistName() %></p>
                        <a href="payment.jsp?artId=<%= artwork.getArtId() %>&amount=<%= artwork.getArtPrice() %>" class="btn btn-primary">Buy Now</a>
                    </div>
                </div>
            </div>
        
            
            <% } %>
            <% } %>
        </div>
    </div>

</body>

</html>

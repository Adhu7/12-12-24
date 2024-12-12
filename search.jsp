
<%@ page import="java.sql.SQLException" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="dao.ArtDao" %>
<%@ page import="bean.ArtBean" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    String query = request.getParameter("query");
    ArtDao artDao = new ArtDao();
    List<ArtBean> artworks = null;
    
    if (query != null && !query.trim().isEmpty()) {
        try {
            artworks = artDao.searchArtworks(query);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred while fetching artworks.");
        }
    }
    request.setAttribute("artworks", artworks);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Artworks</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<style type="text/css">
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
        footer {
            background-color: #f8f9fa;
            padding: 1rem 0;
            text-align: center;
        }
        .navbar .nav-item {
            padding-right: 20px;
        }
        .search-table td,
        .search-table th {
            vertical-align: middle;
        }
        .search-table .product-img {
            width: 120px;
            height: auto;
        }
        .search-summary {
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
        .search-btn {
            background-color: #f8f9fa;
            border: 1px solid #ddd;
            width: 100%;
            padding: 12px;
            color: #0a0a0a;
        }
        .search-btn:hover {
            background-color: #007bff;
            color: white;
            border-color: #007bff;
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
    <!-- Search Form -->
     <div class="container my-5">
        <h2 class="text-center">Search Artworks</h2>
        <!-- Search Form -->
        <form method="get" action="search.jsp">
            <div class="input-group mb-4">
                <input type="text" class="form-control" placeholder="Search by title, artist, or genre" name="query" value="${param.query}">
                <button class="btn btn-primary" type="submit">Search</button>
            </div>
        </form>

        <!-- Display Results -->
        <c:choose>
            <c:when test="${empty artworks}">
                <div class="alert alert-warning text-center">
                    No artworks found for "<c:out value="${param.query}" />". Try a different search.
                </div>
            </c:when>
            <c:otherwise>
                <div class="row">
                    <c:forEach var="artwork" items="${artworks}">
                        <div class="col-md-4 mb-4">
                            <div class="card">
                            
                                <img src="uploads/${artwork.uploadImage}" class="card-img-top" alt="${artwork.artTitle}">

                                <div class="card-body">
                                    <h5 class="card-title">${artwork.artTitle}</h5>
                                    <p class="card-text"><strong>Price:</strong> &#8377; ${artwork.artPrice}</p>
                                    <p class="card-text"><strong>Artist:</strong> ${artwork.artistName}</p>
                                    <p class="card-text"><strong>Genre:</strong> ${artwork.artGenre}</p>
                                    <a href="payment.jsp?artId=${artwork.artId}&amount=${artwork.artPrice}" class="btn btn-primary">Buy Now</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    
<!-- Footer -->
<footer class="text-center mt-5 py-3">
    <p>&copy; 2024 Artevo. All Rights Reserved.</p>
</footer>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>

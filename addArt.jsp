<%@ page import="java.util.List" %>
<%@ page import="dao.ArtistDao" %>
<%@ page import="dao.ArtDao" %>
<%
String email = (String) session.getAttribute("email");

if (email == null) {
	response.sendRedirect("log.jsp");

}
%>
<%
    // Instantiate DAO and fetch list of artist names
    ArtistDao artistDao = new ArtistDao();
    List<String> artistNames = artistDao.getAllArtistNames();
%>
<%@ page import="java.util.List" %>
<%@ page import="dao.ArtistCategoryDAO" %>
<%@ page import="bean.ArtistCategoryBean" %>
<%
    // Instantiate the DAO and retrieve all categories
    ArtistCategoryDAO artistCategoryDAO = new ArtistCategoryDAO();
    List<ArtistCategoryBean> categories = artistCategoryDAO.getAllCategories();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Artwork</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f4f6f9;
            display: flex;
        }
        .sidebar {
            background-color: #0056b3;
            color: white;
            height: 100vh;
            position: fixed;
            top: 0;
            left: 0;
            width: 250px;
            padding-top: 20px;
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
            flex-grow: 1;
        }
        .content-wrapper {
            padding-bottom: 70px;
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
    <script>
        // Function for form validation
        function validateForm() {
            var title = document.getElementById("art-title").value;
            var artistName = document.getElementById("artist-name").value;
            var genre = document.getElementById("artist-genre").value;
            var price = document.getElementById("art-price").value;
            var pricePattern = /^[0-9]+(\.[0-9]{1,2})?$/; // Regex for price (valid numbers with optional 2 decimal places)
            var image = document.getElementById("art-image").value;

            // Validate Artwork Title
            if (title == "") {
                alert("Please enter the artwork title.");
                document.getElementById("art-title").focus();
                return false;
            }

            // Validate Artist Name
            if (artistName == "") {
                alert("Please select an artist.");
                document.getElementById("artist-name").focus();
                return false;
            }

            // Validate Genre
            if (genre == "") {
                alert("Please select a genre.");
                document.getElementById("artist-genre").focus();
                return false;
            }

            // Validate Price (numeric with optional decimal)
            if (!pricePattern.test(price)) {
                alert("Please enter a valid price (e.g., 1000 or 1000.50).");
                document.getElementById("art-price").focus();
                return false;
            }

            // Validate Image (must be selected)
            if (image == "") {
                alert("Please upload an image.");
                document.getElementById("art-image").focus();
                return false;
            }

            return true; // Form is valid
        }
    </script>
</head>
<body>
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

<div class="main-content">
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">Admin Dashboard</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <h5>Artwork Management</h5>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="content-wrapper">
        <h2>Add New Artwork</h2>
        <p>Fill out the form below to add a new piece of art to the gallery.</p>

        <!-- Add Artwork Form -->
        <form action="artAction.jsp" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
            <div class="mb-3">
                <label for="art-title" class="form-label">Artwork Title</label>
                <input type="text" class="form-control" id="art-title" name="art-title" >
            </div>

            <!-- Artist Name Dropdown -->
            <div class="mb-3">
                <label for="artist-name" class="form-label">Artist Name</label>
                <select class="form-control" id="artist-name" name="artist-name" >
                    <option value="">Select Artist</option>
                    <% for (String name : artistNames) { %>
                        <option value="<%= name %>"><%= name %></option>
                    <% } %>
                </select>
            </div>

             <div class="mb-3">
    <label for="artist-genre" class="form-label">Genre</label>
    <select class="form-control" id="artist-genre" name="artist-genre" >
        <option value="">Select Genre</option>
        <% for (ArtistCategoryBean category : categories) { %>
            <option value="<%= category.getCategoryName() %>"><%= category.getCategoryName() %></option>
        <% } %>
    </select>
</div>

            <div class="mb-3">
                <label for="art-price" class="form-label">Price (Rs.)</label>
                <input type="text" class="form-control" id="art-price" name="art-price" >
            </div>

            <div class="mb-3">
                <label for="art-image" class="form-label">Upload Image</label>
                <input type="file" class="form-control" id="art-image" name="art-image" accept="image/*" >
            </div>

            <button type="submit" class="btn btn-primary">Add Artwork</button><br><br>
        </form>
    </div>
</div>

<div style="height: 400px"></div>
<footer>
    <p>&copy; 2024 Artevo. All Rights Reserved.</p>
   <!--  <p><a href="terms.jsp">Terms & Conditions</a> | <a href="privacy.jsp">Privacy Policy</a></p> -->
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

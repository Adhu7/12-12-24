

<%@ page import="dao.ArtDao" %>
<%@ page import="bean.ArtBean" %>
<%
    // Check session
    String email = (String) session.getAttribute("email");
    if (email == null) {
        response.sendRedirect("log.jsp");
        return;
    }

    // Validate and parse form data
    String artId = request.getParameter("art-id");
    String artTitle = request.getParameter("art-title");
    String artName = request.getParameter("artist-name");
    String artPriceStr = request.getParameter("art-price");
    String artGenre = request.getParameter("artist-genre");

    // Validate and convert the price
    double artPrice = 0;
    try {
        artPrice = Double.parseDouble(artPriceStr);
    } catch (NumberFormatException e) {
        out.println("<p>Invalid price format.</p>");
        return;
    }

    // Create an ArtBean object and set its values
    ArtBean artwork = new ArtBean();
    artwork.setArtId(Integer.parseInt(artId));
    artwork.setArtTitle(artTitle);
    artwork.setArtistName(artName);
    artwork.setArtPrice(artPrice);
    artwork.setArtGenre(artGenre);

    // Update the artwork in the database
    ArtDao artDao = new ArtDao();
    boolean isUpdated = artDao.updateArtwork(artwork); // Assuming this method handles updating all fields

    if (isUpdated) {
        response.sendRedirect("artworkManage.jsp");
    } else {
      /*   out.println("<h3>Failed to update artwork.</h3>"); */
      
        out.println("<div class='alert alert-danger' role='alert'>");
        out.println("<h4 class='alert-heading'>Error!</h4>");
        out.println("<p>There was a problem updating the artwork. Please try again later.</p>");
        out.println("<hr>");
        out.println("<p class='mb-0'>If the problem persists, contact support.</p>");
        out.println("</div>");
    }
%>

 	
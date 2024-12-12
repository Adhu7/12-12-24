
<%@ page import="bean.CartBean, dao.CartDao, dao.UserDao"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="java.io.PrintWriter"%>
<%
String email = (String) session.getAttribute("email");

if (email == null) {
	response.sendRedirect("log.jsp");

}
%>
<%
    

    // Retrieve artwork details from the request
   UserDao userDao = new UserDao();
    int userId = userDao.getUserIdByEmail(email); // Assume `getUserIdByEmail` method is implemented in UserDao

    if (userId == 0) {
        out.println("<p>Error: User not found. Please log in again.</p>");
        return;
    }

    // Retrieve artwork details from the request
    String artIdParam = request.getParameter("artId");
    String title = request.getParameter("title");
    String artistName = request.getParameter("artistName");
    String category = request.getParameter("category");
    String priceParam = request.getParameter("price");

    if (artIdParam == null || title == null || artistName == null || category == null || priceParam == null) {
        out.println("<p>Error: Missing artwork details.</p>");
        return;
    }

    try {
        // Parse parameters
        int artId = Integer.parseInt(artIdParam);
        double price = Double.parseDouble(priceParam);
		//BigDecimal price = new BigDecimal(priceParam);
        // Create a CartBean object
        CartBean cart = new CartBean();
        cart.setUserId(userId);
        cart.setArtId(artId);
        cart.setTitle(title);
        cart.setArtistName(artistName);
        cart.setCategory(category);
        cart.setPrice(price);

        // Use CartDao to add the item to the cart
        CartDao cartDao = new CartDao();
        boolean isAdded = cartDao.addToCart(cart);

        if (isAdded) {
            out.println("<script>alert('Item added to cart successfully!'); window.location='shoppingCart.jsp';</script>");
        } else {
            out.println("<script>alert('Failed to add item to cart!'); window.location='home.jsp';</script>");
        }
    } catch (NumberFormatException e) {
        out.println("<p>Error: Invalid data provided.</p>");
        e.printStackTrace();
    }
%>

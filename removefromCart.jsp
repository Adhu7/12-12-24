<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="dao.CartDao" %>
<%
String email = (String) session.getAttribute("email");



if (email == null) {
	response.sendRedirect("log.jsp");

}
%>
<%
    String cartIdParam = request.getParameter("cartId");

    if (cartIdParam != null) {
        int cartId = Integer.parseInt(cartIdParam);
        CartDao cartDao = new CartDao();
        boolean isRemoved = cartDao.removeFromCart(cartId);

        if (isRemoved) {
            response.sendRedirect("shoppingCart.jsp");
        } else {
            out.println("<script>alert('Failed to remove item from cart.'); window.location='shoppingCart.jsp';</script>");
        }
    } else {
        response.sendRedirect("shoppingCart.jsp");
    }
%>

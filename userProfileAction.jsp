<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="dao.UserDao" %>
<%@ page import="java.sql.SQLException" %>
<%
    // Ensure the user is logged in
    String email = (String) session.getAttribute("email");

    if (email == null) {
        response.sendRedirect("log.jsp");
        return;
    }

    // Get updated values from the form
    String newName = request.getParameter("fullName");
    String newPhone = request.getParameter("phone");

    // Initialize UserDao
    UserDao userDao = new UserDao();
    boolean isUpdated = false;

    try {
        // Update user details in the database
        isUpdated = userDao.updateUserProfile(email, newName, newPhone);
    } catch (SQLException e) {
        e.printStackTrace();
    }

    // Redirect based on update status
    if (isUpdated) {
        session.setAttribute("message", "Profile updated successfully.");
        response.sendRedirect("userProfile.jsp"); // Replace with your profile page
    } else {
        session.setAttribute("message", "Failed to update profile. Please try again.");
        response.sendRedirect("userProfile.jsp"); // Redirect back to edit profile page
    }
%>

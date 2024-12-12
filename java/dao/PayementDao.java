package dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import bean.PaymentBean;
import db.ArtDB;
public class PayementDao {
	 public boolean insertPayment(PaymentBean payment) {
	        String query = "INSERT INTO payments (userId, transactionId, artId, name, address, city, state, zip, country, phone, amount, payment_status) " +
	                       "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	        try (Connection conn = ArtDB.getConnection();
	             PreparedStatement ps = conn.prepareStatement(query)) {

	            ps.setInt(1, payment.getUserId());
	            ps.setString(2, payment.getTransactionId());
	            ps.setInt(3, payment.getArtId());
	            ps.setString(4, payment.getName());
	            ps.setString(5, payment.getAddress());
	            ps.setString(6, payment.getCity());
	            ps.setString(7, payment.getState());
	            ps.setString(8, payment.getZip());
	            ps.setString(9, payment.getCountry());
	            ps.setString(10, payment.getPhone());
	            ps.setDouble(11, payment.getAmount());
	            ps.setString(12, payment.getPaymentStatus());

	            return ps.executeUpdate() > 0; // Returns true if at least one record is inserted
	        } catch (SQLException e) {
	            e.printStackTrace();
	            return false;
	        }
	    }

	    // Fetch Payments by User ID
	    public List<PaymentBean> getPaymentsByUserId(int userId) {
	        List<PaymentBean> payments = new ArrayList<>();
	        String query = "SELECT * FROM payments WHERE userId = ?";
	        try (Connection conn = ArtDB.getConnection();
	             PreparedStatement ps = conn.prepareStatement(query)) {

	            ps.setInt(1, userId);
	            ResultSet rs = ps.executeQuery();

	            while (rs.next()) {
	                PaymentBean payment = new PaymentBean();
	                payment.setPaymentId(rs.getInt("payment_id"));
	                payment.setUserId(rs.getInt("userId"));
	                payment.setTransactionId(rs.getString("transactionId"));
	                payment.setArtId(rs.getInt("artId"));
	                payment.setName(rs.getString("name"));
	                payment.setAddress(rs.getString("address"));
	                payment.setCity(rs.getString("city"));
	                payment.setState(rs.getString("state"));
	                payment.setZip(rs.getString("zip"));
	                payment.setCountry(rs.getString("country"));
	                payment.setPhone(rs.getString("phone"));
	                payment.setAmount(rs.getDouble("amount"));
	                payment.setPaymentStatus(rs.getString("payment_status"));
	                payment.setPaymentDate(rs.getString("payment_date"));
	                payments.add(payment);
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return payments;
	    }

	    // Update Payment Status
	    public boolean updatePaymentStatus(int paymentId, String status) {
	        String query = "UPDATE payments SET payment_status = ? WHERE payment_id = ?";
	        try (Connection conn = ArtDB.getConnection();
	             PreparedStatement ps = conn.prepareStatement(query)) {

	            ps.setString(1, status);
	            ps.setInt(2, paymentId);

	            return ps.executeUpdate() > 0;
	        } catch (SQLException e) {
	            e.printStackTrace();
	            return false;
	        }
	    }

	    // Delete Payment
	    public boolean deletePayment(int paymentId) {
	        String query = "DELETE FROM payments WHERE payment_id = ?";
	        try (Connection conn = ArtDB.getConnection();
	             PreparedStatement ps = conn.prepareStatement(query)) {

	            ps.setInt(1, paymentId);

	            return ps.executeUpdate() > 0;
	        } catch (SQLException e) {
	            e.printStackTrace();
	            return false;
	        }
	    }
	    public List<PaymentBean> getAllPayments() {
	        List<PaymentBean> payments = new ArrayList<>();
	        String query = "SELECT * FROM payments";
	        try (Connection conn = ArtDB.getConnection();
	             Statement stmt = conn.createStatement();
	             ResultSet rs = stmt.executeQuery(query)) {

	            while (rs.next()) {
	                PaymentBean payment = new PaymentBean();
	                payment.setPaymentId(rs.getInt("payment_id"));
	                payment.setTransactionId(rs.getString("transactionId"));
	                payment.setArtId(rs.getInt("artId"));
	                payment.setName(rs.getString("name"));
	                payment.setAmount(rs.getDouble("amount"));
	                payment.setPaymentStatus(rs.getString("payment_status"));
	                payment.setPaymentDate(rs.getString("payment_date"));
	                payments.add(payment);
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return payments;
	    }
	    
	    public int getCountOrders() throws SQLException {
	        int totalOrders = 0;  // Variable to store the total count
	        String countSql = "SELECT COUNT(*) FROM payments";  // Query to get the count of users
	        try (Connection conn = ArtDB.getConnection();
	             PreparedStatement countStmt = conn.prepareStatement(countSql);
	             ResultSet countRs = countStmt.executeQuery()) {

	            if (countRs.next()) {
	                totalOrders = countRs.getInt(1);  // Get the total count of users
	            }
	        }
	        return totalOrders;  // Return the count
	    }
	    public int getUserIdByEmail(String email) {
	        String query = "SELECT id FROM users WHERE email = ?";
	        try (Connection conn = ArtDB.getConnection();
	             PreparedStatement ps = conn.prepareStatement(query)) {

	            ps.setString(1, email);
	            ResultSet rs = ps.executeQuery();

	            if (rs.next()) {
	                return rs.getInt("id");
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return -1; // Return -1 if user not found
	    }

}

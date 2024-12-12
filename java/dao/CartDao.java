package dao;

import bean.ArtBean;
import bean.CartBean;
import bean.UserBean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.mysql.jdbc.ResultSetMetaData;

import db.ArtDB;

public class CartDao {
	public boolean addToCart(CartBean cart) {
		String sql = "INSERT INTO cart (userid, artid, title, artist_name, category, price) VALUES (?, ?, ?, ?, ?, ?)";

		try (Connection conn = ArtDB.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

			// Set parameters from the CartBean object
			stmt.setInt(1, cart.getUserId());
			stmt.setInt(2, cart.getArtId());
			stmt.setString(3, cart.getTitle());
			stmt.setString(4, cart.getArtistName());
			stmt.setString(5, cart.getCategory());
			stmt.setDouble(6, cart.getPrice());
			int rowsAffected = stmt.executeUpdate();
			return rowsAffected > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	public int getUserIdByEmail(String email) {
		String sql = "SELECT userId FROM userreg WHERE email = ?";
		try (Connection conn = ArtDB.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setString(1, email);
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				return rs.getInt("userId");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0; // Return 0 if no user found
	}

	public boolean removeFromCart(int cartId) {
		String sql = "DELETE FROM cart WHERE cartid = ?";
		try (Connection conn = ArtDB.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, cartId);
			int rowsAffected = stmt.executeUpdate();
			return rowsAffected > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	private boolean userExists(int userId) {
		String sql = "SELECT COUNT(*) FROM userreg WHERE userId = ?";
		try (Connection connection = ArtDB.getConnection(); // Assuming `ArtDB` is your DB connection class
				PreparedStatement stmt = connection.prepareStatement(sql)) {

			// Set the parameter
			stmt.setInt(1, userId);

			// Execute the query
			ResultSet rs = stmt.executeQuery();

			// Check the result
			if (rs.next()) {
				return rs.getInt(1) > 0; // Return true if count > 0
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false; // Return false if the user doesn't exist or an exception occurs
	}

	// Method to fetch all cart items for a specific user ID
//	public List<CartBean> getCartItemsByUserId(int userId) {
//		List<CartBean> cartItems = new ArrayList<>();
//		String sql = "SELECT * FROM cart WHERE userId = ?";
//
//		// Using try-with-resources to ensure proper closing of database resources
//		try (Connection conn = ArtDB.getConnection(); // Assuming ArtDB is your DB connection class
//				PreparedStatement stmt = conn.prepareStatement(sql)) {
//
//			// Set the parameter for the userId
//			stmt.setInt(1, userId);
//
//			// Execute the query
//			try (ResultSet rs = stmt.executeQuery()) {
//				// Process the result set
//				while (rs.next()) {
//					CartBean cartItem = new CartBean();
//					cartItem.setCartId(rs.getInt("cartId"));
//					cartItem.setUserId(rs.getInt("userId"));
//					cartItem.setArtId(rs.getInt("artId"));
//					cartItem.setTitle(rs.getString("title"));
//					cartItem.setArtistName(rs.getString("artistName"));
//					cartItem.setCategory(rs.getString("category"));
//					cartItem.setPrice(rs.getDouble("price"));
//
//					// Add the cart item to the list
//					cartItems.add(cartItem);
//				}
//			}
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//
//		return cartItems;
//	}
	
	public List<CartBean> getCartItemsByUserId(int userId) {
        List<CartBean> cartItems = new ArrayList<>();
        String sql = "SELECT cartid, userid, artid, title, artist_name, category, price FROM cart WHERE userid = ?";
        try (Connection conn = ArtDB.getConnection(); // Assuming ArtDB is your DB connection class
				PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                CartBean cart = new CartBean();
                cart.setCartId(rs.getInt("cartid"));
                cart.setUserId(rs.getInt("userid"));
                cart.setArtId(rs.getInt("artid"));
                cart.setTitle(rs.getString("title"));
                cart.setArtistName(rs.getString("artist_name"));
                cart.setCategory(rs.getString("category"));
                cart.setPrice(rs.getDouble("price"));
                cartItems.add(cart);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Replace with proper logging in production
        }
        return cartItems;
    }

	public CartBean getCartItem(int userId, int artId) {
        CartBean cartItem = null;
        String sql = "SELECT * FROM cart WHERE userId = ? AND artId = ?";
        try (Connection conn = ArtDB.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, artId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    cartItem = new CartBean();
                    cartItem.setCartId(rs.getInt("cartId"));
                    cartItem.setUserId(rs.getInt("userId"));
                    cartItem.setArtId(rs.getInt("artId"));
                    cartItem.setTitle(rs.getString("title"));
                    cartItem.setArtistName(rs.getString("artistName"));
                    cartItem.setCategory(rs.getString("category"));
                    cartItem.setPrice(rs.getDouble("price")); // Use BigDecimal for price
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cartItem;
    }
}

package dao;

import java.sql.*;
import java.util.*;
import bean.ArtBean;
import db.ArtDB;
import dao.UserDao;
public class ArtDao {

	// Insert new artwork into the database
	public boolean addArtwork(ArtBean artwork) {
		String query = "INSERT INTO artwork (artTitle, artistName, artGenre, artPrice, uploadeImage) VALUES (?, ?, ?, ?, ?)";

		try (Connection conn = ArtDB.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {

			ps.setString(1, artwork.getArtTitle());
			ps.setString(2, artwork.getArtistName());
			ps.setString(3, artwork.getArtGenre());
			ps.setDouble(4, artwork.getArtPrice());
			ps.setString(5, artwork.getUploadImage());

			int result = ps.executeUpdate();
			return result > 0; // If 1 or more rows affected, insert is successful
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	// Delete artwork from the database
	public boolean deleteArtwork(int artID) {
		String query = "DELETE FROM artwork WHERE artId = ?";

		try (Connection conn = ArtDB.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {

			ps.setInt(1, artID);
			int result = ps.executeUpdate();
			return result > 0; // If 1 or more rows affected, delete is successful
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	// Select a single artwork by ID
	public ArtBean getArtworkById(int artId) {
		String query = "SELECT * FROM artwork WHERE artId = ?";
		ArtBean artwork = null;

		try (Connection conn = ArtDB.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {

			ps.setInt(1, artId);
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				artwork = new ArtBean();
				artwork.setArtId(rs.getInt("artId"));
				artwork.setArtTitle(rs.getString("artTitle"));
				artwork.setArtistName(rs.getString("artistName"));
				artwork.setArtGenre(rs.getString("artGenre"));
				artwork.setArtPrice(rs.getDouble("artPrice"));
				artwork.setUploadImage(rs.getString("uploadeImage"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return artwork;
	}

	public List<ArtBean> getAllArtworks() {
		List<ArtBean> artworks = new ArrayList<>();
		String query = "SELECT * FROM artwork";

		try (Connection conn = ArtDB.getConnection();
				PreparedStatement ps = conn.prepareStatement(query);
				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				ArtBean artwork = new ArtBean();
				artwork.setArtId(rs.getInt("artId"));
				artwork.setArtTitle(rs.getString("artTitle"));
				artwork.setArtistName(rs.getString("artistName"));
				artwork.setArtGenre(rs.getString("artGenre"));
				artwork.setArtPrice(rs.getDouble("artPrice"));
				artwork.setUploadImage(rs.getString("uploadeImage"));
				artworks.add(artwork);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return artworks;
	}

	public boolean updateArtPrice(int artId, double newPrice) {
		String query = "UPDATE artwork SET artPrice = ? WHERE artId = ?";
		try (Connection conn = ArtDB.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
			stmt.setDouble(1, newPrice);
			stmt.setInt(2, artId);
			return stmt.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	// Method to update all artwork details (title, artist name, genre, price)
	public boolean updateArtwork(ArtBean artwork) {
		String query = "UPDATE artwork SET artTitle = ?, artistName = ?, artPrice = ?, artGenre = ? WHERE artId = ?";
		try (Connection conn = ArtDB.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
			stmt.setString(1, artwork.getArtTitle());
			stmt.setString(2, artwork.getArtistName());
			stmt.setDouble(3, artwork.getArtPrice());
			stmt.setString(4, artwork.getArtGenre());
			stmt.setInt(5, artwork.getArtId());

			int rowsUpdated = stmt.executeUpdate();
			return rowsUpdated > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	public int getCountArtwork() throws SQLException {
		int totalArts = 0; // Variable to store the total count

		String countSql = "SELECT COUNT(*) FROM artwork"; // Query to get the count of products

		try (Connection conn = ArtDB.getConnection();
				PreparedStatement countStmt = conn.prepareStatement(countSql);
				ResultSet countRs = countStmt.executeQuery()) {

			if (countRs.next()) {
				totalArts = countRs.getInt(1); // Get the total count of products
			}

		}
		return totalArts; // Return the count
	}

	public boolean updateArtworkDetails(int artId, String artTitle, double artPrice) {
		String query = "UPDATE artwork SET artTitle = ?, artPrice = ? WHERE artId = ?";
		try (Connection conn = ArtDB.getConnection(); PreparedStatement pstmt = conn.prepareStatement(query)) {

			pstmt.setString(1, artTitle);
			pstmt.setDouble(2, artPrice);
			pstmt.setInt(3, artId);

			int rowsAffected = pstmt.executeUpdate();
			return rowsAffected > 0; // Return true if the update was successful
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	public List<ArtBean> searchArtworks(String query) throws SQLException {
		List<ArtBean> artworks = new ArrayList<>();

		String sql = "SELECT * FROM artwork WHERE artTitle LIKE ? OR artistName LIKE ? OR artGenre LIKE ?";

		try (Connection connection = ArtDB.getConnection();
				PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

			String searchQuery = "%" + query + "%";
			preparedStatement.setString(1, searchQuery);
			preparedStatement.setString(2, searchQuery);
			preparedStatement.setString(3, searchQuery);

			try (ResultSet rs = preparedStatement.executeQuery()) {
				while (rs.next()) {
					ArtBean art = new ArtBean();
					art.setArtId(rs.getInt("artId"));
					art.setArtTitle(rs.getString("artTitle"));
					art.setArtistName(rs.getString("artistName"));
					art.setArtGenre(rs.getString("artGenre"));
					art.setArtPrice(rs.getDouble("artPrice"));
					art.setUploadImage(rs.getString("uploadeImage"));
					artworks.add(art);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new SQLException("Error occurred while searching artworks.", e);
		}
		return artworks;
	}
	/*
	 * public static List<ArtBean> getArtworksByUserId(int userId) { List<ArtBean>
	 * artworks = new ArrayList<>(); Connection conn = null; PreparedStatement ps =
	 * null; ResultSet rs = null;
	 * 
	 * try { conn = ArtDB.getConnection(); // Assume DBConnection provides a
	 * connection String sql = "SELECT * FROM userreg WHERE userId = ?"; ps =
	 * conn.prepareStatement(sql); ps.setInt(1, userId); rs = ps.executeQuery();
	 * 
	 * while (rs.next()) { ArtBean art = new ArtBean();
	 * art.setArtId(rs.getInt("artId")); art.setArtTitle(rs.getString("artTitle"));
	 * art.setArtPrice(rs.getDouble("artPrice"));
	 * art.setUserId(rs.getInt("userId")); artworks.add(art); } } catch (Exception
	 * e) { e.printStackTrace(); } finally { ArtDB.close(conn, ps, rs); }
	 * 
	 * return artworks; }
	 */
}

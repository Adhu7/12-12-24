package bean;

import java.math.BigDecimal;

public class CartBean {
	private int cartId;
    private int userId;
    private int artId;
    private String title;
    private String artistName;
    private String category;
    private Double price;
	public CartBean() {
		super();
	}
	public CartBean(int cartId, int userId, int artId, String title, String artistName, String category, Double price) {
		super();
		this.cartId = cartId;
		this.userId = userId;
		this.artId = artId;
		this.title = title;
		this.artistName = artistName;
		this.category = category;
		this.price = price;
	}
	public int getCartId() {
		return cartId;
	}
	public void setCartId(int cartId) {
		this.cartId = cartId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public int getArtId() {
		return artId;
	}
	public void setArtId(int artId) {
		this.artId = artId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getArtistName() {
		return artistName;
	}
	public void setArtistName(String artistName) {
		this.artistName = artistName;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}

	public Double getPrice() {
		return price;
	}
	public void setPrice(Double price) {
		this.price = price;
	}
	
	@Override
	public String toString() {
		return "CartBean [cartId=" + cartId + ", userId=" + userId + ", artId=" + artId + ", title=" + title
				+ ", artistName=" + artistName + ", category=" + category + ", price=" + price + "]";
	}
    
}

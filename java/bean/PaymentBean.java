package bean;

public class PaymentBean {
	private int paymentId;
    private int userId;
    private String transactionId;
    private int artId;
    private String name;
    private String address;
    private String city;
    private String state;
    private String zip;
    private String country;
    private String phone;
    private double amount;
    private String paymentStatus;
    private String paymentDate;
	public PaymentBean() {
		super();
	}
	public PaymentBean(int paymentId, int userId, String transactionId, int artId, String name, String address,
			String city, String state, String zip, String country, String phone, double amount, String paymentStatus,
			String paymentDate) {
		super();
		this.paymentId = paymentId;
		this.userId = userId;
		this.transactionId = transactionId;
		this.artId = artId;
		this.name = name;
		this.address = address;
		this.city = city;
		this.state = state;
		this.zip = zip;
		this.country = country;
		this.phone = phone;
		this.amount = amount;
		this.paymentStatus = paymentStatus;
		this.paymentDate = paymentDate;
	}
	public int getPaymentId() {
		return paymentId;
	}
	public void setPaymentId(int paymentId) {
		this.paymentId = paymentId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getTransactionId() {
		return transactionId;
	}
	public void setTransactionId(String transactionId) {
		this.transactionId = transactionId;
	}
	public int getArtId() {
		return artId;
	}
	public void setArtId(int artId) {
		this.artId = artId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getZip() {
		return zip;
	}
	public void setZip(String zip) {
		this.zip = zip;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public double getAmount() {
		return amount;
	}
	public void setAmount(double amount) {
		this.amount = amount;
	}
	public String getPaymentStatus() {
		return paymentStatus;
	}
	public void setPaymentStatus(String paymentStatus) {
		this.paymentStatus = paymentStatus;
	}
	public String getPaymentDate() {
		return paymentDate;
	}
	public void setPaymentDate(String paymentDate) {
		this.paymentDate = paymentDate;
	}
	@Override
	public String toString() {
		return "PaymentBean [paymentId=" + paymentId + ", userId=" + userId + ", transactionId=" + transactionId
				+ ", artId=" + artId + ", name=" + name + ", address=" + address + ", city=" + city + ", state=" + state
				+ ", zip=" + zip + ", country=" + country + ", phone=" + phone + ", amount=" + amount
				+ ", paymentStatus=" + paymentStatus + ", paymentDate=" + paymentDate + "]";
	}
    
}
package com.wit.dto;

public class AddressBookDTO {
	private int addr_book_seq;
	private String emp_no;
	private String name;
	private String email;
	private String phone;
	private String address;
	private int category_id;
	private String photo;
	private String company;
	private String position;

	public AddressBookDTO(int addr_book_seq, String emp_no, String name, String email, String phone, String address,
			int category_id, String photo, String company, String position) {
		super();
		this.addr_book_seq = addr_book_seq;
		this.emp_no = emp_no;
		this.name = name;
		this.email = email;
		this.phone = phone;
		this.address = address;
		this.category_id = category_id;
		this.photo = photo;
		this.company = company;
		this.position = position;
	}

	public AddressBookDTO() {
		super();
	}

	public int getAddr_book_seq() {
		return addr_book_seq;
	}

	public void setAddr_book_seq(int addr_book_seq) {
		this.addr_book_seq = addr_book_seq;
	}

	public String getEmp_no() {
		return emp_no;
	}

	public void setEmp_no(String emp_no) {
		this.emp_no = emp_no;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public int getCategory_id() {
		return category_id;
	}

	public void setCategory_id(int category_id) {
		this.category_id = category_id;
	}

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}
}

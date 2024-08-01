package com.wit.dto;

public class AddressBookDTO {
	private int addr_book_seq;
	private String emp_no;
	private String name;
	private String email;
	private String phone;
	private String address;
	private String category;
	
	public AddressBookDTO(int addr_book_seq, String emp_no, String name, String email, String phone, String address,
			String category) {
		super();
		this.addr_book_seq = addr_book_seq;
		this.emp_no = emp_no;
		this.name = name;
		this.email = email;
		this.phone = phone;
		this.address = address;
		this.category = category;
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
	/**
	 * @return the name
	 */
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

	public String getCategory() {
		return category;
	}
	
	public void setCategory(String category) {
		this.category = category;
	}
}

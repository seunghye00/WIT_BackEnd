package com.wit.dto;

public class CategoriesDTO {
	private int category_id;
	private String emp_no;
	private String category_name;

	public CategoriesDTO(int category_id, String emp_no, String category_name) {
		super();
		this.category_id = category_id;
		this.emp_no = emp_no;
		this.category_name = category_name;
	}

	public CategoriesDTO() {
		super();
	}

	public int getCategory_id() {
		return category_id;
	}

	public void setCategory_id(int category_id) {
		this.category_id = category_id;
	}

	public String getEmp_no() {
		return emp_no;
	}

	public void setEmp_no(String emp_no) {
		this.emp_no = emp_no;
	}

	public String getCategory_name() {
		return category_name;
	}

	public void setCategory_name(String category_name) {
		this.category_name = category_name;
	}

}

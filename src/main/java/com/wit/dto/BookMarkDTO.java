package com.wit.dto;

public class BookMarkDTO {
	private int book_mark_seq;
	private int board_seq;
	private String emp_no;
	
	public BookMarkDTO() {
		super();
	}

	public BookMarkDTO(int book_mark_seq, int board_seq, String emp_no) {
		super();
		this.book_mark_seq = book_mark_seq;
		this.board_seq = board_seq;
		this.emp_no = emp_no;
	}

	public int getBook_mark_seq() {
		return book_mark_seq;
	}

	public void setBook_mark_seq(int book_mark_seq) {
		this.book_mark_seq = book_mark_seq;
	}

	public int getBoard_seq() {
		return board_seq;
	}

	public void setBoard_seq(int board_seq) {
		this.board_seq = board_seq;
	}

	public String getEmp_no() {
		return emp_no;
	}

	public void setEmp_no(String emp_no) {
		this.emp_no = emp_no;
	}
	
	
	
}

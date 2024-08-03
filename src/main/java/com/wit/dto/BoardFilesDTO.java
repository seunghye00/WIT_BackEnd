package com.wit.dto;

public class BoardFilesDTO {
    private int board_files_seq;
    private int board_seq;
    private String oriname;
    private String sysname;
    
    
	public BoardFilesDTO() {
		super();
	}

	public BoardFilesDTO(int board_files_seq, int board_seq, String oriname, String sysname) {
		super();
		this.board_files_seq = board_files_seq;
		this.board_seq = board_seq;
		this.oriname = oriname;
		this.sysname = sysname;
	}

	public int getBoard_files_seq() {
		return board_files_seq;
	}

	public void setBoard_files_seq(int board_files_seq) {
		this.board_files_seq = board_files_seq;
	}

	public int getBoard_seq() {
		return board_seq;
	}

	public void setBoard_seq(int board_seq) {
		this.board_seq = board_seq;
	}

	public String getOriname() {
		return oriname;
	}

	public void setOriname(String oriname) {
		this.oriname = oriname;
	}

	public String getSysname() {
		return sysname;
	}

	public void setSysname(String sysname) {
		this.sysname = sysname;
	}
    
	
    
}

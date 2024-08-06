package com.wit.dto;

public class DocumentFilesDTO {
	private int document_files_seq;
	private int document_seq;
	private String oriname;
	private String sysname;
	public int getDocument_files_seq() {
		return document_files_seq;
	}
	public void setDocument_files_seq(int document_files_seq) {
		this.document_files_seq = document_files_seq;
	}
	public int getDocument_seq() {
		return document_seq;
	}
	public void setDocument_seq(int document_seq) {
		this.document_seq = document_seq;
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
	public DocumentFilesDTO(int document_files_seq, int document_seq, String oriname, String sysname) {
		super();
		this.document_files_seq = document_files_seq;
		this.document_seq = document_seq;
		this.oriname = oriname;
		this.sysname = sysname;
	}
	public DocumentFilesDTO() {
		super();
	}
}

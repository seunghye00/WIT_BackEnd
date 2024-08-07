package com.wit.dto;

import java.sql.Timestamp;

// 전자 결재 메인 화면에서 문서 리스트 출력 시 원하는 데이터만 보관하기 위한 DTO
public class RecentDocuListDTO {
	private int document_seq;
	private Timestamp write_date;
	private String emer_yn;
	private String title;
	private String status;
	private String name;
	public int getDocument_seq() {
		return document_seq;
	}
	public void setDocument_seq(int document_seq) {
		this.document_seq = document_seq;
	}
	public Timestamp getWrite_date() {
		return write_date;
	}
	public void setWrite_date(Timestamp write_date) {
		this.write_date = write_date;
	}
	public String getEmer_yn() {
		return emer_yn;
	}
	public void setEmer_yn(String emer_yn) {
		this.emer_yn = emer_yn;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public RecentDocuListDTO(int document_seq, Timestamp write_date, String emer_yn, String title, String status,
			String name) {
		super();
		this.document_seq = document_seq;
		this.write_date = write_date;
		this.emer_yn = emer_yn;
		this.title = title;
		this.status = status;
		this.name = name;
	}
	public RecentDocuListDTO() {
		super();
	}
}

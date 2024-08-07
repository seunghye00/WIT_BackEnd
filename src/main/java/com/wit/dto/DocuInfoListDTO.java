package com.wit.dto;

import java.sql.Timestamp;

// 전자 결재의 각 페이지에서 문서 리스트 출력 시 원하는 데이터만 보관하기 위한 DTO
public class DocuInfoListDTO {
	private int document_seq;		// 문서 번호
	private String emp_no;			// 기안자 사번
	private String writer;			// 기안자 이름
	private Timestamp write_date;	// 기안일
	private String emer_yn;			// 긴급 여부
	private String title;			// 제목
	private String status;			// 문서 상태
	private String name;			// 문서 양식
	private String last_appr;		// 최종 결재자 사번
	private String last_appr_name;	// 최종 결재자 이름
	private Timestamp done_date;	// 완료일

	public DocuInfoListDTO() {
		super();
	}
	public DocuInfoListDTO(int document_seq, String emp_no, String writer, Timestamp write_date, String emer_yn,
			String title, String status, String name, String last_appr, String last_appr_name, Timestamp done_date) {
		super();
		this.document_seq = document_seq;
		this.emp_no = emp_no;
		this.writer = writer;
		this.write_date = write_date;
		this.emer_yn = emer_yn;
		this.title = title;
		this.status = status;
		this.name = name;
		this.last_appr = last_appr;
		this.last_appr_name = last_appr_name;
		this.done_date = done_date;
	}
	public int getDocument_seq() {
		return document_seq;
	}
	public void setDocument_seq(int document_seq) {
		this.document_seq = document_seq;
	}
	public String getEmp_no() {
		return emp_no;
	}
	public void setEmp_no(String emp_no) {
		this.emp_no = emp_no;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
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
	public String getLast_appr() {
		return last_appr;
	}
	public void setLast_appr(String last_appr) {
		this.last_appr = last_appr;
	}
	public String getLast_appr_name() {
		return last_appr_name;
	}
	public void setLast_appr_name(String last_appr_name) {
		this.last_appr_name = last_appr_name;
	}
	public Timestamp getDone_date() {
		return done_date;
	}
	public void setDone_date(Timestamp done_date) {
		this.done_date = done_date;
	}
	// 문서 번호, 기안일, 긴급, 제목, 문서 상태, 문서 양식 ( 메인 페이지 )
	public DocuInfoListDTO(int document_seq, Timestamp write_date, String emer_yn, String title, String status,
			String name) {
		super();
		this.document_seq = document_seq;
		this.write_date = write_date;
		this.emer_yn = emer_yn;
		this.title = title;
		this.status = status;
		this.name = name;
	}
	// 문서 번호, 작성자 사번, 기안일, 긴급, 제목, 문서 양식, 최종 결재자 사번 ( 결재 대기 or 결재 예정 문서함 )
	public DocuInfoListDTO(int document_seq, String emp_no, Timestamp write_date, String emer_yn, String title,
			String name, String last_appr) {
		super();
		this.document_seq = document_seq;
		this.emp_no = emp_no;
		this.write_date = write_date;
		this.emer_yn = emer_yn;
		this.title = title;
		this.name = name;
		this.last_appr = last_appr;
	}
	// 문서 번호, 기안일, 문서 양식, 긴급, 제목, 문서 상태, 최종 결재자 사번, 완료일 ( 기안 문서함 )
	public DocuInfoListDTO(int document_seq, Timestamp write_date, String emer_yn, String title, String status,
			String name, String last_appr, Timestamp done_date) {
		super();
		this.document_seq = document_seq;
		this.write_date = write_date;
		this.emer_yn = emer_yn;
		this.title = title;
		this.status = status;
		this.name = name;
		this.last_appr = last_appr;
		this.done_date = done_date;
	}
	// 문서 번호, 작성일, 문서 양식, 긴급, 제목 ( 임시 저장 문서함 )
	public DocuInfoListDTO(int document_seq, Timestamp write_date, String emer_yn, String title, String name) {
		super();
		this.document_seq = document_seq;
		this.write_date = write_date;
		this.emer_yn = emer_yn;
		this.title = title;
		this.name = name;
	}
	// 문서 번호, 기안일, 문서 양식, 긴급, 제목, 기안자 사번, 문서 상태, 완료일 ( 결재 or 참조 문서함 )
	public DocuInfoListDTO(int document_seq, String emp_no, Timestamp write_date, String emer_yn,
			String title, String status, String name, Timestamp done_date) {
		super();
		this.document_seq = document_seq;
		this.emp_no = emp_no;
		this.write_date = write_date;
		this.emer_yn = emer_yn;
		this.title = title;
		this.status = status;
		this.name = name;
		this.done_date = done_date;
	}
}

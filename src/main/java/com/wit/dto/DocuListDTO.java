package com.wit.dto;

// 문서 양식 목록에 대한 정보를 제어하기 위한 DTO
public class DocuListDTO {
	private String docu_code;
	private String name;
	public String getDocu_code() {
		return docu_code;
	}
	public void setDocu_code(String docu_code) {
		this.docu_code = docu_code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public DocuListDTO(String docu_code, String name) {
		super();
		this.docu_code = docu_code;
		this.name = name;
	}
	public DocuListDTO() {
		super();
	}
}

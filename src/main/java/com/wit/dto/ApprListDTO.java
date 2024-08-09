package com.wit.dto;

import java.util.List;

// 전자 결재 라인 목록에서 사번만 모아서 보관하기 위한 DTO
public class ApprListDTO {
	
    private List<String> apprList;

    public List<String> getApprList() {
        return apprList;
    }

    public void setApprList(List<String> apprList) {
        this.apprList = apprList;
    }

	public ApprListDTO(List<String> apprList) {
		super();
		this.apprList = apprList;
	}

	public ApprListDTO() {
		super();
	}
}

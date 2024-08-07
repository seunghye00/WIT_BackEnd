package com.wit.dto;

import java.util.List;

// 전자 결재 라인에 대한 데이터를 보관하기 위한 DTO
public class EApprovalLineDTO {
    private List<String> apprList;

    // Getters and setters
    public List<String> getApprList() {
        return apprList;
    }

    public void setApprList(List<String> apprList) {
        this.apprList = apprList;
    }
}

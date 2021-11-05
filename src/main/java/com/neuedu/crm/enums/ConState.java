package com.neuedu.crm.enums;

public enum ConState {
    DEF("草稿"),
    WAIT_AUDIT("待审批"),
    AUDIT("已审批"),
    ;

    private String val;

    ConState(String val) {
        this.val = val;
    }

    public String getVal() {
        return val;
    }
}

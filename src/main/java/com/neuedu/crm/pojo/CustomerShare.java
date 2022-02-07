package com.neuedu.crm.pojo;

public class CustomerShare {
    /**
     * 共享ID
     */
    private Integer id;

    /**
     * 流失用户的id
     */
    private Integer customerId;

    /**
     * 用户ID
     */
    private Integer userId;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Integer customerId) {
        this.customerId = customerId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }
}

package com.neuedu.crm.pojo;

import java.io.Serializable;
import java.util.Date;

/**
 * @Author hxs
 * @Date 2021/11/4 14:46
 * @Description
 * @Version 1.0
 */
public class Contract implements Serializable {
    /**
     * 合同主键
     */
    private Integer id;
    /**
     * 合同编号
     */
    private String contractNo;

    /**
     * 客户ID
     */
    private Integer customerId;

    /**
     * 客户姓名
     */
    private String customerName;

    /**
     * 签约人
     */
    private Integer signUserId;
    /**
     * 签约人
     */
    private String  signUserName;
    /**
     * 创建时间
     */
    private Date createDate;
    /**
     * 签约时间
     */
    private Date signDate;

    /**
     * 过期时间
     */
    private Date endDate;

    /**
     * 负责人
     */
    private Integer manageId;

    /**
     * 负责人
     */
    private String manageName;

    /**
     * 总额
     */
    private Double totalAmount;

    /**
     * 其他
     */
    private Double otherAmount;

    /**
     * 优惠价格
     */
    private Double discountAmount;

    /**
     * 合同金额
     */
    private Double contractAmount;

    /**
     * 合同成本
     */
    private Double baseAmount;

    /**
     * 合同类型
     */
    private String contractType;

    /**
     * 支付方式
     */
    private String payType;

    /**
     * 用户数
     */
    private String  userNum;

    /**
     * 使用年限
     */
    private Double limitYears;

    /**
     * 删除标识
     */
    private Integer delFlag;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getContractNo() {
        return contractNo;
    }

    public void setContractNo(String contractNo) {
        this.contractNo = contractNo;
    }

    public Integer getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Integer customerId) {
        this.customerId = customerId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public Integer getSignUserId() {
        return signUserId;
    }

    public void setSignUserId(Integer signUserId) {
        this.signUserId = signUserId;
    }

    public String getSignUserName() {
        return signUserName;
    }

    public void setSignUserName(String signUserName) {
        this.signUserName = signUserName;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Date getSignDate() {
        return signDate;
    }

    public void setSignDate(Date signDate) {
        this.signDate = signDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public Integer getManageId() {
        return manageId;
    }

    public void setManageId(Integer manageId) {
        this.manageId = manageId;
    }

    public String getManageName() {
        return manageName;
    }

    public void setManageName(String manageName) {
        this.manageName = manageName;
    }

    public Double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(Double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public Double getOtherAmount() {
        return otherAmount;
    }

    public void setOtherAmount(Double otherAmount) {
        this.otherAmount = otherAmount;
    }

    public Double getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(Double discountAmount) {
        this.discountAmount = discountAmount;
    }

    public Double getContractAmount() {
        return contractAmount;
    }

    public void setContractAmount(Double contractAmount) {
        this.contractAmount = contractAmount;
    }

    public Double getBaseAmount() {
        return baseAmount;
    }

    public void setBaseAmount(Double baseAmount) {
        this.baseAmount = baseAmount;
    }

    public String getContractType() {
        return contractType;
    }

    public void setContractType(String contractType) {
        this.contractType = contractType;
    }

    public String getPayType() {
        return payType;
    }

    public void setPayType(String payType) {
        this.payType = payType;
    }

    public Integer getDelFlag() {
        return delFlag;
    }

    public void setDelFlag(Integer delFlag) {
        this.delFlag = delFlag;
    }

    public String getUserNum() {
        return userNum;
    }

    public void setUserNum(String userNum) {
        this.userNum = userNum;
    }

    public Double getLimitYears() {
        return limitYears;
    }

    public void setLimitYears(Double limitYears) {
        this.limitYears = limitYears;
    }
}

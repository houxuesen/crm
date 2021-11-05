package com.neuedu.crm.pojo;

import java.io.Serializable;
import java.time.LocalDate;
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
    private LocalDate signDate;

    /**
     * 过期时间
     */
    private LocalDate endDate;

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
    private String limitYears;

    /**
     * 文件
     */
    private String document;

    /**
     * 删除标识
     */
    private Integer delFlag;

    /**
     * 合同状态
     */
    private String conState;

    private Integer  createUserId;
    private Integer updateUserId;
    private String updater;
    private Date updateDate;
    private String creater;

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

    public LocalDate getSignDate() {
        return signDate;
    }

    public void setSignDate(LocalDate signDate) {
        this.signDate = signDate;
    }

    public LocalDate getEndDate() {
        return endDate;
    }

    public void setEndDate(LocalDate endDate) {
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

    public String getLimitYears() {
        return limitYears;
    }

    public void setLimitYears(String limitYears) {
        this.limitYears = limitYears;
    }

    public Integer getCreateUserId() {
        return createUserId;
    }

    public void setCreateUserId(Integer createUserId) {
        this.createUserId = createUserId;
    }

    public Integer getUpdateUserId() {
        return updateUserId;
    }

    public void setUpdateUserId(Integer updateUserId) {
        this.updateUserId = updateUserId;
    }

    public String getUpdater() {
        return updater;
    }

    public void setUpdater(String updater) {
        this.updater = updater;
    }

    public Date getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    public String getCreater() {
        return creater;
    }

    public void setCreater(String creater) {
        this.creater = creater;
    }

    public String getDocument() {
        return document;
    }

    public void setDocument(String document) {
        this.document = document;
    }

    public String getConState() {
        return conState;
    }

    public void setConState(String conState) {
        this.conState = conState;
    }
}

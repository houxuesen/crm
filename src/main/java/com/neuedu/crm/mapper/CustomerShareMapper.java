package com.neuedu.crm.mapper;

import com.neuedu.crm.pojo.*;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * CustomerLossMapper继承基类
 * @author MybatisGenerator
 */
public interface CustomerShareMapper extends MyBatisBaseDao<CustomerShare, Integer, CustomerShareExample> {
	
	/**
	* 描述：
    * @Title: insertCustomerShareBatch
    * @Description: TODO(批量插入)
    * @param @param orders
    * @param @return    参数
    * @return int    返回类型
    * @throws
    * @author huangqingwen
	*/
	public int insertCustomerShareBatch(@Param("customerShares")List<CustomerShare> customerShares);
}
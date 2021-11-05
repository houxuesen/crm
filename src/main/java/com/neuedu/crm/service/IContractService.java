package com.neuedu.crm.service;

import com.neuedu.crm.pojo.Contract;
import com.neuedu.crm.pojo.ContractExample;
import com.neuedu.crm.pojo.Linkman;

import java.util.List;

/**
 * @author HuangQingwen
 * @date 2018/07/11
 */
public interface IContractService {
	
    /**
     * 描述：按照Example 统计记录总数
     * @author HuangQingwen
     * @date 2018/07/11
     * @version 1.0
     * @param ContractExample
     * @return long
     * @since 1.8
     *
     */
	public long countByContractExample(ContractExample ContractExample);
	
	/**
	 * 描述：按照Example 删除Contract
	 * @author HuangQingwen
	 * @date 2018/07/11
	 * @version 1.0
	 * @param ContractExample
	 * @return boolean
	 * @since 1.8
	 *
	 */
	public boolean deleteByContractExample(ContractExample ContractExample);
	
	/**
	 * 描述：按照Contract主键id删除Contract
	 * @author HuangQingwen
	 * @date 2018/07/11
	 * @version 1.0
	 * @param id
	 * @return boolean
	 * @since 1.8
	 *
	 */
	public boolean deleteByPrimaryKey(Integer id);
	
	/**
	 * 描述：插入一条Contract数据 如字段为空，则插入null
	 * @author HuangQingwen
	 * @date 2018/07/11
	 * @version 1.0
	 * @param Contract
	 * @return boolean
	 * @since 1.8
	 *
	 */
	public boolean insertContract(Contract Contract);
	
	/**
	 * 描述：插入一条Contract数据，如字段为空，则插入数据库表字段的默认值
	 * @author HuangQingwen
	 * @date 2018/07/11
	 * @version 1.0
	 * @param Contract
	 * @return boolean
	 * @since 1.8
	 *
	 */
	public boolean insertSelective(Contract Contract);
	
	/**
	 * 描述：按照Example 条件 模糊查询
	 * @author HuangQingwen
	 * @date 2018/07/11
	 * @version 1.0
	 * @param ContractExample
	 * @return List<Contract>
	 * @since 1.8
	 *
	 */
	public List<Contract> selectByContractExample(ContractExample ContractExample);
	
	/**
	 * 描述：按照Contract 的id 查找 Contract
	 * @author HuangQingwen
	 * @date 2018/07/11
	 * @version 1.0
	 * @param id
	 * @return Contract
	 * @since 1.8
	 *
	 */
	public Contract selectContractByPrimaryKey(Integer id);
	
	/**
	 * 描述：更新Contract ， Contract对象中若有空则不会更新此字段  ContractExample为where条件
	 * @author HuangQingwen
	 * @date 2018/07/11
	 * @version 1.0
	 * @param Contract
	 * @param ContractExample
	 * @return boolean
	 * @since 1.8
	 *
	 */
	public boolean updateByContractExampleSelective(Contract Contract, ContractExample ContractExample);
	
	/**
	 * 描述：更新Contract， Contract对象中若有空则更新字段为null   ContractExample为where条件
	 * @author HuangQingwen
	 * @date 2018/07/11
	 * @version 1.0
	 * @param Contract
	 * @param ContractExample
	 * @return boolean
	 * @since 1.8
	 *
	 */
	public boolean updateByContractExample(Contract Contract, ContractExample ContractExample);
	
	/**
	 * 描述：按照Contract id 更新Contract  Contract对象中如有空则不会更新此字段
	 * @author HuangQingwen
	 * @date 2018/07/11
	 * @version 1.0
	 * @param Contract
	 * @return boolean
	 * @since 1.8
	 *
	 */
	public boolean updateContractByPrimaryKeySelective(Contract Contract);
	
	/**
	 * 描述：按照Contract id 更新Contract  Contract对象中如有空则更新此字段为null
	 * @author HuangQingwen
	 * @date 2018/07/11
	 * @version 1.0
	 * @param Contract
	 * @return boolean
	 * @since 1.8
	 *
	 */
	public boolean updateContractByPrimaryKey(Contract Contract);

	/**
	 * 描述：添加客户，同时设置主要联系人
	 * @author HuangWanzong
	 * @date 2018/07/11
	 * @version 1.0
	 * @param Contract
	 * @param linkman
	 * @return boolean
	 * @since 1.8
	 *
	 */
	public boolean insertSelective(Contract Contract, Linkman linkman);
}

package com.neuedu.crm.service.impl;


import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.neuedu.crm.mapper.RoleMapper;
import com.neuedu.crm.pojo.*;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.neuedu.crm.mapper.CustomerMapper;
import com.neuedu.crm.mapper.SaleOpportunityMapper;
import com.neuedu.crm.mapper.UserMapper;
import com.neuedu.crm.pojo.SaleOpportunityExample.Criteria;
import com.neuedu.crm.service.ISaleOpportunityService;
import org.springframework.util.StringUtils;

/**
 * 
 * @author WangHaoyu
 * @date 2018/07/24
 */
@Service
@Transactional(rollbackFor=Exception.class)
public class SaleOpportunityServiceImpl implements ISaleOpportunityService {

	@Autowired
	private SaleOpportunityMapper saleOpportunityMapper;
	@Autowired
	private CustomerMapper customerMapper;
	@Autowired
	private UserMapper userMapper;

	@Autowired
	private RoleMapper roleMapper;
	
	org.slf4j.Logger logger = LoggerFactory.getLogger(SaleOpportunityServiceImpl.class);
	
	@Override
	public long countBySaleOpportunityExample(SaleOpportunityExample saleOpportunityExample) {
		return saleOpportunityMapper.countByExample(saleOpportunityExample);
	}

	@Override
	public boolean deleteBySaleOpportunityExample(SaleOpportunityExample saleOpportunityExample) {
		return saleOpportunityMapper.deleteByExample(saleOpportunityExample) > 0 ? true : false;
	}

	@Override
	public boolean deleteByPrimaryKey(Integer id) {
		return saleOpportunityMapper.deleteByPrimaryKey(id) > 0 ? true : false;
	}

	@Override
	public boolean insertSaleOpportunity(SaleOpportunity saleOpportunity) {
		return saleOpportunityMapper.insert(saleOpportunity) > 0 ? true : false;
	}

	@Override
	public boolean insertSelective(SaleOpportunity saleOpportunity) {
		return saleOpportunityMapper.insertSelective(saleOpportunity) > 0 ? true : false;
	}

	@Override
	public List<SaleOpportunity> selectBySaleOpportunityExample(SaleOpportunityExample saleOpportunityExample) {
		return saleOpportunityMapper.selectByExample(saleOpportunityExample);
	}

	@Override
	public List<SaleOpportunity> selectBySaleOpportunitySelectiveAndPager(SaleOpportunity saleOpportunity,Pager pager,HttpServletRequest request){
		SaleOpportunityExample opportunityExample = new SaleOpportunityExample();
		Criteria criteria = opportunityExample.createCriteria();
		
		//where??????
		if(saleOpportunity.getId()!=null){
			criteria.andIdEqualTo(saleOpportunity.getId());
		}
		//????????????
		if(saleOpportunity.getSuccess()!=null){
			criteria.andSuccessGreaterThan(saleOpportunity.getSuccess());
		}
		//????????????
		if(saleOpportunity.getDeleteStatus()!=null){
			criteria.andDeleteStatusEqualTo(saleOpportunity.getDeleteStatus());
		}
		//????????????
		if(saleOpportunity.getStatus()!=null){
			criteria.andStatusLike("%"+saleOpportunity.getStatus()+"%");
		}
		//????????????
		if(saleOpportunity.getCustomer()!=null&&saleOpportunity.getCustomer().getName()!=null){
			//?????????????????????????????????Id
			//logger.info(saleOpportunity.getCustomer().getName().toString());
			CustomerExample customerExample = new CustomerExample();
			com.neuedu.crm.pojo.CustomerExample.Criteria criteria2 = customerExample.createCriteria();
			criteria2.andNameLike("%"+saleOpportunity.getCustomer().getName()+"%");
			List<Customer> list = customerMapper.selectByExample(customerExample);
			//???Id????????????example
			List<Integer> arrayList = new ArrayList<>();
			for(Customer c:list){
				arrayList.add(c.getId());
			}
			if(arrayList.size()==0){
				return null;
			}
			criteria.andCustomerIdIn(arrayList);
		}
		//?????????
		/*if(saleOpportunity.getCreaterUser()!=null&&saleOpportunity.getCreaterUser().getRealName()!=null){
			//????????????????????????UserId
			UserExample userExample = new UserExample();
			com.neuedu.crm.pojo.UserExample.Criteria criteria3 = userExample.createCriteria();
			criteria3.andRealNameLike("%"+saleOpportunity.getCreaterUser().getRealName()+"%");
			List<User> list = userMapper.selectByExample(userExample);
			//???Id????????????example
			List<Integer> arrayList = new ArrayList<>();
			for(User user:list){
				arrayList.add(user.getId());
			}
			if(arrayList.size()==0){
				return null;
			}
		}*/
		
		// ????????????
		if (saleOpportunity.getManager()!=null&&saleOpportunity.getManager().getRealName() != null) {
			// ???????????????????????????UserId
			UserExample userExample = new UserExample();
			com.neuedu.crm.pojo.UserExample.Criteria criteria4 = userExample.createCriteria();
			criteria4.andRealNameLike("%" + saleOpportunity.getManager().getRealName() + "%");
			List<User> list = userMapper.selectByExample(userExample);
			// ???Id????????????example
			List<Integer> arrayList = new ArrayList<>();
			for (User user : list) {
				arrayList.add(user.getId());
			}
			//????????????????????????sql??????????????????
			if(arrayList.size()==0){
				return null;
			}
			criteria.andManagerIdIn(arrayList);
		}
		
		//??????????????????(?????????)???????????????   0????????????  1????????????
		criteria.andDeleteStatusNotEqualTo(1);
		//??????????????????????????????????????????????????????????????????????????????????????????????????????
		User u = (User) request.getSession().getAttribute("user");
		Role role = roleMapper.selectByPrimaryKey(u.getRoleId());
		if(role != null){
			if("????????????".equals(role.getName())) {
				//???????????????ID
				criteria.andManagerIdEqualTo(u.getId());
			}
		}

		if(!StringUtils.isEmpty(saleOpportunity.getCheckStatus())){
			criteria.andCheckStatusEqualTo(saleOpportunity.getCheckStatus());
		}


		if(!StringUtils.isEmpty(saleOpportunity.getResultStatus())){
			criteria.andResultStatusEqualTo(saleOpportunity.getResultStatus());
		}

		//??????????????????
		criteria.andCustomerIdIsNotNull();

		opportunityExample.setOrderByClause(" create_Date desc");

		//????????????
		opportunityExample.setLimit(pager.getPageSize());
		opportunityExample.setOffset(new Long(pager.getOffset()));
		Long count = this.countBySaleOpportunityExample(opportunityExample);
		pager.setTotal(count.intValue());
		
		return this.selectBySaleOpportunityExample(opportunityExample);
		
		/*//????????????????????????????????????????????????????????????
		List<SaleOpportunity> list2 = new ArrayList<>();
		list2 = list;
		
		int i = 0;
		for(SaleOpportunity o:list2){
			if(o.getCustomerId()==null){
				list.remove(i);
				o.setDeleteStatus(1);
				this.updateSaleOpportunityByPrimaryKey(o);
			}
			i++;
		}
		
		return list;*/
	}
	
	
	@Override
	public SaleOpportunity selectSaleOpportunityByPrimaryKey(Integer id) {
		return saleOpportunityMapper.selectByPrimaryKey(id);
	}

	@Override
	public boolean updateBySaleOpportunityExampleSelective(SaleOpportunity saleOpportunity, SaleOpportunityExample saleOpportunityExample) {
		return saleOpportunityMapper.updateByExampleSelective(saleOpportunity, saleOpportunityExample) > 0 ? true : false;
	}

	@Override
	public boolean updateBySaleOpportunityExample(SaleOpportunity saleOpportunity, SaleOpportunityExample saleOpportunityExample) {
		return saleOpportunityMapper.updateByExample(saleOpportunity, saleOpportunityExample) > 0 ? true : false;
	}

	@Override
	public boolean updateSaleOpportunityByPrimaryKeySelective(SaleOpportunity saleOpportunity) {
		return saleOpportunityMapper.updateByPrimaryKeySelective(saleOpportunity) > 0 ? true : false;
	}

	@Override
	public boolean updateSaleOpportunityByPrimaryKey(SaleOpportunity saleOpportunity) {
		return saleOpportunityMapper.updateByPrimaryKey(saleOpportunity) > 0 ? true : false ;
	}

	/** (non-Javadoc)
	 * @see com.neuedu.crm.service.ISaleOpportunityService#deleteSaleOpportunitiesByPrimaryKey(java.lang.String)
	 */
	@Override
	public boolean deleteSaleOpportunitiesByPrimaryKey(String ids) {
            //??????ids??????????????????????????????
            String[] idsStrings = ids.split("-");
            for (String idString : idsStrings) {
                Integer id = Integer.parseInt(idString);
                SaleOpportunity saleOpportunity = new SaleOpportunity();
                saleOpportunity.setId(id);
                saleOpportunity.setDeleteStatus(1);
                //??????????????????????????????????????????
                if(saleOpportunityMapper.updateByPrimaryKeySelective(saleOpportunity) < 1){
                	return false;
                	}
            	}
        return true;
	}

	@Override
	public boolean loseSaleOpportunitiesByPrimaryKey(String ids) {
		//??????ids??????????????????????????????
		String[] idsStrings = ids.split("-");
		for (String idString : idsStrings) {
			Integer id = Integer.parseInt(idString);
			SaleOpportunity saleOpportunity = new SaleOpportunity();
			saleOpportunity.setId(id);
			saleOpportunity.setResultStatus("??????");
			//??????????????????????????????????????????
			if(saleOpportunityMapper.updateByPrimaryKeySelective(saleOpportunity) < 1){
				return false;
			}
		}
		return true;
	}
}

package com.neuedu.crm.service.impl;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.neuedu.crm.mapper.CustomerShareMapper;
import com.neuedu.crm.pojo.*;
import com.neuedu.crm.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.neuedu.crm.mapper.CustomerTransferMapper;
import com.neuedu.crm.mapper.UserMapper;

/**
 * 
 * @author WangHaoyu
 * @date 2018/07/24
 */
@Service
@Transactional(rollbackFor=Exception.class)
public class CustomerTransferServiceImpl implements ICustomerTransferService{
	@Autowired
	private CustomerTransferMapper customerTransferMapper;
	
	@Autowired
	private UserMapper userMapper;

	@Autowired
	private ICustomerService customerService;

	@Autowired
	private IUserService userService;

	@Autowired
	private ISaleOpportunityService saleOpportunityService;

	@Autowired
	private ICustomerCareService customerCareService;

	@Autowired
	private CustomerShareMapper customerShareMapper;
	
	@Override
	public long countByCustomerTransferExample(CustomerTransferExample customerTransferExample) {
		return customerTransferMapper.countByExample(customerTransferExample);
	}

	@Override
	public boolean deleteByCustomerTransferExample(CustomerTransferExample customerTransferExample) {
		return customerTransferMapper.deleteByExample(customerTransferExample) > 0 ? true : false;
	}

	@Override
	public boolean deleteByPrimaryKey(Integer id) {
		return customerTransferMapper.deleteByPrimaryKey(id) > 0 ? true : false;
	}

	@Override
	public boolean insertCustomerTransfer(CustomerTransfer customerTransfer) {
		return customerTransferMapper.insert(customerTransfer) > 0 ? true : false;
	}

	@Override
	public boolean insertSelective(CustomerTransfer customerTransfer) {
		return customerTransferMapper.insertSelective(customerTransfer) > 0 ? true : false;
	}

	@Override
	public Map<String,Object> insertManySelective(CustomerTransfer transfer, int[] customers) {
		Map<String,Object> map = new HashMap<String,Object>(16);

		for(int i = 0;i<customers.length;i++){
			transfer.setCustomerId(customers[i]);
			//????????????????????????????????????


			Customer customer = customerService.selectCustomerByPrimaryKey(transfer.getCustomerId());

			if(customer == null) {
				continue;
			}

			//??????????????????
			if(transfer.getOldManagerId() == null) {
				transfer.setOldManagerId(customer.getManagerId());
			}

			//?????????????????????????????????
			if(transfer.getNewManagerId().equals(transfer.getOldManagerId())) {
				continue;
			}


			//???????????????????????????????????????
			transfer.setTime(LocalDateTime.now());

			//??????????????????
			try {
				//?????????????????????????????????
				this.insertSelective(transfer);
				//????????????????????????ID
				customer.setManagerId(transfer.getNewManagerId());
				customerService.updateCustomerByPrimaryKeySelective(customer);

				//??????????????????
				//???????????????????????????????????????
				SaleOpportunityExample saleOpportunityExample = new SaleOpportunityExample();
				saleOpportunityExample.createCriteria().andManagerIdEqualTo(transfer.getOldManagerId());
				List<SaleOpportunity> saleOpportunities = saleOpportunityService.selectBySaleOpportunityExample(saleOpportunityExample);
				if(saleOpportunities != null){
					for (SaleOpportunity saleOpportunity : saleOpportunities) {
						//???????????????????????????????????????
						saleOpportunity.setManagerId(transfer.getNewManagerId());
						saleOpportunityService.updateSaleOpportunityByPrimaryKeySelective(saleOpportunity);
					}

				}

				//??????????????????
				//???????????????????????????????????????
				CustomerCareExample customerCareExample = new CustomerCareExample();
				customerCareExample.createCriteria().andManagerIdEqualTo(transfer.getOldManagerId());
				List<CustomerCare> customerCares = customerCareService.selectByCustomerCareExample(customerCareExample);
				if(customerCares != null){
					for (CustomerCare customerCare : customerCares) {
						//???????????????????????????????????????
						customerCare.setManagerId(transfer.getNewManagerId());
						customerCareService.updateCustomerCareByPrimaryKeySelective(customerCare);
					}
				}


			} catch (Exception e) {

				e.printStackTrace();
				map.put("code", -1000);
				map.put("status", false);
				map.put("msg", "????????????");
				return map;
			}
		}

		map.put("code", 0);
		map.put("status", true);
		map.put("msg", "????????????");

		return map;
	}

	@Override
	public List<CustomerTransfer> selectByCustomerTransferExample(CustomerTransferExample customerTransferExample) {
		
	    List<CustomerTransfer> list = customerTransferMapper.selectByExample(customerTransferExample);
	    
	    for(CustomerTransfer transfer:list) {
	        try {
	            User oldManager = userMapper.selectByPrimaryKey(transfer.getOldManagerId());
	            if(oldManager != null) {
	                oldManager.setPassword(null);
	                oldManager.setSalt(null);
	            }
	            transfer.setOldManager(oldManager);
	            
	            User newManager = userMapper.selectByPrimaryKey(transfer.getNewManagerId());
	            if(newManager != null) {
	                newManager.setPassword(null);
	                newManager.setSalt(null);
	            }
	            transfer.setNewManager(newManager);
	        }catch (Exception e) {
            }
	    }
	    return list;
	}

	@Override
	public CustomerTransfer selectCustomerTransferByPrimaryKey(Integer id) {
	    CustomerTransfer transfer = customerTransferMapper.selectByPrimaryKey(id);
	    try {
            User oldManager = userMapper.selectByPrimaryKey(transfer.getOldManagerId());
            if(oldManager != null) {
                oldManager.setPassword(null);
                oldManager.setSalt(null);
            }
            transfer.setOldManager(oldManager);
            
            User newManager = userMapper.selectByPrimaryKey(transfer.getNewManagerId());
            if(newManager != null) {
                newManager.setPassword(null);
                newManager.setSalt(null);
            }
            transfer.setNewManager(newManager);
        }catch (Exception e) {
        }
		return transfer;
	}

	@Override
	public boolean updateByCustomerTransferExampleSelective(CustomerTransfer customerTransfer, CustomerTransferExample customerTransferExample) {
		return customerTransferMapper.updateByExampleSelective(customerTransfer, customerTransferExample) > 0 ? true : false;
	}

	@Override
	public boolean updateByCustomerTransferExample(CustomerTransfer customerTransfer, CustomerTransferExample customerTransferExample) {
		return customerTransferMapper.updateByExample(customerTransfer, customerTransferExample) > 0 ? true : false;
	}

	@Override
	public boolean updateCustomerTransferByPrimaryKeySelective(CustomerTransfer customerTransfer) {
		return customerTransferMapper.updateByPrimaryKeySelective(customerTransfer) > 0 ? true : false;
	}

	@Override
	public boolean updateCustomerTransferByPrimaryKey(CustomerTransfer customerTransfer) {
		return customerTransferMapper.updateByPrimaryKey(customerTransfer) > 0 ? true : false ;
	}

	@Override
	public Map<String, Object> shareCustomers(CustomerShare share, int[] customers) {
		Map<String,Object> map = new HashMap<String,Object>(16);
		//??????????????????
		try {
			for(int i:customers){
				CustomerShare customerShare = new CustomerShare();
				customerShare.setUserId(share.getCustomerId());
				customerShare.setCustomerId(i);
				customerShareMapper.insert(customerShare);
			}
		} catch (Exception e) {

			e.printStackTrace();
			map.put("code", -1000);
			map.put("status", false);
			map.put("msg", "????????????");
			return map;
		}

		map.put("code", 0);
		map.put("status", true);
		map.put("msg", "????????????");

		return map;
	}
}

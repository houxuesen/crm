package com.neuedu.crm.service.impl;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.neuedu.crm.mapper.CustomerMapper;
import com.neuedu.crm.mapper.LinkmanMapper;
import com.neuedu.crm.mapper.ProductMapper;
import com.neuedu.crm.mapper.UserMapper;
import com.neuedu.crm.pojo.Customer;
import com.neuedu.crm.pojo.CustomerExample;
import com.neuedu.crm.pojo.Linkman;
import com.neuedu.crm.pojo.Product;
import com.neuedu.crm.pojo.User;
import com.neuedu.crm.service.ICustomerService;
import org.springframework.util.StringUtils;

/**
 * 
 * @author WangHaoyu
 * @date 2018/07/24
 */
@Service
@Transactional(rollbackFor=Exception.class)
public class CustomerServiceImpl implements ICustomerService{

	@Autowired
	private CustomerMapper customerMapper;
	
	@Autowired
	private LinkmanMapper linkmanMapper;
	
	@Autowired
	private UserMapper userMapper;
	
	@Autowired
	private ProductMapper productMapper;
	
	
	@Override
	public long countByCustomerExample(CustomerExample customerExample) {
		return customerMapper.countByExample(customerExample);
	}

	@Override
	public boolean deleteByCustomerExample(CustomerExample customerExample) {
		if(customerMapper.deleteByExample(customerExample) > 0) {
		    return true;
		}else {
            return false;
        }
	}

	@Override
	public boolean deleteByPrimaryKey(Integer id) {
	    
	    Customer customer = new Customer();
	    customer.setId(id);
	    customer.setDeleteStatus(1);
	    
		if(customerMapper.updateByPrimaryKeySelective(customer) > 0) {
		    return true;
		}else {
            return false;
        }
	}

	@Override
	public boolean insertCustomer(Customer customer) {
		if(customerMapper.insert(customer) > 0) {
		    return true;
		}else {
            return false;
        }
	}

	@Override
	public boolean insertSelective(Customer customer) {
		if(customerMapper.insertSelective(customer) > 0) {
		    return true;
		}else {
		    return false;
        }
		
	}

    @Override
    public boolean insertSelective(Customer customer,Linkman linkman) {
        //??????????????????
        if(customerMapper.insertSelective(customer) > 0) {
            
            CustomerExample example = new CustomerExample();
            example.createCriteria().andNameEqualTo(customer.getName());
            
            customer = customerMapper.selectByExample(example).get(0);
            
            linkman.setCustomerId(customer.getId());
            linkman.setLevel(0);
            linkmanMapper.insertSelective(linkman);
            
            return true;
        }else {
            return false;
        }
        
    }

	@Override
	public boolean insertSelectiveFromExl(List<List<Object>> list,User user) throws Exception {
		//????????????
		// ??????/??????
		// ?????????
		// ????????????
		// ????????????
		// ????????????
		// ????????????
		// ????????????
		// ?????????
		// ????????????

		for(List<Object> objects:list){
			Customer customer = new Customer();
			customer.setName(objects.get(0).toString());
			customer.setRealmName(objects.get(1).toString());
			customer.setUserNum(objects.get(2).toString());
			customer.setEndDate( !StringUtils.isEmpty(objects.get(3)) ? LocalDate.parse(objects.get(3).toString()):null);
			customer.setSource(objects.get(4).toString());
			customer.setCompanyPhone(objects.get(5).toString());
			customer.setStatus(objects.get(6).toString());
			//?????????????????????????????????
			customer.setManagerId(user.getId());
			//???????????????id
			customer.setCreater(user.getId());
			//??????????????????
			customer.setCreateTime(LocalDateTime.now());
			//???????????????
			customer.setDeleteStatus(0);

			customer.setDescription(objects.get(10).toString());
			Linkman linkman = new Linkman();
			linkman.setName(objects.get(8).toString());
			linkman.setOfficePhone(objects.get(9).toString());

			//??????????????????
			this.insertSelective(customer,linkman);
		}
		return true;
	}

	@Override
	public List<Customer> selectByCustomerExample(CustomerExample customerExample) {
	    
	    List<Customer> list = customerMapper.selectByExample(customerExample);
	    
	    for(Customer customer:list) {
	        try {
	            Product product = productMapper.selectByPrimaryKey(customer.getProductId());
	            customer.setProduct(product);
	            
	            User creater = userMapper.selectByPrimaryKey(customer.getCreater());  
	            if(creater != null) {
	                creater.setPassword(null);
	                creater.setSalt(null);
	            }
	            customer.setCreaterObject(creater);
	            
	            User manager = userMapper.selectByPrimaryKey(customer.getManagerId());
	            if(manager != null) {
	                manager.setPassword(null);
	                manager.setSalt(null);
	            }
	            customer.setManager(manager);
	        }catch (Exception e) {
            }
	    }
		return list;
	}

	@Override
	public Customer selectCustomerByPrimaryKey(Integer id) {
	    Customer customer = customerMapper.selectByPrimaryKey(id);
	    try {
            Product product = productMapper.selectByPrimaryKey(customer.getProductId());
            customer.setProduct(product);
            
            User creater = userMapper.selectByPrimaryKey(customer.getCreater());  
            if(creater != null) {
                creater.setPassword(null);
                creater.setSalt(null);
            }
            customer.setCreaterObject(creater);
            
            User manager = userMapper.selectByPrimaryKey(customer.getManagerId());
            if(manager != null) {
                manager.setPassword(null);
                manager.setSalt(null);
            }
            customer.setManager(manager);
        }catch (Exception e) {
        }
		return customer;
	}

	@Override
	public boolean updateByCustomerExampleSelective(Customer customer, CustomerExample customerExample) {
		if(customerMapper.updateByExampleSelective(customer, customerExample) > 0) {
		    return true;
		}else {
		    return false;
		}
	}

	@Override
	public boolean updateByCustomerExample(Customer customer, CustomerExample customerExample) {
		if(customerMapper.updateByExample(customer, customerExample) > 0) {
		    return true;
		}else {
            return false;
        }
	}

	@Override
	public boolean updateCustomerByPrimaryKeySelective(Customer customer) {
		if(customerMapper.updateByPrimaryKeySelective(customer) > 0) {
		    return true;
		}else {
            return false;
        }
	}

	@Override
	public boolean updateCustomerByPrimaryKey(Customer customer) {
		if(customerMapper.updateByPrimaryKey(customer) > 0) {
		    return true;
		}else {
		    return false;
		}
	}

}

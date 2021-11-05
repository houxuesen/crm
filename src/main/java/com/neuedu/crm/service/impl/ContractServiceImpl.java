package com.neuedu.crm.service.impl;

import com.neuedu.crm.mapper.ContractMapper;
import com.neuedu.crm.mapper.CustomerMapper;
import com.neuedu.crm.mapper.LinkmanMapper;
import com.neuedu.crm.mapper.UserMapper;
import com.neuedu.crm.pojo.Contract;
import com.neuedu.crm.pojo.ContractExample;
import com.neuedu.crm.pojo.Linkman;
import com.neuedu.crm.service.IContractService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @Author hxs
 * @Date 2021/11/5 10:14
 * @Description
 * @Version 1.0
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class ContractServiceImpl implements IContractService {

    @Autowired
    private ContractMapper contractMapper;


    @Autowired
    private UserMapper userMapper;


    @Override
    public long countByContractExample(ContractExample ContractExample) {
        return contractMapper.countByExample(ContractExample);
    }

    @Override
    public boolean deleteByContractExample(ContractExample ContractExample) {
        return false;
    }

    @Override
    public boolean deleteByPrimaryKey(Integer id) {
        Contract contract =  new Contract();
        contract.setId(id);
        contract.setDelFlag(1);
        return this.updateContractByPrimaryKey(contract);
    }

    @Override
    public boolean insertContract(Contract Contract) {
        if (contractMapper.insert(Contract) > 0) {
            return true;
        } else {
            return false;
        }

    }

    @Override
    public boolean insertSelective(Contract Contract) {
        if (contractMapper.insertSelective(Contract) > 0) {
            return true;
        } else {
            return false;
        }
    }

    @Override
    public List<Contract> selectByContractExample(ContractExample ContractExample) {
        return contractMapper.selectByExample(ContractExample);
    }

    @Override
    public Contract selectContractByPrimaryKey(Integer id) {
        return contractMapper.selectByPrimaryKey(id);
    }

    @Override
    public boolean updateByContractExampleSelective(Contract Contract, ContractExample ContractExample) {
        return false;
    }

    @Override
    public boolean updateByContractExample(Contract Contract, ContractExample ContractExample) {
        return false;
    }

    @Override
    public boolean updateContractByPrimaryKeySelective(Contract Contract) {
        if (contractMapper.updateByPrimaryKeySelective(Contract) > 0) {
            return true;
        } else {
            return false;
        }
    }

    @Override
    public boolean updateContractByPrimaryKey(Contract Contract) {
        if (contractMapper.updateByPrimaryKeySelective(Contract) > 0) {
            return true;
        } else {
            return false;
        }
    }

    @Override
    public boolean insertSelective(Contract Contract, Linkman linkman) {
        return false;
    }
}

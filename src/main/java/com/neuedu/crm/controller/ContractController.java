package com.neuedu.crm.controller;

import com.neuedu.crm.pojo.*;
import com.neuedu.crm.pojo.ContractExample.Criteria;
import com.neuedu.crm.service.IContractService;
import com.neuedu.crm.service.ICustomerService;
import com.neuedu.crm.service.IUserService;
import com.neuedu.crm.utils.Operation;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.*;

/**
 * 
 * @author huangwanzong
 * @date 2018年7月6日
 */
@Controller
@RequestMapping("contract")
public class ContractController {
    @Autowired
    private IContractService contractService;
    
    @Autowired
    private ICustomerService customerService;

    @Autowired
    private IUserService userService;
    
    
    private User user = null;

    /**
     * @author huangwanzong
     * @date 2018年7月6日
     */
    private User getUser(HttpServletRequest request) {
        HttpSession session = request.getSession();
        user = (User)session.getAttribute("user");
        return user;
    }
    

    /**
     * 
     * 描述：分页查询合同
     * @author huangwanzong
     * @date 2018/07/06
     * @version 1.0
     * @param page 可选参数，查询的页数，默认值 1
     * @param limit 可选参数，分页的大小，默认值 10
     * @param contract 可选参数，查询的条件
     * @param findtype 可选参数，该参数值为 all 时不执行分页查询，返回全部符合条件的合同
     * @param request
     * @return Map<String,Object>
     * @since 1.8
     *
     */
    
    @RequiresPermissions("80001")
    @Operation(name="分页查询合同")
    @RequestMapping("list")
    @ResponseBody
    public Map<String, Object> listContract(Integer page,Integer limit,Contract contract,String findtype,HttpServletRequest request){
        Map<String, Object> map = new HashMap<String,Object>(16);
        
        //获取用户
        user = this.getUser(request);
        //检验用户正确性
        if(user == null || user.getId() == null) {
            map.put("code", -1);
            map.put("msg", "用户不存在，无法执行操作.");
            return map;
        }
        
        ContractExample example = new ContractExample();
        Criteria criteria = example.createCriteria();
        
        //设置分页参数
        if(page == null || page <= 0) {
            page = 1;
        }
        if(limit == null || limit <= 0) {
            limit = 10;
        }
        String all = "all";
        if(!all.equals(findtype)) {
            example.setLimit(limit);
            Long offset = new Long((page-1)*limit);
            example.setOffset(offset);
        }

        //设置管理者ID
        criteria.andManagerIdEqualTo(user.getId());
        //只查询未删除的合同
        criteria.andDeleteStatusEqualTo(0);
        System.out.println(contract);
        //检测属性是否存在，存在则进行条件查询
        if(contract != null) {
            if(!StringUtils.isEmpty(contract.getContractNo()) ) {
                criteria.andContractNoLike("%" + contract.getContractNo() + "%");
            }
        }
        
        Long count = contractService.countByContractExample(example);
        List<Contract> contracts = contractService.selectByContractExample(example);
        
        map.put("data", contracts);
        map.put("count", count);
        map.put("code", 0);
        
        return map;
    }
    
    
    /**
     * 
     * 描述：添加一个合同
     * @author huangwanzong
     * @date 2018/07/17
     * @version 1.0
     * @param contract 合同信息
     * @param request
     * @return Map<String,Object>
     * @since 1.8
     *
     */
    @RequiresPermissions("80002")
    @Operation(name="添加合同")
    @RequestMapping("add")
    @ResponseBody
    public Map<String, Object> addContract(Contract contract,HttpServletRequest request){
        Map<String, Object> map = new HashMap<String,Object>(16);
        
        this.getUser(request);
        //检测是否存在contract对象
        if(contract == null ) {
            map.put("msg", "参数为空");
            map.put("success", false);
            return map;
        }
        //合同编号
        if(StringUtils.isEmpty(contract.getContractNo())) {
            map.put("msg", "合同编号参数不能为空");
            map.put("success", false);
            return map;
        }
        //合同所属者默认为创建者
        contract.setManageId(user.getId());
        //设置创建者id
        contract.setCreateUserId(user.getId());
        //设置创建时间
        contract.setCreateDate(new Date());
        if(contract.getCustomerId() != null){
            Customer customer = customerService.selectCustomerByPrimaryKey(contract.getCustomerId());
            contract.setCustomerName(customer.getName());
        }

        if(contract.getSignUserId() != null){
            User signUser = userService.findById(contract.getSignUserId());
            contract.setSignUserName(signUser.getRealName());
        }

        //设置未删除
        contract.setDelFlag(0);
        
        //进行数据插入
        if(contractService.insertSelective(contract)) {
            map.put("msg", "添加成功");
            map.put("success", true);
        }else {
            map.put("msg", "添加失败");
            map.put("success", false);
        }
        
        return map;
    }
    
    @RequiresPermissions("7009")
    @Operation(name="检测合同名称是否存在")
    @RequestMapping("checkname")
    @ResponseBody
    public boolean checkContractName(String name){
        
        ContractExample example = new ContractExample();
        example.createCriteria().andNameEqualTo(name);
        
        List<Contract> list = contractService.selectByContractExample(example);
        if(list.size()>0) {
            return true;
        }
        return false;
    }
    
    @RequiresPermissions("80003")
    @Operation(name="更新合同信息")
    @RequestMapping("update")
    @ResponseBody
    public Map<String, Object> updateContract(Contract contract){
        Map<String, Object> map = new HashMap<String,Object>(16);
 
        if(contractService.updateContractByPrimaryKeySelective(contract)) {
            map.put("msg", "更新成功");
            map.put("success", true);
        }else {
            map.put("msg", "更新失败");
            map.put("success", false); 
        }
        return map;
    }
    
    @RequiresPermissions("80004")
    @Operation(name="删除合同")
    @RequestMapping("delete")
    @ResponseBody
    public Map<String, Object> deleteContract(int[] ids){
        Map<String, Object> map = new HashMap<String,Object>(16);
        List<Integer> success = new ArrayList<Integer>();
        List<Integer> fail = new ArrayList<Integer>();
        for(int id : ids) {
            if(contractService.deleteByPrimaryKey(id)) {
                success.add(id);
            }else {
                fail.add(id);
            }
        }
        
        map.put("msg", "删除完成");
        map.put("status", true);
        map.put("success", success);
        map.put("fail", fail);
        
        return map;
    }
    
    @RequiresPermissions("80005")
    @Operation(name="id查找合同")
    @RequestMapping("find")
    @ResponseBody
    public Map<String, Object> findContract(Integer id){
        Map<String, Object> map = new HashMap<String,Object>(16);
        Contract contract = null;
        
        if(id == null) {
            map.put("msg", "非法操作");
            map.put("success", false); 
            return map;
        }
        
        contract = contractService.selectContractByPrimaryKey(id);
        
        if(contract != null) {
            map.put("msg", "查找成功");
            map.put("success", true);
            map.put("data", contract);
        }else {
            map.put("msg", "查找失败");
            map.put("success", false); 
        }
        return map;
    }
    
    
}

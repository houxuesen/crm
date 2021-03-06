package com.neuedu.crm.controller;

import java.io.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.neuedu.crm.mapper.RoleMapper;
import com.neuedu.crm.pojo.*;
import com.neuedu.crm.service.IFollowUpService;
import com.neuedu.crm.utils.ImportExcelUtil;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.neuedu.crm.pojo.CustomerExample.Criteria;
import com.neuedu.crm.service.ICustomerService;
import com.neuedu.crm.utils.Operation;
import org.springframework.web.multipart.MultipartFile;


/**
 * 
 * @author huangwanzong
 * @date 2018年7月6日
 */
@Controller
@RequestMapping("customer")
public class CustomerController {
    @Autowired
    private ICustomerService customerService;

    @Autowired
    private RoleMapper roleMapper;

    @Autowired
    private IFollowUpService followupService;
    


    /**
     * @author huangwanzong
     * @date 2018年7月6日
     */
    private User getUser(HttpServletRequest request) {
        HttpSession session = request.getSession();
        User user  = (User)session.getAttribute("user");
        if(user == null){
            return user;
        }
        user.setRole(roleMapper.selectByPrimaryKey(user.getRoleId()));
        return user;
    }
    

    /**
     * 
     * 描述：分页查询客户
     * @author huangwanzong
     * @date 2018/07/06
     * @version 1.0
     * @param page 可选参数，查询的页数，默认值 1
     * @param limit 可选参数，分页的大小，默认值 10
     * @param customer 可选参数，查询的条件
     * @param findtype 可选参数，该参数值为 all 时不执行分页查询，返回全部符合条件的客户
     * @param request
     * @return Map<String,Object>
     * @since 1.8
     *
     */
    
    @RequiresPermissions("5001")
    @Operation(name="分页查询客户")
    @RequestMapping("list")
    @ResponseBody
    public Map<String, Object> listCustomer(Integer page,Integer limit,Customer customer,String findtype,HttpServletRequest request){
        Map<String, Object> map = new HashMap<String,Object>(16);
        
        //获取用户
        User user = this.getUser(request);
        //检验用户正确性
        if(user == null || user.getId() == null) {
            map.put("code", -1);
            map.put("msg", "用户不存在，无法执行操作.");
            return map;
        }
        
        CustomerExample example = new CustomerExample();
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
        if("客户经理".equals(user.getRole().getName())) {
            //设置管理者ID
            //criteria.andManagerIdEqualTo(user.getId());
            criteria.andSql(" (manager_Id = " + user.getId() + " or  id in ( select customer_Id from customer_share where user_id = "+user.getId()+" ) )");
        }

        //只查询未删除的客户
        criteria.andDeleteStatusEqualTo(0);

        System.out.println(customer);
        //检测属性是否存在，存在则进行条件查询
        if(customer != null) {
            if(customer.getName() != null && !"".equals(customer.getName())) {
                criteria.andNameLike("%" + customer.getName() + "%");
            }

            if(customer.getDescription() != null && !"".equals(customer.getDescription())){
                criteria.andDescriptionLike("%" + customer.getDescription() + "%");
            }
            if(customer.getManagerName() != null && !"".equals(customer.getManagerName())) {
               criteria.andSql(" manager_Id in (select id from user where real_Name like '%"+customer.getManagerName()+"%' ) ");
            }


            
            if(customer.getType() != null && !"".equals(customer.getType())) {
                criteria.andTypeEqualTo(customer.getType()); 
            }
            if(customer.getStatus() != null && !"".equals(customer.getStatus())) {
                criteria.andStatusEqualTo(customer.getStatus());
            }
            if(customer.getSource() != null && !"".equals(customer.getSource())) {
                criteria.andSourceEqualTo(customer.getSource());
            }
            if(customer.getLevel() != null && !"".equals(customer.getLevel())) {
                criteria.andLevelEqualTo(customer.getLevel());
            }
            if(customer.getCredit() != null && !"".equals(customer.getCredit())) {
                criteria.andCreditEqualTo(customer.getCredit());
            }
            if(customer.getMaturity() != null && !"".equals(customer.getMaturity())) {
                criteria.andMaturityEqualTo(customer.getMaturity());
            }

            if(customer.getEndDateBegin() != null){
                criteria.andEndDateGreaterThanOrEqualTo(customer.getEndDateBegin());
            }

            if(customer.getEndDateEnd() != null){
                criteria.andEndDateLessThanOrEqualTo(customer.getEndDateEnd());
            }
            DateTimeFormatter dtf2 = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            if(customer.getLastDateBegin() != null){
                criteria.andSql(" id in (select customer_id from Follow_Up where time >= '"+ dtf2.format(customer.getLastDateBegin())+"' ) ");
            }

            if(customer.getLastDateEnd() != null){
                criteria.andSql(" id in (select customer_id from Follow_Up where time <= '"+dtf2.format(customer.getLastDateEnd())+"' ) ");
            }

            if(customer.getReportEndDateBegin() !=  null){
                criteria.andReportEndDateGreaterThanOrEqualTo(customer.getReportEndDateBegin());
            }

            if(customer.getReportEndDateEnd() !=  null){
                criteria.andReportEndDateLessThanOrEqualTo(customer.getReportEndDateEnd());
            }

            if(!StringUtils.isEmpty(customer.getRealmName())){
                criteria.andRealmNameLike(customer.getRealmName());
            }

            if(!StringUtils.isEmpty(customer.getInstantMessage())){
                criteria.andInstantMessageEqualTo(customer.getInstantMessage());
            }

            if(customer.getUserNumBegin() != null){
                criteria.andUserNumBegin(customer.getUserNumBegin());
            }

            if(customer.getUserNumEnd() != null){
                criteria.andUserNumEnd(customer.getUserNumEnd());
            }

        }

        example.setOrderByClause(" create_time desc ");
        
        Long count = customerService.countByCustomerExample(example);
        List<Customer> customers = customerService.selectByCustomerExample(example);
        for(Customer ct:customers){
            FollowUpExample followUpExample = new FollowUpExample();
            FollowUpExample.Criteria criteria1 = followUpExample.createCriteria();
            criteria1.andCustomerIdEqualTo(ct.getId());
            criteria1.andDeleteStatusEqualTo(0);
            List<FollowUp> followUps = followupService.selectByFollowUpExample(followUpExample);
            if(followUps != null && followUps.size() > 0){
                ct.setFollowId(followUps.get(0).getId());
                ct.setContent(followUps.get(0).getContent());
                ct.setLastTime(followUps.get(0).getTime());
            }
        }
        
        map.put("data", customers);
        map.put("count", count);
        map.put("code", 0);
        
        return map;
    }
    
    
    /**
     * 
     * 描述：添加一个客户
     * @author huangwanzong
     * @date 2018/07/17
     * @version 1.0
     * @param customer 客户信息
     * @param linkman 联系人信息
     * @param customerName 客户名称
     * @param linkmanName 联系人名称
     * @param customerLevel 客户等级
     * @param request
     * @return Map<String,Object>
     * @since 1.8
     *
     */
    @RequiresPermissions("5002")
    @Operation(name="添加客户")
    @RequestMapping("add")
    @ResponseBody
    public Map<String, Object> addCustomer(Customer customer,
                                           Linkman linkman,
                                           String customerName,
                                           String linkmanName,
                                           String email,
                                           String customerLevel,
                                           HttpServletRequest request){
        Map<String, Object> map = new HashMap<String,Object>(16);

        //获取用户
        User   user = this.getUser(request);

        //检验用户正确性
        if(user == null || user.getId() == null) {
            map.put("code", -1);
            map.put("msg", "用户不存在，无法执行操作.");
            return map;
        }
        
        //检测是否存在customer对象
        if(customer == null || linkman == null) {
            map.put("msg", "参数为空");
            map.put("success", false);
            return map;
        }
        
        //检测客户名是否存在
        if(customerName == null || "".equals(customerName)) {
            map.put("msg", "用户名称参数不能为空");
            map.put("success", false);
            return map;
        }
        
        //检测联系人姓名是否存在
        if(linkmanName == null || "".equals(linkmanName)) {
            map.put("msg", "联系人名称参数不能为空");
            map.put("success", false);
            return map;
        }
        
        //客户所属者默认为创建者
        customer.setManagerId(user.getId());
        //设置创建者id
        customer.setCreater(user.getId());
        //设置创建时间
        customer.setCreateTime(LocalDateTime.now());
        //设置客户名称
        customer.setName(customerName);
        //设置客户等级
        customer.setLevel(customerLevel);
        //设置未删除
        customer.setDeleteStatus(0);
        
        //设置联系人名称
        linkman.setName(linkmanName);
     
        
        //进行数据插入
        if(customerService.insertSelective(customer,linkman)) {
            map.put("msg", "添加成功");
            map.put("success", true);
        }else {
            map.put("msg", "添加失败");
            map.put("success", false);
        }
        
        return map;
    }
    
    @RequiresPermissions("7009")
    @Operation(name="检测客户名称是否存在")
    @RequestMapping("checkname")
    @ResponseBody
    public boolean checkCustomerName(String name){
        
        CustomerExample example = new CustomerExample();
        example.createCriteria().andNameEqualTo(name);
        
        List<Customer> list = customerService.selectByCustomerExample(example);
        if(list.size()>0) {
            return true;
        }
        return false;
    }
    
    @RequiresPermissions("5003")
    @Operation(name="更新客户信息")
    @RequestMapping("update")
    @ResponseBody
    public Map<String, Object> updateCustomer(Customer customer){
        Map<String, Object> map = new HashMap<String,Object>(16);
 
        if(customerService.updateCustomerByPrimaryKeySelective(customer)) {
            map.put("msg", "更新成功");
            map.put("success", true);
        }else {
            map.put("msg", "更新失败");
            map.put("success", false); 
        }
        return map;
    }
    
    @RequiresPermissions("5004")
    @Operation(name="删除客户")
    @RequestMapping("delete")
    @ResponseBody
    public Map<String, Object> deleteCustomer(int[] ids){
        Map<String, Object> map = new HashMap<String,Object>(16);
        List<Integer> success = new ArrayList<Integer>();
        List<Integer> fail = new ArrayList<Integer>();
        for(int id : ids) {
            if(customerService.deleteByPrimaryKey(id)) {
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
    
    @RequiresPermissions("7010")
    @Operation(name="id查找客户")
    @RequestMapping("find")
    @ResponseBody
    public Map<String, Object> findCustomer(Integer id){
        Map<String, Object> map = new HashMap<String,Object>(16);
        Customer customer = null;
        
        if(id == null) {
            map.put("msg", "非法操作");
            map.put("success", false); 
            return map;
        }
        
        customer = customerService.selectCustomerByPrimaryKey(id);
        
        if(customer != null) {
            map.put("msg", "查找成功");
            map.put("success", true);
            map.put("data", customer);
        }else {
            map.put("msg", "查找失败");
            map.put("success", false); 
        }
        return map;
    }


    @Operation(name="根据名字查找客户")
    @RequestMapping("findByName")
    @ResponseBody
    public Map<String, Object> findByName(Customer customer,HttpServletRequest request){
        Map<String, Object> map = new HashMap<String,Object>(16);

        //获取用户
        User   user = this.getUser(request);

        //检验用户正确性
        if(user == null || user.getId() == null) {
            map.put("code", -1);
            map.put("msg", "用户不存在，无法执行操作.");
            return map;
        }

        CustomerExample example = new CustomerExample();
        example.setLimit(50);
        example.setOffset(0L);
        Criteria criteria = example.createCriteria();

        if("客户经理".equals(user.getRole().getName())) {
            //设置管理者ID
            criteria.andManagerIdEqualTo(user.getId());
        }

        //只查询未删除的客户
        criteria.andDeleteStatusEqualTo(0);

        if(customer != null) {
            if(customer.getName() != null) {
                criteria.andNameLike("%" + customer.getName() + "%");
            }
        }
        List<Customer> customers = customerService.selectByCustomerExample(example);
        map.put("data", customers);
        return map;
    }

    @Operation(name="根据名字查找客户")
    @RequestMapping("findAllByName")
    @ResponseBody
    public Map<String, Object> findAllByName(Customer customer){
        Map<String, Object> map = new HashMap<String,Object>(16);

        CustomerExample example = new CustomerExample();
        example.setLimit(50);
        example.setOffset(0L);
        Criteria criteria = example.createCriteria();

        //只查询未删除的客户
        criteria.andDeleteStatusEqualTo(0);

        if(customer != null) {
            if(customer.getName() != null) {
                criteria.andNameLike("%" + customer.getName() + "%");
            }
        }
        List<Customer> customers = customerService.selectByCustomerExample(example);
        map.put("data", customers);
        return map;
    }



    @Operation(name="上传客户信息")
    @RequestMapping("upload")
    @ResponseBody
    public Map<String, Object> upload(MultipartFile file
            ,HttpServletRequest request){
        Map<String, Object> map = new HashMap<String,Object>(16);
        //获取用户
        User  user = this.getUser(request);

        if(user == null){
            map.put("msg", "更新失败，请重新登录");
            map.put("success", false);
        }

        try {
            List<List<Object>> list =  ImportExcelUtil.getBankListByExcel(file.getInputStream(),file.getOriginalFilename());
            customerService.insertSelectiveFromExl(list,user);
            map.put("msg", "更新成功");
            map.put("success", true);
        }catch (Exception e){
            e.printStackTrace();
            map.put("msg", "更新失败"+e.getMessage());
            map.put("success", false);
        }
        return map;
    }




    @Operation(name="更新客户信息")
    @RequestMapping("updateDev")
    @ResponseBody
    public Map<String, Object> updateCustomerDev(Customer customer,HttpServletRequest request){
        Map<String, Object> map = new HashMap<String,Object>(16);
        //获取用户
        User user = this.getUser(request);
        if(customerService.updateCustomerByPrimaryKeySelective(customer)) {

            if(!StringUtils.isEmpty(customer.getContent())){
                FollowUp followUp = new FollowUp();
                followUp.setContent(customer.getContent());
                followUp.setTime(customer.getLastTime() == null ? LocalDateTime.now() : customer.getLastTime());
                if(customer.getFollowId() != null){
                    followUp.setId(customer.getFollowId());
                    followupService.updateFollowUpByPrimaryKeySelective(followUp);
                }else{
                    followUp.setDeleteStatus(0);
                    followUp.setManagerId(user.getId());
                    followUp.setCustomerId(customer.getId());
                    followupService.insertSelective(followUp);
                }
            }

            map.put("msg", "更新成功");
            map.put("success", true);
        }else {
            map.put("msg", "更新失败");
            map.put("success", false);
        }
        return map;
    }


}

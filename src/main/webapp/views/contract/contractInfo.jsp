<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>客户信息</title>
  <link rel="stylesheet" href="../../layui/css/layui.css">
  <script src="../../js/myutil.js"></script>
  <script src="../../layui/layui.js"></script>
  <style type="text/css">
     .my-table-class{}
     .my-table-class tr td:nth-child(even){
           text-align: left;
       }
     .my-table-class tr td:nth-child(odd){
         text-align: right;
     }
  </style>
</head>
<body >
<div style="width: 96%;margin-left: 2%;">
  <div class="layui-tab layui-tab-card">
    <ul class="layui-tab-title">
        <li class="layui-this" id="contract-info">合同详情</li>
      <li  id="customer-follow-up">跟踪记录</li>
      <li  id="customer-info">详细资料</li>
      <li id="customer-linkman">联系人</li>
      <li id="customer-transfer">转移记录</li>
    </ul>
    <div class="layui-tab-content" style="height: 100%;">
          <!-- 详细资料 -->
          <div class="layui-tab-item  layui-show">
              <!--startprint-->
              <table class="layui-table" lay-skin="col">
                  <colgroup>
                      <col width="20%">
                      <col width="30%">
                      <col width="20%">
                      <col width="30%">
                  </colgroup>
                  <thead>
                  <tr>
                      <th>合同信息</th>
                      <th></th>
                      <th></th>
                      <th></th>
                  </tr>
                  </thead>
                  <tbody class="my-table-class">
                  <tr>
                      <td>合同编号：</td>
                      <td id="contractNo"></td>
                      <td>客户：</td>
                      <td id="customerName"></td>
                  </tr>

                  <tr>
                      <td>合同类型：</td>
                      <td id="contractType"></td>
                      <td>签约人</td>
                      <td id="signUserName"></td>
                  </tr>

                  <tr>
                      <td>负责人：</td>
                      <td id="manageName"></td>
                      <td>签约时间</td>
                      <td id="signDate"></td>
                  </tr>

                  <tr>
                      <td>过期时间：</td>
                      <td id="endDate"></td>
                      <td>域名/网站：</td>
                      <td id="cont_realmName"></td>
                  </tr>

                  <tr>
                      <td>用户数：</td>
                      <td id="userNum"></td>
                      <td>购买年限</td>
                      <td id="limitYears"></td>
                  </tr>

                  <tr>
                      <td>合同金额：</td>
                      <td id="contractAmount"></td>
                      <td>合同成本</td>
                      <td id="baseAmount"></td>
                  </tr>
                  <tr>
                      <td>毛利额：</td>
                      <td id="otherAmount"></td>
                      <%--<td>总额</td>
                      <td id="totalAmount"></td>--%>
                      <td>支付方式</td>
                      <td id="payType"></td>
                  </tr>


                <%--  <tr>
                      <td>其他：</td>
                      <td id="otherAmount"></td>
                      <td>优惠金额</td>
                      <td id="discountAmount"></td>
                  </tr>--%>
                  <shiro:hasPermission name="80006">
                  <tr>
                      <td>核定毛利额：</td>
                      <td id="cont_li_run"></td>
                      <td></td>
                      <td ></td>
                  </tr>
                  </shiro:hasPermission>
                  <tr>
                      <td colspan="1">合同相关资料：</td>
                      <td colspan="3" id="contDocument"></td>
                  </tr>


                  </tbody>
              </table>
              <!--endprint-->
              <shiro:hasPermission name="80006">
              <div>
                  <div class="layui-form-item">
                      <div class="layui-input-block">
                          <button type="button" class="layui-btn" id="auditPass" >通过</button>
                          <button type="button" class="layui-btn" id="auditRefuse" >驳回</button>
                      </div>
                  </div>
              </div>
              </shiro:hasPermission>
          </div>

      <!-- 跟踪记录 -->
      <div class="layui-tab-item" style="height: 100%">
          <shiro:hasPermission name="6002">
          <div style="margin-bottom: 10px;">
                    <button class="layui-btn" id="add-follow">新建跟踪记录</button>
                    <!-- <button class="layui-btn" id="delete-follow">删除</button> -->
            </div>
          </shiro:hasPermission>
          <div id="show-followup">
        <ul class="layui-timeline" id="follow-flow">
        </ul>        
         </div>
        </div>
      
      
      <!-- 详细资料 -->
      <div class="layui-tab-item">
        <!--startprint-->
            <table class="layui-table" lay-skin="col">
            <colgroup>
                    <col width="20%">
                    <col width="30%">
                    <col width="20%">
                    <col width="30%">
            </colgroup>
            <thead>
                <tr>
                  <th>公司信息</th>
                  <th></th>
                  <th></th>
                  <th></th>
                </tr>
            </thead>
                <jsp:include page="../customer/customerInfoTable.jsp"></jsp:include>
            </table>
            <!--endprint-->
        </div>
        
        
      <!-- 联系人 -->
      <div class="layui-tab-item">
        <div>
            <shiro:hasPermission name="7001">  
             <button class="layui-btn" id="add-linkman">添加</button>
          </shiro:hasPermission>
          
          <shiro:hasPermission name="7002">
               <button class="layui-btn" id="update-linkman">修改</button>
          </shiro:hasPermission>
          
          <shiro:hasPermission name="7004">
               <button class="layui-btn" id="delete-linkman">删除</button>
          </shiro:hasPermission>
        </div>
            <table id="linkman-table" class="layui-hide"></table>
        </div>
        
        <!-- 客户转移记录 -->
        <div class="layui-tab-item">
            <div>
                <ul class="layui-timeline" id="transfer-flow">
                </ul>          
           </div>
        </div>        
        
    </div>
  </div>


</div>
  
<script type="text/javascript">
layui.use(['element','table','flow'],function(){
  var flow = layui.flow;
  var layer = layui.layer;
  var table = layui.table;
  var $ = layui.$;
  
  var parm = getParm();
  var linkmanstatus = false;
  
  var printstatus = false;
  
  var createrId = 0;


    //进行详细信息显示
    getContInfo();

    //加载客户详细信息
    function getContInfo(){
        var loadindex = layer.load(2);
        $.ajax({
            type: "POST",
            url: '${pageContext.request.contextPath}/contract/find',
            data: {'id':parm.contractId},
            dataType: "json",
            success: function(data){
                if(data.success){
                    var contract = data.data;
                    $('#contractNo').text(contract.contractNo);
                    $('#customerName').text(contract.customerName);
                    $('#signUserName').text(contract.signUserName);
                    $('#manageName').text(contract.manageName);
                    $('#signDate').text(contract.signDate);
                    $('#endDate').text(contract.endDate);
                    $('#totalAmount').text(contract.totalAmount);
                    $('#otherAmount').text(contract.otherAmount);
                    $('#discountAmount').text(contract.discountAmount);
                    $('#contractAmount').text(contract.contractAmount);
                    $('#baseAmount').text(contract.baseAmount);
                    $('#contractType').text(contract.contractType);
                    $('#payType').text(contract.payType);
                    $('#userNum').text(contract.userNum);
                    $('#limitYears').text(contract.limitYears);

                    $('#cont_li_run').text(contract.contractAmount - contract.baseAmount - contract.discountAmount);
                    $('#cont_realmName').text(contract.customer.realmName);

                    //添加文件下载按钮
                    if(contract.document != null && contract.document != ''){
                        var document = contract.document;
                        var filename = '' + contract.contractNo + '.' + document.split(".")[1];
                        var html = '<a class="layui-btn" style="margin-left:30px;" href="${pageContext.request.contextPath}/upload/' + contract.document + '"'
                            + ' download="' + filename + '">下载文件</a>';
                        html = '' + document +  html;
                        $('#contDocument').html(html);
                    }
                }else{
                    layer.msg('获取不到合同');
                }
                layer.close(loadindex);
            },
            error:function(){
                layer.msg("服务器开小差了，请稍后再试...");
            }
        });
    }


  //进行详细信息显示
  getCustomerInfo();
  
  //加载客户详细信息
  function getCustomerInfo(){
    var loadindex = layer.load(2);
    $.ajax({
          type: "POST",
          url: '${pageContext.request.contextPath}/customer/find',
          data: {'id':parm.id},
          dataType: "json",
          success: function(data){
            if(data.success){
                  var customer = data.data;
                  $('#customer-name').text(customer.name);
                  $('#type').text(customer.type);
                  $('#level').text(customer.level);
                  $('#status').text(customer.status);
                  $('#credit').text(customer.credit); 
                  $('#area').text(customer.area); 
                  $('#companyAddress').text(customer.companyAddress); 
                  $('#companyPhone').text(customer.companyPhone); 
                  $('#postCode').text(customer.postCode); 
                  $('#faxAddress').text(customer.faxAddress); 
                  $('#companyWebsite').text(customer.companyWebsite); 
                  $('#licenseNumber').text(customer.licenseNumber);
                  $('#corporation').text(customer.corporation);
                  $('#annualSale').text(customer.annualSale);
                  $('#depositBank').text(customer.depositBank);
                  $('#bankAccount').text(customer.bankAccount);
                  $('#landTaxNumber').text(customer.landTaxNumber);
                  $('#nationalTaxNumber').text(customer.nationalTaxNumber);
                  $('#source').text(customer.source);
                  $('#description').text(customer.description);
                  $('#maturity').text(customer.maturity);
                  //添加文件下载按钮
                  if(customer.document != null && customer.document != ''){
                    var document = customer.document;
                    var filename = '' + customer.name + '.' + document.split(".")[1];
                    var html = '<a class="layui-btn" style="margin-left:30px;" href="${pageContext.request.contextPath}/upload/' + customer.document + '"'
                          + ' download="' + filename + '">下载文件</a>';
                    html = '' + document +  html;
                    //$('#document').text('asdf');
                    $('#document').html(html);
                  }
                  
                  if(customer.manager != null){
                    $('#managerId').text(customer.manager.account);
                  }
                  
                  if(customer.product != null){
                    $('#productId').text(customer.product.name);
                  }
                  
                  if(customer.createrObject != null){
                    $('#creater').text(customer.createrObject.realName);
                    createrId = customer.createrObject.id;
                  }
                  
                  $('#createTime').text(localDateTimeToStr(customer.createTime));
              }else{
                layer.msg('获取不到客户');
              }
            layer.close(loadindex);
          },
          error:function(){
              layer.msg("服务器开小差了，请稍后再试...");
          }
      });
  }
  
  
  //加载联系人
  function getLinkman(){
    var loadindex = layer.load(2);
    table.render({
          elem: '#linkman-table'
          ,even: true
          ,url: '${pageContext.request.contextPath}/linkman/list'
          ,where:{'customerId':parm.id,'type':'all'}
          ,method : 'post'
          ,height: 'full-200'
          ,page: false
          ,cols: [[ //表头
              {type:'checkbox'}
              ,{field:'name',title:'名字'}
              ,{field:'position',title:'职位'}
              ,{field:'officePhone',title:'固定电话'}
              ,{field:'mobilePhone',title:'移动电话'}
              ,{field:'birthday',title:'生日',templet:function(d){
                if(d.birthday != null){
                  return '' + d.birthday[0] + '-' + d.birthday[1] + '-' + d.birthday[2];
                }
                return '';
              }}
              ,{field:'sex',title:'性别'}
              ,{field:'level',title:'联系人级别',templet:function(d){
                //console.log(d);
                      return d.level == 0?'重要':'普通';
                  }}
              ,{field:'remark',title:'备注'}
            
          ]]
          ,done:function(){
            layer.close(loadindex);
          }
        });
  }
  
  //修改按钮点击事件
    $('#update-customer-info-btn').click(function(){ 
        layer.open({
        type:2,
        title:'编辑客户',
        area:['750px','92%'],
        shadeClose:false,
        closeBtn:1,
        content:'${pageContext.request.contextPath}/views/customer/updatecustomer.jsp?id='+parm.id,
        end:function(){
          getCustomerInfo();
        }
      });
    });

  //点击联系人后获取联系人数据
  $('#customer-linkman').click(function(){
    if(linkmanstatus){
      table.reload('linkman-table');
    }
    else{
      getLinkman();
    }
  });
  
  
  //点击添加联系人事件
  $('#add-linkman').click(function(){
    layer.open({
      type:2,
      title:'添加联系人',
      area:['450px','590px'],
      closeBtn:1,
      shadeClose:false,
      content:'${pageContext.request.contextPath}/views/customer/editlinkman.jsp?type=add&customerId=' + parm.id,
      end:function(){
        table.reload('linkman-table');
      }   
    });
  });
  
  //点击更新联系人事件
  $('#update-linkman').click(function(){
    var checkStatus = table.checkStatus('linkman-table')
        ,data = checkStatus.data;
        if(data.length != 1){
          layer.msg('请选择一行数据');
          return;
        }
    
    layer.open({
      type:2,
      title:'编辑联系人',
      area:['450px','590px'],
      closeBtn:1,
      shadeClose:false,
      content:'${pageContext.request.contextPath}/views/customer/editlinkman.jsp?type=update&id=' + data[0].id,
      end:function(){
        table.reload('linkman-table');
      }   
    });
  });
  
  
  //点击删除联系人事件
    $('#delete-linkman').click(function(){
        var checkStatus = table.checkStatus('linkman-table')
        ,data = checkStatus.data;
        if(data.length <= 0){
            layer.msg('请至少选择一行数据');
            return;
        }else if(data.length == 1){
          if(data[0].level == 0){
            layer.msg('重要联系人无法删除!');
            return;
          }
        }

        
        var showStr = '你确定删除以下联系人吗？<br>(PS:重要联系人不能删除)<br/>';
        layui.each(data,function(index,item){
          if(item.level != 0){
              showStr += item.name + '<br>';
          }
        });
        
        layer.confirm(showStr,{icon:7, title:'确认删除'},function(index){
            layer.close(index);
            var ids = [];
            layui.each(data,function(index,item){
              if(item.level != 0){
                ids.push(item.id);
              }
            });
            
            $.ajax({
                  url:'${pageContext.request.contextPath}/linkman/delete',
                  data:{'ids':ids},
                  traditional:true,   //使用传统模式传递数组
                  success:function(data){
                      var str = '<div style="text-align:center" >删除完成<br>';
                      str += '成功条目：'+ data.success.length + ' <br>';
                      str += '失败条目：'+ data.fail.length + ' <br>';
                      str += '合计条目：'+ ids.length + ' <br></div>';
                      var index = layer.open({
                          type:1,
                          title:'操作完成',
                          btn:'确定',
                          content:str,
                          end:function(){
                              layer.close(index);
                              table.reload('linkman-table');
                          }
                      }); 
                  }
            });
        });
 
    });
  
  
  
  
  
  //跟踪记录模块
  
  //使用流加载跟踪记录
  flow.load({
     elem: '#follow-flow' //指定列表容器
     ,done: function(page, next){ //到达临界点（默认滚动触发），触发下一页
       var lis = [];
       //以jQuery的Ajax请求为例，请求下一页数据（注意：page是从2开始返回）
       $.post('${pageContext.request.contextPath}/followup/list',{'page':page,'customerId':parm.id}, function(res){
         //假设你的列表返回在data集合中
         layui.each(res.data, function(index, item){
         var title = '' + item.time[0] + '年' + item.time[1] + '月' + item.time[2] + '日' + '   ' + item.time[3] + ':' +item.time[4] + ':' +item.time[5];
           var str = '<li class="layui-timeline-item"><i class="layui-icon layui-timeline-axis">&#xe63f;</i>';
           str += '<div class="layui-timeline-content layui-text" >';
           str += '<h3 class="layui-timeline-title"  id="followup-' + item.id + '"> <span style="font-size: 16px;">' + item.manager.account + '</span> ';
           str += title + '</h3></a><p>';
           str += '' + item.general + '</p></div></li>';
         lis.push(str);
         }); 
         
         //执行下一页渲染，第二参数为：满足“加载更多”的条件，即后面仍有分页
         //pages为Ajax返回的总页数，只有当前页小于总页数的情况下，才会继续出现加载更多
         next(lis.join(''), page < res.pages);    
           
       });
     }
   });                                   
                  
                  
     //点击新建跟踪记录按钮        
     $('#add-follow').click(function(){
       layer.open({
             type:2,
             title:'新建跟踪',
             area:['500px','680px'],
             closeBtn:1,
             shadeClose:false,
             content:'${pageContext.request.contextPath}/views/customer/editfollowup.jsp?type=add&customerId=' + parm.id,
             end:function(){
                location.reload();
             }       
         });
     });             
                  
     
  //展示跟踪记录详细信息
  //动态加载出来的元素需要使用on来绑定
  $(document).on("click","h3[id^=followup]",function(){
        //layer.msg('click');
        //console.log(this);
        var id = this.id.split("-")[1];
        layer.open({
            type:2,
            title:'详情',
            area:['400px','60%'],
            closeBtn:1,
            shadeClose: true,
            content:'${pageContext.request.contextPath}/views/customer/followupInfo.jsp?id=' + id,
            end:function(){
                 //location.reload();
            }       
        });
    });

  
  //使用流加载转移记录
    flow.load({
       elem: '#transfer-flow' //指定列表容器
       ,done: function(page, next){ //到达临界点（默认滚动触发），触发下一页
         var lis = [];
         //以jQuery的Ajax请求为例，请求下一页数据（注意：page是从2开始返回）
         $.post('${pageContext.request.contextPath}/customer/transfer/list',{'page':page,'customerId':parm.id}, function(res){
           //假设你的列表返回在data集合中
           layui.each(res.data, function(index, item){
             var title = '' + item.time[0] + '-' + item.time[1] + '-' + item.time[2] + '   ' + item.time[3] + ':' +item.time[4] + ':' +item.time[5];
             var str = '<li class="layui-timeline-item"><i class="layui-icon layui-timeline-axis">&#xe63f;</i>';
             str += '<div class="layui-timeline-content layui-text">';
             str += '<h3 class="layui-timeline-title">' + title + '</h3>';
             str += '<p><p>原所属者:<strong>' + item.oldManager.account + '</strong></p>';
             str += '<p>新所属者:<strong>' + item.newManager.account + '</strong></p>';
             str += '<p>转移原因:' + item.reason + '</p>';
             str += '</p></div></li>';
             lis.push(str);
           }); 
           
           //执行下一页渲染，第二参数为：满足“加载更多”的条件，即后面仍有分页
           //pages为Ajax返回的总页数，只有当前页小于总页数的情况下，才会继续出现加载更多
           next(lis.join(''), page < res.pages);    
             
         });
       }
     });
  
  
  //打印功能
  $('#print-btn').click(function(){
    layer.open({
            type:2,
            title:'客户详情',
            area:['100%','100%'],
            clostBtn:1,
            shadeClose: true,
            maxmin:true,
            offset:'r',
            content:'printCustomer.jsp?id='+ parm.id
        });
  });


  $('#creater').click(function(){
    layer.open({
            type:2,
            title:'用户信息',
            area : ['1000px','400px'],
            clostBtn:1,
            shadeClose: true,
            content:'${pageContext.request.contextPath}/views/user/showUserInfo.jsp?id='+ createrId
        });  
  });

    $('#auditPass').click(function(){
        auditCont('已审批');
    });


    $('#auditRefuse').click(function(){
        auditCont('草稿');
    });

    function auditCont(result){
        $.ajax({
            type: "POST",
            url: '${pageContext.request.contextPath}/contract/auditCont',
            data: {
                'id': parm.contractId,
                'conState': result
            },
            dataType: "json",
            success: function (data) {
                top.layer.msg(data.msg);    //使用top显示
                if (data.success) {//成功
                    //关闭当前弹出层
                    var thisindex = parent.layer.getFrameIndex(window.name);
                    parent.layer.close(thisindex);
                }
            },
            error: function (data) {
                top.layer.msg("服务器开小差了，请稍后再试...");
            }
        });
    }

  
  function localDateTimeToStr(time){
    var str = '';
    var len = time.length;
    switch(len){
      case 1: str = '' + time[0];break;
      case 2: str = '' + time[0] + '-' + time[1];break;
      case 3: str = '' + time[0] + '-' + time[1] + '-' + time[2];break;
      case 4: str = '' + time[0] + '-' + time[1] + '-' + time[2] + '   ' + time[3];break;
      case 5: str = '' + time[0] + '-' + time[1] + '-' + time[2] + '   ' + time[3] + ':' + time[4];break;
      case 6: str = '' + time[0] + '-' + time[1] + '-' + time[2] + '   ' + time[3] + ':' + time[4] + ':' + time[5];break;
    }
    return str;
  }


});



</script>
    
</body>
</html>
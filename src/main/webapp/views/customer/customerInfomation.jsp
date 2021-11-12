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
	    
	    <li  id="customer-follow-up">跟踪记录</li>
	    <li class="layui-this" id="customer-info">详细资料</li>
	    <li id="customer-linkman">联系人</li>
	    <li id="customer-transfer">转移记录</li>
	  </ul>
	  <div class="layui-tab-content" style="height: 100%;">
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
	    <div class="layui-tab-item  layui-show">
	    	<div>
	    	    <shiro:hasPermission name="5003">
	    		    <button class="layui-btn" id="update-customer-info-btn">修改</button>
	    		</shiro:hasPermission>
	    		<button class="layui-btn" id="print-btn">打印</button>
	    	</div>
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
				<jsp:include page="customerInfoTable.jsp"></jsp:include>
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
	                $('#realmName').text(customer.realmName);
	                $('#type').text(customer.type);
	                $('#endDate').text(customer.endDate);
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
					$('#userNum').text(customer.userNum);
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
		          ,{field:'email',title:'邮箱'}
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
			area:['450px','90%'],
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

	getFollowup();

	function getFollowup(){
		//使用流加载跟踪记录
		flow.load({
			elem: '#follow-flow' //指定列表容器
			,done: function(page, next){ //到达临界点（默认滚动触发），触发下一页
				var lis = [];
				//以jQuery的Ajax请求为例，请求下一页数据（注意：page是从2开始返回）
				$.post('${pageContext.request.contextPath}/followup/list',{'page':page,'customerId':parm.id}, function(res){
					//假设你的列表返回在data集合中
					layui.each(res.data, function(index, item){
						console.info(item);
						var title = '' + item.time[0] + '年' + item.time[1] + '月' + item.time[2] + '日' + '   ' + item.time[3] + ':' +item.time[4] ;
						var str = '<li class="layui-timeline-item"><i class="layui-icon layui-timeline-axis">&#xe63f;</i>';
						str += '<div class="layui-timeline-content layui-text" >';
						str += '<h3 class="layui-timeline-title"  id="followup-' + item.id + '"> <span style="font-size: 16px;">' + item.manager.account + '</span> ';
						str += title + '</h3></a><p style="width:100%;word-break:break-all;word-wrap:break-word;">';
						str += '' + item.content + '</p></div></li>';
						if(index == 0){
							str += '<button type="button" class="layui-btn" style="margin-left: 180px;" id="updateFollow-'+item.id+'">编辑</button>';
							str += '<button type="button" class="layui-btn" style="margin-left: 180px;" id="delFollow-'+item.id+'">删除</button>';
							str += '<br />'
						}

						lis.push(str);
					});

					//执行下一页渲染，第二参数为：满足“加载更多”的条件，即后面仍有分页
					//pages为Ajax返回的总页数，只有当前页小于总页数的情况下，才会继续出现加载更多
					next(lis.join(''), page < res.pages);

				});
			}
		});
	}


                  
                  
     //点击新建跟踪记录按钮        
     $('#add-follow').click(function(){
    	 layer.open({
             type:2,
             title:'新建跟踪',
             area:['700px','90%'],
             closeBtn:1,
             shadeClose:false,
             content:'${pageContext.request.contextPath}/views/customer/editfollowup.jsp?type=add&customerId=' + parm.id,
             end:function(){
				 reloadFlow();
             }
         });
     });             
                  
     
	//展示跟踪记录详细信息
	//动态加载出来的元素需要使用on来绑定
	initUpdateFollow();
	function initUpdateFollow(){
		$(document).on("click","[id^=updateFollow-]",function(){
			var id = this.id.split("-")[1];
			layer.open({
				type:2,
				title:'新建跟踪',
				area:['700px','90%'],
				closeBtn:1,
				shadeClose:false,
				content:'${pageContext.request.contextPath}/views/customer/editfollowup.jsp?type=update&customerId=' + parm.id +"&id="+id,
				end:function(){
					reloadFlow();
				}
			});
		});
	}
	initDelFollow();
	function initDelFollow(){
		$(document).on("click","[id^=delFollow-]",function(){
			var id = this.id.split("-")[1];
			var ids = [];
			ids.push(id)
			$.ajax({
				type: "POST",
				url: '${pageContext.request.contextPath}/followup/delete',
				data: {
					'ids':ids
				},
				traditional:true,
				success: function(data){
					top.layer.msg(data.msg);
					reloadFlow();
				},
				error:function(){
					top.layer.msg("服务器开小差了，请稍后再试...");
					layer.closeAll('loading');
				}
			});
		});
	}



	function reloadFlow(){
		$('#follow-flow').remove();
		$('#show-followup').append('<ul class="layui-timeline" id="follow-flow"></ul>');
		getFollowup();
		initUpdateFollow();
		initDelFollow();
	}


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
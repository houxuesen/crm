<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>           
<hr class="layui-bg-orange">

<!-- 搜索框 -->
<form class="layui-form">
    <blockquote class="layui-elem-quote quoteBox">
        <div class="layui-inline">
            <button type="button" class="layui-btn" id="search-btn">
                <i class="layui-icon  layui-icon-search"></i>搜索
            </button>
        </div>
        
		<div class="layui-inline" id="add-btn-div">
            <ul>
                <li id="add-btn">
	               <button type="button" class="layui-btn">
	                   <i class="layui-icon  layui-icon-add-1"></i>新建
	               </button>
                </li>
            </ul>
            <ul id="add-btn-more" style="z-index: 999;position: fixed;display: none;" class="layui-bg-green">
                <shiro:hasPermission name="5002">
                    <li>
	                    <button type="button" class="layui-btn" id="add-customer-btn">
	                        <i class="layui-icon  layui-icon-add-1"></i>新建客户
	                    </button>    
                    </li>
                </shiro:hasPermission>
                <shiro:hasPermission name="6002">
	                <li>
	                    <button type="button" class="layui-btn" id="add-followup-btn">
	                        <i class="layui-icon  layui-icon-add-1"></i>新建跟踪记录
	                    </button>    
	                </li>
                </shiro:hasPermission>
            </ul>
		</div>
		
	    <shiro:hasPermission name="5003">
			<div class="layui-inline">
		        <button type="button" class="layui-btn" id="update-button">
		            <i class="layui-icon  layui-icon-edit"></i>修改
		        </button>
	        </div>  
        </shiro:hasPermission>
		<div class="layui-inline">
			<button type="button" id="upload-button" class="layui-btn layui-btn-danger">
				<i class="layui-icon  layui-icon-home"></i>上传
			</button>
		</div>
	</blockquote>
</form>

<!-- 要显示的表格 id是必须的 -->
<table class="layui-hide" id="customer-table" lay-filter="customer-table">
</table>        


<div class="layui-hide">
    <input type="text" name="name" />
    <input type="text" name="status" />
    <input type="text" name="type" />
    <input type="text" name="source" />
    <input type="text" name="level" />
    <input type="text" name="description" />
	<input type="text" name="endDateBegin" />
	<input type="text" name="endDateEnd" />
	<input type="text" name="managerName" />
	<input type="text" name="lastDateBegin" />
	<input type="text" name="lastDateEnd" />


    <button type="button" data-type="reload" id="search-button">搜索</button>
</div>



<script src="https://cuikangjie.github.io/JsonExportExcel/dist/JsonExportExcel.min.js"></script>
<script >
var checkJson;
layui.use(['table','form','laydate'], function(){
    var table = layui.table;
    var layer = layui.layer;
	var laydate = layui.laydate;
    var $ = layui.$;
    
    
    //加载表格数据
    var tableload = layer.load(2);
    table.render({
      elem: '#customer-table'       //html中表格的id
      ,even: true                     //开启隔行变色
      ,url: 'customer/list' //数据接口
      ,method : 'post'
      ,height: 'full-200'
	  , limit: 50
      ,page: {layout: ['limit', 'count', 'prev', 'page', 'next', 'skip','refresh'],groups: 1 }
      ,cols: [[ //表头
          {type:'checkbox'}
          ,{field:'name',title:'客户名称' ,width: 300,templet:function(data){
        	  return str = '<a style="color:blue;" href="javascript:" lay-event="detail">' +data.name + '</a>';
          }}
          ,{field:'realmName',title:'域名',width: 100}
          ,{field:'source',title:'现服务商',width: 130}
          ,{field:'companyPhone',title:'联系电话',edit:'text',width: 200}
          ,{field:'userNum',title:'用户数',edit:'text',width: 100}
          ,{field:'content',title:'最新跟进记录',edit:'text',width: 700}
		  ,{field:'lastTime',title:'最后跟踪时间', edit: 'text',width: 200,event:'chooseDate',data_field: "dBeginDate",sort: true,templet(data){
				return  getDate(data.lastTime)
			}}
        
      ]],
      done: function(){
          layer.close(tableload);
      }
    });
    

    //搜索按钮点击事件
    $('#search-btn').click(function(){
    	
    	layer.open({
            type:2,
            title:'搜索条件',
            area:['700px','550px'],
            clostBtn:1,
            shadeClose: true,
            maxmin: false,
            //offset:'r',
            content:'views/customer/search.jsp?'
        });
    	//console.log(layer.getChildFrame());
    });
    
    //搜索功能
    $('#search-button').on('click', function(){
        //执行重载
        table.reload('customer-table', {
          page: {
            curr: 1 //重新从第 1 页开始
          }
          ,where: {
              'name': $('input[name=name]').val(),
              'status':$('input[name=status]').val(),
              'type':$('input[name=type]').val(),
              'source':$('input[name=source]').val(),
              'level':$('input[name=level]').val(),
              'credit':$('input[name=credit]').val(),
              'description':$('input[name=description]').val(),
				'endDateBegin':$('input[name=endDateBegin]').val(),
				'endDateEnd':$('input[name=endDateEnd]').val(),
				'managerName':$('input[name=managerName]').val(),
				'lastDateBegin':$('input[name=lastDateBegin]').val(),
				'lastDateEnd':$('input[name=lastDateEnd]').val()
          }
        });
      });



	//监听名称编辑操作
	table.on('edit(customer-table)', function(obj){
		var value = obj.value //得到修改后的值
				,data = obj.data //得到所在行所有键值
				,field = obj.field; //得到字段
		updateDev(data);
	});


	function updateDev(data){
		var index = top.layer.msg('修改中...', {
			icon : 16,
			time : false,
			shade : 0.8
		});
		var itemid = data.id;
		var userNum = data.userNum;
		var followId = data.followId;
		var companyPhone = data.companyPhone;
		var content = data.content;
		var lastTime = getDate(data.lastTime);
		$.post('${pageContext.request.contextPath}/customer/updateDev',
				{'id':itemid,'userNum':userNum,'lastTime':lastTime,"followId":followId,"content":content,"companyPhone":companyPhone},
				function(data){
					layer.msg(data.msg);
					top.layer.close(index);
				}
		);
	}

	//详情弹出窗
    table.on('tool(customer-table)',function(obj){
    	var data = obj.data;
    	var customerid = data.id;
		var newdata = {};
    	if(obj.event === 'detail'){
    		layer.open({
    			type:2,
    			title:'客户详情',
    			area:['80%','100%'],
    			clostBtn:1,
    			shadeClose: true,
    			maxmin:true,
    			offset:'r',
    			content:'views/customer/customerInfomation.jsp?id='+ customerid
    		});
    		
        }else if (obj.event === 'chooseDate') {
			var field = $(this).data('field');
			laydate.render({
				elem: this.firstChild
				, show: true //直接显示
				, closeStop: this
				, type: 'datetime'
				, format: "yyyy-MM-dd HH:mm:ss"
				, done: function (value, date) {
					newdata[field] = value;
					obj.update(newdata);
					data.lastTime = value;
					updateDev(data);
				}
			});
		}
    });
    

    //删除事件
    $('#delete-button').click(function(){
    	var checkStatus = table.checkStatus('customer-table')
        ,data = checkStatus.data;
        if(data.length <= 0){
        	layer.msg('请至少选择一行数据');
        	return;
        }
    	
        var showStr = '你确定删除以下客户吗？<br>';
        layui.each(data,function(index,item){
        	showStr += item.name + '<br>';
        });
    	
        layer.confirm(showStr,{icon:7, title:'确认删除'},function(index){
        	layer.close(index);
        	var ids = [];
        	layui.each(data,function(index,item){
                ids.push(item.id);
            });
        	
        	$.ajax({
        		  url:'${pageContext.request.contextPath}/customer/delete',
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
                              table.reload('customer-table');
                          }
                      }); 
        		  }
        	});
        });
 
    });
    
  	//修改按钮点击事件
    $('#update-button').click(function(){
    	var checkStatus = table.checkStatus('customer-table')
        ,data = checkStatus.data;
        if(data.length != 1){
        	layer.msg('请选择一行数据');
        	return;
        }
        
        var id = data[0].id;
        //console.log(data);
        
        layer.open({
    		type:2,
    		title:'编辑客户',
    		area:['750px','92%'],
    		shadeClose:false,
    		closeBtn:1,
    		content:'views/customer/updatecustomer.jsp?id='+id,
    		end:function(){
    			table.reload('customer-table');
    		}
    	});
    });
    
    //显示添加按钮鼠标经过事件
    $('#add-btn-div').mouseover(function(){
    	$('#add-btn-more').show();
    });
    $('#add-btn-div').mouseleave(function(){
    	$('#add-btn-more').hide();
    });
    
    //点击添加客户点击事件
    $('#add-customer-btn').click(function(){
    	layer.open({
    		type:2,
    		title:'新建客户',
    		area:['750px','92%'],
    		shadeClose:false,
    		closeBtn:1,
    		content:'views/customer/addcustomer.jsp',
    		end:function(){
    			table.reload('customer-table');
    		}
    	});
    });
    
    
    //点击添加跟踪记录事件
    $('#add-followup-btn').click(function(){
    	layer.open({
            type:2,
            title:'新建跟踪',
            area:['750px','92%'],
            closeBtn:1,
            shadeClose:false,
            content:'${pageContext.request.contextPath}/views/customer/editfollowup.jsp?type=add',
            end:function(){
                //table.reload('linkman-table');
                //flow.reload();
            }       
        });
    });
    
    //转移按钮点击事件
    $('#customer-transfer-button').click(function(){
    	var checkStatus = table.checkStatus('customer-table')
        ,data = checkStatus.data;

        if(data.length == 0){
			layer.msg('请至少选一行数据');
        	return;
		}

		checkJson = JSON.stringify(data);

		layer.open({
			type:2,
			title:'客户转移',
			area:['700px','430px'],
			shadeClose:false,
			closeBtn:1,
			content:'views/customer/customerTransferMany.jsp',
			end:function(){
				table.reload('customer-table');
			}
		});
    });

	//上传
	$('#upload-button').click(function(){
		layer.open({
			type:2,
			title:'上传客户',
			area:['750px','92%'],
			shadeClose:false,
			closeBtn:1,
			content:'views/fileupload.jsp',
			end:function(){
				table.reload('customer-table');
			}
		});
	});



	//导出按钮点击事件
    $('#export-button').click(function(){
    	var checkStatus = table.checkStatus('customer-table')
        ,data = checkStatus.data;
        if(data.length < 1){
            layer.msg('请至少选一行数据');
            return;
        }
    	var option={};
    	option.fileName = 'excel'
    	option.datas=[
    	  {
    	    sheetData:data,
    	    sheetName:'sheet',
    	    sheetFilter:['name','type','level','status','credit','area','companyAddress','companyPhone','postCode','faxAddress','companyWebsite','licenseNumber','corporation','annualSale','depositBank','bankAccount','landTaxNumber','nationalTaxNumber','source','description','maturity'],
    	    sheetHeader:['名称' ,'类别' ,'等级'  ,'状态'   ,'信用度' ,'area' ,'详细地址'       ,'电话'          ,'邮政编码'  ,'传真地址'    ,'公司网站'        ,'营业执照注册号'  ,'法人'        ,'年营业额'    ,'开户银行'     ,'银行账号'     ,'地税登记号'      ,'国税登记号'         ,'来源'   ,'描述'        ,'成熟度']
    	  }
    	 
    	];
    	var toExcel=new ExportJsonExcel(option);
    	toExcel.saveExcel();
    });

});

function getDate(time){
	if(time !=null ){
		if(time.length == 6){
			return  time[0]+'-'+time[1]+'-'+time[2]+' '+time[3]+":"+time[4]+":"+time[5];
		}else if(time.length == 5){
			return  time[0]+'-'+time[1]+'-'+time[2]+' '+time[3]+":"+time[4];
		}else{
			return  time[0]+'-'+time[1]+'-'+time[2];
		}
	}else{
		return '';
	}
}

</script>



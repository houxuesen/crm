<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>跟踪记录</title>
	<link rel="stylesheet" href="../../layui/css/layui.css">
	<script src="../../js/myutil.js"></script>
	<script src="../../layui/layui.js"></script>
	
</head>
<body >
<div style="width: 96%;margin-left: 2%;">

    <form class="layui-form" lay-filter="search-form" style="width: 96%">
	    <div class="layui-form-item">
	        <!-- 客户名称 -->  
	        <label class="layui-form-label">客户名称：</label>
	        <div class="layui-input-inline">
	          <input type="text" name="name" class="layui-input">
	        </div>
	        <div class="layui-form-mid layui-word-aux">模糊查询</div>
	    </div>      
	
	    <div class="layui-form-item">
            <!-- 客户状态 --> 
            <label class="layui-form-label">客户状态：</label>
            <div class="layui-input-inline">
              <select name="status" lay-filter="status">
                <option value="">--数据加载中--</option>
              </select>
            </div> 
	        
	        <!-- 客户类别 --> 
	        <label class="layui-form-label">客户规模：</label>
	        <div class="layui-input-inline">
	          <select name="type" lay-filter="type">
	            <option value="">--数据加载中--</option>
	          </select>
	        </div>  
	    </div>  
	    
	    <div class="layui-form-item">
	        <!-- 客户来源-->  
	        <label class="layui-form-label">现服务商：</label>
	        <div class="layui-input-inline">
	            <select name="source" lay-filter="source">
	                <option value="">--数据加载中--</option>
	            </select>
	        </div>
	        
	        <!-- 客户等级 --> 
	        <label class="layui-form-label">客户等级：</label>
	        <div class="layui-input-inline">
		          <select name="level" lay-filter="level">
		            <option value="">--数据加载中--</option>
		          </select>
	        </div>  
	    </div>




	    <div class="layui-form-item">
			<label class="layui-form-label">邮箱过期：</label>
			<div class="layui-input-inline" >
				<input type="text" name="endDateBegin" id="endDateBegin" class="layui-input">
			</div>
			<div class="layui-input-inline" style="width: 20px;">--</div>
			<div class="layui-input-inline" >
				<input type="text"  id="endDateEnd" name="endDateEnd" class="layui-input" >
			</div>
	    </div>

		<div class="layui-form-item">
			<label class="layui-form-label">用户数量范围：</label>
			<div class="layui-input-inline" >
				<input type="text" name="userNumBegin" id="userNumBegin" class="layui-input">
			</div>
			<div class="layui-input-inline" style="width: 20px;">--</div>
			<div class="layui-input-inline" >
				<input type="text"  id="userNumEnd" name="userNumEnd" class="layui-input" >
			</div>
		</div>


		<div class="layui-form-item">
			<label class="layui-form-label">最后跟踪时间：</label>
			<div class="layui-input-inline" >
				<input type="text" name="lastDateBegin" dateFormat="yyyy-MM-dd HH:mm:ss" id="lastDateBegin" class="layui-input">
			</div>
			<div class="layui-input-inline" style="width: 20px;">--</div>
			<div class="layui-input-inline" >
				<input type="text"  id="lastDateEnd" dateFormat="yyyy-MM-dd HH:mm:ss" name="lastDateEnd" class="layui-input" >
			</div>
		</div>



		<div class="layui-form-item">
			<label class="layui-form-label">报备到期范围：</label>
			<div class="layui-input-inline" >
				<input type="text" name="reportEndDateBegin" id="reportEndDateBegin" class="layui-input">
			</div>
			<div class="layui-input-inline" style="width: 20px;">--</div>
			<div class="layui-input-inline" >
				<input type="text"   name="reportEndDateEnd" id="reportEndDateEnd" class="layui-input" >
			</div>
		</div>


		<div class="layui-form-item">

			<label class="layui-form-label">客户归属人：</label>
			<div class="layui-input-inline">
				<input type="text" name="managerName" class="layui-input">
			</div>

			<label class="layui-form-label">备注：</label>
			<div class="layui-input-inline">
				<input type="text" name="description" class="layui-input">
			</div>

		</div>


		<div class="layui-form-item">

			<label class="layui-form-label">域名/网址：</label>
			<div class="layui-input-inline">
				<input type="text" name="realmName" class="layui-input">
			</div>

			<label class="layui-form-label">即时通讯：</label>
			<div class="layui-input-inline">
				<select name="instantMessage" lay-filter="instantMessage">
					<option value="">--数据加载中--</option>
				</select>
			</div>

		</div>
	    <div class="layui-form-item"  style="width: 450px;margin-top: 40px;">
            <div class="layui-input-block">
                <button type="reset" class="layui-btn" style="margin-left: 135px;">重置</button>
                <button type="button" name="form-submit-btn" lay-submit lay-filter="form-submit-btn" class="layui-btn">查询</button>
            </div>
        </div>  
    </form>

</div>
	
<script type="text/javascript">
layui.use(['form','laydate'],function(){
	var form = layui.form;
	var layer = layui.layer;
	var laydate = layui.laydate;
	var $ = layui.$;
	//获取父窗口jQuery
	var parent$ = window.parent.layui.jquery;
	
	form.on('submit(form-submit-btn)',function(data){
		var formdata = data.field;
		//console.log(formdata);
		//对父窗口的表单进行数据填充
		parent$('input[name=name]').val(formdata.name);
		parent$('input[name=status]').val(formdata.status);
		parent$('input[name=type]').val(formdata.type);
		parent$('input[name=source]').val(formdata.source);
		parent$('input[name=level]').val(formdata.level);
		parent$('input[name=description]').val(formdata.description);


		parent$('input[name=endDateBegin]').val(formdata.endDateBegin);
		parent$('input[name=endDateEnd]').val(formdata.endDateEnd);
		parent$('input[name=managerName]').val(formdata.managerName);


		parent$('input[name=lastDateBegin]').val(formdata.lastDateBegin);
		parent$('input[name=lastDateEnd]').val(formdata.lastDateEnd);

		parent$('input[name=reportEndDateBegin]').val(formdata.reportEndDateBegin);
		parent$('input[name=reportEndDateEnd]').val(formdata.reportEndDateEnd);
		parent$('input[name=realmName]').val(formdata.realmName);
		parent$('input[name=instantMessage]').val(formdata.instantMessage);


		parent$('input[name=userNumBegin]').val(formdata.userNumBegin);
		parent$('input[name=userNumEnd]').val(formdata.userNumEnd);




		//执行查询功能
		parent$('#search-button').click();
		//关闭当前弹出层
        var thisindex = parent.layer.getFrameIndex(window.name);
        parent.layer.close(thisindex);
		return false;
	});


	//加载日期选择器
	laydate.render({
		elem: '#endDateBegin' //指定元素
		, type: 'date'
		, format: 'yyyy-MM-dd'
		, trigger: 'click'
	});

	//加载日期选择器
	laydate.render({
		elem: '#endDateEnd' //指定元素
		, type: 'date'
		, format: 'yyyy-MM-dd'
		, trigger: 'click'
	});


	//加载日期选择器
	laydate.render({
		elem: '#lastDateBegin' //指定元素
		, type: 'datetime'
		, format: 'yyyy-MM-dd HH:mm:ss'
		, trigger: 'click'
	});

	//加载日期选择器
	laydate.render({
		elem: '#lastDateEnd' //指定元素
		, type: 'datetime'
		, format: 'yyyy-MM-dd HH:mm:ss'
		, trigger: 'click'
	});

	//加载日期选择器
	laydate.render({
		elem: '#reportEndDateBegin' //指定元素
		, type: 'date'
		, format: 'yyyy-MM-dd'
		, trigger: 'click'
	});

	//加载日期选择器
	laydate.render({
		elem: '#reportEndDateEnd' //指定元素
		, type: 'date'
		, format: 'yyyy-MM-dd'
		, trigger: 'click'
	});



	//获取客户状态字典并加载下拉框
    setTimeout(getSelectData('客户状态','status'),0);
	//getSelectData('客户状态','status');
    
    //获取客户类别字典并加载下拉框
    setTimeout(getSelectData('客户类别','type'),500);
    //getSelectData('客户类别','type');
    
    //获取客户来源字典并加载下拉框
    setTimeout(getSelectData('客户来源','source'),1500);
    //getSelectData('客户来源','source');
    
    //获取客户等级字典并加载下拉框
    setTimeout(getSelectData('客户等级','level'),2000);
    //getSelectData('客户等级','level');
    
    //获取客户信用度字典并加载下拉框
    setTimeout(getSelectData('客户信用度','credit'),2500);
    //getSelectData('客户信用度','credit');
    
    //获取客户成熟度字典并加载下拉框
    setTimeout(getSelectData('客户成熟度','maturity'),3000);
    //getSelectData('客户成熟度','maturity');

	setTimeout(getSelectData('即时通讯','instantMessage'),3500);

    
    function getSelectData(dictionaryName,selectName){
        $.post('${pageContext.request.contextPath}/dictionary/find',{'name':dictionaryName},function(data){
            var d = data.data.dictionaryItems;
            var str = '<option value="">请选择</option>';
            for(var i=0;i<d.length;i++){
                str += '<option value="' + d[i].name + '">' + d[i].name + '</option>';
            }
            $('select[name=' + selectName + ']').html(str);
            form.render('select');
            $('select[name=' + selectName + ']').val(parent$('input[name=' + selectName + ']').val());
        }); 
    }

    
    
    //从父窗口中获取上次的查询参数
    setParm();
    function setParm(){
    	$('input[name=name]').val(parent$('input[name=name]').val());
    }
    
    
    
});
</script>
		
</body>
</html>
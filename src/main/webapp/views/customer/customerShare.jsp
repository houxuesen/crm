<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>客户转移</title>
	<link rel="stylesheet" href="../../layui/css/layui.css">
	<script src="../../js/myutil.js"></script>
	<script src="../../layui/layui.js"></script>
	
</head>
<body >
<div style="width: 96%;margin-left: 2%;">

    <form class="layui-form" lay-filter="transfer-form" style="width: 96%">

	    <div class="layui-form-item" style="margin-top: 20px;">
            <label class="layui-form-label">分享对象：</label>
            <div class="layui-input-inline" id="customers">

            </div> 
            
            <label class="layui-form-label">共享给：</label>
            <div class="layui-input-inline">
              <select name="customerId" lay-verify="required">
                	<option value="">--数据加载中--</option>
              </select>
            </div>
        </div>

	    <div class="layui-form-item"  style="width: 450px;margin-top: 40px;">
            <div class="layui-input-block">
                <button type="button" name="form-submit-btn" lay-submit lay-filter="form-submit-btn" class="layui-btn">共享</button>
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

	var parm = getParm();
	//console.log(parm);
	
	//console.log(parm.hasOwnProperty('customerId'));
	
	form.on('submit(form-submit-btn)',function(data){
		var formdata = data.field;

        var customers = [];
        layui.each(eval('('+parent.checkJson+')'),function(index,item){
            customers.push(item.id);
        });
        formdata.customers = customers;
        console.info(formdata);
		layer.load(2);
		$.ajax({
	        type: "POST",
	        url: '${pageContext.request.contextPath}/customer/transfer/share',
	        data: formdata,
	        dataType: "json",
	        success: function(data){
	        	    top.layer.msg(data.msg);
	        	    layer.closeAll('loading');
	                if(data.status){
	                	var thisindex = parent.layer.getFrameIndex(window.name);
	                    parent.layer.close(thisindex);
	                }
	        },
	        error:function(){
	            top.layer.msg("服务器开小差了，请稍后再试...");
	            layer.closeAll('loading');
	        }
	        
	    });
	
		return false;
	});
	

	layer.load(2);

    var parent_json = eval('('+parent.checkJson+')');

    var names  = '';
    for(var i=0;i<parent_json.length;i++){
        names += parent_json[i].name + "<br />";
    }
    console.log(names);
    $('#customers').html(names);


	$.ajax({
		type: "POST",
        url: '${pageContext.request.contextPath}/user/findOthersManager',
        data: {'findtype':'all'},
        dataType: "json",
        success: function(data){
            	var d = data.list;
                var str = '<option value="">请选择</option>';
                for(var i=0;i<d.length;i++){
                    str += '<option value="' + d[i].id + '">' + d[i].account + '</option>';
                }
                $('select[name=customerId]').html(str);
                form.render('select');
                layer.closeAll('loading');
        },
        error:function(){
            top.layer.msg("服务器开小差了，请稍后再试...");
        }
		
	});
});
</script>
		
</body>
</html>
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
	<link href="../../css/base/jquery-ui-1.9.2.custom.css" rel="stylesheet">
	<script src="../../js/jquery-1.8.3.js"></script>
	<script src="../../js/jquery-ui-1.9.2.custom.js"></script>


	<script type="text/javascript" src="../../js/ueditor/ueditor.config.js"></script>
	<!-- 编辑器源码文件 -->
	<script type="text/javascript" src="../../js/ueditor/ueditor.all.js"></script>
	<script type="text/javascript" src="../../js/ueditor/lang/zh-cn/zh-cn.js"></script>
</head>
<body >
<div style="width: 96%;margin-left: 2%;">

	<form class="layui-form" lay-filter="followup-form" style="width: 96%">
		
		<input type="hidden" name="id" value="-1">
		
		
        <div class="layui-form-item" id="customer" style="display: none">
            <label class="layui-form-label">客户：</label>
            <%--<div class="layui-input-inline" style="width: 320px;">
                <select class="layui-input" name="customerId" lay-verify="customerSelect" >
                    <option value="-1" >--数据加载中--</option>
                </select>
            </div>--%>

			<div class="layui-input-inline">
				<input type="hidden" name="customerId" id="customerId" >
				<div class="layui-input-inline">
					<input type="text" name="customerName"  id="customerName" class="layui-input"  />
				</div>
			</div>
        </div>		
		
		<div class="layui-form-item">
	        <label class="layui-form-label">时间：</label>
	        <div class="layui-input-inline"  style="width: 320px;">
	            <input type="text" name="time" id="time" dateFormat="yyyy-MM-dd HH:mm:ss" lay-verify="required"  class="layui-input" />
	        </div>
        </div>

		<div class="layui-form-item">
	        <label class="layui-form-label">详细信息：</label>
	        <div class="layui-input-inline">
	           <%-- <textarea class="layer-input" name="content" lay-verify="required" style="height: 300px;width: 520px"></textarea>
				--%>

				<script id="content" type="text/plain" name="content"  style="width:520px;height:350px;"></script>
			</div>
        </div>		

		<div class="layui-form-item">
	        <label class="layui-form-label">备注：</label>
	        <div class="layui-input-inline">
	          	<textarea class="layer-input" name="remark" style="height: 100px;width: 520px"></textarea>
	        </div>  
        </div>		

	
	    <!-- 相关文件 -->
	    <div class="layui-form-item">
	        <input type="hidden" name="document" value=""/>
	        <label class="layui-form-label">相关文件：</label>
	        <div class="layui-input-block">
	            <div class="layui-inline layui-upload " >
	                <button type="button" class="layui-btn layui-btn-normal" id="fileupload">选择文件</button>
	                <span id="upload-filename" class="layui-inline" style="color: #999999"></span>
	                <button type="button" class="layui-btn layui-hide" id="upload-btn">开始上传</button>
	            </div>
	        </div>
	    </div>	   
	
		<div class="layui-form-item"  style="width: 320px;">
			<div class="layui-input-block">
				<!--
				<button type="reset" class="layui-btn" style="margin-left: 30px;">重置</button>
				 -->
				<button type="button" name="form-submit-btn" lay-submit lay-filter="form-submit-btn" class="layui-btn">保存</button>
			</div>
		</div>	
	</form>
</div>
	
<script type="text/javascript">

var ue = UE.getEditor('content', {});

ue.ready(function(){
	ue.execCommand('fontsize','14px');
});

layui.use(['form','upload','laydate'],function(){
	var form = layui.form;
	var layer = layui.layer;
	var upload = layui.upload;
	var laydate = layui.laydate;
	var $ = layui.$;

	var parm = getParm();
	
	var url = '${pageContext.request.contextPath}/followup/add';


	var now = new Date();
	
	//加载日期选择器
	laydate.render({
	    elem: '#time' //指定元素
	    ,type:'datetime'
	    ,format:'yyyy-MM-dd HH:mm:ss'
	    ,trigger: 'click'
	    ,value:new Date()
	  });


	
	//保存点击事件
	form.on('submit(form-submit-btn)',function(data){
	
		var formdata = data.field;
		
		if(parm.type == 'add' && parm.customerId != null){
			formdata.customerId = parm.customerId;
		}

		if(parm.type == 'update' && parm.customerId != null){
			formdata.customerId = parm.customerId;
		}

		if(formdata.customerId == '' || formdata.customerId == null){
			layer.alert('请选择客户');
			return false;
		}

		if(formdata.file != null && formdata.file != ''){
			$('#upload-btn').click();
			return false;
		}
		
		submitData(formdata);
		return false;
		
	});

	$('#customerName').autocomplete({
		source: function (request, response) {
			$.ajax({
				url: '${pageContext.request.contextPath}/customer/findByName',//ajax取值
				type: "post",
				data: {'name': $("#customerName").val()},
				success: function (result) {
					var data = result.data;
					response($.map(data, function (item) {
						return {code: item.id, name: item.name, label: item.name};
					}));
				}
			});
		},
		change: function (event, ui) {
			if (ui.item == null) {
				$("#customerId").val("");
				$("#customerName").val("");
			}
			return false;
		},
		select: function (event, ui) {
			$("#customerId").val(ui.item.code);
			$("#customerName").val(ui.item.name);
			return false;
		},
		autoFill: false,
		scroll: true,
		pagingMore: true,
		scrollHeight: 50,
		delay: 500,
		minLength: 1
	});

	
	//提交数据
	function submitData(formdata){
		console.info(formdata);
		$.ajax({
			type:"POST",
			url:url,
			data:formdata,
			dataType: "json",
			success:function(data){
				layer.msg(data.msg);
				if(data.status){
					//关闭当前弹出层
                    var thisindex = parent.layer.getFrameIndex(window.name);
                    parent.layer.close(thisindex);
				}
			},
			error:function(){
				layer.msg('服务器去云游了，请稍后再试...');
			}
		});
	}

	
	//文件上传实现
    upload.render({
      elem: '#fileupload'
      ,url: '${pageContext.request.contextPath}/file/upload'
      ,accept:'file'     //允许所有类型文件上传
      ,size:10240        //上传大小限制为10M
      ,auto:false        //不自动上传
      ,number:1
      ,bindAction:'#upload-btn'
      ,choose:function(obj){
        obj.preview(function(index, file, result){
            $('#upload-filename').text(file.name);
        });
        $('#upload-btn').removeClass('layui-btn-disabled');
      }
      ,before:function(){
    	  layer.msg('正在上传文件...', {
              icon : 16,
              time : false,
              shade : 0.8
          });
      }
      ,done: function(res){
        
        if(res.status){
            layer.closeAll('loading');
            $('input[name=document]').val(res.filename);
            $('input[name=file]').val(''); //将file输入框内容去除
            $('button[name=form-submit-btn]').click();
        }else{
            layer.msg(res.msg);
        }
    
      }
    });   

	//判断添加还是更新
	if(parm.type == 'add'){
		//如果是从客户列表进来的，就加载客户可选列表
		if(parm.customerId == null || parm.customerId == ''){
			//显示客户选择框
			$('#customer').show();
		}
	}else if(parm.type == 'update'){

		url = '${pageContext.request.contextPath}/followup/updatePart';
		$.post('${pageContext.request.contextPath}/followup/find',{'id':parm.id},function(data){
			var formdata = data.data;
			console.info(formdata);
			formdata.time = getDate(formdata.time);
			form.val('followup-form',formdata);
			form.render();

			ue.ready(function () {
				ue.setContent(formdata.content);//赋值给UEditor
			});
		});


	} else{//如果是更新则从服务器读取最新的联系人数据
		url = '${pageContext.request.contextPath}/followup/update';
		$.post('${pageContext.request.contextPath}/followup/find',{'id':parm.id},function(data){
			var formdata = data.data;
			console.info(formdata)
			form.val('followup-form',formdata);
			form.render();
			ue.ready(function () {
				ue.setContent(formdata.content);//赋值给UEditor
			});
		});
	}

 	//表单自定义验证
	form.verify({
		customerSelect:function(value){
			if(value == null || value == '' || value == '-1'){
				return '请选择客户';
			}
		}
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
		
</body>
</html>
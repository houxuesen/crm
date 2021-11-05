<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>合同编辑</title>
    <link rel="stylesheet" href="../../layui/css/layui.css">
    <script src="../../js/myutil.js"></script>
    <script src="../../layui/layui.js"></script>
</head>
<body>
<div style="width: 96%;margin-left: 2%;">

    <hr>
    <div style="width: 100%;height: 20px;background-color: #efff57;padding: 6px 0px;margin-bottom: 5px;">
        <p style="width: 100%;line-height: 20px;margin-left: 20px;">合同基本信息</p>
    </div>
    <form class="layui-form " lay-filter="contract-form">

        <!-- 合同ID -->
        <input type="hidden" name="id" value="0">

        <div class="layui-form-item">
            <label class="layui-form-label">合同编号<strong style="color: red">*</strong>：</label>
            <div class="layui-input-inline">
                <input type="text" name="contractNo" lay-verify="required" class="layui-input">
            </div>
            <div class="layui-form-mid layui-word-aux" id="contractNo-msg"></div>
        </div>

        <div class="layui-form-item">
           
            <label class="layui-form-label">客户：</label>
            <div class="layui-input-inline">
                <select name="customerId">
                    <option value="">--数据加载中--</option>
                </select>
            </div>
            
            <label class="layui-form-label">签约人：</label>
            <div class="layui-input-inline">
                <select name="signUserId">
                    <option value="">--数据加载中--</option>
                </select>
            </div>
        </div>
        <!-- 相关文件 -->
        <div class="layui-form-item">
            <input type="hidden" name="document" value=""/>
            <label class="layui-form-label">相关文件：</label>
            <div class="layui-input-block">
                <div class="layui-inline layui-upload ">
                    <button type="button" class="layui-btn layui-btn-normal" id="fileupload">选择文件</button>
                    <span id="upload-filename" class="layui-inline" style="color: #999999"></span>
                    <button type="button" class="layui-btn layui-btn-disabled layui-hide" id="upload-btn">开始上传</button>
                </div>
                <div class="layui-form-mid layui-word-aux">只可上传一个文件</div>
            </div>
        </div>

        <div>
            <div class="layui-form-item">
                <div class="layui-input-block">
                   <%-- <button type="button" class="layui-btn" style="margin-left: 180px;">重置</button>--%>
                    <button type="button" name="contract-form-submit-btn" lay-submit lay-filter="contract-form-submit"
                            class="layui-btn">保存
                    </button>
                </div>
            </div>
        </div>
    </form>


    <script type="text/javascript">
        layui.use(['form', 'upload', 'laydate'], function () {
            var form = layui.form;
            var layer = layui.layer;
            var upload = layui.upload;
            var laydate = layui.laydate;
            var $ = layui.$;

            var parm = getParm();

            var url = '${pageContext.request.contextPath}/contract/update';

            //点击保存事件
            form.on('submit(contract-form-submit)', function (data) {
                var formdata = data.field;
                //console.log(formdata);

                //添加客户时检验客户名可用性
                if ($('#contractNo-msg').text() == '合同编号名已存在' && parm.type == 'add') {
                    layer.msg('合同编号重复，请重新填写');
                    return false;
                }

                //判断是否选择了文件
                if (data.field.file != null && data.field.file != '') {
                    //文件存在，提交文件
                    $('#upload-btn').click();
                    return false;
                }
                delete formdata.file;
                $.ajax({
                    type: "POST",
                    url: url,
                    data: formdata,
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

                return false;
            });

            //获取客户成熟度字典并加载下拉框
            getSelectData('客户成熟度', 'maturity');

            function getSelectData(dictionaryName, selectName) {
                $.post('${pageContext.request.contextPath}/dictionary/find', {'name': dictionaryName}, function (data) {
                    var d = data.data.dictionaryItems;
                    var str = '<option value="">请选择</option>';
                    for (var i = 0; i < d.length; i++) {
                        str += '<option value="' + d[i].name + '">' + d[i].name + '</option>';
                    }
                    $('select[name=' + selectName + ']').html(str);
                    form.render('select');
                });
            }

            //加载客户列表
            $.post('${pageContext.request.contextPath}/customer/list',{'findtype':'all'},function(data){
                var customers = data.data;
                var str = '<option value="">--请选择客户--</option>'
                for(var i=0;i<customers.length;i++){
                    str += '<option value="' + customers[i].id + '">' + customers[i].name + '</option>';
                }
                $('select[name=customerId]').html(str);
                form.render('select');
            });

            //加载客户列表
            $.post('${pageContext.request.contextPath}/user/allUser',function(data){
                var users = data.data;
                var str = '<option value="">--请选择用户--</option>'
                for(var i=0;i<users.length;i++){
                    str += '<option value="' + users[i].id + '">' + users[i].realName + '</option>';
                }
                $('select[name=signUserId]').html(str);
                form.render('select');
            });



            //客户名检测
            $('input[name=customerName]').blur(function () {
                var name = $('input[name=customerName]').val();
                $.post('${pageContext.request.contextPath}/customer/checkname', {'name': name}, function (data) {
                    if (data) {
                        $('#contractNo-msg').text('客户名已存在');
                    } else {
                        $('#contractNo-msg').text('客户名可用');
                    }
                });
            });

            //文件上传实现
            var uploadindex = 0;
            upload.render({
                elem: '#fileupload'
                , url: '${pageContext.request.contextPath}/file/upload'
                , accept: 'file'     //允许所有类型文件上传
                , size: 10240        //上传大小限制为10M
                , auto: false        //不自动上传
                , number: 1
                , bindAction: '#upload-btn'
                , choose: function (obj) {
                    obj.preview(function (index, file, result) {
                        $('#upload-filename').text(file.name);
                    });
                    $('#upload-btn').removeClass('layui-btn-disabled');
                }
                , before: function () {
                    uploadindex = layer.load(2);
                    $('#upload-btn').addClass('layui-btn-disabled');
                }
                , done: function (res) {
                    layer.close(uploadindex);
                    if (res.status) {
                        //layer.msg("上传完成");
                        $('input[name=document]').val(res.filename);
                        $('input[name=file]').val(''); //将file输入框内容去除
                        $('button[name=contract-form-submit-btn]').click();
                    } else {
                        layer.msg(res.msg);
                    }

                }
            });

            //加载日期选择器
            laydate.render({
                elem: '#birthday' //指定元素
                , type: 'date'
                , format: 'yyyy-MM-dd'
                , trigger: 'click'
            });



            //加载用户数据
            $.ajax({
                type: "POST",
                url: '${pageContext.request.contextPath}/contract/find',
                data: {'id':parm.id},
                dataType: "json",
                success: function(data){
                    if(data.success){//成功
                        var contract = data.data;
                        form.val('contract-form',contract);
                        form.render();
                    }else{
                        layer.msg('找不到合同...');
                    }
                },
                error:function(){
                    top.layer.msg("服务器开小差了，请稍后再试...");
                }
            });



            $('a[id^=field]').click(function () {
                var name = this.name;
                var field = this.id.split('-')[1];
                editDictionary(name, field);

                return false;
            });




            //编辑字典
            function editDictionary(name, field) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/dictionary/find',
                    data: {'name': name},
                    success: function (data) {
                        //console.log(name);
                        //console.log(data);
                        if (!data.success) {
                            layer.msg('字典不存在，无法编辑');
                            return;
                        }

                        layer.open({
                            type: 2,
                            title: '字典子项',
                            area: ['80%', '90%'],
                            closeBtn: 1,
                            //area: '516px',
                            //skin: 'layui-bg-black', //没有背景色
                            shade: 0.5,
                            shadeClose: false,
                            content: '${pageContext.request.contextPath}/views/dictionary/itemlist.jsp?typeid=' + data.data.id,
                            end: function () {
                                getSelectData(name, field);
                            }
                        });
                    }
                });
            }

        });
    </script>

</body>
</html>
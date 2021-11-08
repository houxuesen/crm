<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<hr class="layui-bg-orange">

<!-- 搜索框 -->
<form class="layui-form">
    <blockquote class="layui-elem-quote quoteBox">

        <label style="margin-left: 20px;" style="" class="layui-label">合同编号：</label>

        <div style="width: 120px;" class="layui-inline">
            <input type="text" name="contractNo" placeholder="合同编号"
                   autocomplete="off" class="layui-input">
        </div>

        <label style="margin-left: 20px;" style="" class="layui-label">合同状态：</label>
        <div style="width: 120px;" class="layui-input-inline">
            <select name="conState">
                <option value="">--数据加载中--</option>
            </select>
        </div>


        <div class="layui-inline">
            <button type="button" class="layui-btn" id="search-btn">
                <i class="layui-icon  layui-icon-search"></i>搜索
            </button>
        </div>

        <div class="layui-inline" id="add-btn-div">
            <ul>
                <li id="add-btn">
                    <button type="button" class="layui-btn" id="add-contract-btn">
                        <i class="layui-icon  layui-icon-add-1"></i>新建合同
                    </button>
                </li>
            </ul>
        </div>

        <shiro:hasPermission name="5003">
            <div class="layui-inline">
                <button type="button" class="layui-btn" id="update-button">
                    <i class="layui-icon  layui-icon-edit"></i>修改
                </button>
            </div>
        </shiro:hasPermission>

        <%--<shiro:hasPermission name="7007">
			<div class="layui-inline">
		        <button type="button" class="layui-btn layui-bg-orange"  id="contract-transfer-button">
		            <i class="layui-icon  layui-icon-senior" ></i>转移
		        </button>
	        </div> 
	    </shiro:hasPermission>--%>

        <shiro:hasPermission name="7004">
            <div class="layui-inline">
                <button type="button" id="delete-button" class="layui-btn layui-btn-danger">
                    <i class="layui-icon  layui-icon-delete"></i>删除
                </button>
            </div>
        </shiro:hasPermission>

        <%--  <div class="layui-inline">
              <button type="button" id="export-button" class="layui-btn layui-btn-danger">
                      <i class="layui-icon  layui-icon-delete"></i>导出
              </button>
          </div>	--%>
    </blockquote>
</form>

<!-- 要显示的表格 id是必须的 -->
<table class="layui-hide" id="contract-table" lay-filter="contract-table">
</table>


<div class="layui-hide">
    <button type="button" data-type="reload" id="search-button">搜索</button>
</div>


<script src="https://cuikangjie.github.io/JsonExportExcel/dist/JsonExportExcel.min.js"></script>
<script>
    layui.use(['table', 'form'], function () {
        var form = layui.form;
        var table = layui.table;
        var layer = layui.layer;
        var $ = layui.$;


        //加载表格数据
        var tableload = layer.load(2);
        table.render({
            elem: '#contract-table'       //html中表格的id
            , even: true                     //开启隔行变色
            , url: 'contract/list' //数据接口
            , method: 'post'
            , height: 'full-200'
            , page: {layout: ['limit', 'count', 'prev', 'page', 'next', 'skip', 'refresh'], groups: 1}
            , cols: [[ //表头
                {type: 'checkbox'}
                , {field: 'customerName', title: '客户姓名'}
                , {field: 'contractNo', title: '合同编号',templet:function(data){
                        return str = '<a style="color:blue;" href="javascript:" lay-event="detail">' +data.contractNo + '</a>';
                    }
                }
                , {field: 'signUserName', title: '签约人'}
                , {field: 'signDate', title: '签约时间'}
                , {field: 'manageName', title: '负责人'}
                , {field: 'totalAmount', title: '总额'}
                , {field: 'otherAmount', title: '其他'}
                , {field: 'discountAmount', title: '优惠价格'}
                , {field: 'contractAmount', title: '合同金额'}
                , {field: 'baseAmount', title: '合同成本'}
                , {field: 'payType', title: '支付方式'}
                , {field: 'userNum', title: '用户数'}
                , {field: 'limitYears', title: '使用年限'}
                , {field: 'conState', title: '合同状态'}
            ]],
            done: function () {
                layer.close(tableload);
            }
        });

        //获取客户成熟度字典并加载下拉框
        getSelectData('合同状态', 'conState');

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



        //搜索按钮点击事件
        $('#search-btn').click(function () {
            $('#search-button').click();
        });

        //搜索功能
        $('#search-button').on('click', function () {
            //执行重载
            table.reload('contract-table', {
                page: {
                    curr: 1 //重新从第 1 页开始
                }
                , method: "post"
                , where: {
                    'contractNo': $("input[name='contractNo']").val(),
                    'conState': $("select[name='conState']").val()
                }
            });
        });



        //删除事件
        $('#delete-button').click(function () {
            var checkStatus = table.checkStatus('contract-table')
                , data = checkStatus.data;
            if (data.length <= 0) {
                layer.msg('请至少选择一行数据');
                return;
            }

            for(var i = 0; i < data.length;i++){
                if(data[i].conState != '草稿'){
                    layer.msg('非草稿状态不能编辑！');
                    return;
                }
            }

            var showStr = '你确定删除以下合同吗？<br>';
            layui.each(data, function (index, item) {
                showStr += item.contractNo + '<br>';
            });

            layer.confirm(showStr, {icon: 7, title: '确认删除'}, function (index) {
                layer.close(index);
                var ids = [];
                layui.each(data, function (index, item) {
                    ids.push(item.id);
                });

                $.ajax({
                    url: '${pageContext.request.contextPath}/contract/delete',
                    data: {'ids': ids},
                    traditional: true,   //使用传统模式传递数组
                    success: function (data) {
                        var str = '<div style="text-align:center" >删除完成<br>';
                        str += '成功条目：' + data.success.length + ' <br>';
                        str += '失败条目：' + data.fail.length + ' <br>';
                        str += '合计条目：' + ids.length + ' <br></div>';
                        var index = layer.open({
                            type: 1,
                            title: '操作完成',
                            btn: '确定',
                            content: str,
                            end: function () {
                                layer.close(index);
                                table.reload('contract-table');
                            }
                        });
                    }
                });
            });

        });

        //修改按钮点击事件
        $('#update-button').click(function () {
            var checkStatus = table.checkStatus('contract-table')
                , data = checkStatus.data;
            if (data.length != 1) {
                layer.msg('请选择一行数据');
                return;
            }

            var id = data[0].id;
            //console.log(data);
            if(data[0].conState != '草稿'){
                layer.msg('非草稿状态不能编辑！');
                return;
            }


            layer.open({
                type: 2,
                title: '修改合同',
                area: ['750px', '92%'],
                shadeClose: false,
                closeBtn: 1,
                content: 'views/contract/updateContract.jsp?id=' + id,
                end: function () {
                    table.reload('contract-table');
                }
            });
        });

        //显示添加按钮鼠标经过事件
        $('#add-btn-div').mouseover(function () {
            $('#add-btn-more').show();
        });
        $('#add-btn-div').mouseleave(function () {
            $('#add-btn-more').hide();
        });

        //点击添加客户点击事件
        $('#add-contract-btn').click(function () {
            layer.open({
                type: 2,
                title: '新增合同',
                area: ['750px', '92%'],
                shadeClose: false,
                closeBtn: 1,
                content: 'views/contract/addContract.jsp',
                end: function () {
                    table.reload('contract-table');
                }
            });
        });


        //点击添加跟踪记录事件
        $('#add-followup-btn').click(function () {
            layer.open({
                type: 2,
                title: '新建跟踪',
                area: ['500px', '750px'],
                closeBtn: 1,
                shadeClose: false,
                content: '${pageContext.request.contextPath}/views/contract/editfollowup.jsp?type=add',
                end: function () {
                    //table.reload('linkman-table');
                    //flow.reload();
                }
            });
        });


        //详情弹出窗
        table.on('tool(contract-table)',function(obj){
            var data = obj.data;
            var contractId = data.id;
            var customerId = data.customerId;
            if(obj.event === 'detail'){
                layer.open({
                    type:2,
                    title:'客户详情',
                    area:['80%','100%'],
                    clostBtn:1,
                    shadeClose: true,
                    maxmin:true,
                    offset:'r',
                    content:'views/contract/contractInfo.jsp?id='+ customerId +"&contractId="+contractId,
                    end: function () {
                        table.reload('contract-table');
                    }
                });

            }
        });


        //转移按钮点击事件
        $('#contract-transfer-button').click(function () {
            var checkStatus = table.checkStatus('contract-table')
                , data = checkStatus.data;
            if (data.length > 1) {
                layer.msg('最对只能选一行数据');
                return;
            }

            if (data.length == 1) {
                var contractid = data[0].id;
                layer.open({
                    type: 2,
                    title: '客户转移',
                    area: ['700px', '430px'],
                    shadeClose: false,
                    closeBtn: 1,
                    content: 'views/contract/contracttransfer.jsp?contractId=' + contractid,
                    end: function () {
                        table.reload('contract-table');
                    }
                });
                return;
            }

            layer.open({
                type: 2,
                title: '客户转移',
                area: ['700px', '430px'],
                shadeClose: false,
                closeBtn: 1,
                content: 'views/contract/contracttransfer.jsp',
                end: function () {
                    table.reload('contract-table');
                }
            });
        });


        //导出按钮点击事件
        $('#export-button').click(function () {
            var checkStatus = table.checkStatus('contract-table')
                , data = checkStatus.data;
            if (data.length < 1) {
                layer.msg('请至少选一行数据');
                return;
            }
            var option = {};
            option.fileName = 'excel'
            option.datas = [
                {
                    sheetData: data,
                    sheetName: 'sheet',
                    sheetFilter: ['name', 'type', 'level', 'status', 'credit', 'area', 'companyAddress', 'companyPhone', 'postCode', 'faxAddress', 'companyWebsite', 'licenseNumber', 'corporation', 'annualSale', 'depositBank', 'bankAccount', 'landTaxNumber', 'nationalTaxNumber', 'source', 'description', 'maturity'],
                    sheetHeader: ['名称', '类别', '等级', '状态', '信用度', 'area', '详细地址', '电话', '邮政编码', '传真地址', '公司网站', '营业执照注册号', '法人', '年营业额', '开户银行', '银行账号', '地税登记号', '国税登记号', '来源', '描述', '成熟度']
                }

            ];
            var toExcel = new ExportJsonExcel(option);
            toExcel.saveExcel();
        });

    });

</script>



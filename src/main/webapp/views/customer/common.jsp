<%--
  Created by IntelliJ IDEA.
  User: 10282
  Date: 2021/11/8
  Time: 19:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="layui-form-item">
    <!-- 客户名称 -->
    <label class="layui-form-label">客户名称<strong style="color: red">*</strong>：</label>
    <div class="layui-input-inline">
        <input type="text" name="customerName" lay-verify="required" class="layui-input">
    </div>
    <div class="layui-form-mid layui-word-aux" id="customer-name-msg"></div>
</div>

<div class="layui-form-item">
    <!-- 客户名称 -->
    <label class="layui-form-label">域名\网址<strong style="color: red">*</strong>：</label>
    <div class="layui-input-inline">
        <input type="text" name="realmName" lay-verify="required"  class="layui-input">
    </div>

</div>
<div class="layui-form-item">

    <label class="layui-form-label">用户数<strong style="color: red">*</strong>：</label>
    <div class="layui-input-inline">
        <input type="text" name="userNum" lay-verify="required"  class="layui-input"  id="userNum" />
    </div>

    <%--到期时间--%>
    <label class="layui-form-label">到期时间：</label>
    <div class="layui-input-inline">
        <input type="text" name="endDate" class="layui-input"  id="endDate" />
    </div>

</div>
<div class="layui-form-item">
    <!-- 公司电话 -->
    <label class="layui-form-label">公司电话<strong style="color: red">*</strong>：</label>
    <div class="layui-input-inline">
        <input type="text" name="companyPhone" lay-verify="required"   class="layui-input">
    </div>

    <!-- 现服务商-->
    <label class="layui-form-label">现服务商<strong style="color: red">*</strong>：</label>
    <div class="layui-input-inline" style="width: 135px;">
        <select name="source" lay-verify="required" >
            <option value="">--数据加载中--</option>
        </select>
    </div>
    <div class="layui-form-mid layui-word-aux">
        <a href="#" name="客户来源" id="field-source"  style="color: blue;">
            <i class="layui-icon  layui-icon-add-1"></i>编辑
        </a>
    </div>
</div>

<div class="layui-form-item">

    <!-- 客户状态 -->
    <label class="layui-form-label">客户状态<strong style="color: red">*</strong>：</label>
    <div class="layui-input-inline" style="width: 135px;">
        <select name="status" lay-verify="required" >
            <option value="">--数据加载中--</option>
        </select>
    </div>
    <div class="layui-form-mid layui-word-aux">
        <a href="#" name="客户状态" id="field-status"   style="color: blue;">
            <i class="layui-icon  layui-icon-add-1"></i>编辑
        </a>
    </div>

    <!-- 客户类别 -->
    <label class="layui-form-label">客户规模<strong style="color: red">*</strong>：</label>
    <div class="layui-input-inline" style="width: 135px;">
        <select name="type" lay-verify="required"  >
            <option value="">--数据加载中--</option>
        </select>
    </div>
    <div class="layui-form-mid layui-word-aux">
        <a href="#" name="客户类别" id="field-type"  style="color: blue;">
            <i class="layui-icon  layui-icon-add-1"></i>编辑
        </a>
    </div>
</div>

<div class="layui-form-item">

    <!-- 客户等级 -->
    <label class="layui-form-label">客户等级：</label>
    <div class="layui-input-inline" style="width: 135px;">
        <select name="customerLevel">
            <option value="">--数据加载中--</option>
        </select>
    </div>
    <div class="layui-form-mid layui-word-aux">
        <a href="#" name="客户等级" id="field-customerLevel"  style="color: blue;">
            <i class="layui-icon  layui-icon-add-1"></i>编辑
        </a>
    </div>

    <label class="layui-form-label">报备到期：</label>
    <div class="layui-input-inline">
        <input type="text" name="reportEndDate"  class="layui-input" id="reportEndDate">
    </div>

</div>





<%--<div class="layui-form-item">
    <!-- 客户所在地区 -->
    <label class="layui-form-label">所在地区：</label>
    <div class="layui-input-inline">
        <input type="text" name="area"  class="layui-input">
    </div>

    <!-- 邮政编码 -->
    <label class="layui-form-label">邮政编码：</label>
    <div class="layui-input-inline">
        <input type="text" name="postCode"  class="layui-input">
    </div>
</div>--%>

<!-- 详细地址 -->
<div class="layui-form-item">
    <label class="layui-form-label">详细地址：</label>
    <div class="layui-input-block">
        <input type="text" name="companyAddress" class="layui-input"  style="width: 500px;" />
    </div>
</div>
<div class="layui-form-item">
    <label class="layui-form-label">备注：</label>
    <div class="layui-input-block">
        <textarea  name="description" class="layui-input"  style="width: 500px;height: 100px;" ></textarea>
    </div>
</div>

<%--<!-- 相关文件 -->
<div class="layui-form-item">
    <input type="hidden" name="document" value=""/>
    <label class="layui-form-label">相关文件：</label>
    <div class="layui-input-block">
        <div class="layui-inline layui-upload " >
            <button type="button" class="layui-btn layui-btn-normal" id="fileupload">选择文件</button>
            <span id="upload-filename" class="layui-inline" style="color: #999999"></span>
            <button type="button" class="layui-btn layui-btn-disabled layui-hide" id="upload-btn">开始上传</button>
        </div>
        <div class="layui-form-mid layui-word-aux">只可上传一个文件</div>
    </div>
</div>



<!-- 客户介绍 -->


<div class="layui-form-item">
    <!-- 传真地址 -->
    <label class="layui-form-label">传真地址：</label>
    <div class="layui-input-inline">
        <input type="text" name="faxAddress"  class="layui-input">
    </div>

    <!-- 公司网站 -->
    <label class="layui-form-label">公司网站：</label>
    <div class="layui-input-inline">
        <input type="text" name="companyWebsite"  class="layui-input">
    </div>
</div>


<div class="layui-form-item">
    <!-- 法人 -->
    <label class="layui-form-label">法人：</label>
    <div class="layui-input-inline">
        <input type="text" name="corporation"  class="layui-input">
    </div>

    <!-- 开户银行 -->
    <label class="layui-form-label">开户银行：</label>
    <div class="layui-input-inline">
        <input type="text" name="depositBank"  class="layui-input">
    </div>
</div>

<!-- 银行账号 -->
<div class="layui-form-item">
    <label class="layui-form-label">银行账号：</label>
    <div class="layui-input-block">
        <input type="text" name="bankAccount" class="layui-input"  style="width: 500px;" />
    </div>
</div>

<!-- 年营业额-->
<div class="layui-form-item">
    <label class="layui-form-label">年营业额：</label>
    <div class="layui-input-block">
        <input type="text" name="annualSale" class="layui-input"  style="width: 500px;" />
    </div>
</div>


<!-- 营业执照注册号 -->
<div class="layui-form-item">
    <label class="layui-form-label">营业执照注册号：</label>
    <div class="layui-input-block">
        <input type="text" name="licenseNumber" class="layui-input"  style="width: 500px;" />
    </div>
</div>

<!-- 地税登记号 -->
<div class="layui-form-item">
    <label class="layui-form-label">地税登记号：</label>
    <div class="layui-input-block">
        <input type="text" name="landTaxNumber" class="layui-input"  style="width: 500px;" />
    </div>
</div>

<!-- 国税登记号 -->
<div class="layui-form-item">
    <label class="layui-form-label">国税登记号：</label>
    <div class="layui-input-block">
        <input type="text" name="nationalTaxNumber" class="layui-input"  style="width: 500px;" />
    </div>
</div>--%>

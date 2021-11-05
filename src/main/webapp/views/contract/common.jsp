<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- 合同ID -->
<input type="hidden" name="id" value="0">

<div class="layui-form-item">
    <!-- 客户名称 -->
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

<div class="layui-form-item">
    <label class="layui-form-label">负责人：</label>
    <div class="layui-input-inline">
        <select name="manageId">
            <option value="">--数据加载中--</option>
        </select>
    </div>

    <label class="layui-form-label">签约时间：</label>
    <div class="layui-input-inline">
        <input type="text" name="signDate" lay-verify="required"  id="signDate" class="layui-input"  />
    </div>
</div>


<div class="layui-form-item">
    <label class="layui-form-label">过期时间：</label>
    <div class="layui-input-inline">
        <input type="text" name="endDate" lay-verify="required"  id="endDate" class="layui-input"  />
    </div>
    <label class="layui-form-label">总额：</label>
    <div class="layui-input-inline">
        <input type="text" name="totalAmount" lay-verify="required"  onblur="value=zhzs(this.value)" id="totalAmount"  class="layui-input"  />
    </div>

</div>

<div class="layui-form-item">
    <label class="layui-form-label">其他：</label>
    <div class="layui-input-inline">
        <input type="text" name="otherAmount" lay-verify="required" onblur="value=zhzs(this.value)" id="otherAmount" class="layui-input"  />
    </div>
    <label class="layui-form-label">总额：</label>
    <div class="layui-input-inline">
        <input type="text" name="discountAmount" lay-verify="required"  onblur="value=zhzs(this.value)" id="discountAmount" class="layui-input"  />
    </div>

</div>


<div class="layui-form-item">
    <label class="layui-form-label">合同金额：</label>
    <div class="layui-input-inline">
        <input type="text" name="contractAmount" lay-verify="required" onblur="value=zhzs(this.value)" id="contractAmount" class="layui-input"  />
    </div>
    <label class="layui-form-label">合同成本：</label>
    <div class="layui-input-inline">
        <input type="text" name="baseAmount" lay-verify="totalAmount" onblur="value=zhzs(this.value)"  id="required" class="layui-input"  />
    </div>
</div>


<div class="layui-form-item">
    <label class="layui-form-label">合同类型：</label>
    <div class="layui-input-inline">
        <input type="text" name="contractType" lay-verify="required"  id="contractType" class="layui-input"  />
    </div>
    <label class="layui-form-label">支付方式：</label>
    <div class="layui-input-inline">
        <input type="text" name="payType" lay-verify="totalAmount"  id="payType" class="layui-input"  />
    </div>
</div>


<div class="layui-form-item">
    <label class="layui-form-label">用户数：</label>
    <div class="layui-input-inline">
        <input type="text" name="userNum" lay-verify="required"  id="userNum" class="layui-input"  />
    </div>
    <label class="layui-form-label">使用年限：</label>
    <div class="layui-input-inline">
        <input type="text" name="limitYears" lay-verify="required"  id="limitYears" class="layui-input"  />
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
                    class="layui-btn">提交
            </button>
        </div>
    </div>
</div>
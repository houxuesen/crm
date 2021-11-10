<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- 合同ID -->
<input type="hidden" name="id" value="0">
<input type="hidden" name="conState" id="conState" value="0">
<div class="layui-form-item">
    <!-- 客户名称 -->
    <label class="layui-form-label">合同编号<strong style="color: red">*</strong>：</label>
    <div class="layui-input-inline">
        <input type="text" name="contractNo" lay-verify="required"  placeholder="姓名全拼年月日编号（01,02,03）" class="layui-input"  />
    </div>
    <div class="layui-form-mid layui-word-aux" id="contractNo-msg"></div>
</div>

<div class="layui-form-item">

    <label class="layui-form-label">客户<strong style="color: red">*</strong>：</label>
    <div class="layui-input-inline">
        <input type="hidden" name="customerId" id="customerId" >
        <div class="layui-input-inline">
            <input type="text" name="customerName" lay-verify="required"  id="customerName" class="layui-input"  />
        </div>
    </div>
</div>

<div class="layui-form-item">
    <label class="layui-form-label">合同类型<strong style="color: red">*</strong>：</label>
    <div class="layui-input-inline">
        <%--<input type="text" name="contractType" lay-verify="required"  id="contractType" class="layui-input"  />--%>
        <select name="contractType" lay-verify="required">
            <option value="">--数据加载中--</option>
        </select>
    </div>
    <label class="layui-form-label">签约人<strong style="color: red">*</strong>：</label>
    <div class="layui-input-inline">
        <select name="signUserId" lay-verify="required">
            <option value="">--数据加载中--</option>
        </select>
    </div>
</div>

<div class="layui-form-item">
    <label class="layui-form-label">负责人<strong style="color: red">*</strong>：</label>
    <div class="layui-input-inline">
        <select name="manageId" lay-verify="required">
            <option value="">--数据加载中--</option>
        </select>
    </div>

    <label class="layui-form-label">签约时间<strong style="color: red">*</strong>：</label>
    <div class="layui-input-inline">
        <input type="text" name="signDate" lay-verify="required"  id="signDate" class="layui-input"  />
    </div>
</div>


<div class="layui-form-item">
    <label class="layui-form-label">过期时间<strong style="color: red">*</strong>：</label>
    <div class="layui-input-inline">
        <input type="text" name="endDate" lay-verify="required"  id="endDate" class="layui-input"  />
    </div>
    <label class="layui-form-label">总额<strong style="color: red">*</strong>：</label>
    <div class="layui-input-inline">
        <input type="text" name="totalAmount" lay-verify="required"  onblur="value=zhzs(this.value)" id="totalAmount"  class="layui-input"  />
    </div>

</div>

<div class="layui-form-item">
    <label class="layui-form-label">用户数<strong style="color: red">*</strong>：</label>
    <div class="layui-input-inline">
        <input type="text" name="userNum" lay-verify="required"  id="userNum" class="layui-input"  />
    </div>
    <label class="layui-form-label">购买年限<strong style="color: red">*</strong>：</label>
    <div class="layui-input-inline">
        <input type="text" name="limitYears" lay-verify="required"  id="limitYears" class="layui-input"  />
    </div>
</div>


<div class="layui-form-item">
    <label class="layui-form-label">合同金额<strong style="color: red">*</strong>：</label>
    <div class="layui-input-inline">
        <input type="text" name="contractAmount" lay-verify="required" onblur="value=zhzs(this.value)" id="contractAmount" class="layui-input"  />
    </div>
    <label class="layui-form-label">合同成本<strong style="color: red">*</strong>：</label>
    <div class="layui-input-inline">
        <input type="text" name="baseAmount" lay-verify="required" onblur="value=zhzs(this.value)"  id="baseAmount" class="layui-input"  />
    </div>
</div>

<div class="layui-form-item">
    <label class="layui-form-label">商务返点<strong style="color: red">*</strong>：</label>
    <div class="layui-input-inline">
        <input type="text" name="discountAmount" lay-verify="required"  onblur="value=zhzs(this.value)" id="discountAmount" class="layui-input"  />
    </div>
    <label class="layui-form-label">毛利额<strong style="color: red">*</strong>：</label>
    <div class="layui-input-inline">
        <input type="text" name="otherAmount" lay-verify="required" onblur="value=zhzs(this.value)" id="otherAmount" class="layui-input"  />
    </div>
</div>


<div class="layui-form-item">

    <label class="layui-form-label">支付方式<strong style="color: red">*</strong>：</label>
    <div class="layui-input-inline">
       <%-- <input type="text" name="payType" lay-verify="required"  id="payType" class="layui-input"  />--%>
           <select name="payType" lay-verify="required">
               <option value="">--数据加载中--</option>
           </select>
    </div>
</div>




<!-- 相关文件 -->
<div class="layui-form-item">
    <input type="hidden" name="document" value=""/>
    <label class="layui-form-label">合同上传<strong style="color: red">*</strong>：</label>
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

            <button type="button" name="contract-form-save-btn" lay-submit lay-filter="contract-form-save" lay-event="save"
                    class="layui-btn">保存草稿
            </button>

            <button type="button" name="contract-form-submit-btn" lay-submit lay-filter="contract-form-submit" lay-event="submit"
                    class="layui-btn">提交
            </button>
        </div>
    </div>
</div>
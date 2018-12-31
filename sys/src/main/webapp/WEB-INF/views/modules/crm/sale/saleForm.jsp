<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>销售线索管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});

            var jbox;
            $("input[name='selectSaleAdviser']").click(function () {
                jbox =  top.$.jBox.open("iframe:/crm/sale/selectSaleAdviser", "选择员工", 1024, 520);
            });

            $("#selectCustomer").click(function () {
                jbox =  top.$.jBox.open("iframe:/crm/sale/selectCustomer", "添加客户", 1024, 520);
            });
            $("#addCustomer").click(function () {
                location.href="${ctx}/crm/customer/baseCustomerForm";
            });
            $.ajax({
                type:"POST",
                async:false,
                url:"${ctx}/crm/sale/findCustomerName",
                data:"customerId="+$("#customerId").val(),
                success: function(data){
                    if(data.status == "success"){
                        showCustomer(data.customer);
                    }else{

                    }
                }
            });
		});
        function selectCustomerCallback(customerId,name,phone,customerName){
            console.log("#btnSelect"+customerId+name,phone,customerName);
            $("#customerId").val(customerId);
            $("#names").val(name);
            $("#phone").val(phone);
            $("#customerName").val(customerName);

        }

        function showCustomer(customer){
            $("#customer").val(customer.id);
            $("#names").val(customer.name);
            $("#phone").val(customer.phone);
            $("#customerName").val(customer.customerResource.customerName);
		}

        function selectSaleAdviserCallback(userId,name){
            console.log("#btnSelect"+userId,name);
            $("#saleAdviserId").val(userId);
            $("#saleAdviserName").val(name);
        }
       // 验证委派自己为销售顾问复选框是否被选中
        function checkSaleAdviser() {
            if( $("#saleAdviser").attr("checked")=='checked'){
                $("#selectAdviser").attr("disabled",true);
                $("#saleAdviserId").val('${user.id}')
                $("#saleAdviserName").val('${user.name}')

            }else{
                $("#selectAdviser").attr("disabled",false);
                $("#saleAdviserId").val(" ")
                $("#saleAdviserName").val(" ")

			}

        }

        function checkVip() {
            if( $("#vipFlag").attr("checked")=='checked'){
                $("#vipFlag").val(0);
            }else{
                $("#vipFlag").val(1);

            }

        }
	</script>
</head>
<body>

	<c:if test="${tagFlag == null}">
		<div id="divOne">
			<ul class="nav nav-tabs">
				<li class="active"><a href="${ctx}/crm/sale/form?id=${crmSale.id}">销售线索<shiro:hasPermission name="crm:sale:form">${not empty crmSale.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="crm:sale:form">查看</shiro:lacksPermission></a></li>
			</ul><br/>
		</div>
	</c:if>

	<c:if test="${tagFlag == 1}">
		<div id="divTwo">
			<font size="4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;新增销售线索</font>
		</div>
		<br/>
	</c:if>

	<form:form id="inputForm" modelAttribute="crmSale" action="${ctx}/crm/sale/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<input type="hidden" name="createTime" value="<fmt:formatDate value="${createTime}" pattern="yyyy-MM-dd HH:mm"/>">
		<input type="hidden" name="tagFlag" value="${tagFlag}">
		<input type="hidden" name="customerId" value="${customerId}">
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">客户姓名：</label>
			<div class="controls">
				<input type="hidden" name="customer.id" id="customerId" value="${crmSale.customer.id}">
				<input  type="text"  name="customer.name" id="names"  value="${crmSale.customer.name}"
						style="width:200px;" placeholder="点击选择添加客户" readonly=readonly class="required"/>&nbsp;&nbsp;
				<c:if test="${tagFlag == null}">
					<input id="selectCustomer" class="btn btn-primary" type="button" value="选择客户"/>
					<input id="addCustomer" class="btn btn-primary" type="button" value="添加客户"/>
				</c:if>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">手机号码：</label>
			<div class="controls">
				<input  type="text"  name="customer.phone" id="phone"  value="${crmSale.customer.phone}"
						style="width:200px;" readonly=readonly />&nbsp;&nbsp;
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">意向业务：</label>
			<div class="controls">
				<form:select path="serviceTypeId" class="required input-medium">
					<form:options items="${erp:getCommonsTypeList(59)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">意向门店：</label>
			<div class="controls">

			</div>
		</div>
		<div class="control-group">
			<label class="control-label">预计消费时间：</label>
			<div class="controls">
				<input name="planConsumptionTime" type="text"  maxlength="20" class="required input-medium Wdate "
					   value="<fmt:formatDate value="${crmSale.planConsumptionTime}" pattern="yyyy-MM-dd HH:mm"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">线索来源：</label>
			<div class="controls">
				<input type="text" value="${crmSale.customerResource.customerName}" id="customerName" readonly="readonly" style="width: 200px;">
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">线索获取人：</label>
			<div class="controls">
				<sys:treeselect id="clueAccessId" name="clueAccessName.id" value="${crmSale.clueAccessName.id}"
								labelName="clueAccessName.name" labelValue="${crmSale.clueAccessName.name}"
								title="用户" url="/sys/office/treeData?type=3" notAllowSelectParent="true" allowClear="true" cssClass="required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">重要程度：</label>
			<div class="controls">
				<form:select path="importantDegree"  class="required input-large ">
					<form:option value="">请选择</form:option>
					<form:options items="${erp:getCommonsTypeList(54)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
				<input type="checkbox" name="vipFlag" id="vipFlag" value="0" onchange="checkVip()" checked="checked">VIP客户
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">需求描述：</label>
			<div class="controls">
				<form:textarea path="clueDescription" htmlEscape="false" rows="4" class="required input-xxlarge" maxlength="1024" />
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div>
			<div class="control-group">
				<div class="controls">
					<input type="checkbox" id="saleAdviser" onchange="checkSaleAdviser()">指派自己为销售顾问
				</div>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">销售顾问：</label>
			<div class="controls">
					<input type="hidden" name="saleAdviserId" id="saleAdviserId" >
					<input  type="text"  name="saleAdviserName" id="saleAdviserName"
							style="width:200px;" placeholder="点击选择添加员工" readonly=readonly/>&nbsp;&nbsp;
					<input name="selectSaleAdviser" class="btn btn-primary" type="button" id="selectAdviser" value="从员工中选择"/>
			</div>

		</div>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remark" htmlEscape="false" rows="4" class="input-xxlarge" maxlength="1024" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">添加人：</label>
			<div class="controls">
				<form:input path="createUserName.name" htmlEscape="false" maxlength="20" class="input-large " disabled="true" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">添加时间：</label>
			<div class="controls">
				<input name="" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate  "
					   value="<fmt:formatDate value="${crmSale.createTime}" pattern="yyyy-MM-dd HH:mm"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="crm:sale:save"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>
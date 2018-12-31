<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>收款单管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			alert(${erpOrder.id});
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
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/erp/paymentBill/list">收款单列表</a></li>
		<li class="active"><a href="${ctx}/erp/paymentBill/form?orderId=${erpPaymentBill.order.id}">收款单<shiro:hasPermission name="erp:paymentBill:form">${not empty erpPaymentBill.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="erp:paymentBill:form">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="paymentBill" action="${ctx}/erp/paymentBill/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">账单编号：</label>
			<div class="controls">
				<form:input path="billsCode" htmlEscape="false" maxlength="20" class="input-xlarge required digits"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">订单ID：</label>
			<div class="controls">
				<form:input path="order.id" value="${order.id}" htmlEscape="false" maxlength="1" class="input-xlarge "/>
			</div>
		</div>


		<table id="contentTable" class="table table-striped table-bordered table-condensed">
				<tr>
					<td>收费</td>
					<td>实收</td>
					<td>应收</td>
				</tr>
				<tr>
					<td rowspan="3">学费</td>
					<td>
						<label class="control-label">定金：</label>
						<form:input path="prepaidAmount" htmlEscape="false" maxlength="20" class="input-xlarge  digits"/>
					</td>
					<td>
						<div class="control-group">
							<label class="control-label">定金：${erpOrder.id}&nbsp;&nbsp;(元)</label>
							<label class="control-label">已交定金：${erpOrder.paymentAmount}&nbsp;&nbsp;(元)</label>
						</div>
					</td>
				</tr>

				<tr>
					<td>
						<label class="control-label">学费：</label>
						<form:input path="tuitionAmount" htmlEscape="false" maxlength="20" class="input-xlarge  digits"/>
					</td>
					<td>
						<div class="control-group">
							<label class="control-label">学费：${erpOrder.id}&nbsp;&nbsp;(元)</label>
							<label class="control-label">已交学费：${erpOrder.paymentAmount}&nbsp;&nbsp;(元)</label>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<label class="control-label">学杂费：</label>
						<form:input path="miscellaneousAmount" htmlEscape="false" maxlength="20" class="input-xlarge  digits"/>
					</td>
					<td>
						<div class="control-group">
							<label class="control-label">学杂费：${erpOrder.id}&nbsp;&nbsp;(元)</label>
							<label class="control-label">已交学杂费：${erpOrder.paymentAmount}&nbsp;&nbsp;(元)</label>
						</div>
					</td>
				</tr>

			<tr>
				<td rowspan="2">代收</td>
				<td>
					<label class="control-label">保证金：</label>
					<form:input path="depositAmount" htmlEscape="false" maxlength="20" class="input-xlarge  digits"/>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">保证金：${erpOrder.id}&nbsp;&nbsp;(元)</label>
						<label class="control-label">已交保证金：${erpOrder.paymentAmount}&nbsp;&nbsp;(元)</label>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<label class="control-label">保险费：</label>
					<form:input path="insuranceAmount" htmlEscape="false" maxlength="20" class="input-xlarge  digits"/>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">保险费：${erpOrder.id}&nbsp;&nbsp;(元)</label>
						<label class="control-label">已交保险费：${erpOrder.paymentAmount}&nbsp;&nbsp;(元)</label>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<label class="control-label">合计收费：123 &nbsp;&nbsp;(元)</label>
					<label class="control-label">收款方式：</label>
					<%--<form:input path="typeId" htmlEscape="false" maxlength="20" class="input-xlarge  digits"/>--%>
					<form:select path="typeId" id="typeId" class="input-large" style="width: 180px">
						<form:option value="" label="------请选择------"/>
						<form:options items="${erp:getCommonsTypeList(18)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
					</form:select>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">付款类型：全额付款</label>
						<label class="control-label">财务编号：AS10086</label>
					</div>
				</td>
			</tr>
		</table>

		<div class="control-group">
			<label class="control-label">状态：</label>
			<div class="controls">
				<form:select path="status" class="input-medium">
					<form:option value="" label="------请选择------"/>
					<form:options items="${erp:billStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
				<%--<form:input path="status" htmlEscape="false" maxlength="1" class="input-xlarge "/>--%>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="erp:paymentBill:save"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>
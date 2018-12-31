<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>单表管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
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
		<li><a href="${ctx}/erp/paymentBillRecord/">其他收款列表</a></li>
		<li class="active"><a href="${ctx}/erp/paymentBillRecord/form?id=${erpPaymentRecord.id}">单表<shiro:hasPermission name="paymentrecord:erpPaymentRecord:edit">${not empty erpPaymentRecord.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="paymentrecord:erpPaymentRecord:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="paymentBill" action="${ctx}/erp/paymentBillRecord/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div>
			<table id="billRecordTable">
				<tr>
					<td>
						<div class="control-group">
							<label class="control-label">收款类别:</label>
							<div class="controls">
                                <form:select path="erpPaymentBillRecord.payType" class="input-large " disabled="true">
                                    <form:options items="${fns:getDictList('bill_pay_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                                </form:select>
							</div>
						</div>
					</td>
					<td>
						<div class="control-group">
							<label class="control-label">收入科目:</label>
							<div class="controls">
								<form:input path="erpPaymentBillRecord.erpFinaceType.id" value="${erpPaymentBill.erpPaymentBillRecord.erpFinaceType.subjectName}" type="text" readonly="readonly" style="width:250px;"/>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="control-group">
							<label class="control-label">收款金额:</label>
							<div class="controls">
								<form:input path="erpPaymentBillRecord.amount" value="${erpPaymentBill.erpPaymentBillRecord.amount}" type="text" readonly="readonly" style="width:250px;"/>
							</div>
						</div>
					</td>
					<td>
						<div class="control-group">
							<label class="control-label">收款方式:</label>
							<div class="controls">
								<form:input path="typeId" value="${erpPaymentBill.typeId}" type="text" readonly="readonly" style="width:250px;"/>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2">
                        <div class="control-group">
                            <label class="control-label">状态：</label>
                            <div class="controls">
                                <form:select path="status" class="input-large ">
                                    <form:options items="${fns:getDictList('sys_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                                </form:select>
                            </div>
                        </div>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<div class="control-group">
							<label class="control-label">备注:</label>
							<div class="controls">
                                <form:textarea path="remark" value="${erpPaymentBill.remark}" rows="4" style="width:709px;" maxlength="1000"/>
                            </div>
						</div>
					</td>
				</tr>
			</table>
		</div>

		<div class="form-actions">
			<shiro:hasPermission name="paymentrecord:erpPaymentRecord:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>
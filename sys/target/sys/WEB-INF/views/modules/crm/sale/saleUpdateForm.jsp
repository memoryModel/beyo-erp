<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>销售线索管理</title>
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
		<li><a href="${ctx}/crm/sale/list">销售线索</a></li>
		<li class="active"><a href="${ctx}/crm/sale/updateForm?id=${sale.id}&&tagFlag=${tagFlag}">基本信息</a></li>
		<li><a href="${ctx}/crm/saleFollow/saleFollowInfo?saleId=${sale.id}&&tagFlag=${tagFlag}">跟进记录</a></li>
	</ul>
	<form:form id="inputForm" modelAttribute="sale" action="${ctx}/crm/sale/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="crmCustomerManagement.id"/>
		<input type="hidden" name="customer" id="customer" value="${customerId}">
		<input type="hidden" value="${saleFollowId}" name="saleFollowId">
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">员工姓名：</label>
			<div class="controls">
				<input type="text"  value="${sale.crmCustomerManagement.names}" class="input-xlarge " readonly="true">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">服务类型：</label>
			<div class="controls">
				<form:select path="crmSkill.id"  class="input-large ">
					<form:options items="${crmSkillList}" itemLabel="skillName" itemValue="id" htmlEscape="false" />
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">线索描述：</label>
			<div class="controls">
				<form:textarea path="clueDescription" htmlEscape="false" rows="4" style="width:700px;" maxlength="1024" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remark" htmlEscape="false" rows="4" style="width:700px;" maxlength="1024" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">线索来源：</label>
			<div class="controls">
				<input type="text"  value="${sale.crmCustomerManagement.customerResource.customerName}" class="input-xlarge " readonly="true"  style="width:200px;">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">销售顾问：</label>
			<div class="controls">
				<input type="text" value="${sale.saleAdviser.name}" class="input-xlarge " readonly="true" style="width:200px;">
			</div>
		</div>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>变更状态</strong>
		<table>
			<tr>
				<td>
					<div class="control-group">
					<label class="control-label">当前状态：</label>
						<div class="controls">
								${erp:changeStatusName(sale.changeStatus)}
						</div>
				    </div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">变更状态：</label>
						<div class="controls">
							<form:select path="changeStatus" class="input-large ">
								<form:options items="${erp:changeStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
							</form:select>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div class="control-group">
						<label class="control-label">变更原因：</label>
						<div class="controls">
							<form:textarea path="changeReason" htmlEscape="false" rows="4" style="width:700px;" maxlength="1024" class="required"/>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
			</tr>
		</table>
		<div class="form-actions">
			<shiro:hasPermission name="crm:sale:save"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>
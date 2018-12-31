<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>职级管理</title>
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
		<li><a href="${ctx}/erp/employeeLevel/list">职工级别列表</a></li>
		<li class="active"><a href="${ctx}/erp/employeeLevel/form?id=${employeeLevel.id}">职工级别<shiro:hasPermission name="erp:employeeLevel:form">${not empty employeeLevel.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="erp:employeeLevel:form">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="employeeLevel" action="${ctx}/erp/employeeLevel/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<input type="hidden" name="token" value="${token}">
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">名称：</label>
			<div class="controls">
				<form:input path="jobName" htmlEscape="false" maxlength="255" class="required input-xlarge " style="width:200px"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">描述：</label>
			<div class="controls">
				<form:textarea path="description" htmlEscape="false" rows="4"  class="input-xlarge " maxlength="1024"  style="width:350px"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">级别：</label>
			<div class="controls">
				<form:input path="jobLevel" htmlEscape="false" maxlength="1" class="required input-xlarge digits " style="width:200px"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<c:if test="${employeeLevel.id != null }">
			<div class="control-group">
				<label class="control-label">状态：</label>
				<div class="controls">
					<form:select path="status" class="input-large ">
						<form:options items="${erp:commonsStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
		</c:if>
		<div class="form-actions">
			<shiro:hasPermission name="erp:employeeLevel:save"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>
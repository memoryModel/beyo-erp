<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>资历信息</title>
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
		<li class="active"><a href="${ctx}/erp/employeeResume/form?id=${employeeResume.id}">资历信息<shiro:hasPermission name="erp:employeeResume:form">${not empty employeeResume.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="erp:employeeResume:form">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="employeeResume" action="${ctx}/erp/employeeResume/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
			<table>
				<tr>
					<td>
						<div class="control-group">
							<label class="control-label">公司名称：</label>
							<div class="controls">
								<form:input path="companyTitle" htmlEscape="false"/>
								<span class="help-inline"><font color="red">*</font> </span>
							</div>
						</div>
					</td>
					<td>
						<div class="control-group">
							<label class="control-label">部门名称：</label>
							<div class="controls">
								<form:input path="department" htmlEscape="false"/>
								<span class="help-inline"><font color="red">*</font> </span>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="control-group">
							<label class="control-label">公司岗位：</label>
							<div class="controls">
								<form:input path="title" htmlEscape="false"/>
								<span class="help-inline"><font color="red">*</font> </span>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="control-group">
							<label class="control-label">开始时间：</label>
							<div class="controls">
								<input name="startTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
									   value="<fmt:formatDate value="${employeeResume.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
									   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
								<span class="help-inline"><font color="red">*</font> </span>
							</div>
						</div>
					</td>
					<td>
						<div class="control-group">
							<label class="control-label">结束时间：</label>
							<div class="controls">
								<input name="endTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
									   value="<fmt:formatDate value="${employeeResume.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
									   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
								<span class="help-inline"><font color="red">*</font> </span>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="control-group">
							<label class="control-label">工作描述：</label>
							<div class="controls">
								<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="200" class="input-xxlarge "/>
							</div>
						</div>
					</td>
				</tr>
			</table>
		<div class="form-actions">
			<shiro:hasPermission name="erp:employeeResume:save"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>
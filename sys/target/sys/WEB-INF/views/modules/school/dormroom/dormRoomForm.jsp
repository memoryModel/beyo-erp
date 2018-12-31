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
		<li><a href="${ctx}/erp/dorm/list">宿舍管理</a></li>
		<li class="active"><a href="${ctx}/erp/dormRoom/list?dormId=${dormRoom.erpDorm.id}">房间管理</a></li>
	</ul><br/>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/erp/dormRoom/list?dormId=${dormRoom.erpDorm.id}">房间列表</a></li>
		<li class="active"><a href="${ctx}/erp/dormRoom/form?dormId=${dormRoom.erpDorm.id}&&id=${dormRoom.id}">房间
			<shiro:hasPermission name="erp:dormRoom:form">${not empty dormRoom.id?'修改':'添加'}</shiro:hasPermission>
			<shiro:lacksPermission name="erp:dormRoom:form">查看</shiro:lacksPermission></a>
		</li>
	</ul><br/>


	<form:form id="inputForm" modelAttribute="dormRoom" action="${ctx}/erp/dormRoom/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="status"/>
		<sys:message content="${message}"/>
		<div class="control-group" hidden="hidden">
			<label class="control-label">宿舍Id：</label>
			<div class="controls">
				<form:input path="erpDorm.id" htmlEscape="false" maxlength="64" class="input-xlarge " />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">宿舍：</label>
			<div class="controls">
				<input type="text" name="dormName" value="${dormName}" class="input-xlarge " readonly="readonly" style="width: 200px;">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">房间：</label>
			<div class="controls">
				<form:input path="roomName" htmlEscape="false" maxlength="64" class="required input-xlarge " style="width: 200px;"/>
				<span class="help-inline"><font color="red">*</font> </span>

			</div>
		</div>
		<div class="control-group">
			<label class="control-label">床位数量：</label>
			<div class="controls">
				<form:input path="bedNumber" htmlEscape="false" maxlength="20" class="required digits valid " style="width: 200px;"/>
				<span class="help-inline"><font color="red">*</font> </span>

			</div>
		</div>
			<%--<div class="control-group">
				<label class="control-label">状态：</label>
				<div class="controls">
					<form:select path="status" class="input-large ">
						<form:options items="${erp:commonsStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>--%>
		<div class="form-actions">
			<shiro:hasPermission name="erp:dormRoom:save"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>客户来源管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#name").focus();
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
		<li><a href="${ctx}/erp/customerResource/list">客户来源列表</a></li>
		<li class="active"><a href="${ctx}/erp/customerResource/form?id=${customerResource.id}">客户来源<shiro:hasPermission name="erp:customerResource:form">${not empty customerResource.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="erp:customerResource:form">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="customerResource" action="${ctx}/erp/customerResource/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">上级类型名称：</label>
			<div class="controls">
				<sys:treeselect id="customerResource" name="parent.id" value="${customerResource.parent.id}"
								labelName="parent.customerName" labelValue="${customerResource.parent.customerName}"
								title="类型名称" url="/erp/customerResource/treeData"
								extId="${customerResource.id}" cssClass="" allowClear="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">客户来源名称：</label>
			<div class="controls">
				<form:input path="customerName" htmlEscape="false" maxlength="20" class="required" style="width: 200px"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">描述：</label>
			<div class="controls">
				<form:textarea path="description" htmlEscape="false" rows="4" class="input-xlarge " maxlength="1024" style="width:330px"/>
			</div>
		</div>
		<c:if test="${customerResource.id != null }">
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
			<shiro:hasPermission name="erp:customerResource:save"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>

		</div>
	</form:form>
</body>
</html>
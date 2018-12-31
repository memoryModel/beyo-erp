<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>招工沟通管理表管理</title>
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
		<li><a href="${ctx}/employeecommunication/employeeCommunication/">招工沟通管理表列表</a></li>
		<li class="active"><a href="${ctx}/employeecommunication/employeeCommunication/form?id=${employeeCommunication.id}">招工沟通管理表<shiro:hasPermission name="employeecommunication:employeeCommunication:edit">${not empty employeeCommunication.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="employeecommunication:employeeCommunication:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="employeeCommunication" action="${ctx}/employeecommunication/employeeCommunication/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">指派状态 0:已指派 1:未指派：</label>
			<div class="controls">
				<form:input path="appointStatus" htmlEscape="false" maxlength="1" class="input-xlarge  digits"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">指派人：</label>
			<div class="controls">
				<form:input path="appointId" htmlEscape="false" maxlength="280" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">指派时间：</label>
			<div class="controls">
				<input name="appointTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${employeeCommunication.appointTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">沟通人：</label>
			<div class="controls">
				<form:input path="communicationId" htmlEscape="false" maxlength="280" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">最近沟通时间：</label>
			<div class="controls">
				<input name="communicationTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${employeeCommunication.communicationTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">签约意向  0:确定签约  1:犹豫中  2:不签约：</label>
			<div class="controls">
				<form:input path="signingIntention" htmlEscape="false" maxlength="1" class="input-xlarge  digits"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">status：</label>
			<div class="controls">
				<form:input path="status" htmlEscape="false" maxlength="1" class="input-xlarge  digits"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">create_time：</label>
			<div class="controls">
				<input name="createTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${employeeCommunication.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="employeecommunication:employeeCommunication:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>
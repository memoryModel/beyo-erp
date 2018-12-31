<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>招工沟通历史记录表管理</title>
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
		<li><a href="${ctx}/employeecommunicationhistory/employeeCommunicationHistory/">招工沟通历史记录表列表</a></li>
		<li class="active"><a href="${ctx}/employeecommunicationhistory/employeeCommunicationHistory/form?id=${employeeCommunicationHistory.id}">招工沟通历史记录表<shiro:hasPermission name="employeecommunicationhistory:employeeCommunicationHistory:edit">${not empty employeeCommunicationHistory.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="employeecommunicationhistory:employeeCommunicationHistory:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="employeeCommunicationHistory" action="${ctx}/employeecommunicationhistory/employeeCommunicationHistory/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">招工人主键：</label>
			<div class="controls">
				<form:input path="employeeId" htmlEscape="false" maxlength="280" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">沟通人：</label>
			<div class="controls">
				<form:input path="communicateId" htmlEscape="false" maxlength="280" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">沟通时间：</label>
			<div class="controls">
				<input name="communicateTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${employeeCommunicationHistory.communicateTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">沟通方式：</label>
			<div class="controls">
				<form:input path="communication Mode" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">签约意向  0:确定签约  1:犹豫中  2:不签约：</label>
			<div class="controls">
				<form:input path="signingIntention" htmlEscape="false" maxlength="1" class="input-xlarge  digits"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">联系主题：</label>
			<div class="controls">
				<form:input path="theme" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">下次沟通安排  0:有  1:无：</label>
			<div class="controls">
				<form:input path="nextCommunicationArrangement" htmlEscape="false" maxlength="1" class="input-xlarge  digits"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">下次沟通方式：</label>
			<div class="controls">
				<form:input path="nextCommunicationMode" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">下次沟通时间：</label>
			<div class="controls">
				<input name="nextCommunicationTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${employeeCommunicationHistory.nextCommunicationTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
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
					value="<fmt:formatDate value="${employeeCommunicationHistory.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="employeecommunicationhistory:employeeCommunicationHistory:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>
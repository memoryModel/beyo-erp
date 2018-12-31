<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>委派记录管理</title>
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
		<li><a href="${ctx}/saledelegaterecord/saleDelegateRecord/">委派记录列表</a></li>
		<li class="active"><a href="${ctx}/saledelegaterecord/saleDelegateRecord/form?id=${saleDelegateRecord.id}">委派记录<shiro:hasPermission name="saledelegaterecord:saleDelegateRecord:edit">${not empty saleDelegateRecord.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="saledelegaterecord:saleDelegateRecord:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="saleDelegateRecord" action="${ctx}/saledelegaterecord/saleDelegateRecord/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">线索表id：</label>
			<div class="controls">
				<form:input path="saleId" htmlEscape="false" maxlength="20" class="input-xlarge  digits"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">销售顾问：</label>
			<div class="controls">
				<form:input path="saleAdviserId" htmlEscape="false" maxlength="20" class="input-xlarge  digits"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">委派操作时间：</label>
			<div class="controls">
				<input name="delegateTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${saleDelegateRecord.delegateTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">委派操作人：</label>
			<div class="controls">
				<form:input path="delegtatePersonId" htmlEscape="false" maxlength="20" class="input-xlarge  digits"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">撤回时间：</label>
			<div class="controls">
				<input name="withdrawTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${saleDelegateRecord.withdrawTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">撤回类型：</label>
			<div class="controls">
				<form:textarea path="withdrawType" htmlEscape="false" rows="4" maxlength="20" class="input-xxlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">撤回原因：</label>
			<div class="controls">
				<form:textarea path="withdrawReason" htmlEscape="false" rows="4" maxlength="1028" class="input-xxlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">撤回操作人：</label>
			<div class="controls">
				<form:input path="withdrawPersonId" htmlEscape="false" maxlength="20" class="input-xlarge  digits"/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="saledelegaterecord:saleDelegateRecord:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>
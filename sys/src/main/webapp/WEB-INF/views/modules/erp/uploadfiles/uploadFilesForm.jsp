<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>上传图片管理</title>
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
		<li><a href="${ctx}/upload/">上传图片列表</a></li>
		<li class="active"><a href="${ctx}/upload/form?id=${uploadFiles.id}">上传图片<shiro:hasPermission name="erp:uploadFiles:form">${not empty uploadFiles.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="upload:form">查看</shiro:lacksPermission></a></li>
	</ul>	<br/>
	<form:form id="inputForm" modelAttribute="uploadFiles" action="${ctx}/upload/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">名称：</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" maxlength="100" class="required"    style="width:200px" />
				<span class="help-inline" id="spanId"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">长度：</label>
			<div class="controls">
				<form:input path="size" htmlEscape="false" maxlength="180" class="required " style="width:200px"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">类型：</label>
			<div class="controls">
				<form:input path="type" htmlEscape="false" maxlength="180" class="required " style="width:200px"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">目录：</label>
			<div class="controls">
				<form:input path="dir" htmlEscape="false" maxlength="180" class="required " style="width:200px"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">创建时间：</label>
			<div class="controls">
				<input name="createTime" type="text" readonly="readonly" maxlength="180" class="input-medium Wdate "
					value="<fmt:formatDate value="${erpUploadFiles.createTime}" pattern="yyyy-MM-dd HH:mm"/>" style="width:200px"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">状态：</label>
			<div class="controls">
				<form:select path="status" class="input-large ">
					<form:options items="${erp:uploadStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="upload:save"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>财务科目设置管理</title>
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
	<li><a href="${ctx}/erp/finaceType/list">财务科目管理列表</a></li>
	<li class="active"><a href="${ctx}/erp/finaceType/form?id=${finaceType.id}">财务科目设置添加<shiro:hasPermission name="erp:finaceType:form">${not empty finaceType.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="erp:finaceType:form">查看</shiro:lacksPermission></a></li>
</ul><br/>
<form:form id="inputForm" modelAttribute="finaceType" action="${ctx}/erp/finaceType/save" method="post" class="form-horizontal">
	<form:hidden path="id"/>
	<sys:message content="${message}"/>
	<div class="control-group">
		<label class="control-label">上级科目名称类型：</label>
		<div class="controls">
			<sys:treeselect id="finaceType" name="parent.id" value="${finaceType.parent.id}"
							labelName="parent.subjectName" labelValue="${finaceType.parent.subjectName}"
							title="类型名称" url="/erp/finaceType/treeData"
							extId="${finaceType.id}" cssClass="" allowClear="true"/>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">科目名称：</label>
		<div class="controls">
			<form:input path="subjectName" htmlEscape="false" maxlength="255" class="required"  style="width: 200px"/>
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
	</div>

	<div class="control-group">
		<label class="control-label">科目编码：</label>
		<div class="controls">
			<form:input path="subjectCode" htmlEscape="false" maxlength="255" class="required"  style="width: 200px"/>
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">备注：</label>
		<div class="controls">
			<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="1024"  style="width: 330px"/>
		</div>
	</div>
	<c:if test="${finaceType.id != null }">
		<div class="control-group">
			<label class="control-label">状态：</label>
			<div class="controls">
				<form:select path="status" class="input-large ">
					<form:options items="${erp:commonsStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
	</c:if>
	<div class="form-actions">
		<shiro:hasPermission name="erp:finaceType:save"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
		<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
	</div>
</form:form>
</body>
</html>
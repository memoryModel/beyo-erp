<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>教室设置管理</title>
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
	<li><a href="${ctx}/school/classroom/list">教室设置列表</a></li>
	<li class="active"><a href="${ctx}/school/classroom/form?id=${classroom.id}">教室<shiro:hasPermission name="school:classroom:form">${not empty classroom.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="school:classroom:form">查看</shiro:lacksPermission></a></li>
</ul><br/>
<form:form id="inputForm" modelAttribute="classroom" action="${ctx}/school/classroom/save" method="post" class="form-horizontal">
	<form:hidden path="id"/>
	<sys:message content="${message}"/>
	<div class="control-group">
		<label class="control-label">教室名称：</label>
		<div class="controls">
			<form:input path="classroomName" htmlEscape="false" maxlength="64"  class="required input-xlarge " style="width:210px" />
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">容纳人数：</label>
		<div class="controls">
			<form:input path="marksNumber" htmlEscape="false" maxlength="20" class="required input-xlarge digits" style="width: 210px"/>
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
	</div>
	<c:if test="${classroom.id != null }">
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
		<shiro:hasPermission name="school:classroom:save"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
		<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
	</div>
</form:form>
</body>
</html>
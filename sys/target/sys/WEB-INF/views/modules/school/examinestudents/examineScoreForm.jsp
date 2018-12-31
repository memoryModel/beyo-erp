<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>成绩管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {

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
		<li><a href="${ctx}/school/examineStudents/list">成绩查询</a></li>
		<li class="active"><a href="${ctx}/school/examineStudents/form?id=${examineStudents.id}">修改成绩</a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="examineStudents" action="${ctx}/school/examineStudents/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">考试名称</label>
			<div class="controls">
				<input value="${examineStudents.examineInfo.examineName}" type="text" readonly="readonly" class="input-xlarge"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">姓名：</label>
			<div class="controls">
				<input value="${examineStudents.student.name}" type="text" readonly="readonly" class="input-xlarge"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">学号：</label>
			<div class="controls">
				<input value="${examineStudents.student.studentNumber}" type="text" readonly="readonly" class="input-xlarge"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">通过分数：</label>
			<div class="controls">

				${examineStudents.examineInfo.passingGrade}&nbsp;分
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">得分：</label>
			<div class="controls">
				<form:input path="grade" htmlEscape="false" maxlength="10" class="required digits valid" style="width: 50px;text-align: right;"/>&nbsp;分
				<span class="help-inline"><font color="red">*</font></span>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="school:examineStudents:save"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>授课计划管理</title>
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

			var result = '${result}';
			if(result == 'y'){
			    $('#btnSubmit').hide();
			}
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/school/lesson/list">课程列表</a></li>
		<li class="active"><a href="${ctx}/school/lessonPlans/list?lessonId=${classLessonPlans.schoolClassLesson.id}">授课计划</a></li>
	</ul></div><br/><div>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/school/lessonPlans/list?lessonId=${classLessonPlans.schoolClassLesson.id}">授课计划列表</a></li>
		<li class="active">
			    <shiro:hasPermission name="school:lessonPlans:form"><a href="${ctx}/school/lessonPlans/form?lessonId=${classLessonPlans.schoolClassLesson.id}&&id=${classLessonPlans.id}">授课计划
				${not empty classLessonPlans.id?'修改':'添加'}</shiro:hasPermission>
				<shiro:lacksPermission name="school:lessonPlans:form">查看</shiro:lacksPermission></a>
		</li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="classLessonPlans" action="${ctx}/school/lessonPlans/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="control-group"  style="display:none">
			<label class="control-label">课程Id：</label>
			<div class="controls">
				<form:input path="schoolClassLesson.id" htmlEscape="false" maxlength="20" class="input-xlarge required digits"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">课程节数名称：</label>
			<div class="controls">
				<form:input path="lessonSectionName" htmlEscape="false" maxlength="20" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">授课内容：</label>
			<div class="controls">
				<form:textarea path="lessonSectionContent" htmlEscape="false" rows="4" maxlength="512" class="input-xlarge required" style="width:700px;"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<c:if test="${classLessonPlans.id != null }">
			<div class="control-group">
				<label class="control-label">状态：</label>
				<div class="controls">
					<form:select path="status" class="input-medium">
						<form:options items="${erp:commonsStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
		</c:if>
		<div class="form-actions">
			<shiro:hasPermission name="school:lessonPlans:save"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>
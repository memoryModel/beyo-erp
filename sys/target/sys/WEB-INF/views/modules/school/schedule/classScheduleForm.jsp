<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>课表管理</title>
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
		<li><a href="${ctx}/school/schedule/list">课表列表</a></li>
		<li class="active">
			<a href="${ctx}/school/schedule/form?id=${schoolClassSchedule.id}">
				<shiro:hasPermission name="school:schedule:form">
					${not empty schoolClassSchedule.id?'课表修改':'排课管理'}
				</shiro:hasPermission>
			</a>
		</li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="classSchedule" action="${ctx}/school/schedule/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		

		<div class="control-group">
			<label class="control-label">班级：</label>
			<div class="controls">
				<form:select path="schoolClass.id" class="required">
					<c:if test="${empty schoolClassSchedule.id}">
						<form:option value="" label="--请选择--"/>
					</c:if>

					<form:options items="${classList}" itemLabel="className" itemValue="id" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">教室：</label>
			<div class="controls">
				<form:select path="schoolClassroom.id" class="required">
					<c:if test="${empty schoolClassSchedule.id}">
						<form:option value="" label="--请选择--"/>
					</c:if>
					<form:options items="${classroomList}" itemLabel="classroomName" itemValue="id" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">课程：</label>
			<div class="controls">
				<form:select path="schoolClassLesson.id" class="required digits valid">
					<c:if test="${empty schoolClassSchedule.id}">
						<form:option value="" label="--请选择--"/>
					</c:if>
					<form:options items="${lessonList}" itemLabel="lessonName" itemValue="id" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">开始日期：</label>
			<div class="controls">
				<input name="beginTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${schoolClassSchedule.beginTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">结束日期：</label>
			<div class="controls">
				<input name="endTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${schoolClassSchedule.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">创建时间：</label>
			<div class="controls">
				<input name="createTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${schoolClassSchedule.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">状态：</label>
				<div class="controls">
					<form:input path="status" htmlEscape="false" maxlength="1"/>
				</div>
			</div>

		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<form:textarea path="remark" htmlEscape="false" rows="3" maxlength="200"
						class="input-xlarge" style="width:250px;"/>
			</div>
		</div>

	<br/><br/>



		<div class="form-actions">
			<shiro:hasPermission name="school:schedule:save"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>
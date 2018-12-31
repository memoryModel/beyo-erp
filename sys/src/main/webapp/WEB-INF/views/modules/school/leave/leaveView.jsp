<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>请假预计延误课程</title>
	<meta name="decorator" content="default"/>
</head>
<body>
<br/>
<form:form id="inputForm" modelAttribute="schoolLeave" action="${ctx}/school/leave/save" method="post" class="form-horizontal">
	<form:hidden path="id"/>
	<sys:message content="${message}"/>
	<div class="alert alert-info">预计延误课程</div>
	<div class="control-group">
		<label class="control-label">姓名：</label>
		<div class="controls">
			<form:input path="student.name" htmlEscape="false" maxlength="20" class="required input-xlarge  " readonly="true"/>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">学号：</label>
		<div class="controls">
			<form:input path="student.studentNumber" htmlEscape="false" maxlength="20" class="required input-xlarge  " readonly="true"/>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">请假时间：</label>
		<input name="startTime" id="startTime"  type="text" readonly="readonly" maxlength="20" class="required input-medium Wdate "
			   value="<fmt:formatDate value="${schoolLeave.startTime}" pattern="yyyy-MM-dd HH:mm"/>"
			   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true,onpicked:function(dp){changeTime()}});"/>&nbsp;至&nbsp;
		<input name="endTime" id="endTime" type="text" readonly="readonly" maxlength="20" class="required input-medium Wdate "
			   value="<fmt:formatDate value="${schoolLeave.endTime}" pattern="yyyy-MM-dd HH:mm" />"
			   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true,onpicked:function(dp){changeTime()}});" />
	</div>

	<%--<div class="alert alert-info">预计延误课程</div>--%>
	<div class="control-group">
		<label class="control-label">请假原因：</label>
		<div class="controls">
			<form:select id="leaveReason" path="leaveReason" class="required input-large" >
				<form:options items="${erp:getCommonsTypeList(28)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
			</form:select>
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
	</div>

	<div class="control-group">
		<label class="control-label"><b>预计延误课程</b></label>
		<div class="controls">
			<table id="contentTable" class="table table-striped table-bordered table-condensed" style="width: 80%">
				<thead>
				<tr>
					<th>班级名称</th>
					<th>课程名称</th>
					<th>授课老师</th>
					<th>上课时间</th>
					<th>上课教室</th>
				</tr>
				</thead>
				<tbody id="classTable">

				</tbody>
			</table>
		</div>
	</div>
</form:form>
</body>
</html>
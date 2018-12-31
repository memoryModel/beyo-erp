<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>签到上课管理</title>
	<meta name="decorator" content="default"/>

</head>
<body>
<br/>
<form:form id="inputForm" modelAttribute="classSchedule"   method="post" class="form-horizontal">
	<form:hidden path="id"/>
	<sys:message content="${message}"/>
	<div class="control-group">
		<label class="control-label">班级：</label>
		<div class="controls">
				${classSchedule.schoolClass.className}
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">课程：</label>
		<div class="controls">
				${classSchedule.schoolClassLesson.lessonName}
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">授课老师：</label>
		<div class="controls">
				${classSchedule.teacher.name}
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">上课时间：</label>
		<div class="controls">
			<fmt:formatDate  value="${classSchedule.beginTime}" pattern="yyyy-MM-dd HH:mm"/>~
			<fmt:formatDate value="${classSchedule.endTime}" pattern="HH:mm"/>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">上课内容：</label>
		<div class="controls">

				<textarea readonly="readonly" name="content"  htmlEscape="false" id="lessonContent" name="lessonContent" rows="4" maxlength="512" class="input-xxlarge ">${classLessonSign.lessonContent}</textarea>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">备注：</label>
		<div class="controls">

					<textarea readonly="readonly" name="remark" id="remark" htmlEscape="false" rows="4" name="remark" maxlength="512" class="input-xxlarge " >${classLessonSign.remark}</textarea>
		</div>
	</div>
	<div class="control-group">
		<table id="contentTable" class="table table-striped table-bordered table-condensed" >
			<thead>
			<tr>

				<th>学号</th>
				<th>姓名</th>
				<th>联系电话</th>
				<th>是否缺勤</th>
				<th>缺勤原因</th>
			</tr>
			</thead>
			<tbody>
			<c:forEach items="${studentList}" var="student">
				<tr id="myclass">

					<td>
							${student.studentNumber}
					</td>
					<td>
							${student.name}
					</td>
					<td>
							${student.phone}
					</td>
					<td>
						<c:if test="${student.classLessonSignHistory.status == 1}">
							缺勤
						</c:if>
					</td>
					<td>
							${erp:getCommonsTypeName(student.classLessonSignHistory.absenceReason)}
					</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>

	<div class="control-group">
		<label class="control-label">总人数：</label>
		<div class="controls">
			共<input type="text" readonly="readonly" id="studentCount" style="width: 20px" name="" value="${studentList.size()}">&nbsp;人&nbsp;&nbsp;&nbsp;
			实际出勤:<input type="text" readonly="readonly" style="width: 20px" id="signCount" value="${classSchedule.signCount}">&nbsp;人
		</div>
	</div>
</form:form>
</body>
</html>
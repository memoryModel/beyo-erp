<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>补课管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
<br>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/school/student/info?id=${student.id}&&tagFlag=${tagFlag}">基本信息</a></li>
		<li><a href="${ctx}/school/student/enrollInfo?id=${student.id}&&tagFlag=${tagFlag}">招生信息</a></li>
		<li><a href="${ctx}/school/student/classInfo?id=${student.id}&&tagFlag=${tagFlag}">报读班级</a></li>
		<li><a href="${ctx}/school/student/scheduleInfo?id=${student.id}&&tagFlag=${tagFlag}">课表信息</a></li>
		<li class="active"><a href="${ctx}/school/student/signInfo?id=${student.id}&&tagFlag=${tagFlag}">上课记录</a></li>
		<li><a href="${ctx}/school/student/communicateInfo?id=${student.id}&&tagFlag=${tagFlag}">沟通记录</a></li>
	</ul>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<th>班级名称</th>
			<th>课程</th>
			<th>授课老师</th>
			<th>上课时间</th>
			<th>上课时长</th>
			<th>上课教室</th>
			<th>是否出勤</th>
			<th>缺勤原因</th>
		</thead>
		<tbody>
		<c:forEach items="${classLessonSignHistoryList}" var="classLessonSignHistory">
			<tr>
				<td>
					${classLessonSignHistory.classLessonSign.schoolClass.className}
				</td>
				<td>
					${classLessonSignHistory.classLessonSign.schoolClassLesson.lessonName}
				</td>
				<td>
					${classLessonSignHistory.classLessonSign.teacher.name}
				</td>
				<td>
					<fmt:formatDate value="${classLessonSignHistory.classLessonSign.beginTime}" pattern="yyyy-MM-dd HH:mm"/>~<br/>
					<fmt:formatDate value="${classLessonSignHistory.classLessonSign.endTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
					<fmt:formatNumber value="${(classLessonSignHistory.classLessonSign.endTime.getTime()-classLessonSignHistory.classLessonSign.beginTime.getTime())/1000/60}" pattern="#0"/>分钟
				</td>
				<td>
					${classLessonSignHistory.classSchedule.schoolClassroom.classroomName}
				</td>
				<td>
					${erp:lessonSignName(classLessonSignHistory.status)}
				</td>
				<td>
					${erp:getCommonsTypeName(classLessonSignHistory.absenceReason)}
				</td>

			</tr>
		</c:forEach>
		</tbody>
	</table>

</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>课表管理</title>
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
		<li class="active"><a href="${ctx}/school/student/scheduleInfo?id=${student.id}&&tagFlag=${tagFlag}">课表信息</a></li>
		<li><a href="${ctx}/school/student/signInfo?id=${student.id}&&tagFlag=${tagFlag}">上课记录</a></li>
		<li><a href="${ctx}/school/student/communicateInfo?id=${student.id}&&tagFlag=${tagFlag}">沟通记录</a></li>
	</ul>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>班级名称</th>
				<th>课程</th>
				<th>授课老师</th>
				<th>上课时间</th>
				<th>上课时长</th>
				<th>上课教师</th>
				<th>状态</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${classScheduleList}" var="schoolClassSchedule">
			<tr>
				<td>
					${schoolClassSchedule.schoolClass.className}
				</td>
				<td>
					${schoolClassSchedule.schoolClassLesson.lessonName}
				</td>
				<td>
					<%--${schoolClassSchedule.schoolClassLesson.teacher.name}--%>
					<c:forEach items="${schoolClassSchedule.schoolClassLesson.teacherList}" var="teacher">
						${teacher.name}<br>
					</c:forEach>
				</td>
				<td>
					<fmt:formatDate value="${schoolClassSchedule.beginTime}" pattern="yyyy-MM-dd HH:mm"/> ~~
					<fmt:formatDate value="${schoolClassSchedule.endTime}" pattern="HH:mm EE"/>
				</td>
				<td>
					<fmt:formatNumber value="${(schoolClassSchedule.endTime.getTime()-schoolClassSchedule.beginTime.getTime())/1000/60}" pattern="#0"/>分钟
				</td>
				<td>
					${schoolClassSchedule.schoolClassroom.classroomName}
				</td>

				<td>
					${erp:lessonsStatusName(schoolClassSchedule.status)}
				</td>
		</c:forEach>
		</tbody>
	</table>
</body>
</html>
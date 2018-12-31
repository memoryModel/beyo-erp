<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>班级管理</title>
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
		<li ><a href="${ctx}/school/student/info?id=${student.id}&&tagFlag=${tagFlag}">基本信息</a></li>
		<li><a href="${ctx}/school/student/enrollInfo?id=${student.id}&&tagFlag=${tagFlag}">招生信息</a></li>
		<li  class="active"><a href="${ctx}/school/student/classInfo?id=${student.id}&&tagFlag=${tagFlag}">报读班级</a></li>
		<li><a href="${ctx}/school/student/scheduleInfo?id=${student.id}&&tagFlag=${tagFlag}">课表信息</a></li>
		<li><a href="${ctx}/school/student/signInfo?id=${student.id}&&tagFlag=${tagFlag}">上课记录</a></li>
		<li><a href="${ctx}/school/student/communicateInfo?id=${student.id}&&tagFlag=${tagFlag}">沟通记录</a></li>
	</ul>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>

				<th>报名日期</th>
				<th>班级名称</th>
				<th>课程</th>
				<th>学费</th>
				<th>班主任</th>
				<th>计划开班日期</th>
				<th>实际开班日期</th>
				<th>状态</th>

		</thead>
		<tbody>
		<c:forEach items="${classList}" var="schoolClass">
			<tr>
				<td>
					<fmt:formatDate value="${schoolClass.erpStudentEnroll.schoolClassStudents.applyTime}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					${schoolClass.className}
				</td>
				<td>
					${schoolClass.schoolClassToLesson.schoolClassLesson.lessonName}
				</td>
				<td>
					${schoolClass.tuitionAmount}
				</td>
				<td>
					${schoolClass.headteacher.name}
				</td>

				<td>
					<fmt:formatDate value="${schoolClass.planBeginTime}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					<fmt:formatDate value="${schoolClass.realBeginTime}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					${erp:classStatusName(schoolClass.status)}${erp:classPlanStatusName(schoolClass.status)}
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</body>
</html>
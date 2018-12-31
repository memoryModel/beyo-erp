<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
<html>
<body>
<script type="text/javascript">
    $(document).ready(function() {

    });



    function selectAllLesson(lessonId,lessonName,teacherId,teacherName){
		parent.window.frames["mainFrame"].selectAllLessonCallback(lessonId,lessonName,teacherId,teacherName);
		top.$.jBox.close(true);
    }
</script>
<table id="scheduleTable" class="table table-striped table-bordered table-condensed">
</table>


<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
	<thead>
	<tr>
		<th>课程名称</th>
		<th>授课老师</th>
		<th>年份</th>
		<th>期段</th>
		<th>类型</th>
		<%--<th>科目</th>--%>
		<th>创建时间</th>
		<%--<th>状态</th>--%>
		<td>操作</td>
	</tr>
	</thead>
	<tbody>
	<c:forEach items="${classLessonList}" var="schoolClassLesson">
		<tr>
			<td>
					${schoolClassLesson.lessonName}
			</td>
			<td>
				<input type="hidden" value="${schoolClassLesson.teacherIds}">
					${schoolClassLesson.teacherNames}
			</td>
			<td>
				<fmt:formatDate value="${schoolClassLesson.createTime}" pattern="yyyy"/>
			</td>
			<td>
				<fmt:formatDate value="${schoolClassLesson.createTime}" pattern="MMMM"/>
			</td>
			<td>
					${schoolClassLesson.commonsType.commonsName}
			</td>
				<%--<td>
                        ${schoolClassLesson.schoolSubject.subjectName}
                </td>--%>
			<td>
				<fmt:formatDate value="${schoolClassLesson.createTime}" pattern="yyyy-MM-dd"/>
			</td>
				<%--<td>
                        ${erp:commonsStatusName(schoolClassLesson.status)}
                </td>--%>
			<td>
				<input type="button" id="button${schoolClassLesson.id}" value="选择" class="btn btn-primary" onclick="selectAllLesson(
						'${schoolClassLesson.id}','${schoolClassLesson.lessonName}',
						'${schoolClassLesson.teacherIds}','${schoolClassLesson.teacherNames}',
						'${schoolClassLesson.commonsType.commonsName}')"/>
			</td>
		</tr>
	</c:forEach>
	</tbody>
</table>
</body>
</html>
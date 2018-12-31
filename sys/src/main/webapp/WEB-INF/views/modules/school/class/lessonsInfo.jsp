<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>学员信息</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
        var tagFlag = 0;
        if(${not empty tagFlag}) tagFlag = ${tagFlag}; //标签页标记 0:显示标签页 1.隐藏标签页
		$(document).ready(function() {
			//$("#asProCategoryButton").addClass("disabled");
			//$("#userButton").addClass("disabled");
			
		});
		function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			$("#searchForm").submit();
	    	return false;
	    }
	</script>
</head>
<body>
	<c:if test="${tagFlag != 1}">
		<div>
			<ul class="nav nav-tabs">
				<li><a href="${ctx}/school/class/list">班级列表</a></li>
				<li class="active"><a href="${ctx}/school/class/info?id=${classSchedule.schoolClass.id}">班级详情</a></li>
			</ul>
		</div><br/>
	</c:if>
	<div>
		<ul class="nav nav-tabs">
			<li><a href="${ctx}/school/class/info?id=${classSchedule.schoolClass.id}&&tagFlag=${tagFlag}">基本信息</a></li>
			<li><a href="${ctx}/school/class/studentInfo?id=${classSchedule.schoolClass.id}&&tagFlag=${tagFlag}">学员信息</a></li>
			<li class="active"><a href="${ctx}/school/class/lessonInfo?id=${classSchedule.schoolClass.id}&&tagFlag=${tagFlag}">上课信息</a></li>
			<li><a href="${ctx}/school/class/classInstall?id=${classSchedule.schoolClass.id}&&tagFlag=${tagFlag}">班级设置</a></li>
		</ul>
	</div><br/>

	<form:form id="searchForm" modelAttribute="classSchedule" action="${ctx}/school/class/lessonInfo" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<form:input type="hidden" path="schoolClass.id" htmlEscape="false" maxlength="20" class="input-medium"/>
			<li><label>授课老师：</label>
				<form:input path="teacher.name" placeholder="请选择授课老师" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>授课时间：</label>
					<input id="startTime" readonly="readonly" type="text" class="input-medium Wdate " onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
					—<input  id="endTime" readonly="readonly" type="text" class="input-medium Wdate " onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
		<tr>
			<th>课程</th>
			<th>日期</th>
			<th>星期</th>
			<th>上课时间</th>
			<th>授课老师</th>
			<th>教室</th>
			<th>状态</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="schoolClassSchedule">
			<tr>
				<td>
						${schoolClassSchedule.schoolClassLesson.lessonName}
				</td>
				<td>
						<fmt:formatDate value="${schoolClassSchedule.beginTime}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
						<fmt:formatDate value="${schoolClassSchedule.beginTime}" pattern="E"/>
				</td>
				<td>
						<fmt:formatDate value="${schoolClassSchedule.beginTime}" pattern="HH:mm"/>~
						<fmt:formatDate value="${schoolClassSchedule.endTime}" pattern="HH:mm"/>
				</td>
				<td>
						${schoolClassSchedule.teacher.name}
				</td>
				<td>
						${schoolClassSchedule.schoolClassroom.classroomName}
				</td>
				<td>
						${erp:lessonsStatusName(schoolClassSchedule.status)}
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>

</body>
</html>
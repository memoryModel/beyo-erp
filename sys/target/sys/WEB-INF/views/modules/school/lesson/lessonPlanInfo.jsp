<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>授课计划</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
        $(document).ready(function() {
            //$("#asProCategoryButton").addClass("disabled");
            //$("#userButton").addClass("disabled");

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
	<ul class="nav nav-tabs">
		<li><shiro:hasPermission name="school:lesson:list"><a href="${ctx}/school/lesson/list">课程列表</a></shiro:hasPermission></li>
		<li class="active"><shiro:hasPermission name="school:lesson:info"><a href="${ctx}/school/lesson/info?id=${schoolClassLesson.id}">课程详情</a></shiro:hasPermission></li>
	</ul></div><br/><div>
	<ul class="nav nav-tabs">
		<li><shiro:hasPermission name="school:lesson:info"><a href="${ctx}/school/lesson/info?id=${schoolClassLessonPlans.schoolClassLesson.id}">基本信息</a></shiro:hasPermission></li>
		<li class="active"><shiro:hasPermission name="school:lesson:lessonPlanInfo"><a href="${ctx}/school/lesson/lessonPlanInfo?lessonId=${schoolClassLessonPlans.schoolClassLesson.id}">授课计划</a></shiro:hasPermission></li>
	</ul></div><br/>

	<form:form id="searchForm" modelAttribute="class" action="${ctx}/lesson/schoolClassLesson/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
		<tr>
			<th>课程名称</th>
			<th>课程节数名称</th>
			<th>授课内容</th>
			<%--<th>状态</th>--%>
			<th>操作</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="schoolClassLessonPlans">
			<tr>
				<td><a href="${ctx}/school/lessonPlans/form?id=${schoolClassLessonPlans.id}">
						${schoolClassLessonPlans.schoolClassLesson.lessonName}
				</a></td>
				<td>
						${schoolClassLessonPlans.lessonSectionName}
				</td>
				<td>
						${schoolClassLessonPlans.lessonSectionContent}
				</td>
				<%--<td>
						${fns:getDictLabel(schoolClassLessonPlans.status, 'sys_status', '')}
				</td>--%>
				<td>
					<shiro:hasPermission name="school:lessonPlans:form"><a href="${ctx}/school/lessonPlans/form?id=${schoolClassLessonPlans.id}">修改</a></shiro:hasPermission>
					<shiro:hasPermission name="school:lessonPlans:delete"><a href="${ctx}/school/lessonPlans/delete?id=${schoolClassLessonPlans.id}" onclick="return confirmx('确认要删除该授课计划吗？', this.href)">删除</a></shiro:hasPermission>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>

</body>
</html>
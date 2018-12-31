<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>授课计划管理</title>
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
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/school/lesson/list">课程列表</a></li>
		<li class="active"><a href="${ctx}/school/lessonPlans/list?lessonId=${classLessonPlans.schoolClassLesson.id}">授课计划</a></li>
	</ul></div><br/><div>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/school/lessonPlans/list?lessonId=${classLessonPlans.schoolClassLesson.id}">授课计划列表</a></li>
		<shiro:hasPermission name="school:lessonPlans:form">
			<li><a href="${ctx}/school/lessonPlans/form?lessonId=${classLessonPlans.schoolClassLesson.id}">授课计划添加</a></li>
		</shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="classLessonPlans" action="${ctx}/school/lessonPlans/list" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<form:hidden path="schoolClassLesson.id" value="${classLessonPlans.schoolClassLesson.id}" htmlEscape="false" maxlength="20" class="input-xlarge required"/>
			<%--<input name="schoolClassLesson.id" type="text" value="${classLessonPlans.schoolClassLesson.id}"/>--%>
			<li><label>创建时间：</label>
				<input name="createTimeStart" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>-
				<input name="createTimeEnd" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>
			</li>
			
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>课程名称</th>
				<th>课程节数名称</th>
				<th>授课内容</th>
				<%--<th>创建时间</th>--%>
				<%--<th>状态</th>--%>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="schoolClassLessonPlans">
			<tr>
				<td><a href="${ctx}/school/lessonPlans/info?id=${schoolClassLessonPlans.id}">
						${schoolClassLessonPlans.schoolClassLesson.lessonName}
				</a></td>
				<td>
						${schoolClassLessonPlans.lessonSectionName}
				</td>
				<td>
						${schoolClassLessonPlans.lessonSectionContent}
				</td>
				<%--<td>
						<fmt:formatDate value="${schoolClassLessonPlans.createTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>--%>
				<%--<td>
						${erp:commonsStatusName(schoolClassLessonPlans.status)}
				</td>--%>

				<td>
					<shiro:hasPermission name="school:lessonPlans:form"><a href="${ctx}/school/lessonPlans/form?lessonId=${schoolClassLessonPlans.schoolClassLesson.id}&&id=${schoolClassLessonPlans.id}">修改</a></shiro:hasPermission>
					<shiro:hasPermission name="school:lessonPlans:delete"><a href="${ctx}/school/lessonPlans/delete?id=${schoolClassLessonPlans.id}" onclick="return confirmx('确认要删除该授课计划吗？', this.href)">删除</a></shiro:hasPermission>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
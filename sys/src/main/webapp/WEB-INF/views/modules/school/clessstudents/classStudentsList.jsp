<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>新增班级中间表管理</title>
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
		<li class="active"><a href="${ctx}/schoolclessstudents/schoolClassStudents/">新增班级中间表列表</a></li>
		<shiro:hasPermission name="schoolclessstudents:schoolClassStudents:edit"><li><a href="${ctx}/schoolclessstudents/schoolClassStudents/form">新增班级中间表添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="classStudents" action="${ctx}/schoolclessstudents/schoolClassStudents/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>id</th>
				<th>班级ID</th>
				<th>学员ID</th>
				<shiro:hasPermission name="schoolclessstudents:schoolClassStudents:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="schoolClassStudents">
			<tr>
				<td><a href="${ctx}/schoolclessstudents/schoolClassStudents/form?id=${schoolClassStudents.id}">
					${schoolClassStudents.id}
				</a></td>
				<td>
					${schoolClassStudents.classId}
				</td>
				<td>
					${schoolClassStudents.studentId}
				</td>
				<shiro:hasPermission name="schoolclessstudents:schoolClassStudents:edit"><td>
    				<a href="${ctx}/schoolclessstudents/schoolClassStudents/form?id=${schoolClassStudents.id}">修改</a>
					<a href="${ctx}/schoolclessstudents/schoolClassStudents/delete?id=${schoolClassStudents.id}" onclick="return confirmx('确认要删除该新增班级中间表吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
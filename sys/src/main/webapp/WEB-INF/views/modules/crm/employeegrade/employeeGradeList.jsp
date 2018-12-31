<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>升降级管理管理</title>
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
		<li class="active"><a href="${ctx}/crm/employeeGradeManager/">升降级管理列表</a></li>
		<shiro:hasPermission name="crm:employeeLevel:edit"><li><a href="${ctx}/crm/employeeGradeManager/form">升降级管理添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="employeeGrade" action="${ctx}/crm/employeeGradeManager/" method="post" class="breadcrumb form-search">
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
				<th>员工id</th>
				<th>待升级基础服务技能</th>
				<th>定级生效时间</th>
				<th>提交状态</th>
				<th>升级操作时间</th>
				<th>升级操作人</th>
				<shiro:hasPermission name="crm:employeeGrade:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="employeeGrade">
			<tr>
				<td><a href="${ctx}/crm/employeeGradeManager/form?id=${employeeGrade.id}">
					${employeeGrade.employeeId}
				</a></td>
				<td>
					${employeeGrade.type}
				</td>
				<td>
					<fmt:formatDate value="${employeeGrade.entryTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${employeeGrade.status}
				</td>
				<td>
					<fmt:formatDate value="${employeeGrade.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${employeeGrade.createUser}
				</td>
				<shiro:hasPermission name="crm:employeeGrade:edit"><td>
    				<a href="${ctx}/crm/employeeGradeManager/form?id=${employeeGrade.id}">修改</a>
					<a href="${ctx}/crm/employeeGradeManager/delete?id=${employeeGrade.id}" onclick="return confirmx('确认要删除该升降级管理吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
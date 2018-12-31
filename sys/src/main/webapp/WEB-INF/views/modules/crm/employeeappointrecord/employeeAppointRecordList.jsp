<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>招工沟通管理指派记录表管理</title>
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
		<li class="active"><a href="${ctx}/employeeappointrecord/employeeAppointRecord/">招工沟通管理指派记录表列表</a></li>
		<shiro:hasPermission name="employeeappointrecord:employeeAppointRecord:edit"><li><a href="${ctx}/employeeappointrecord/employeeAppointRecord/form">招工沟通管理指派记录表添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="employeeAppointRecord" action="${ctx}/employeeappointrecord/employeeAppointRecord/" method="post" class="breadcrumb form-search">
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
				<shiro:hasPermission name="employeeappointrecord:employeeAppointRecord:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="employeeAppointRecord">
			<tr>
				<shiro:hasPermission name="employeeappointrecord:employeeAppointRecord:edit"><td>
    				<a href="${ctx}/employeeappointrecord/employeeAppointRecord/form?id=${employeeAppointRecord.id}">修改</a>
					<a href="${ctx}/employeeappointrecord/employeeAppointRecord/delete?id=${employeeAppointRecord.id}" onclick="return confirmx('确认要删除该招工沟通管理指派记录表吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
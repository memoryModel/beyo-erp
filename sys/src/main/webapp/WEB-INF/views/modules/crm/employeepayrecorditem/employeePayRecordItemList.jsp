<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>其他项目增减项管理</title>
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
		<li class="active"><a href="${ctx}/crm/employeePayRecordItem/">其他项目增减项列表</a></li>
		<shiro:hasPermission name="crm:employeepayrecorditem:employeePayRecordItem:edit"><li><a href="${ctx}/crm/employeePayRecordItem/form">其他项目增减项添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="employeePayRecordItem" action="${ctx}/crm/employeePayRecordItem/" method="post" class="breadcrumb form-search">
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
				<th>项目名称</th>
				<shiro:hasPermission name="crm:employeepayrecorditem:employeePayRecordItem:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="employeePayRecordItem">
			<tr>
				<td><a href="${ctx}/crm/employeePayRecordItem/form?id=${employeePayRecordItem.id}">
					${employeePayRecordItem.name}
				</a></td>
				<shiro:hasPermission name="crm:employeepayrecorditem:employeePayRecordItem:edit"><td>
    				<a href="${ctx}/crm/employeePayRecordItem/form?id=${employeePayRecordItem.id}">修改</a>
					<a href="${ctx}/crm/employeePayRecordItem/delete?id=${employeePayRecordItem.id}" onclick="return confirmx('确认要删除该其他项目增减项吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
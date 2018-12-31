<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>考核权重管理</title>
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
		<li class="active"><a href="${ctx}/crm/weight/list">考核权重列表</a></li>
		<shiro:hasPermission name="crm:weight:form"><li><a href="${ctx}/crm/weight/form">考核权重添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="crmWeight" action="${ctx}/crm/weight/list" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>

	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>考核指标</th>
				<th>描述</th>
				<th>比例</th>
				<th>状态</th>
				<th>创建时间</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="crmWeight">
			<tr>
				<td>
						${crmWeight.checkName}
				</td>
				<td>
					${crmWeight.remark}
				</td>
				<td>
					${crmWeight.percentage}%
				</td>
				<td>
						${erp:commonsStatusName(crmWeight.status)}
				</td>
				<td>
					<fmt:formatDate value="${crmWeight.createTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
					<shiro:hasPermission name="crm:weight:form"><a href="${ctx}/crm/weight/form?id=${crmWeight.id}">修改</a></shiro:hasPermission>
					<shiro:hasPermission name="crm:weight:delete"><a href="${ctx}/crm/weight/delete?id=${crmWeight.id}" onclick="return confirmx('确认要删除该考核权重吗？', this.href)">删除</a></shiro:hasPermission>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
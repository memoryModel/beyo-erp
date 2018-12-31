<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>员工签约管理</title>
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
		<li class="active"><a href="${ctx}/erp/employeeInfo/">员工签约列表</a></li>
		<shiro:hasPermission name="erp:employeeInfo:form"><li><a href="${ctx}/erp/employeeInfo/form">员工签约添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="employeeInfo" action="${ctx}/erp/employeeInfo/" method="post" class="breadcrumb form-search">
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
				<th>名称</th>
				<th>类型</th>
				<th>图片</th>
				<th>状态</th>
				<th>创建时间</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="employeeInfo">
			<tr>
				<td><a href="${ctx}/erp/employeeInfo/form?id=${employeeInfo.id}">
					${employeeInfo.name}
				</a></td>
				<td>
					${erp:employeeInfoTypeName(employeeInfo.type)}
				</td>
				<td>
					<img src='${employeeInfo.url}@100w_100h'/>
				</td>
				<td>
					${erp:commonsStatusName(employeeInfo.status)}
				</td>
				<td>
					<fmt:formatDate value="${employeeInfo.createTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
					<shiro:hasPermission name="erp:employeeInfo:form"><a href="${ctx}/erp/employeeInfo/form?id=${employeeInfo.id}">修改</a></shiro:hasPermission>
					<shiro:hasPermission name="erp:employeeInfo:delete"><a href="${ctx}/erp/employeeInfo/delete?id=${employeeInfo.id}" onclick="return confirmx('确认要删除该员工签约吗？', this.href)">删除</a></shiro:hasPermission>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
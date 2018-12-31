<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>待委派客户管理</title>
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
		<li class="active"><a href="${ctx}/crm/customerDelegateRecord/">待委派客户列表</a></li>
		<shiro:hasPermission name="crm:customerDelegateRecord:edit"><li><a href="${ctx}/crm/customerDelegateRecord/form">待委派客户添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="crmCustomerDelegateRecord" action="${ctx}/crm/customerDelegateRecord/" method="post" class="breadcrumb form-search">
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
				<shiro:hasPermission name="customerdelegate:crmCustomerDelegateRecord:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="crmCustomerDelegateRecord">
			<tr>
				<shiro:hasPermission name="crm:customerDelegateRecord:edit"><td>
    				<a href="${ctx}/crm/customerDelegateRecord/form?id=${crmCustomerDelegateRecord.id}">修改</a>
					<a href="${ctx}/crm/customerDelegateRecord/delete?id=${crmCustomerDelegateRecord.id}" onclick="return confirmx('确认要删除该待委派客户吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
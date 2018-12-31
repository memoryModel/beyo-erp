<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>收入明细</title>
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
		<li class="active"><a href="${ctx}/erp/IncomeAffirm/">应收账单列表</a></li>
		<shiro:hasPermission name="finance/erpfinanceReceivable:edit"><li><a href="${ctx}/erp/IncomeAffirm/form">应收账单添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="financeReceivable" action="${ctx}/erp/IncomeAffirm/" method="post" class="breadcrumb form-search">
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
				<th>订单编号</th>
				<th>客户名称</th>
				<th>业务归属部门</th>
				<th>业务归属人</th>
				<th>收入类别</th>
				<th>收入科目</th>
				<th>收入金额</th>
				<th>收入确认人</th>
				<th>收入确认时间</th>
				<shiro:hasPermission name="finance:erpfinanceReceivable:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="financeReceivable">
			<tr>
				<td><a href="${ctx}/finance/erpfinanceReceivable/form?id=${financeReceivable.id}">
					${financeReceivable.orderId}
				</a></td>
				<td>
					${financeReceivable.orderType}
				</td>
				<td>
					${financeReceivable.shouldIncomeAmount}
				</td>
				<td>
					${financeReceivable.practicalIncomeAmount}
				</td>
				<td>
					${financeReceivable.incomeTypeId}
				</td>
				<td>
					${financeReceivable.chargeId}
				</td>
				<td>
					<fmt:formatDate value="${financeReceivable.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${financeReceivable.createUser}
				</td>
				<td>
					${financeReceivable.gatheringStatus}
				</td>
				<td>
					${financeReceivable.status}
				</td>
				<shiro:hasPermission name="finance/erpfinanceReceivable:edit"><td>
    				<a href="${ctx}/finance/erpfinanceReceivable/form?id=${financeReceivable.id}">修改</a>
					<a href="${ctx}/finance/erpfinanceReceivable/delete?id=${financeReceivable.id}" onclick="return confirmx('确认要删除该应收账单吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
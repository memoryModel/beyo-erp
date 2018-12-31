<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>应收账单管理</title>
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
				<th>订单类别</th>
				<th>合同编号</th>
				<th>业务归属部门</th>
				<th>招聘老师</th>
				<th>应收金额</th>
				<th>收款金额</th>
				<th>支出金额</th>
				<th>合计收入金额</th>
				<th>下单时间</th>
				<th>结单时间</th>
				<shiro:hasPermission name="finance:erpfinanceReceivable:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="financeReceivable">
			<tr>
				<td>
					${financeReceivable.erpStudentEnroll.financialNumbers}<%--财务编号/订单编号--%>
				</td>
				<td>
					${financeReceivable.orderType}<%--订单类别--%>
				</td>
				<td>
					${financeReceivable.erpOrder.contractNumber}<%--合同编号--%>
				</td>
				<td>
					${financeReceivable.practicalIncomeAmount}<%--业务归属部门--%>
				</td>
				<td>
					${financeReceivable.incomeTypeId}<%--招聘老师--%>
				</td>
				<td>
					${financeReceivable.chargeId}<%--应收金额--%>
				</td>
				<td>
					<fmt:formatDate value="${financeReceivable.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/><%--收款金额--%>
				</td>
				<td>
					${financeReceivable.createUser}<%--支出金额--%>
				</td>
				<td>
					${financeReceivable.gatheringStatus}<%--合计收入金额--%>
				</td>
				<td>
					<fmt:formatDate value="${financeReceivable.erpOrder.orderTime}" pattern="yyyy-MM-dd HH:mm:ss"/><%--下单时间--%>
				</td>
				<td>
					<fmt:formatDate value="${financeReceivable.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/><%--结单时间--%>
				</td>
				<shiro:hasPermission name="finance:erpfinanceReceivable:edit"><td>
					<a href="${ctx}/erp/IncomeAffirm/form?id=${financeReceivable.id}">处理</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
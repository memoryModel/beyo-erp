<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>单表管理</title>
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
		<li class="active"><a href="${ctx}/erp/order/">单表列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="erpOrder" action="${ctx}/erp/order/" method="post" class="breadcrumb form-search">

	</form:form>
	<sys:message content="${erpOrder}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>交费日期</th>
				<th>交费类型</th>
				<th>缴费金额</th>
				<th>收款方式</th>
				<th>经办人</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><fmt:formatDate value="${erpOrder.createTime}" pattern="yyyy-MM-dd"/></td>
				<td>${erpOrder.erpPaymentRecord.feeType}</td>
				<td>${erpOrder.erpPaymentRecord.feeMoneyAmount}</td>
				<td>${erpOrder.erpPaymentRecord.paymentTerm}</td>
				<td>${erpOrder.erpPaymentRecord.operator}</td>
			</tr>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
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
		<li class="active"><a href="${ctx}/erp/ErpInvoice/">单表列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="erpInvoice" action="${ctx}/erp/ErpInvoice/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>学号</th>
				<th>姓名</th>
				<th>性别</th>
				<th>手机号</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>${erpInvoice.erpStudentEnroll.studentNumber}</td>
				<td>${erpInvoice.erpStudentEnroll.name}</td>
				<td>${fns:getDictLabel(erpInvoice.erpStudentEnroll.sex, 'sex', '')}</td>
				<td>${erpInvoice.erpStudentEnroll.phone}</td>
			</tr>
		</tbody>
	</table>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
		<tr>
			<th>对应订单</th>
			<th>发票类型</th>
			<th>发票抬头</th>
			<th>发票金额</th>
			<th>发票内容</th>
			<th>收款单位</th>
		</tr>
		</thead>
		<tbody>
		<tr>
			<td>${erpInvoice.correspondingNumber}</td>
			<td>${erpInvoice.invoiceType}</td>
			<td>${erpInvoice.invoiceTitle}</td>
			<td>${erpInvoice.invoiceAmountId}</td>
			<td>${erpInvoice.invoiceContent}</td>
			<td>${fns:getDictLabel(erpInvoice.collectionUnit, 'collection_unit', '')}</td>

		</tr>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
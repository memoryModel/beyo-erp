<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>欠费管理</title>
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
	<li class="active"><a href="${ctx}/erp/arrears/list">欠费列表</a></li>
</ul>
<ul class="nav nav-tabs">
	<li ><a href="${ctx}/erp/arrears/info?id=${receivableBill.id}">基本信息</a></li>
	<li><a href="${ctx}/erp/arrears/serviceInfo?id=${receivableBill.id}&&orderType=${receivableBill.order.orderType}">服务信息</a></li>
	<li  ><a href="${ctx}/erp/arrears/receivableAmountInfo?orderId=${receivableBill.order.id}">收款信息</a></li>
	<li class="active"><a href="${ctx}/erp/arrears/expendAmountInfo?id=${receivableBill.id}&&orderId=${receivableBill.order.id}">支出信息</a></li>
</ul><br/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>支出单号</th>
				<th>支出类别</th>
				<th>支出科目</th>
				<th>支出金额</th>
				<th>支出人</th>
				<th>支出确认人</th>
				<th>支出确认时间</th>
				<th>付款人</th>
				<th>付款时间</th>
				<th>付款方式</th>
				<th>备注</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${erpOrderList}" var="erpOrder">
			<tr>
				<td>
					${erpOrder.spendingBills.expenNumber}
				</td>
				<td>
					${erpOrder.spendingBills.spendingCategory}
				</td>
				<td>
					${erpOrder.spendingBills.finaceTypeId}
				</td>
				<td>
					${erpOrder.spendingBills.alreadyInsuranceAmount}
				</td>
				<td>
						${erpOrder.spendingBills.expendId}
				</td>
				<td>
						${erpOrder.spendingBills.expendConfirmId}
				</td>
				<td>
					<fmt:formatDate value="${erpOrder.spendingBills.confirmTime}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					${erpOrder.spendingBills.paymentId}
				</td>
				<td>
					<fmt:formatDate value="${erpOrder.spendingBills.paymentTime}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					${erpOrder.spendingBills.paymentType}
				</td>
				<td>
						${erpOrder.spendingBills.remark}
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</body>
</html>
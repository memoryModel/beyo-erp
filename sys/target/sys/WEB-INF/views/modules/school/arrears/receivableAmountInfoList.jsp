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
	<li ><a href="${ctx}/erp/arrears/info?orderId=${receivableBill.order.id}&&id=${erpReceivableBill.id}">基本信息</a></li>
	<li><a href="${ctx}/erp/arrears/serviceInfo?id=${erpReceivableBill.id}&&orderType=${paymentBill.order.orderType}&&orderId=${erpReceivableBill.order.id}">订单信息</a></li>
	<li class="active"><a href="${ctx}/erp/arrears/receivableAmountInfo?id=${erpReceivableBill.id}&&orderId=${paymentBill.order.id}">收款信息</a></li>
	<%--<li><a href="${ctx}/erp/arrears/expendAmountInfo?id=${erpReceivableBill.id}&&orderId=${paymentBill.order.id}">支出信息</a></li>--%>
</ul><br/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
		<tr>
			<th>收款单号</th>
			<th>收款类别</th>
			<th>收款科目</th>
			<th>收款金额</th>
			<th>收款方式</th>
			<th>收款人</th>
			<th>收款时间</th>
			<th>收款确认人</th>
			<th>确认时间</th>
			<th>收款状态</th>
			<th>账单状态</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="erpPaymentBill">
			<tr>
				<td>
						${erpPaymentBill.billsCode}
				</td>
				<td>
						${erp:getCommonsTypeName(erpPaymentBill.erpPaymentBillRecord.payType)}
				</td>
				<td>
						${erpPaymentBill.erpPaymentBillRecord.erpFinaceType.subjectName}
				</td>
				<td>
						${erpPaymentBill.erpPaymentBillRecord.amount}
				</td>
				<td>
						${erp:getCommonsTypeName(erpPaymentBill.typeId)}
				</td>
				<td>
						${erpPaymentBill.collectionEmployee.name}
				</td>
				<td>
					<fmt:formatDate value="${erpPaymentBill.createTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
						${erpPaymentBill.confirmEmployee.name}
				</td>
				<td>
					<fmt:formatDate value="${erpPaymentBill.confirmTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
						${erp:billStatusName(erpPaymentBill.status)}
				</td>
				<td>
						${erp:receivableBillName(erpPaymentBill.receivableBill.status)}
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
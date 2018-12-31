<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>商品订单管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
        $(document).ready(function() {
        });
	</script>
</head>
<body>
		<c:if test="${tagFlag == 0}">
			<ul class="nav nav-tabs">
				<li  class="active"><a href="${ctx}/erp/allOrder/list">全部订单列表</a></li>
			</ul><br/>
			<ul class="nav nav-tabs">
				<li><a href="${ctx}/erp/allOrder/form?id=${order.id}&&studentId=${order.student.id}&&tagFlag=${tagFlag}">订单信息</a></li>
				<li><a href="${ctx}/erp/allOrder/customerInfo?id=${order.id}&&studentId=${order.student.id}&&tagFlag=${tagFlag}">
					<c:if test="${order.orderType == 1}">
						学生信息
					</c:if>
					<c:if test="${order.orderType == 2}">
						客户信息
					</c:if>
				</a></li>
				<li><a href="${ctx}/erp/allOrder/contractInfo?id=${order.id}&&studentId=${order.student.id}&&tagFlag=${tagFlag}">合同信息</a></li>
				<li  class="active"><a href="${ctx}/erp/allOrder/receivableBillsInfo?id=${order.id}&&studentId=${order.student.id}&&tagFlag=${tagFlag}">结算信息</a></li>
					<%--<li><a href="${ctx}/erp/allOrder/form?orderId=${order.id}">服务信息</a></li>--%>
			</ul>
		</c:if>
		<c:if test="${tagFlag == 1}">
			<ul class="nav nav-tabs">
				<li><a href="${ctx}/erp/allOrder/contractInfo?id=${order.id}&&tagFlag=${tagFlag}">合同信息</a></li>
				<li  class="active"><a href="${ctx}/erp/allOrder/receivableBillsInfo?id=${order.id}&&tagFlag=${tagFlag}">财务信息</a></li>
			</ul><br/>
		</c:if>

	<form:form id="inputForm" modelAttribute="order" action="${ctx}/erp/allOrder/receivableBillsInfo" method="post" class="form-horizontal">
		<strong>支付信息</strong>
		<table>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label" >订单总金额:</label>
						<div class="controls">
							<form:input path="overallAmount" id="overallAmount" value="${order.overallAmount}"  class=" digits valid" readonly="true" style="width: 150px;"/>&nbsp;元
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label" >已结算金额:</label>
						<div class="controls">
							<form:input path="receivableBill.deliveredAmount"  value="${order.receivableBill.deliveredAmount}" class="required money valid" readonly="true" />&nbsp;元
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">未结算金额:</label>
						<div class="controls">
							<form:input path="" value="${order.overallAmount - order.receivableBill.deliveredAmount}" class="required money valid" readonly="true" />&nbsp;元
						</div>
					</div>
				</td>
			</tr>
		</table>
	<table class="table table-striped table-bordered table-condensed">
		<thead>
		<tr>
			<th></th>
			<th>实收金额</th>
			<th>实际收款日</th>
			<th>收款单号</th>
			<th>收款人</th>
			<th>收款状态</th>
			<th>支付方式</th>
			<th>创建时间</th>
			<th>创建人</th>
		</tr>
		</thead>
		<tbody>
			<c:forEach items="${paymentBillList}" var="erpPaymentBill" varStatus="times">
				<c:if test="${erpPaymentBill.id != null }">
					<tr>
						<td>
							第${times.index+1}期
						</td>
						<td>
								${erpPaymentBill.erpPaymentBillRecord.amount}
						</td>
						<td>
							<fmt:formatDate value="${erpPaymentBill.createTime}" pattern="yyyy-MM-dd HH:mm"/>
						</td>
						<td>
								${erpPaymentBill.billsCode}
						</td>
						<td>
								${erpPaymentBill.collectionEmployee.name}
						</td>
						<td>
								${erp:billStatusName(erpPaymentBill.status)}
						</td>

						<td>
								${erp:getCommonsTypeName(erpPaymentBill.erpPaymentBillRecord.payType)}
						</td>
						<td>
							<fmt:formatDate value="${erpPaymentBill.createTime}" pattern="yyyy-MM-dd HH:mm"/>
						</td>
						<td>
								${erpPaymentBill.user.name}
						</td>
					</tr>
				</c:if>
			</c:forEach>
		</tbody>
	</table>
		<strong>发票信息</strong>
		<table>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label" >发票总金额:</label>
						<div class="controls">
							<form:input path="invoice.amount"  value="${order.invoice.amount}" class="required money valid" readonly="true" />&nbsp;元
						</div>
					</div>
				</td>
			</tr>
		</table>
		<table class="table table-striped table-bordered table-condensed">
			<thead>
			<tr>
				<th>申请日期</th>
				<th>发票总金额</th>
				<th>发票抬头</th>
				<th>发票类型</th>
				<th>发票内容</th>
				<th>开票单位</th>
				<th>开票状态</th>
				<th>审核日期</th>
			</tr>
			</thead>
			<tbody>
			<c:forEach items="${invoiceList}" var="invoice">
				<tr>
					<td>
						<fmt:formatDate value="${invoice.createTime}" pattern="yyyy-MM-dd"/><%--申请时间--%>
					</td>
					<td>
							${invoice.amount}<%--金额--%>
					</td>
					<td>
							${invoice.title}<%--发票抬头--%>
					</td>
					<td>
							${erp:getCommonsTypeName(invoice.typeId)}<%--发票类型--%>
					</td>
					<td>
							${erp:getCommonsTypeName(invoice.subjectId)}<%--收款内容--%>
					</td>
					<td>
							${erp:getCommonsTypeName(invoice.payeeId)}<%--收款单位--%>
					</td>
					<td>
							${erp:InvoiceStatusName(invoice.status)}
					</td>
					<td>
						<fmt:formatDate value="${invoice.invoiceTime}" pattern="yyyy-MM-dd"/><%--开票时间--%>
					</td>

				</tr>
			</c:forEach>
			</tbody>
		</table>
	</form:form>




</body>
</html>
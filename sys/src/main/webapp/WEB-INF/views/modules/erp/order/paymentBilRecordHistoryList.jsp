<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>历史交费记录</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
	</script>
</head>
<body>
	
	<form:form id="inputForm" class="form-horizontal">

	<div>
		<table id="billListTable" class="table table-striped table-bordered table-condensed">
			<thead>
				<th>交费日期</th>
				<th>交费类型</th>
				<th>交费金额</th>
				<th>收款方式</th>
				<th>经办人</th>

			</thead>
			<tbody>
			<c:forEach items="${paymentBillRecordList}" var="paymentBillRecord">
				<tr>
					<td>
						<fmt:formatDate value="${paymentBillRecord.createTime}" pattern="yyyy-MM-dd HH:mm"/>
					</td>
					<td>
							${erp:getCommonsTypeName(paymentBillRecord.payType)}
					</td>
					<td>
							${paymentBillRecord.amount}
					</td>
					<td>
                            ${erp:getCommonsTypeName(paymentBillRecord.erpPaymentBill.typeId)}
					</td>
					<td>
							${paymentBillRecord.user.name}
					</td>

				</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>
		
	</form:form>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>订单详情</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#asProCategoryButton").addClass("disabled");
			//$("#userButton").addClass("disabled");
			
		});
		function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			$("#searchForm").attr("action","${ctx}/pro/schoolClass/info");
			$("#searchForm").submit();
	    	return false;
	    }
	</script>
</head>
<body>
	
	<form:form id="inputForm" modelAttribute="receivableBill" class="form-horizontal">

	<div>
		<table id="billListTable" class="table table-striped table-bordered table-condensed">
			<thead>
				<th>收款时间</th>
				<th>收入科目</th>
				<th>收款金额(元)</th>
				<th>收款方式</th>
				<th>收款确认人</th>

			</thead>
			<tbody>
			<c:forEach items="${page.list}" var="erpPaymentBill">
				<tr>
					<td>
						<fmt:formatDate value="${erpPaymentBill.createTime}" pattern="yyyy-MM-dd HH:mm"/>
					</td>
					<td>
							${erpPaymentBill.erpPaymentBillRecord.erpFinaceType.subjectName}
					</td>
					<td>
							${erpPaymentBill.erpPaymentBillRecord.amount}
					</td>
					<td>
							${erpPaymentBill.typeId}
					</td>
					<td>
							${erpPaymentBill.confirmEmployee.name}
					</td>

				</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>
		
	</form:form>
</body>
</html>
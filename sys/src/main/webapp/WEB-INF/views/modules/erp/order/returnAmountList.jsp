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
		<%--<shiro:hasPermission name="order:erpOrder:edit"><li><a href="${ctx}/erp/order/form">单表添加</a></li></shiro:hasPermission>--%>
	</ul>
	<form:form id="searchForm" modelAttribute="erpOrder" action="${ctx}/erp/order/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	</form:form>
	<sys:message content="${message}"/>
	<font>学员信息</font>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>学号</th>
				<th>姓名</th>
				<th>性别姓名</th>
				<th>手机号码</th>
				<th>财务编号</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>${erpOrder.student.studentNumber}</td>
				<td>${erpOrder.student.name}</td>
				<td>${fns:getDictLabel(erpOrder.student.sex, 'sex', '')}</td>
				<td>${erpOrder.student.phone}</td>
				<td>${erpOrder.student.financialNumbers}</td>
			</tr>
		</tbody>
	</table>
	<font>班级信息</font>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
		<tr>
			<th>班级名称</th>
			<th>课程</th>
			<th>班主任</th>
			<th>学费</th>
			<th>付款类型</th>
			<th>学费优惠</th>
			<th>开班日期</th>
			<th>报名日期</th>
		</tr>
		</thead>
		<tbody>
		<tr>
			<td>${erpOrder.student.schoolClass.className}</td>
			<td>${erpOrder.student.schoolClassLesson.lessonName}</td>
			<td>${erpOrder.employee.name}</td>
			<td>${erpOrder.schoolClass.tuitionAmount}</td>
			<td>${fns:getDictLabel(erpOrder.student.paymentType, 'pay_type', '')}</td>
			<td>${erpOrder.student.tuitionFavorable}</td>
			<td><fmt:formatDate value="${erpOrder.schoolClass.realBeginTime}" pattern="yyyy-MM-dd"/></td>
			<td><fmt:formatDate value="${erpOrder.student.applyTime}" pattern="yyyy-MM-dd"/></td>
		</tr>
		</tbody>
	</table>
	<font>退费信息</font>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
		<tr>
			<th>学费应退金额</th>
			<th>扣款金额</th>
			<%--<th>学费实退金额</th>--%>
			<th>学杂费应退金额</th>
			<th>扣款金额</th>
			<%--<th>学杂费实退金额</th>--%>
			<th>保证金应退金额</th>
			<th>扣款金额</th>
			<%--<th>保证金实退金额</th>--%>
			<th>手续费扣款</th>
			<th>刷卡费扣款</th>
		</tr>
		</thead>
		<tbody>
		<tr>
			<td>${erpOrder.orderRefund.tuitionAmount}</td>
			<td>${erpOrder.orderRefund.tuitionRefundAmount}</td>
			<td>${erpOrder.orderRefund.feesAmount}</td>
			<td>${erpOrder.orderRefund.feesRefundAmount}</td>
			<td>${erpOrder.orderRefund.bondAmount}</td>
			<td>${erpOrder.orderRefund.bondRefundAmount}</td>
			<td>${erpOrder.orderRefund.counterFeeAmount}</td>
			<td>${erpOrder.orderRefund.cardAmountAmount}</td>
		</tr>
		</tbody>
	</table>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
		<tr>
			<th>开户人</th>
			<th>开户银行</th>
			<th>银行卡号</th>
		</tr>
		</thead>
		<tbody>
		<tr>
			<td>${erpOrder.orderRefund.accountName}</td>
			<td>${erpOrder.orderRefund.accountBank}</td>
			<td>${erpOrder.orderRefund.bankCardNumber}</td>
		</tr>
		</tbody>
	</table>
	<font>退费原因</font>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
		<tr>
			<th>单据是否退还</th>
			<th>退费原因</th>
		</tr>
		</thead>
		<tbody>
		<tr>
			<td>${erpOrder.orderRefund.receipts}</td>
			<td>${erpOrder.orderRefund.refundReson}</td>
		</tr>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
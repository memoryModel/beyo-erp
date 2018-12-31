<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>财务待审核列表</title>
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
	<form:form id="searchForm" modelAttribute="orderRefund" action="${ctx}/erp/orderRefund/financeCreatedList" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li>
				<label>编号</label>
				<input name="financialBillsCode" type="text" placeholder="退款/财务账单/订单编号" class="input-medium" value="${orderRefund.financialBillsCode}">
			</li>
			<li>申请退款时间：
				<input name="createTimeStart" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   value="<fmt:formatDate value="${orderRefund.createTimeStart}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>-
				<input name="createTimeEnd" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   value="<fmt:formatDate value="${orderRefund.createTimeEnd}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>

	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>退费单号</th>
				<th>财务账单编号</th>
				<th>订单编号</th>
				<th>业务类别</th>
				<th>客户名称</th>
				<th>手机号码</th>
				<th>退款类型</th>
				<th>退款金额</th>
				<th>申请退款时间</th>
				<th>业务审核时间</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="orderRefund">
			<tr>
				<td>${orderRefund.financialBillsCode}</td>
				<td><a href="${ctx}/erp/orderRefund/orderRefundDetails?id=${orderRefund.id}">${orderRefund.order.receivableBill.financialCode}</a></td>
				<td>${orderRefund.order.orderCode}</td>
				<td>${erp:getTypeStatusName(orderRefund.type)}</td>
				<td>${orderRefund.order.student.name}</td>
				<td>${orderRefund.order.student.phone}</td>
				<td>${erp:getRefundTypeStatusName(orderRefund.refundType)}</td>
				<td>${orderRefund.grossAmount}</td>
				<td><fmt:formatDate value="${orderRefund.createTime}" pattern="yyyy-MM-dd HH:mm"/></td>
				<td><fmt:formatDate value="${orderRefund.financeCreateTime}" pattern="yyyy-MM-dd HH:mm"/></td>
				<td>
					<shiro:hasPermission name="erp:orderRefund:view">
					<a href="${ctx}/erp/orderRefund/toAudit?readOnly=y&id=${orderRefund.id}">查看</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="erp:orderRefund:toFinanceAudit">
					<a href="${ctx}/erp/orderRefund/toFinanceAudit?id=${orderRefund.id}">退款审核</a>
					</shiro:hasPermission>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
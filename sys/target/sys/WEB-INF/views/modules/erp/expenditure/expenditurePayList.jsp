<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>已支出付款单列表</title>
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
	<form:form id="searchForm" modelAttribute="expenditure" action="${ctx}/expenditure/expenditure/paylist" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li>
				<label>编号</label>
				<input name="expenditureCode" type="text" placeholder="付款/财务账单/订单编号" class="input-medium" value="${expenditure.expenditureCode}">
			</li>
			<li>付款时间：
				<input name="payTimeStart" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   value="<fmt:formatDate value="${expenditure.payTimeStart}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>-
				<input name="payTimeEnd" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   value="<fmt:formatDate value="${expenditure.payTimeEnd}" pattern="yyyy-MM-dd"/>"
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
				<th>付款单号</th>
				<th>财务账单编号</th>
				<th>业务类别</th>
				<th>付款类别</th>
				<th>付款金额</th>
				<th>付款科目</th>
				<th>付款方式</th>
				<th>备注</th>
				<th>付款人</th>
				<th>付款时间</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="expenditure">
			<tr>
				<td>${expenditure.expenditureCode}</td>
				<td>${expenditure.orderRefund.order.receivableBill.financialCode}</td>
				<td>${erp:getTypeStatusName(expenditure.orderRefund.type)}</td>
				<td>${erp:getRefundTypeStatusName(expenditure.orderRefund.refundType)}</td>
				<td>${expenditure.amount}</td>
				<td>${erp:getCommonsTypeName(expenditure.payType)}</td>
				<td>${erp:getCommonsTypeName(expenditure.typeId)}</td>
				<td>${expenditure.remark}</td>
				<td>${expenditure.payUser.name}</td>
				<td><fmt:formatDate value="${expenditure.payTime}" pattern="yyyy-MM-dd HH:mm"/></td>
				<td>
					<shiro:hasPermission name="expenditure:expenditure:view">
						<a href="${ctx}/expenditure/expenditure/toPay?result=y&id=${expenditure.id}">查看</a>
					</shiro:hasPermission>

				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
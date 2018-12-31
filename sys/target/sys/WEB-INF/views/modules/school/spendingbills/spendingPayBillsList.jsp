<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>支出记账管理</title>
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
		<li class="active"><a href="${ctx}/erp/orderRefundPayBill/">支出付款列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="orderRefund" action="${ctx}/erp/orderRefundPayBill/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li>
				<label style="width: auto">业务归属部门：</label>
				<sys:treeselect id="office" name="order.student.teacher.office.id" value="${order.student.teacher.office.id}" labelName="order.student.teacher.office.name" labelValue="${order.student.teacher.office.name}"
								title="机构" url="/sys/office/treeData?type=2" allowClear="true" notAllowSelectParent="true"/>

			</li>
			<li>
				<label>业务归属人：</label>
						<sys:employeeselect id="employee" name="order.student.teacher.id" value="${orderRefund.order.student.teacher.id}" labelName="orderRefund.order.student.teacher.name" labelValue="${orderRefund.order.student.teacher.name}"
											title="用户" url="/erp/employee/officeTreeData?type=3" allowClear="true" notAllowSelectParent="true"/>

			</li>
			<li>
				<label>付款时间：</label>
				<input name="paymentTimeStart" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>-
				<input name="paymentTimeEnd" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			</li>
			<li><label>付款状态：</label>
				<form:select path="paymentStatus" class="input-large ">
					<form:option value="">请选择</form:option>
					<form:options items="${erp:paymentStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
		<tr>
			<th>支出单号</th>
			<th>订单编号</th>
			<th>客户名称</th>
			<th>业务归属部门</th>
			<th>业务归属人</th>
			<th>支出类别</th>
			<th>支出科目</th>
			<th>支出金额</th>
			<th>支出人</th>
			<th>支出确认人</th>
			<th>支出确认时间</th>
			<th>付款人</th>
			<th>付款时间</th>
			<th>付款方式</th>
			<th>付款状态</th>
			<th>操作</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${billPayList}" var="orderRefund">
			<tr>
				<td>
					${orderRefund.financialBillsCode}
				</td>
				<td>
					${orderRefund.order.orderCode}
				</td>
				<td>
					${orderRefund.order.student.name}
				</td>
				<td>
					${orderRefund.order.student.teacher.office.name}
				</td>
				<td>
					${orderRefund.order.student.teacher.name}
				</td>
				<td>
					${fns:getDictLabel(orderRefund.orderRefundBill.refundType, 'bill_pay_type', '')}
				</td>
				<td>
					${orderRefund.orderRefundBill.erpFinaceType.subjectName}
				</td>
				<td>
					${orderRefund.orderRefundBill.refundAmount}
				</td>
				<td>
					${orderRefund.createUser}
				</td>
				<td>
					${orderRefund.expenditureEmployee.name}
				</td>
				<td>
					<fmt:formatDate value="${orderRefund.expenditureTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
					${orderRefund.paymentEmployee.name}
				</td>
				<td>
					<fmt:formatDate value="${orderRefund.paymentTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
					${fns:getDictLabel(orderRefund.paymentType, 'bill_pay', '')}
				</td>
				<td>
					${erp:paymentStatusName(orderRefund.paymentStatus)}
				</td>
				<td>
					<c:if test="${orderRefund.paymentStatus == 	1}">
						<shiro:hasPermission name="erp:orderRefundPayBill:payBill"><a href="${ctx}/erp/orderRefundPayBill/payBill?id=${orderRefund.id}&&orderId=${orderRefund.order.id}">支出付款</a></shiro:hasPermission>
					</c:if>
					<c:if test="${orderRefund.paymentStatus==0}">
						<shiro:hasPermission name="erp:orderRefundBill:spendingInfo"><a href="${ctx}/erp/orderRefundBill/spendingInfo?id=${orderRefund.id}&&orderId=${orderRefund.order.id}">查看</a></shiro:hasPermission>
					</c:if>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</body>
</html>
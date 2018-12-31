<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>应收账单管理</title>
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
	<li class="active"><a href="${ctx}/erp/receivableBill/list">应收账单列表</a></li>
	<%--<shiro:hasPermission name="erpreceivablebill:erpReceivableBill:edit"><li>
		<a href="${ctx}/erp/receivableBill/form">应收账单添加</a>
	</li></shiro:hasPermission>--%>
</ul>
<form:form id="searchForm" modelAttribute="receivableBill" action="${ctx}/erp/receivableBill/list" method="post" class="breadcrumb form-search">
	<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	<ul class="ul-form">
		<li><label>编号：</label>
			<form:input path="order.orderCode" placeholder="请输入财务/订单/合同编号" htmlEscape="false" maxlength="20" style="width:200px;" class="input-medium"/>
		</li>
		<li><label>客户名称：</label>
			<form:input path="order.student.name" placeholder="请输入客户名称" htmlEscape="false" maxlength="20" style="width:200px;" class="input-medium"/>
		</li>
		<li><label>下单时间：</label>
			<input name="order.createTimeStart" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
				   value="<fmt:formatDate value="${receivableBill.order.createTimeStart}" pattern="yyyy-MM-dd"/>"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>-
			<input name="order.createTimeEnd" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
				   value="<fmt:formatDate value="${receivableBill.order.createTimeEnd}" pattern="yyyy-MM-dd"/>"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
		</li>
		<li><label>订单类别：</label>
			<%--<form:input path="order.orderType" htmlEscape="false" maxlength="20" class="input-medium"/>--%>
			<form:select path="order.orderType" class="input-medium">
				<form:option value="" label="------请选择------"/>
				<form:options items="${erp:orderTypeList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
			</form:select>
		</li>
		<li><label>账单状态：</label>
			<form:select path="status" class="input-medium">
				<form:option value="" label="------请选择------"/>
				<form:options items="${erp:receivableBillList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
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
		<th>财务编号</th>
		<th>订单类别</th>
		<th>合同编号</th>
		<th>客户名称</th>
		<th>业务归属部门</th>
		<th>业务归属人</th>
		<th>应收金额</th>
		<th>实收金额</th>
		<th>欠收金额</th>
		<th>下单时间</th>
		<th>收款状态</th>
		<th>操作</th>
	</tr>
	</thead>
	<tbody>
	<c:forEach items="${page.list}" var="erpReceivableBill">
		<tr>
			<td>
					${erpReceivableBill.financialCode}
			</td>
			<td>
					${erp:orderTypeName(erpReceivableBill.order.orderType)}
			</td>
			<td>
					${erpReceivableBill.order.contract.code}
			</td>
			<td>
					${erpReceivableBill.order.student.name}
			</td>

			<td>
					${erpReceivableBill.order.student.teacher.office.name}
					<%--${erpReceivableBill.order.erpStudentEnroll.employee.name}--%>
			</td>
			<td>
					${erpReceivableBill.order.student.teacher.name}
			</td>
			<td>
					${erpReceivableBill.receivableAmount}
			</td>
			<td>
					${erpReceivableBill.deliveredAmount}
			</td>
			<td>
					${erpReceivableBill.receivableAmount-erpReceivableBill.deliveredAmount}
			</td>
			<td>
					<fmt:formatDate value="${erpReceivableBill.order.createTime}" pattern="yyyy-MM-dd HH:mm"/>
			</td>
			<td>
					${erp:receivableBillName(erpReceivableBill.status)}
			</td>
			<td>
				<c:if test="${erpReceivableBill.status ==0}">
					<shiro:hasPermission name="erp:receivableBill:orderRecordInfo"><a href="${ctx}/erp/paymentBill/bill?orderId=${erpReceivableBill.order.id}">收款记账</a></shiro:hasPermission>
				</c:if>
				<shiro:hasPermission name="erp:receivableBill:orderInfo"><a href="${ctx}/erp/receivableBill/orderInfo?id=${erpReceivableBill.id}&&orderId=${erpReceivableBill.order.id}">收款记录</a></shiro:hasPermission>


			</td>
		</tr>
	</c:forEach>
	</tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>
f<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>待确认账单</title>
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
			<shiro:hasPermission name="erpreceivablebill:erpReceivableBill:edit"><li class="active"><a href="${ctx}/erp/incomeNotarize/list?status=1&&status=0">应收账单</a></li></shiro:hasPermission>
			<shiro:hasPermission name="erpreceivablebill:erpReceivableBill:edit"><li><a href="${ctx}/erp/incomeNotarize/listInfo?status=3">已确认账单</a></li></shiro:hasPermission>
			<shiro:hasPermission name="erpreceivablebill:erpReceivableBill:edit"><li><a href="${ctx}/erp/incomeNotarize/listInfoo?status=2">挂起账单</a></li></shiro:hasPermission>
		</ul>
	<form:form id="searchForm" modelAttribute="receivableBill" action="${ctx}/erp/incomeNotarize/list" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input name="billStatus" type="hidden" value="1"/>
		<ul class="ul-form">
			<li><label>订单编号：</label>
				<form:input path="order.orderCode" htmlEscape="false" placeholder="请输入学员姓名/学号/手机号码/财务编号" maxlength="20" class="input-medium"/>
			</li>
			<li><label>订单类型：</label>
				<form:select path="order.orderType" class="input-large ">
					<form:option value="">请选择</form:option>
					<form:options items="${erp:getCommonsTypeList(35)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>下单时间：</label>
				<input name="order.createTimeStart" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   value="<fmt:formatDate value="${receivableBill.order.createTimeStart}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>-
				<input name="order.createTimeEnd" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   value="<fmt:formatDate value="${receivableBill.order.createTimeEnd}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			</li><br/><br/>
			<li><label>结单时间：</label>
				<input name="order.createTimeStart" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   value="<fmt:formatDate value="${receivableBill.order.createTimeStart}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>-
				<input name="order.createTimeEnd" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   value="<fmt:formatDate value="${receivableBill.order.createTimeEnd}" pattern="yyyy-MM-dd"/>"
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
			<th>财务编号/订单编号</th>
			<th>订单类别</th>
			<th>合同编号</th>
			<th>业务归属部门</th>
			<th>业务归属人</th>
			<th>应收金额</th>
			<th>收款金额</th>
			<th>支出金额</th>
			<th>合计收入金额</th>
			<th>下单时间</th>
			<th>结单时间</th>
			<th>账单状态</th>

			<shiro:hasPermission name="erpreceivablebill:erpReceivableBill:edit"><th>操作</th></shiro:hasPermission>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="erpReceivableBill">
			<tr>
				<td>
						${erpReceivableBill.order.orderCode}<%--财务编号--%>
				</td>
				<td>
						${erp:orderTypeName(erpReceivableBill.order.orderType)}<%--订单类别--%>
				</td>
				<td>
						${erpReceivableBill.order.contract.code}<%--合同编号--%>
				</td>
				<td>
						${erpReceivableBill.order.student.teacher.office.name}<%--业务归属部门--%>
				</td>
				<td>
						${erpReceivableBill.order.student.teacher.name}<%--业务归属人--%>
				</td>
				<td>
						${erpReceivableBill.receivableAmount}<%--应收金额--%>
				</td>
				<td>
						${erpReceivableBill.deliveredAmount}<%--收款金额--%>
				</td>
				<td>
						${erpReceivableBill.deliveredAmount}<%--支出金额--%>
				</td>
				<td>
						${erpReceivableBill.receivableAmount}<%--合计收入金额--%>
				</td>
				<td>
						<fmt:formatDate value="${erpReceivableBill.order.createTime}" pattern="yyyy-MM-dd HH:mm"/><%--下单时间--%>
				</td>
				<td>
					<fmt:formatDate value="${erpReceivableBill.order.createTime}" pattern="yyyy-MM-dd HH:mm"/><%--结单时间--%>
				</td>
				<td>
						${erp:receivableBillName(erpReceivableBill.status)}<%--支出金额--%>
				</td>
				<shiro:hasPermission name="erpreceivablebill:erpReceivableBill:edit"><td>
					<a href="${ctx}/erp/incomeNotarize/orderInfo?id=${erpReceivableBill.id}&&orderId=${erpReceivableBill.order.id}">处理</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
		<div class="pagination">${page}</div>
</body>
</html>
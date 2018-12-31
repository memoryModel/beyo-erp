<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>收入明细</title>
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

	<form:form id="searchForm" modelAttribute="receivableBill" action="${ctx}/erp/incomeNotarize/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>收入类别：</label>
				<form:input path="order.orderCode" htmlEscape="false"  maxlength="20" class="input-medium"/>
			</li>
			<li><label>确认时间：</label>
				<input name="order.createTimeStart" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>-
				<input name="order.createTimeEnd" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			</li>

			<li><label>归属部门：</label>
				<form:input path="order.orderCode" htmlEscape="false" placeholder="选择部门" maxlength="20" class="input-medium"/>
			</li>
			<li><label>业务归属人：</label>
				<form:input path="order.orderCode" htmlEscape="false" placeholder="选择附属人" maxlength="20" class="input-medium"/>
			</li>
			<li><label>收入科目：</label>
				<form:input path="order.orderCode" htmlEscape="false" placeholder="选择科目" maxlength="20" class="input-medium"/>
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
			<th>客户名称</th>
			<th>业务归属部门</th>
			<th>业务归属人</th>
			<th>收入类别</th>
			<th>收入科目</th>
			<th>收入金额</th>
			<th>收入确认人</th>
			<th>收入确认时间</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="erpReceivableBill">
			<tr>
				<td>
						${erpReceivableBill.order.orderCode}<%--财务编号/订单编号--%>
				</td>
				<td>
						${erpReceivableBill.order.orderType}<%--客户名称--%>
				</td>
				<td>
						${erpReceivableBill.order.student.teacher.office.name}<%--业务归属部门--%>
				</td>
				<td>
						${erpReceivableBill.order.student.teacher.name}<%--业务归属人--%>
				</td>
				<td>
						${erpReceivableBill.receivableAmount}<%--收入类别--%>
				</td>
				<td>
						${erpReceivableBill.deliveredAmount}<%--收入科目--%>
				</td>
				<td>
						${erpReceivableBill.deliveredAmount}<%--收入金额--%>
				</td>
				<td>
						${erpReceivableBill.receivableAmount}<%--收入确认人--%>
				</td>
				<td>
						<fmt:formatDate value="${erpReceivableBill.order.createTime}" pattern="yyyy-MM-dd HH:mm"/><%--收入确认时间--%>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>收款记账</title>
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
		<li class="active"><a href="${ctx}/erp/paymentBillRecord/list">收款记账列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="paymentBill" action="${ctx}/erp/paymentBillRecord/list" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>客户：</label>
				<form:input path="order.student.name" placeholder="请输入客户名称/学号" htmlEscape="false" maxlength="20" style="width:200px;" class="input-medium"/>
			</li>
			<li><label>编号：</label>
				<form:input path="billsCode" placeholder="请输入收款单/订单/合同编号" htmlEscape="false" maxlength="20" style="width:200px;" class="input-medium"/>
			</li>
			<li><label>收款时间：</label>
				<input name="createTimeStart" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   value="<fmt:formatDate value="${paymentBill.createTimeStart}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>-
				<input name="createTimeEnd" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   value="<fmt:formatDate value="${paymentBill.createTimeEnd}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			</li>
			<li><label>收款类别：</label>
				<form:select path="erpPaymentBillRecord.payType" class="input-medium">
					<form:option value="" label="------请选择------"/>
					<form:options items="${erp:getCommonsTypeList(19)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>收款方式：</label>
				<form:select path="typeId" class="input-medium">
					<form:option value="" label="------请选择------"/>
					<form:options items="${erp:getCommonsTypeList(18)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>收款状态：</label>
				<form:select path="status" class="input-medium">
					<form:option value="" label="------请选择------"/>
					<form:options items="${erp:billStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>账单状态：</label>
				<form:select path="receivableBill.status" class="input-medium">
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
			<th>收款单号</th>
			<th>财务编号/订单编号</th>
			<th>客户名称</th>
			<th>业务归属部门</th>
			<th>业务归属人</th>
			<th>收款类别</th>
			<th>收入科目</th>
			<th>收款金额</th>
			<th>收款方式</th>
			<th>收款人</th>
			<th>收款时间</th>
			<th>收款确认人</th>
			<th>确认时间</th>
			<th>收款状态</th>
			<th>操作</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="erpPaymentBill">
			<tr>
				<td>
						${erpPaymentBill.billsCode}
				</td>
				<td>
						${erpPaymentBill.order.orderCode}
				</td>
				<td>
						<%--${erpPaymentBill.order.student.name != null ?
                                erpPaymentBill.order.erpStudentEnroll.name : erpPaymentBill.order.employee.name}--%>
						${erpPaymentBill.order.student.name}
				</td>

				<td>
						<%--${erpPaymentBill.order.erpStudentEnroll.name != null ?
                                erpPaymentBill.order.erpStudentEnroll.employee.office.name : erpPaymentBill.order.employee.user.office.name}--%>
								${erpPaymentBill.order.student.teacher.office.name}
				</td>
				<td>
						<%--${erpPaymentBill.order.erpStudentEnroll.name != null && erpPaymentBill.order.erpStudentEnroll.name != '' ?
                                erpPaymentBill.order.erpStudentEnroll.employee.name : erpPaymentBill.order.employee.user.name}--%>
						${erpPaymentBill.order.student.teacher.name}
				</td>
				<td>
						${erp:getCommonsTypeName(erpPaymentBill.erpPaymentBillRecord.payType)}
				</td>
				<td>
						${erpPaymentBill.erpPaymentBillRecord.erpFinaceType.subjectName}
				</td>
				<td>
						${erpPaymentBill.erpPaymentBillRecord.amount}
				</td>
				<td>
						${erp:getCommonsTypeName(erpPaymentBill.typeId)}
				</td>
				<td>
						${erpPaymentBill.collectionEmployee.name}
				</td>
				<td>
					<fmt:formatDate value="${erpPaymentBill.createTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
						${erpPaymentBill.confirmEmployee.name}
				</td>
				<td>
					<fmt:formatDate value="${erpPaymentBill.confirmTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
						${erp:billStatusName(erpPaymentBill.status)}
				</td>
				<td>
					<c:if test="${erpPaymentBill.status == 0}">
						<shiro:hasPermission name="erp:paymentBillRecord:form"><a href="${ctx}/erp/paymentBillRecord/form?id=${erpPaymentBill.id}&&billRecordId=${erpPaymentBill.erpPaymentBillRecord.id}&&orderId=${erpPaymentBill.order.id}">修改</a></shiro:hasPermission>
						<shiro:hasPermission name="erp:receivableBill:orderRecordInfo"><a href="${ctx}/erp/receivableBill/orderRecordInfo?billId=${erpPaymentBill.id}&&orderId=${erpPaymentBill.order.id}">收款确认</a></shiro:hasPermission>
					</c:if>
					<c:if test="${erpPaymentBill.status != 0}">
						<shiro:hasPermission name="erp:paymentBillRecord:form"><a href="${ctx}/erp/paymentBillRecord/view?id=${erpPaymentBill.id}&&billRecordId=${erpPaymentBill.erpPaymentBillRecord.id}&&orderId=${erpPaymentBill.order.id}">查看</a></shiro:hasPermission>
					</c:if>
					<%--无收款记录时--%>
					<%--<c:if test="${erpPaymentBill.status == null}">
						<a href="${ctx}/erp/paymentBillRecord/form?id=${erpPaymentBill.id}&&billRecordId=${erpPaymentBill.erpPaymentBillRecord.id}&&orderId=${erpPaymentBill.order.id}">修改</a>
					</c:if>--%>
					<%--<a href="${ctx}/erp/paymentBill/delete?id=${erpPaymentBill.id}" onclick="return confirmx('确认要删除该收款单吗？', this.href)">删除</a>--%>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>收款单管理</title>
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
		<li class="active"><a href="${ctx}/erp/paymentBill/">收款单列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="paymentBill" action="${ctx}/erp/paymentBill/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>客户：</label>
				<form:input path="order.student.name" placeholder="请输入客户名称/学号/编号" htmlEscape="false" maxlength="20" style="width:200px;" class="input-medium"/>
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
			<%--<li><label>收款科目：</label>
				<sys:treeselect id="finaceType" name="finaceType.id"
								value="${erpPaymentBill.erpPaymentBillRecord.erpFinaceType.id}"
								labelName="finaceType.subjectName"
								labelValue="${erpPaymentBill.erpPaymentBillRecord.erpFinaceType.subjectName}"
								title="类型名称" url="${ctx}/finacetype/erpFinaceType/treeData"
								extId="${erpPaymentBill.erpPaymentBillRecord.erpFinaceType.id}" cssClass="" allowClear="true"/>
			</li>--%>
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
				<th>订单编号</th>
				<th>姓名</th>
				<th>编号</th>
				<th>账单编号</th>
				<th>合同编号</th>

				<th>收款金额</th>
				<th>收款方式</th>
				<th>收款类别</th>
				<th>收款科目</th>
				<th>收款人ID</th>
				<th>收款时间</th>
				<th>确认人ID</th>
				<th>确认时间</th>
				<th>收款状态</th>
				<th>账单状态</th>
				<shiro:hasPermission name="erppaymentbill:erpPaymentBill:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="erpPaymentBill">
			<tr>
				<td>
					${erpPaymentBill.order.orderCode}
				</td>
				<td>
					${erpPaymentBill.order.student.name}
				</td>
				<td>
						${erpPaymentBill.order.student.studentNumber }
				</td>
				<td>
					${erpPaymentBill.billsCode}
				</a></td>
				<td>
					${erpPaymentBill.order.contract.code}
				</td>


				<td>
					${erpPaymentBill.totalAmount}
				</td>


				<td>
					${erp:getCommonsTypeName(erpPaymentBill.typeId)}
				</td>
				<td>
					${erp:getCommonsTypeName(erpPaymentBill.erpPaymentBillRecord.payType)}
				</td>
				<td>
					${erpPaymentBill.erpPaymentBillRecord.erpFinaceType.subjectName}
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
					<fmt:formatDate value="${erpPaymentBill.confirmTime}" pattern="yyyy-MM-dd  HH:mm"/>
				</td>
				<td>
					${erp:billStatusName(erpPaymentBill.status)}
				</td>
				<td>
					${erp:receivableBillName(erpPaymentBill.receivableBill.status)}
				</td>
				<shiro:hasPermission name="erppaymentbill:erpPaymentBill:edit"><td>

					<a href="${ctx}/erp/paymentBillRecord/form?id=${erpPaymentBill.id}&&billRecordId=${erpPaymentBill.erpPaymentBillRecord.id}&&orderId=${erpPaymentBill.order.id}">查看</a>
					<%--<c:if test="${erpPaymentBill.status == 0 && erpPaymentBill.receivableBill.billStatus == 0}">
						&lt;%&ndash;<a href="${ctx}/erp/paymentBill/form?id=${erpPaymentBill.id}&&orderId=${erpPaymentBill.order.id}">修改</a>&ndash;%&gt;
						<a href="${ctx}/erp/paymentBill/bill?orderId=${erpPaymentBill.order.id}" onclick="return confirmx('确认订单'+${erpPaymentBill.order.orderCode}, this.href)">添加收费</a>
					</c:if>--%>

					<c:if test="${erpPaymentBill.receivableBill.status == 0 || erpPaymentBill.status == null}">
						<%--<a href="${ctx}/erp/paymentBill/form?id=${erpPaymentBill.id}">查看</a>--%>
						<a href="${ctx}/erp/paymentBill/bill?orderId=${erpPaymentBill.order.id}" onclick="return confirmx('确认订单'+${erpPaymentBill.order.orderCode}, this.href)">添加收费</a>
					</c:if>
					<%--<a href="${ctx}/erp/paymentBill/delete?id=${erpPaymentBill.id}" onclick="return confirmx('确认要删除该收款单吗？', this.href)">删除</a>--%>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
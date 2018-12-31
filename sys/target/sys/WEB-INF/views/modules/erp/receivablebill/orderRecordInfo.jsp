<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>订单详情</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
        $(document).ready(function() {

        });
        function page(n,s){
            if(n) $("#pageNo").val(n);
            if(s) $("#pageSize").val(s);
            <%--$("#searchForm").attr("action","${ctx}/pro/schoolClass/info");--%>
            $("#searchForm").submit();
            return false;
        }

        //确认单条收款记录
        /*function updateBill(billId) {
         $.ajax({
         type : 'post',
         url : '${ctx}/erp/receivableBill/updateBillStatus',
		 data:{orderId:${erpReceivableBill.order.id},billId:billId},
		 success : function(data) {
		 if (data && data.result == "success") {
		 location.href = '${ctx}/school/classPlan/list/';
		 } else {
		 window.location.reload();
		 }
		 }
		 })

		 }


		 //提交from表单  确认全部收款记录
		 function submitSave() {

		 $.ajax({
		 type : 'post',
		 url : '${ctx}/erp/receivableBill/updateBillStatus',
		 data:{orderId:${erpReceivableBill.order.id}},
		 success : function(data) {
		 if (data && data.result == "success") {
		 location.href = '${ctx}/school/classPlan/list/';
		 } else {
		 location.href = '${ctx}/school/classPlan/list/';
		 //                        window.location.reload();
		 }
		 }
		 })

		 }*/

	</script>
</head>
<body>
<div>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/erp/receivableBill/list">应收账单列表</a></li>
		<li class="active">
			<a href="${ctx}/erp/receivableBill/orderRecordInfo?id=${erpReceivableBill.id}&&orderId=${classAmount.id}">收款记账</a>
		</li>
	</ul></div><br/><div>

	<form:form id="inputForm" modelAttribute="receivableBill" action="${ctx}/erp/receivableBill/updateBillStatus?orderId=${classAmount.id}" method="post" class="form-horizontal">
		<form:hidden path="id"/>

	<table id="contentTable" style="width: 78%">
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">归属账单:</label>
					<div class="controls">
						<input value="${classAmount.orderCode}" type="text" readonly="readonly" style="width:250px;"/>
					</div>
				</div>
			</td>
			<td>
				<div class="control-group">
					<label class="control-label">订单类别:</label>
					<div class="controls">
						<input value="${erp:orderTypeName(classAmount.orderType)}" type="text" readonly="readonly" style="width:250px;"/>
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">客户名称:</label>
					<div class="controls">
						<input value="${classAmount.student.name }"
							   type="text" readonly="readonly" style="width:250px;"/>
					</div>
				</div>
			</td>
			<td>
				<div class="control-group">
					<label class="control-label">合同编号:</label>
					<div class="controls">
						<input value="${classAmount.contract.code}" type="text" readonly="readonly" style="width:250px;"/>
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">业务归属部门:</label>
					<div class="controls">
						<input value="${classAmount.student.teacher.office.name}"
							   type="text" readonly="readonly" style="width:250px;"/>
					</div>
				</div>
			</td>
			<td>
				<div class="control-group">
					<label class="control-label">业务归属人:</label>
					<div class="controls">
						<input value="${classAmount.student.teacher.name }"
							   type="text" readonly="readonly" style="width:250px;"/>
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">下单时间:</label>
					<div class="controls">
						<input id="classAmount.createTime" name="classAmount.createTime" style="width:250px;" type="text" readonly="readonly"
							   value="<fmt:formatDate value="${classAmount.createTime}" pattern="yyyy-MM-dd HH:mm"/>"/>
					</div>
				</div>
			</td>
			<td>
				<div class="control-group">
					<label class="control-label">订单状态:</label>
					<div class="controls">
						<input id="status" style="width:250px;" type="text" readonly="readonly"
							   value="${erp:orderStatusName(classAmount.status)}"/>
					</div>
				</div>
			</td>
		</tr>

	</table>



	<strong>收款项目:</strong><br/>
	<table id="billsTable" class="table table-striped table-bordered table-condensed" style="width: 78%;">
		<thead>
		<tr>
			<th>收款类别</th>
			<th>应收金额(元)</th>
			<th>实收金额(元)</th>
			<th>欠收金额(元)</th>
		</tr>
		</thead>
		<tbody>
		<tr>
			<td>预定金</td>
			<td prepaidAmount>${classAmount.schoolClass.prepaidAmount}</td>
			<td></td>
			<td></td>
		</tr>
		<tr>
			<td>学费</td>
			<td>${classAmount.schoolClass.tuitionAmount - classAmount.favorableAmount}</td>
			<td>${not empty tuitionAmount ? tuitionAmount:'0.00'}</td>
			<td tuitionAmount>${classAmount.schoolClass.tuitionAmount - classAmount.favorableAmount - tuitionAmount}</td>
		</tr>
		<tr>
			<td>学杂费</td>
			<td>${classAmount.schoolClass.miscellaneousAmount}</td>
			<td>${not empty miscellaneousAmount ? miscellaneousAmount:'0.00'}</td>
			<td>${classAmount.schoolClass.miscellaneousAmount - miscellaneousAmount}</td>
		</tr>
		<tr>
			<td>合计优惠：${classAmount.favorableAmount}&nbsp;&nbsp;(元)</td>
			<td>合计应收：${classAmount.overallAmount}&nbsp;&nbsp;(元)</td>
			<td>合计实收：${classAmount.paymentAmount}&nbsp;&nbsp;(元)</td>
			<td>合计欠收：${classAmount.overallAmount-classAmount.paymentAmount}&nbsp;&nbsp;(元)</td>
		</tr>
		</tbody>
	</table>

	<strong>收款单:</strong><br/>
	<table id="billListTable" class="table table-striped table-bordered table-condensed" style="width: 78%;">
		<thead>
		<tr>
			<th>收款单号</th>
			<th>收款金额(元)</th>
			<th>收款类别</th>
			<th>收入科目</th>
			<th>收款方式</th>
			<th>收款人</th>
			<th>收款时间</th>
			<th>备注</th>
				<%--<th>状态</th>--%>
				<%--<th>操作</th>--%>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${paymentBillList}" var="erpPaymentBill">
			<tr>
				<td>
						${erpPaymentBill.billsCode}
				</td>
				<td>
						${erpPaymentBill.erpPaymentBillRecord.amount}
				</td>
				<td>
						${erp:getCommonsTypeName(erpPaymentBill.erpPaymentBillRecord.payType)}
				</td>
				<td>
						${erpPaymentBill.erpPaymentBillRecord.erpFinaceType.subjectName}
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
						${erpPaymentBill.remark}
				</td>
					<%--<td>
							${erpPaymentBill.status}
					</td>--%>
					<%--<td>
						<shiro:hasPermission name="erpreceivablebill:erpReceivableBill:edit">
							&lt;%&ndash;<a href="${ctx}/erp/receivableBill/updateBillRecord?billId=${erpPaymentBill.id}&&billRecordId=${erpPaymentBill.erpPaymentBillRecord.id}&&orderId=${erpReceivableBill.order.id}">收款</a>&ndash;%&gt;
							<a href="${ctx}/erp/receivableBill/updateBillStatus?billId=${erpPaymentBill.id}&&orderId=${erpReceivableBill.order.id}">确认收款</a>
						</shiro:hasPermission>
					</td>--%>
			</tr>
		</c:forEach>
		</tbody>
	</table>

	<div class="form-actions">
		<shiro:hasPermission name="erp:receivableBill:updateBillStatus">
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="收款确认"/>&nbsp;
		</shiro:hasPermission>
		<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
	</div>

	</form:form>
</body>
</html>
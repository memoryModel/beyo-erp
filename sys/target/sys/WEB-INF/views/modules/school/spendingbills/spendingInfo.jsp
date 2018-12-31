<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>支出查看</title>
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
		<li class="active">
			<a href="">支出详情</a>
		</li>
	</ul></div><br/><div>

	<form:form id="inputForm" modelAttribute="orderRefund" action="${ctx}/erp/orderRefundPayBill/updatePayBill?billId=${orderRefund.id}&&orderId=${orderRefund.order.id}" method="post" class="form-horizontal">
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
							<input value="${classAmount.student.name }" type="text" readonly="readonly" style="width:250px;"/>
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
							<input value="${classAmount.student.teacher.name}"
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
							<input id="erpReceivableBill.order.createTime" name="erpReceivableBill.order.createTime" style="width:250px;" type="text" readonly="readonly"
								   value="<fmt:formatDate value="${orderRefund.order.createTime}" pattern="yyyy-MM-dd HH:mm"/>"/>
						</div>
					</div>
				</td>
				<td>
					<%--<div class="control-group">
						<label class="control-label">订单状态:</label>
						<div class="controls">
							<input id="billStatus" name="billStatus" style="width:250px;" type="text" readonly="readonly"
								   value="${erpReceivableBill.billStatus ==1 ? '已结清':'未结清'}"/>
						</div>
					</div>--%>
				</td>
			</tr>

		</table>



	<strong>收款项目:</strong><br/>
	<table id="billsTable" class="table table-striped table-bordered table-condensed" style="width: 78%">
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
			<td>${classAmount.schoolClass.prepaidAmount}</td>
			<td>${not empty prepaidAmount ? prepaidAmount:'0.00'}</td>
			<td>${classAmount.schoolClass.prepaidAmount - prepaidAmount}</td>
		</tr>
		<tr>
			<td>学费</td>
			<td>${classAmount.schoolClass.tuitionAmount}</td>
			<td>${not empty tuitionAmount ? tuitionAmount:'0.00'}</td>
			<td>${classAmount.schoolClass.tuitionAmount - tuitionAmount}</td>
		</tr>
		<tr>
			<td>学杂费</td>
			<td>${classAmount.schoolClass.miscellaneousAmount}</td>
			<td>${not empty miscellaneousAmount ? miscellaneousAmount:'0.00'}</td>
			<td>${classAmount.schoolClass.miscellaneousAmount - miscellaneousAmount}</td>
		</tr>
		<tr>
			<td>保证金</td>
			<td>${classAmount.schoolClass.depositAmount}</td>
			<td>${not empty depositAmount ? depositAmount:'0.00'}</td>
			<td>${classAmount.schoolClass.depositAmount - depositAmount}</td>
		</tr>
		<tr>
			<td>保险费</td>
			<td>${classAmount.schoolClass.insuranceAmount}</td>
			<td>${not empty insuranceAmount ? insuranceAmount:'0.00'}</td>
			<td>${classAmount.schoolClass.insuranceAmount - insuranceAmount}</td>
		</tr>
		<tr>
			<td>合计优惠：${classAmount.favorableAmount}&nbsp;&nbsp;(元)</td>
			<td>合计应收：${classAmount.paymentAmount}&nbsp;&nbsp;(元)</td>
			<td>合计实收：${classAmount.receivableBill.deliveredAmount}&nbsp;&nbsp;(元)</td>
			<td>合计欠收：${classAmount.paymentAmount-classAmount.receivableBill.deliveredAmount}&nbsp;&nbsp;(元)</td>
		</tr>
		</tbody>
	</table>

	<strong>支出单:</strong><br/>
		<table id="billListTable" class="table table-striped table-bordered table-condensed" style="width: 78%">
			<thead>
			<tr>
				<th>支出单号</th>
				<th>支出金额(元)</th>
				<th>支出类别</th>
				<th>支出科目</th>
				<th>支出人</th>
				<th>支出确认人</th>
				<th>支出确认时间</th>
				<th>付款人</th>
				<th>付款确认时间</th>
				<th>付款方式</th>
				<th>退款时间</th>
				<th>退款原因</th>
				<th>支出状态</th>
			</tr>
			</thead>
			<tbody>
			<c:forEach items="${refunds}" var="orderRefund">
				<tr>
					<td>
						${orderRefund.financialBillsCode}
					</td>
					<td>
						${orderRefund.orderRefundBill.refundAmount}
					</td>
					<td>

					</td>
					<td>
						${orderRefund.orderRefundBill.erpFinaceType.subjectName}
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
						${orderRefund.paymentType}
					</td>
					<td>
						<fmt:formatDate value="${orderRefund.createTime}" pattern="yyyy-MM-dd HH:mm"/>
					</td>
					<td>
						${orderRefund.remark}
					</td>
					<td>
						${erp:expendStatusName(orderRefund.expenditureStatus)}
					</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</form:form>
</body>
</html>
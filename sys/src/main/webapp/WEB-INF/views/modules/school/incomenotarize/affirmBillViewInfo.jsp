<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>已确认账单（查看）</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
        $(document).ready(function() {
            //$("#asProCategoryButton").addClass("disabled");
            //$("#userButton").addClass("disabled");

        });
        function page(n,s){
            if(n) $("#pageNo").val(n);
            if(s) $("#pageSize").val(s);
            $("#searchForm").attr("action","${ctx}/pro/schoolClass/info");
            $("#searchForm").submit();
            return false;
        }
	</script>
</head>
<body>
<div>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/erp/incomeNotarize/">账单处理</a></li>
	</ul></div><br/><div>

	<form:form id="inputForm" modelAttribute="erpReceivableBill" class="form-horizontal">
		<form:hidden path="id"/>
	<table id="contentTable">
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">归属账单:</label>
					<div class="controls">
						<input value="${erpReceivableBill.order.orderCode}" type="text" readonly="readonly" style="width:250px;"/>
					</div>
				</div>
			</td>
			<td>
				<div class="control-group">
					<label class="control-label">订单类别:</label>
					<div class="controls">
						<input value="${erp:orderTypeName(erpReceivableBill.order.orderType)}" type="text" readonly="readonly" style="width:250px;"/>

					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">客户名称:</label>
					<div class="controls">
						<input value="${erpReceivableBill.order.student.name}" type="text" readonly="readonly" style="width:250px;"/>
					</div>
				</div>
			</td>
			<td>
				<div class="control-group">
					<label class="control-label">合同编号:</label>
					<div class="controls">
						<input value="${erpReceivableBill.order.contract.code}" type="text" readonly="readonly" style="width:250px;"/>
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">业务归属部门:</label>
					<div class="controls">
						<input value="${erpReceivableBill.order.student.teacher.office.name}" type="text" readonly="readonly" style="width:250px;"/>
					</div>
				</div>
			</td>
			<td>
				<div class="control-group">
					<label class="control-label">业务归属人:</label>
					<div class="controls">
						<input value="${erpReceivableBill.order.student.teacher.name}" type="text" readonly="readonly" style="width:250px;"/>
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
							   value="<fmt:formatDate value="${erpReceivableBill.order.createTime}" pattern="yyyy-MM-dd HH:mm"/>"/>
					</div>
				</div>
			</td>
			<td>
				<div class="control-group">
					<label class="control-label">结单时间:</label>
					<div class="controls">
						<input id="erpReceivableBill.order.orderTime" name="erpReceivableBill.order.createTime" style="width:250px;" type="text" readonly="readonly"
							   value="<fmt:formatDate value="${erpReceivableBill.order.createTime}" pattern="yyyy-MM-dd HH:mm"/>"/>
					</div>
				</div>
			</td>
		</tr>
		<tr>
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

	<strong>收款项目:</strong><br/>
		<table id="billListTable" class="table table-striped table-bordered table-condensed" style="width: 78%">
			<thead>
			<tr>
				<th>收款类别</th>
				<th>收入科目</th>
				<th>收款金额(元)</th>
			</tr>
			</thead>
			<tbody>
			<c:forEach items="${page.list}" var="erpPaymentBill">
				<tr>
					<td>
							${erpPaymentBill.erpPaymentBillRecord.payType}
					</td>
					<td>
							${erpPaymentBill.erpPaymentBillRecord.erpFinaceType.subjectName}
					</td>
					<td>
							${erpPaymentBill.erpPaymentBillRecord.amount}
					</td>

				</tr>
			</c:forEach>
			</tbody>
		</table>

		<strong>账单处理:</strong><br/>
		<table id="contentTable" class="table table-striped table-bordered table-condensed" style="width: 78%">
			<thead>
			<tr>
				<th>操作</th>
				<th>经办人</th>
				<th>办理时间</th>
				<th>备注</th>
			</tr>
			</thead>
			<tbody>
			<c:forEach items="${billHistorypage.list}" var="billHistory">
				<tr>
					<td>
							${erp:receivableBillName(billHistory.status)}
					</td>
					<td>
							${billHistory.createUser}
					</td>
					<td>
							${billHistory.lastDate}
					</td>
					<td>
							${billHistory.remark}
					</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</form:form>
</body>
</html>
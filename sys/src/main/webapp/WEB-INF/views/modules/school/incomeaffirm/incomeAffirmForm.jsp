<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>应收账单管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
	</script>
</head>
<body>

<ul class="nav nav-tabs">
	<li class="active"><a href="${ctx}/financearrears/financeReceivable/">账单处理</a></li>
</ul>
<ul class="nav nav-tabs">
	<li><a href="${ctx}/erp/IncomeAffirm/orderInfo?id=${financeReceivable.id}">基本信息</a></li>
	<li><a href="${ctx}/financearrears/financeReceivable/getServiceInfo?id=${financeReceivable.id}&&orderType=${financeReceivable.orderType}">服务信息</a></li>
	<li><a href="${ctx}/financearrears/financeReceivable/getReceivableAmountInfo?id=${financeReceivable.id}">收款信息</a></li>
	<li><a href="${ctx}/financearrears/financeReceivable/getExpendAmountInfo?id=${financeReceivable.id}">支出信息</a></li>
</ul><br/>
<form:form id="inputForm" modelAttribute="financeReceivable" action="${ctx}/erp/IncomeAffirm/save" method="post" class="form-horizontal">
	<form:hidden path="id"/>
	<table>
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">财务编号/订单编号：</label>
					<div class="controls">
						${financeReceivable.erpStudentEnroll.financialNumbers}
					</div>
				</div>
			</td>
			<td>
				<div class="control-group">
					<label class="control-label">订单类别：</label>
					<div class="controls">
						${financeReceivable.orderType}
					</div>
				</div>
			</td>
			<td></td>
		</tr>
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">客户名称：</label>
					<div class="controls">
						${financeReceivable.erpOrder.erpStudentEnroll.name}
					</div>
				</div>
			</td>
			<td>
				<div class="control-group">
					<label class="control-label">合同编号：</label>
					<div class="controls">
						${financeReceivable.erpOrder.contractNumber}
					</div>
				</div>
			</td>
			<td></td>
		</tr>
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">业务归属部门：</label>
					<div class="controls">

					</div>
				</div>
			</td>
			<td>
				<div class="control-group">
					<label class="control-label">业务归属人：</label>
					<div class="controls">
						${financeReceivable.erpOrder.erpStudentEnroll.employee.name}
					</div>
				</div>
			</td>
			<td></td>
		</tr>
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">下单时间：</label>
					<div class="controls">
						<fmt:formatDate value="${financeReceivable.erpOrder.orderTime}" pattern="yyyy-MM-dd"/>
					</div>
				</div>
			</td>
			<td>
				<div class="control-group">
					<label class="control-label">结单时间：</label>
					<div class="controls">
						<fmt:formatDate value="${financeReceivable.erpOrder.orderTime}" pattern="yyyy-MM-dd"/>
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td>
			<div class="control-group">
				<label class="control-label">订单状态：</label>
				<div class="controls">
					${fns:getDictLabel(financeReceivable.erpOrder.status, 'order_status', '')}
				</div>
			</div>
			</td>

		</tr>
	</table>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
		<tr>
			<th>收款类别</th>
			<th>应收金额</th>
			<th>实收金额</th>
			<th>欠收金额</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${financeReceivableList}" var="financeReceivable">
			<tr>
				<td>
						${financeReceivable.erpOrder.orderId}
				</td>
				<td>
						${financeReceivable.orderType}
				</td>
				<td>
						${financeReceivable.schoolClassLesson.shouldTuitionAmount}
				</td>
				<td>
						${financeReceivable.schoolClassLesson.alreadyInsuranceAmount}
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<table>
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">合计应收：</label>
					<div class="controls">
							${financeReceivable.erpStudentEnroll.shouldTuitionAmount}
					</div>
				</div>
			</td>
			<td>
				<div class="control-group">
					<label class="control-label">合计实收：</label>
					<div class="controls">
					</div>
				</div>
			</td>
			<td>
				<div class="control-group">
					<label class="control-label">合计欠收：</label>
					<div class="controls">
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="form-actions">
					<shiro:hasPermission name="erp:employee:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="   账单挂起   "/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input id="btnSubmit" class="btn btn-primary" type="submit" value="   确认收入   "/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</shiro:hasPermission>
					<input id="btnCancel" class="btn" type="button" value="    取  消     " onclick="history.go(-1)"/>
				</div>
			</td>
		</tr>
	</table>
</form:form>
</body>
</html>
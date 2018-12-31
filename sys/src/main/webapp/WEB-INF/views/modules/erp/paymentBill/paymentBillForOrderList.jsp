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
		<li class="active"><a href="${ctx}/erp/paymentBill/list">收款单列表</a></li>
	</ul>
<form:form id="searchForm" modelAttribute="receivableBill" action="${ctx}/erp/paymentBill/list" method="post" class="breadcrumb form-search">
	<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	<ul class="ul-form">
		<li><label>编号：</label>
			<form:input path="order.orderCode" placeholder="请输入订单编号" htmlEscape="false" maxlength="20" style="width:200px;" class="input-medium"/>
		</li>
		<li><label>客户：</label>
			<form:input path="order.student.name" placeholder="请输入客户名称/学号/编号" htmlEscape="false" maxlength="20" style="width:200px;" class="input-medium"/>
		</li>
		<%--<li><label>下单时间：</label>
			<input name="order.createTimeStart" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
				   value="<fmt:formatDate value="${receivableBill.order.createTimeStart}" pattern="yyyy-MM-dd"/>"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>-
			<input name="order.createTimeEnd" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
				   value="<fmt:formatDate value="${receivableBill.order.createTimeEnd}" pattern="yyyy-MM-dd"/>"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
		</li>--%>
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
		<th>姓名</th>
		<th>订单编号</th>
		<th>班级名称</th>
		<th>班主任</th>
		<th>学费应收</th>
		<th>付款类型</th>
		<th>学费实收</th>
		<th>合计欠费</th>
		<th>开班日期</th>
		<th>报名日期</th>
		<th>交费记录</th>
		<th>账单状态</th>
		<th>操作</th>
	</tr>
	</thead>
	<tbody>
	<c:forEach items="${page.list}" var="erpReceivableBill">
		<tr createUser="${erpReceivableBill.createUser}" id="${erpReceivableBill.id}">
			<td>
					${erpReceivableBill.order.student.name}
			</td>
			<td>
					${erpReceivableBill.order.orderCode}
			</td>
			<td>
					${erpReceivableBill.order.classStudents.schoolClass.className}
			</td>
			<td>
					${erpReceivableBill.order.classStudents.schoolClass.headteacher.name}
			</td>
			<td>
					${erpReceivableBill.receivableAmount}
			</td>
			<td>
					${erp:getCommonsTypeName(erpReceivableBill.order.payType)}
			</td>
			<td>
					${erpReceivableBill.deliveredAmount}
			</td>
			<td>
					${erpReceivableBill.receivableAmount - erpReceivableBill.deliveredAmount}
			</td>
			<td>
					<fmt:formatDate value="${erpReceivableBill.order.classStudents.schoolClass.realBeginTime}" pattern="yyyy-MM-dd HH:mm"/>
			</td>
			<td>
					<fmt:formatDate value="${erpReceivableBill.order.classStudents.applyTime}" pattern="yyyy-MM-dd HH:mm"/>
			</td>
			<td>
				<a name="payRecordForm" receivableBillId="${erpReceivableBill.id}" orderId="${erpReceivableBill.order.id}" href="javascript:;">交费记录</a>
			</td>
			<td>
					${erp:receivableBillName(erpReceivableBill.status)}
			</td>
			<td>
				<c:if test="${not empty erpReceivableBill.erpPaymentBill.id}">
					<shiro:hasPermission name="erp:paymentBillRecord:form"><a href="${ctx}/erp/paymentBillRecord/view?id=${erpReceivableBill.erpPaymentBill.id}&&billRecordId=
							${erpReceivableBill.erpPaymentBill.erpPaymentBillRecord.id}&&orderId=${erpReceivableBill.order.id}">查看</a></shiro:hasPermission>
				</c:if>
				<c:if test="${erpReceivableBill.status == 0 || erpReceivableBill.status == null}">
					<shiro:hasPermission name="erp:paymentBill:bill"><a href="${ctx}/erp/paymentBill/bill?orderId=${erpReceivableBill.order.id}" onclick="return confirmx('确认该订单添加收费？', this.href)">添加收费</a></shiro:hasPermission>
				</c:if>
			</td>
		</tr>
	</c:forEach>
	</tbody>
</table>
<div class="pagination">${page}</div>
	<script type="text/javascript">
        $("a[name='payRecordForm']").each(function () {
            var orderId = $(this).attr("orderId");
            var receivableBillId = $(this).attr('receivableBillId');
            $(this).click(function () {
                top.$.jBox("iframe:/erp/paymentRecord/paymentBilRecordHistoryList?receivableBillId="+receivableBillId,{
                    title:"历史交费记录",
                    width:800,
                    height:500,
                    buttons:{}
                });
            });
        });
	</script>
<script src="${ctxStatic}/officeNames/officeNames.js" type="text/javascript"></script>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>全部订单管理</title>
	<meta name="decorator" content="default"/>

</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/erp/allOrder/list">全部订单</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="order" action="/erp/allOrder/list" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input name="status" type="hidden" value="${order.status}"/>
		<ul class="ul-form">
			<li><label>订单类型：</label>
				<form:select path="orderType" class="input-medium">
					<form:option value="" label="------请选择------"/>
					<form:options items="${erp:orderTypeList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>缴费状态：</label>
				<form:select path="feeStatus" class="input-medium">
					<form:option value="" label="------请选择------"/>
					<form:options items="${erp:feeStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>下单时间：</label>
				<input name="createTimeStart" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});" value="<fmt:formatDate value="${order.createTimeStart}" pattern="yyyy-MM-dd "/>"/>-
				<input name="createTimeEnd" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});" value="<fmt:formatDate value="${order.createTimeEnd}" pattern="yyyy-MM-dd"/>"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
			<tr>
				<th>订单编号</th>
				<th>类别</th>
				<th>客户名称</th>
				<th>手机号码</th>
				<th>缴费状态</th>
				<th>下单时间</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="erpOrder">
			<tr>
				<td>
					<a href="${ctx}/erp/allOrder/view?id=${erpOrder.id}&&studentId=${erpOrder.student.id}&&tagFlag=0">${erpOrder.orderCode}</a>
				</td>
				<td>
						${erp:orderTypeName(erpOrder.orderType)}
				</td>
				<td>
						${erpOrder.student != null ? erpOrder.student.name : erpOrder.customer.name}
				</td>
				<td>
						${erpOrder.student != null ? erpOrder.student.phone : erpOrder.customer.phone}
				</td>
				<td>
					<c:if test="${erpOrder.receivableBill.status == 0}">
						${erp:feeStatusName(1)}
					</c:if>
					<c:if test="${erpOrder.receivableBill.status == 1}">
						${erp:feeStatusName(2)}
					</c:if>
				</td>
				<td>
					<fmt:formatDate value="${erpOrder.createTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
						<shiro:hasPermission name="erp:allOrder:form"><a href="${ctx}/erp/allOrder/form?id=${erpOrder.id}&&studentId=${erpOrder.student.id}&&tagFlag=0">查看</a></shiro:hasPermission>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
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
</body>
</html>
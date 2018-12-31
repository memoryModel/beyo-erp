<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>销售跟进管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">

	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/crm/sale/saleInfo?id=${sale.id}&&tagFlag=${tagFlag}">线索信息</a></li>
		<li><a href="${ctx}/crm/saleFollow/view?saleId=${sale.id}&&saleDelegateRecordId=${sale.saleDelegateRecord.id}&&tagFlag=${tagFlag}">跟进记录</a></li>
		<li class="active"><a href="${ctx}/crm/saleFollow/findAllListBySaleId?saleId=${sale.id}&&tagFlag=${tagFlag}">跟进计划</a></li>
		<li><a href="${ctx}/erp/productOrder/saleOrderList?status=1&customerId=${sale.customer.id}">预定订单</a></li>

	</ul>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
		<tr>
			<th>跟进人</th>
			<th>计划跟进日期</th>
			<th>跟进阶段</th>
			<th>跟进结果</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${myList}" var="crmSaleFollow" varStatus="status">
			<tr>
				<td>
						${crmSaleFollow.saleAdviserName}
				</td>

				<td>
						<fmt:formatDate value="${crmSaleFollow.planFollowTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
						${crmSaleFollow.followStage}
				</td>
				<td>
						${erp:getFollowStatusName(crmSaleFollow.followFunction)}
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div>
		<input type="button" class="btn btn-primary" onclick="history.go(-1)" value="返回">
	</div>
</body>
</html>
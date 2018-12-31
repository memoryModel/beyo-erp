<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>委派记录管理</title>
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
		<li><a href="${ctx}/crm/sale/saleInfo?id=${sale.id}&&tagFlag=${tagFlag}">线索信息</a></li>
		<li><a href="${ctx}/crm/saleFollow/saleFollowList?saleId=${sale.id}&&tagFlag=${tagFlag}">跟进记录</a></li>
		<li><a href="${ctx}/erp/productOrder/saleOrderList?status=1&customerId=${sale.customer.id}&&saleId=${sale.id}&&tagFlag=${tagFlag}">预定订单</a></li>
		<li class="active"><a href="${ctx}/crm/saleDelegateRecord/list?saleId=${sale.id}&&tagFlag=${tagFlag}">历史分配</a></li>
	</ul>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
			<thead>
			<tr>
				<th>销售顾问</th>
				<th>委派时间</th>
				<th>委派操作人</th>
				<th>撤回时间</th>
				<th>撤回类型</th>
				<th>撤回原因</th>
				<th>撤回操作人</th>
			</tr>
			</thead>
			<tbody>
			<c:forEach items="${saleDelegateRecordList}" var="saleDelegateRecord">
				<tr>
					<td>
						${saleDelegateRecord.saleAdviserName.name}
					</td>
					<td>
						<fmt:formatDate value="${saleDelegateRecord.delegateTime}" pattern="yyyy-MM-dd HH:mm"/>
					</td>
					<td>
						${saleDelegateRecord.delegtatePersonName.name}
					</td>
					<td>
						<fmt:formatDate value="${saleDelegateRecord.cancelTime}" pattern="yyyy-MM-dd HH:mm"/>
					</td>
					<td>${erp:getCancelTypeName(saleDelegateRecord.cancelType)}</td>
					<td>${saleDelegateRecord.cancelReason}</td>
					<td>${saleDelegateRecord.cancelPersonName}</td>

				</tr>
			</c:forEach>
			</tbody>
	</table>
	<div>
		<input type="button" class="btn btn-primary" onclick="history.go(-1)" value="返回">
	</div>
</body>
</html>
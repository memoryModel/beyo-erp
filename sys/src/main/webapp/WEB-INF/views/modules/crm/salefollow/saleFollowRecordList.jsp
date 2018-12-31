
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>销售线索管理</title>
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
	<li class="active"><a href="${ctx}/crm/saleFollow/saleFollowList?saleId=${sale.id}&&tagFlag=${tagFlag}">跟进记录</a></li>
	<li><a href="${ctx}/erp/productOrder/saleOrderList?status=1&customerId=${sale.customer.id}&&saleId=${sale.id}&&tagFlag=${tagFlag}">预定订单</a></li>
	<li><a href="${ctx}/crm/saleDelegateRecord/list?saleId=${sale.id}&&tagFlag=${tagFlag}">历史分配</a></li>
</ul>

	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
		<tr>
			<th>跟进人</th>
			<th>跟进时间</th>
			<th>销售阶段</th>
			<th>跟进形式</th>
			<th>跟进主题</th>
			<th>跟进结果</th>
			<th>成单几率</th>
		    <th>操作</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${list}" var="crmSaleFollow" varStatus="status">
			<tr>
				<td>
						${crmSaleFollow.saleDelegateRecord.saleAdviserName.name}
				</td>

				<td>
					<fmt:formatDate value="${crmSaleFollow.followTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
						${erp:getCommonsTypeName(crmSaleFollow.followStage)}
				</td>
				<td>
						${erp:getCommonsTypeName(crmSaleFollow.followForm)}
				</td>
				<td>
						${crmSaleFollow.theme}
				</td>
				<td>
						${erp:getCommonsTypeName(crmSaleFollow.customerIntention)}
				</td>
				<td>
						${erp:getCommonsTypeName(crmSaleFollow.orderFormPercentage)}
				</td>
				<td>
					<shiro:hasPermission name="crm:saleFollow:saleFollowRecodeInfo"><a href="${ctx}/crm/saleFollow/recordView?id=${crmSaleFollow.id}&&tagFlag=1">查看</a></shiro:hasPermission>
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
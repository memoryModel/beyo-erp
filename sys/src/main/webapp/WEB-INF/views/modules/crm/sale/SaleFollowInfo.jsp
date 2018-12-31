
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
	<li><a href="${ctx}/crmsale/crmSale/">销售线索列表</a></li>
</ul></div><br/><div>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/crmsale/crmSale/getCrmSaleInfo?id=${crmSale.id}">基本信息</a></li>
		<li class="active"><a href="${ctx}/crmsale/crmSale/getSaleFollowInfo?id=${crmSale.id}">跟进记录详情</a></li>
	</ul></div><br/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
		<tr>
			<th>跟进人</th>
			<th>跟进时间</th>
			<th>跟进次数</th>
			<th>跟进阶段</th>
			<th>跟进形式</th>
			<th>跟进主题</th>
			<th>成单几率</th>
			<shiro:hasPermission name="crmsale:crmSale:edit"><th>操作</th></shiro:hasPermission>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${crmSaleFolloInfoList}" var="crmSale" varStatus="status">
			<tr>
				<td>
						${crmSale.employee.empName}
				</td>

				<td>
					<fmt:formatDate value="${crmSale.saleFollow.followTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					第${status.index+1}次
				</td>
				<td>
						${crmSale.saleFollow.theme}
				</td>
				<td>
						${crmSale.saleFollow.theme}
				</td>
				<td>
						${crmSale.saleFollow.theme}
				</td>
				<td>
						${crmSale.saleFollow.orderFormPercentage}
				</td>
				<shiro:hasPermission name="crmsale:crmSale:edit"><td>
						<a href="${ctx}/crmsale/crmSale/getFollowRecord?id=${crmSale.id}">查看</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>销售线索管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
            $(document).find("a[name='saleForm']").each(function () {

                var id = $(this).attr("id");
                $(this).click(function () {
                    top.$.jBox.open("iframe:/crm/sale/selectDelegate?id="+id,
                        "选择委派人",
                        500,
                        550
                    );
                });
            });
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
        function selectDelegatesCallback(){
            window.location.reload(true);
        }
	</script>
</head>
<body>
<ul class="nav nav-tabs">
		<li><a href="${ctx}/crm/customer/info?id=${customer.id}&&tagFlag=${tagFlag}">基本信息</a></li>
		<li><a href="${ctx}/crm/customer/informationInfo?id=${customer.id}&&tagFlag=${tagFlag}">扩展信息</a></li>
		<li><a href="${ctx}/crm/customer/delegateInfo?id=${customer.id}&&tagFlag=${tagFlag}">委派记录</a></li>
		<li><a href="${ctx}/crm/customer/followInfo?id=${customer.id}&&tagFlag=${tagFlag}">跟进记录</a></li>
		<li class="active"><a href="${ctx}/crm/customer/saleInfo?id=${customer.id}&&tagFlag=${tagFlag}">销售线索</a></li>
		<li><a href="${ctx}/crm/customer/orderInfo?id=${customer.id}&&tagFlag=${tagFlag}">订单信息</a></li>
		<li><a href="${ctx}/crm/customer/contractInfo?id=${customer.id}&&tagFlag=${tagFlag}">合同信息</a></li>
		<li><a href="">服务记录</a></li>
</ul><br/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
		<tr>
			<th>意向业务</th>
			<th>线索来源</th>
			<th>重要程度</th>
			<th>销售顾问</th>
			<th>跟进阶段</th>
			<th>客户意向</th>
			<th>线索负责人</th>
			<th>跟进次数</th>
			<th>创建时间</th>
			<th>操作</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${saleList}" var="crmSale">
			<tr>
				<td>
						${erp:getCommonsTypeName(crmSale.serviceTypeId)}
				</td>
				<td>
						${crmSale.customerResource.customerName}
				</td>
				<td>
						意向门店
				</td>
				<td>
						${crmSale.saleDelegateRecord.saleAdviserName.name}
				</td>
				<td>
						${erp:getFollowStatusName(crmSale.followStatus)}
				</td>
				<td>
						${erp:getCommonsTypeName(crmSale.crmSaleFollow.customerIntention)}
				</td>
				<td>
						${crmSale.saleDelegateRecord.saleAdviserName.name}
				</td>
				<td>
						${crmSale.delegateNumber}
				</td>
				<td>
					<fmt:formatDate value="${crmSale.createTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
						<shiro:hasPermission name="crm:customer:info">
							<a href="${ctx}/crm/sale/saleInfo?id=${crmSale.id}&&tagFlag=1">
							查看
						</shiro:hasPermission>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>

</body>
</html>
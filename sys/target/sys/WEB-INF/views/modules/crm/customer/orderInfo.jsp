<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>商品订单管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<ul class="nav nav-tabs">

			<li><a href="${ctx}/crm/customer/info?id=${customer.id}&&tagFlag=${tagFlag}">基本信息</a></li>
			<li><a href="${ctx}/crm/customer/informationInfo?id=${customer.id}&&tagFlag=${tagFlag}">扩展信息</a></li>
			<li><a href="${ctx}/crm/customer/delegateInfo?id=${customer.id}&&tagFlag=${tagFlag}">委派记录</a></li>
			<li><a href="${ctx}/crm/customer/followInfo?id=${customer.id}&&tagFlag=${tagFlag}">跟进记录</a></li>
			<li><a href="${ctx}/crm/customer/saleInfo?id=${customer.id}&&tagFlag=${tagFlag}">销售线索</a></li>
			<li class="active"><a href="${ctx}/crm/customer/orderInfo?id=${customer.id}&&tagFlag=${tagFlag}">订单信息</a></li>
			<li><a href="${ctx}/crm/customer/contractInfo?id=${customer.id}&&tagFlag=${tagFlag}">合同信息</a></li>
			<li><a href="">服务记录</a></li>

	</ul><br/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
			<tr>
				<th>订单编号</th>
				<th>客户名称</th>
				<th>销售顾问</th>
				<th>签约状态</th>
				<th>订单金额</th>
				<th>优惠金额</th>
				<th>合同金额</th>
				<th>下单时间</th>
				<th>签约时间</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${orderList}" var="erpOrder">
			<tr>
				<td>
					<a name="viewOrder" orderId="${erpOrder.id}" href="javascript:;">${erpOrder.orderCode}</a>
				</td>
				<td>
						${erpOrder.customer.name}
				</td>
				<td>
						${erpOrder.sale.name}
				</td>

				<td>
						${erp:contractSignStatusName(erpOrder.signStatus)}
				</td>
				<td>
							${erpOrder.overallAmount}
				</td>
				<td>
							${erpOrder.favorableAmount}
				</td>
				<td>
						${erpOrder.favorableAmount}
				</td>
				<td>
						<fmt:formatDate value="${erpOrder.createTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
					<fmt:formatDate value="${erpOrder.contract.createTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<script type="text/javascript">
        $(document).ready(function() {
			$(document).find("a[name='viewOrder']").each(function () {
				var orderId = $(this).attr("orderId");
                $(this).click(function () {
                    top.$.jBox("iframe:/erp/productOrder/view?id="+orderId,{
                        title:"查看订单",
                        width:1024,
                        height:768,
                        buttons:{}
                    });
                });
            });
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
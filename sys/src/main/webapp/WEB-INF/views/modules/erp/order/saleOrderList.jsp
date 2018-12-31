<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>商品订单管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>
<c:if test="${tagFlag == 1}">
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/crm/sale/saleInfo?id=${saleId}&&tagFlag=${tagFlag}">线索信息</a></li>
		<li><a href="${ctx}/crm/saleFollow/saleFollowList?saleId=${saleId}&&tagFlag=${tagFlag}">跟进记录</a></li>
		<li class="active"><a href="${ctx}/erp/productOrder/saleOrderList?status=1&customerId=${customerId}&&saleId=${saleId}&&tagFlag=${tagFlag}">预定订单</a></li>
		<li><a href="${ctx}/crm/saleDelegateRecord/list?saleId=${saleId}&&tagFlag=${tagFlag}">历史分配</a></li>
	</ul>
</c:if>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>订单编号</th>
				<th>业务类型</th>
				<th>商品数量</th>
				<th>商品金额</th>
				<th>优惠金额</th>
				<th>应付金额</th>
				<th>订单状态</th>
				<th>下单时间</th>
				<th>销售顾问</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${orderItemList}" var="orderItem">
			<tr>
					<td>
						${orderItem.order.orderCode}
					</td>
					<td>
							${orderItem.parentProduct.productCategory.name}
					</td>
					<td>
							${orderItem.order.num}
					</td>
					<td>
							${orderItem.order.overallAmount}
					</td>
					<td>
							${orderItem.order.favorableAmount}
					</td>
					<td>
							${orderItem.order.paymentAmount}
					</td>
					<td>
							${erp:orderStatusName(orderItem.order.status)}
					</td>
					<td>
						<fmt:formatDate value="${orderItem.order.createTime}" pattern="yyyy-MM-dd HH:mm"/>
					</td>
					<td>
							${orderItem.order.sale.name}
					</td>
					<td>
						<a name="viewOrder" orderId="${orderItem.order.id}" href="javascript:;">${erpOrder.orderCode}查看</a>
					</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div>
		<input type="button" class="btn btn-primary" onclick="history.go(-1)" value="返回">
	</div>
	<div class="pagination">${page}</div>
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
	</script>
</body>
</html>
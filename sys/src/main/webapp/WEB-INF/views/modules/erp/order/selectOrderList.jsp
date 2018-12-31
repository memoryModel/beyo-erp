<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>商品订单管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<form:form id="searchForm" modelAttribute="order" action="/crm/dispatch/selectOrder" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input name="status" type="hidden" value="${order.status}"/>
		<input type="hidden" id="orderId" value="${order.id}">
		<ul class="ul-form">
			<li>
				<label>订单编码：</label>
				<form:input path="orderCode" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li>
				<label>客户姓名：</label>
				<form:input path="customer.name" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li>
				<label>客户手机：</label>
				<form:input path="customer.phone" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<tr>
			<th></th>
			<th>订单编号</th>
			<th>姓名</th>
			<th>手机号码</th>
			<th>商品数量</th>
			<th>订单价格</th>
			<th>订单来源</th>
			<th>下单时间</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="erpOrder">
			<tr>
				<td>
					<input type="radio" name="selectOrderRadio" customerId="${erpOrder.customer.id}" orderId="${erpOrder.id}" orderCode="${erpOrder.orderCode}"/>
				</td>
				<td>
					<a name="viewOrder" orderId="${erpOrder.id}"  href="javascript:;">${erpOrder.orderCode}</a>
				</td>
				<td>
						${erpOrder.customer.name}
				</td>
				<td>
						${erpOrder.customer.phone}
				</td>
				<td>
						${erpOrder.num}
				</td>
				<td>
						${erpOrder.paymentAmount}
				</td>
				<td>
						${erpOrder.customerResource.customerName}
				</td>
				<td>
					<fmt:formatDate value="${erpOrder.createTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
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
            $(document).find("input[name='selectOrderRadio']").each(function () {
                var orderId = $(this).attr("orderId");
                var orderCode = $(this).attr("orderCode");
                var customerId = $(this).attr("customerId");
				var requestOrderId = $("#orderId").val();

                if(orderId == requestOrderId){
                    $(this).attr("checked",true);
				}


                $(this).click(function () {

                    parent.window.frames["mainFrame"].selectOrderCallback(orderId,orderCode,customerId);
                });
            });


            //
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
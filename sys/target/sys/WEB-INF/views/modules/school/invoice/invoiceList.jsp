<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>单表管理</title>
	<meta name="decorator" content="default"/>

</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/erp/invoice/list">发票申请</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="invoice" action="${ctx}/erp/invoice/list" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>编号：</label>
				<form:input path="code" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			</li>
			<li><label>发票类型：</label>
				<form:select path="typeId" style="width: 200px;">
					<form:option value="">请选择</form:option>
					<form:options items="${erp:getCommonsTypeList(38)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>发票内容：</label>
				<form:select path="subjectId" style="width: 200px;">
					<form:option value="">请选择</form:option>
					<form:options items="${erp:getCommonsTypeList(44)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>收款单位：</label>
				<form:select path="payeeId" style="width: 200px;">
					<form:option value="">请选择</form:option>
					<form:options items="${erp:getCommonsTypeList(45)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>申请时间：</label>
				<input name="createTimeStart" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   value="<fmt:formatDate value="${invoice.createTimeStart}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>-
				<input name="createTimeEnd" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   value="<fmt:formatDate value="${invoice.createTimeStart}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>订单编码</th>
				<th>发票类型</th>
				<th>发票金额</th>
				<th>发票抬头</th>
				<th>发票内容</th>
				<th>收款单位</th>
				<th>申请人</th>
				<th>申请时间</th>
				<th>开票时间</th>
				<th>开票状态</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="invoice">
			<tr>
				<td>
					<a name="orderView" orderId="${invoice.order.id}" orderType="${invoice.order.orderType}" href="javascript:;">${invoice.order.orderCode}</a>
				</td>
				<td>
						${erp:getCommonsTypeName(invoice.typeId)}<%--发票类型--%>
				</td>
				<td>
					${invoice.amount}<%--金额--%>
				</td>
				<td>
					${invoice.title}<%--发票抬头--%>
				</td>
				<td>
						${erp:getCommonsTypeName(invoice.subjectId)}<%--收款内容--%>
				</td>
				<td>
						${erp:getCommonsTypeName(invoice.payeeId)}<%--收款单位--%>
				</td>
				<td>
					${invoice.user.name}<%--申请人--%>
				</td>
				<td>
					<fmt:formatDate value="${invoice.createTime}" pattern="yyyy-MM-dd"/><%--申请时间--%>
				</td>
				<td>
					<fmt:formatDate value="${invoice.invoiceTime}" pattern="yyyy-MM-dd"/><%--开票时间--%>
				</td>
				<td>
					${erp:InvoiceStatusName(invoice.status)}
				</td>
				<td>
					<c:if test="${invoice.status == 0}">
						<shiro:hasPermission name="erp:invoice:openInvoive"><a href="${ctx}/erp/invoice/openInvoive?id=${invoice.id}" onclick="return confirmx('确定该订单开票？', this.href)">开票</a></shiro:hasPermission>
					</c:if>
					<%--<a href="${ctx}/erp/invoice/form?id=${invoice.id}">修改</a>--%>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	<script type="text/javascript">
        $(document).ready(function() {
            $(document).find("a[name='orderView']").each(function () {
                var orderId = $(this).attr("orderId");
                var type = $(this).attr("orderType");
                if (type == 2){
                    $(this).click(function () {
                        top.$.jBox.open("iframe:/erp/productOrder/view?id="+orderId,
                            "查看订单",
                            1024,
                            768
                        );
                    });
				}

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
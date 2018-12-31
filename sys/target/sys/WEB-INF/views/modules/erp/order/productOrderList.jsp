<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>商品订单管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<ul class="nav nav-tabs">
		<li <c:if test="${(empty order.status || order.status==1 || order.status==0) && empty order.refundStatus}">class="active"</c:if>><a href="${ctx}/erp/productOrder/list?status=1">未支付</a></li>
		<li <c:if test="${!empty order.status && order.status==2}">class="active"</c:if>><a href="${ctx}/erp/productOrder/list?status=2">已支付</a></li>
		<li <c:if test="${!empty order.status && order.status==5}">class="active"</c:if>><a href="${ctx}/erp/productOrder/list?status=5">已取消</a></li>
		<li <c:if test="${!empty order.refundStatus}">class="active"</c:if>><a href="${ctx}/erp/productOrder/list?refundStatus=0">退款订单</a></li>
		<li><a href="${ctx}/erp/productOrder/form">订单添加</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="order" action="/erp/productOrder/list" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input name="status" type="hidden" value="${order.status}"/>
		<ul class="ul-form">
			<li>
				<label>客户姓名：</label>
				<form:input path="customer.name" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li>
				<label>客户手机：</label>
				<form:input path="customer.phone" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>订单类型：</label>
				<select name="extendOrder.id" class="input-medium">
					<option value="">------请选择------</option>
					<option value="1" <c:if test="${!empty order.extendOrder && order.extendOrder.id == 1}">selected</c:if>>新单</option>
					<option value="2" <c:if test="${!empty order.extendOrder && order.extendOrder.id == 2}">selected</c:if>>续单</option>
				</select>
			</li>
			<li>
				<label>订单来源</label>
				<sys:treeselect id="customerResource" name="customerResource.id" value="${order.customerResource.id}"
								labelName="customerResource.customerName" labelValue="${order.customerResource.customerName}"
								title="来源名称" url="/erp/CustomerResource/treeData" cssClass="required"/>
			</li>
			<c:if test="${!empty order.refundStatus}">
			<li><label>退款状态：</label>
				<form:select path="refundStatus" class="input-medium">
					<form:option value="" label="------请选择------"/>
					<form:options items="${erp:refundStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			</c:if>
			<li class="clearfix"></li>
			<li><label>下单时间：</label>
				<input name="createTimeStart" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});" value="<fmt:formatDate value="${order.createTimeStart}" pattern="yyyy-MM-dd HH:mm"/>"/>-
				<input name="createTimeEnd" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});" value="<fmt:formatDate value="${order.createTimeEnd}" pattern="yyyy-MM-dd HH:mm"/>"/>
			</li>
			<li><label>支付时间：</label>
				<input name="payTimeStart" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});" value="<fmt:formatDate value="${order.payTimeStart}" pattern="yyyy-MM-dd HH:mm"/>"/>-
				<input name="payTimeEnd" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});" value="<fmt:formatDate value="${order.payTimeEnd}" pattern="yyyy-MM-dd HH:mm"/>"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<c:if test="${(empty order.status || order.status==1 || order.status==0 || order.status==5) && empty order.refundStatus}">
			<tr>
				<th>订单编号</th>
				<th>姓名</th>
				<th>手机号码</th>
				<th>商品数量</th>
				<th>总金额</th>
				<th>优惠金额</th>
				<th>应付金额</th>
				<th>订单类型</th>
				<th>订单来源</th>
				<th>下单时间</th>
				<th>销售顾问</th>
				<th>操作</th>
			</tr>
		</c:if>
		<c:if test="${!empty order.status && order.status==2}">
			<tr>
				<th>订单编号</th>
				<th>姓名</th>
				<th>手机号码</th>
				<th>销售顾问</th>
				<th>订单类型</th>
				<th>订单来源</th>
				<th>应付金额</th>
				<th>已结算金额</th>
				<th>是否线下签约</th>
				<th>签约状态</th>
				<th>服务状态</th>
				<th>发票状态</th>
				<th>支付时间</th>
				<th>操作</th>
			</tr>
		</c:if>
		<c:if test="${!empty order.refundStatus}">
			<tr>
				<th>订单编号</th>
				<th>姓名</th>
				<th>手机号码</th>
				<th>销售顾问</th>
				<th>订单类型</th>
				<th>订单来源</th>
				<th>应付金额</th>
				<th>已结算金额</th>
				<th>是否线下签约</th>
				<th>签约状态</th>
				<th>服务状态</th>
				<th>发票状态</th>
				<th>退款状态</th>
				<th>审核失败原因</th>
				<th>退款申请时间</th>
				<th>操作</th>
			</tr>
		</c:if>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="erpOrder">
			<tr>
				<td>
					<a name="viewOrder" orderId="${erpOrder.id}" href="javascript:;">${erpOrder.orderCode}</a>
				</td>
				<td>
						${erpOrder.customer.name}
				</td>
				<td>
						${erpOrder.customer.phone}
				</td>
				<c:if test="${(empty order.status || order.status==1 || order.status==0 || order.status==5) && empty order.refundStatus}">
					<td>
							${erpOrder.num}
					</td>
					<td>
							${erpOrder.overallAmount}
					</td>
					<td>
							${erpOrder.favorableAmount}
					</td>
					<td>
							${erpOrder.paymentAmount}
					</td>
					<td>
						<c:choose>
							<c:when test="${empty erpOrder.extendOrder || empty erpOrder.extendOrde.id}">
								新单
							</c:when>
							<c:otherwise>
								续单
							</c:otherwise>
						</c:choose>

					</td>
					<td>
							${erpOrder.customerResource.customerName}
					</td>
					<td>
						<fmt:formatDate value="${erpOrder.createTime}" pattern="yyyy-MM-dd HH:mm"/>
					</td>
					<td>
							${erpOrder.sale.name}
					</td>
				</c:if>
				<c:if test="${!empty order.status && order.status==2}">
					<td>
							${erpOrder.sale.name}
					</td>
					<td>
						<c:choose>
							<c:when test="${empty erpOrder.extendOrder || empty erpOrder.extendOrde.id}">
								新单
							</c:when>
							<c:otherwise>
								续单
							</c:otherwise>
						</c:choose>

					</td>
					<td>
							${erpOrder.customerResource.customerName}
					</td>
					<td>
							${erpOrder.paymentAmount}
					</td>
					<td>
							${erpOrder.receivableBill.deliveredAmount}
					</td>
					<td>
						<c:if test="${erpOrder.sign == 0}">
							否
						</c:if>
						<c:if test="${erpOrder.sign == 1}">
							是
						</c:if>
					</td>
					<td>
						${erp:contractSignStatusName(erpOrder.signStatus)}
					</td>
					<td>
						服务状态
					</td>
					<td>
						发票状态
					</td>
					<td>
						支付时间
					</td>
				</c:if>
				<c:if test="${!empty order.refundStatus}">
					<td>
							${erpOrder.sale.name}
					</td>
					<td>
						<c:choose>
							<c:when test="${empty erpOrder.extendOrder || empty erpOrder.extendOrde.id}">
								新单
							</c:when>
							<c:otherwise>
								续单
							</c:otherwise>
						</c:choose>

					</td>
					<td>
							${erpOrder.customerResource.customerName}
					</td>
					<td>
							${erpOrder.paymentAmount}
					</td>
					<td>
						${erpOrder.receivableBill.deliveredAmount}
					</td>
					<td>
						<c:if test="${erpOrder.sign == 0}">
							否
						</c:if>
						<c:if test="${erpOrder.sign == 1}">
							是
						</c:if>
					</td>
					<td>
							${erp:contractSignStatusName(erpOrder.signStatus)}
					</td>
					<td>
						服务状态
					</td>
					<td>
						发票状态
					</td>
					<td>
						退款状态
					</td>
					<td>
						审核失败原因
					</td>
					<td>
						退款申请时间
					</td>
				</c:if>
				<td>
					<c:if test="${erpOrder.status == 1}">
						<shiro:hasPermission name="erp:productOrder:form"><a href="${ctx}/erp/productOrder/form?id=${erpOrder.id}">修改</a>&nbsp;&nbsp;</shiro:hasPermission>
						<shiro:hasPermission name="erp:productOrder:pay"><a name="payForm" orderId="${erpOrder.id}" href="javascript:;">支付</a></shiro:hasPermission>
					</c:if>
					<c:if test="${erpOrder.status == 2}">
						<c:choose>
							<c:when test="${empty erpOrder.sale || empty erpOrder.sale.id}">
								<shiro:hasPermission name="erp:productOrder:sale"><a name="saleForm" orderId="${erpOrder.id}" href="javascript:;">委派</a>&nbsp;&nbsp;</shiro:hasPermission>
							</c:when>
							<c:otherwise>
								<shiro:hasPermission name="erp:productOrder:sale"><a name="saleForm" orderId="${erpOrder.id}" href="javascript:;">重新委派</a>&nbsp;&nbsp;</shiro:hasPermission>
							</c:otherwise>
						</c:choose>

						<c:if test="${erpOrder.sign == 1 && (empty erpOrder.signStatus || erpOrder.signStatus==0)}">
							<shiro:hasPermission name="erp:productOrder:contract"><a name="contractForm" orderId="${erpOrder.id}" href="javascript:;">签订合同</a>&nbsp;&nbsp;</shiro:hasPermission>
						</c:if>
						<c:if test="${!empty erpOrder.receivableBill && erpOrder.receivableBill.deliveredAmount>0}">
							<shiro:hasPermission name="erp:productOrder:refund"><a href="${ctx}/erp/productOrder/refund?id=${erpOrder.id}">退款申请</a></shiro:hasPermission>
						</c:if>
						<shiro:hasPermission name="erp:invoice:form"><a name="invoiceForm" orderId="${erpOrder.id}" href="javascript:;">开具发票</a></shiro:hasPermission>
						<shiro:hasPermission name="erp:productOrder:form"><a href="${ctx}/erp/productOrder/form?extendOrder.id=${erpOrder.id}">续单</a>&nbsp;&nbsp;</shiro:hasPermission>
					</c:if>
					<c:if test="${erpOrder.status == 3}">
						<shiro:hasPermission name="erp:productOrder:form"><a href="${ctx}/erp/productOrder/form?extendOrder.id=${erpOrder.id}">续单</a>&nbsp;&nbsp;</shiro:hasPermission>
						<shiro:hasPermission name="erp:productOrder:refund"><a href="${ctx}/erp/productOrder/refund?id=${erpOrder.id}">退款申请</a></shiro:hasPermission>
					</c:if>
					<c:if test="${erpOrder.status == 4}">
						<shiro:hasPermission name="erp:productOrder:invoice"><a href="${ctx}/erp/productOrder/invoice?id=${erpOrder.id}">开具发票</a>&nbsp;&nbsp;</shiro:hasPermission>
						<shiro:hasPermission name="erp:productOrder:form"><a href="${ctx}/erp/productOrder/form?extendOrder.id=${erpOrder.id}">续单</a></shiro:hasPermission>
					</c:if>
					<c:if test="${erpOrder.status <=1 }">
						<shiro:hasPermission name="erp:productOrder:cancel"><a href="${ctx}/erp/productOrder/cancel?id=${erpOrder.id}" onclick="return confirmx('确认取消订单吗？', this.href)">取消订单</a></shiro:hasPermission>
					</c:if>
					<c:if test="${!empty erpOrder.refundStatus && erpOrder.refundStatus == 1 }">
						<shiro:hasPermission name="erp:productOrder:renew"><a href="${ctx}/erp/productOrder/form?extendOrder.id=${erpOrder.id}">退款审核</a></shiro:hasPermission>
					</c:if>
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

            $(document).find("a[name='contractForm']").each(function () {
                var orderId = $(this).attr("orderId");
                $(this).click(function () {
                    top.$.jBox("iframe:/erp/productOrder/contract?id="+orderId,{
                        title:"签订合同",
                        width:500,
                        height:550,
                        buttons:{},
                        closed:function () {
                            document.location.reload();
                        }
                    });
                });
            });

            $(document).find("a[name='saleForm']").each(function () {
                var orderId = $(this).attr("orderId");
                $(this).click(function () {
                    top.$.jBox("iframe:/erp/productOrder/sale?id="+orderId,{
                        title:"指派跟进人",
                        width:500,
                        height:550,
                        buttons:{},
                        closed:function () {
                            document.location.reload();
                        }
                    });
                });
            });

            $(document).find("a[name='payForm']").each(function () {
                var orderId = $(this).attr("orderId");
                $(this).click(function () {
                    top.$.jBox("iframe:/erp/productOrder/pay?id="+orderId,{
                        title:"支付订单",
                        width:500,
                        height:550,
                        buttons:{},
                        closed:function () {
                            document.location.reload();
                        }
                    });
                });
            });

            $(document).find("a[name='invoiceForm']").each(function () {
                var orderId = $(this).attr("orderId");
                $(this).click(function () {
                    top.$.jBox("iframe:/erp/invoice/form?order.id="+orderId,{
                        title:"开具发票",
                        width:500,
                        height:550,
                        buttons:{},
                        closed:function () {
                            document.location.reload();
                        }
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
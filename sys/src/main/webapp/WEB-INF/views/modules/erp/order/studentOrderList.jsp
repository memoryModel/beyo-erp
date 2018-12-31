<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>学校订单</title>
	<meta name="decorator" content="default"/>

</head>
<body>
<ul class="nav nav-tabs">
	<li class="active"><a href="${ctx}/erp/studentOrder/list">学校订单</a></li>
</ul>
<form:form id="searchForm" modelAttribute="order" action="${ctx}/erp/studentOrder/list" method="post" class="breadcrumb form-search">
	<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	<ul class="ul-form">
		<li>
			<label>订单编号：</label>
			<form:input path="orderCode" htmlEscape="false" maxlength="20" class="input-medium"/>
		</li>
		<li>
			<label>学员姓名：</label>
			<form:input path="student.name" htmlEscape="false" maxlength="20" class="input-medium"/>
		</li>
		<li>
			<label>学员手机：</label>
			<form:input path="student.phone" htmlEscape="false" maxlength="20" class="input-medium"/>
		</li>
		<li>
			<label>报读班级：</label>
			<form:input path="schoolClass.className" htmlEscape="false" maxlength="20" class="input-medium"/>
		</li>

		<li class="clearfix"></li>
		<li><label>缴费状态：</label>
			<form:select path="feeStatus" class="input-medium">
				<form:option value="" label="------请选择------"/>
				<form:options items="${erp:receivableBillList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
			</form:select>
		</li>
		<%--<li><label>退款状态：</label>
			<form:select path="refundStatus" class="input-medium">
				<form:option value="" label="------请选择------"/>
				<form:options items="${erp:refundStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
			</form:select>
		</li>
		<li><label>订单状态：</label>
			<form:select path="status" class="input-medium">
				<form:option value="" label="------请选择------"/>
				<form:options items="${erp:schoolOrderStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
			</form:select>
		</li>--%>
		<li><label>付款类型：</label>
			<form:select path="payType" class="input-medium">
				<form:option value="" label="------请选择------"/>
				<form:options items="${erp:getCommonsTypeList(22)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
			</form:select>
		</li>
		<li class="clearfix"></li>
		<li><label>下单时间：</label>
			<input name="createTimeStart" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
				   value="<fmt:formatDate value="${order.createTimeStart}" pattern="yyyy-MM-dd"/>"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>-
			<input name="createTimeEnd" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
				   value="<fmt:formatDate value="${order.createTimeEnd}" pattern="yyyy-MM-dd"/>"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
		</li>
		<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
	</ul>
</form:form>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
	<thead>
	<th>订单编号</th>
	<th>下单时间</th>
	<th>学员姓名</th>
	<th>班级名称</th>
	<th>学费总金额</th>
	<th>优惠金额</th>
	<th>学费应收</th>
	<th>付款类型</th>
	<th>学费实收</th>
	<th>合计欠款</th>
	<th>缴费状态</th>
	<%--<th>退款状态</th>
	<th>发票状态</th>
	<th>订单状态</th>--%>
	<th>操作</th>
	</thead>
	<tbody>
	<c:forEach items="${page.list}" var="erpOrder">
		<tr createUser="${erpOrder.createUser}" id="${erpOrder.id}">
			<!-- 订单编号 -->
			<td>
				<a name="orderView" orderId="${erpOrder.id}" href="javascript:;" >${erpOrder.orderCode}</a>
			</td>
			<!-- 下单时间 -->
			<td>
				<fmt:formatDate value="${erpOrder.createTime}" pattern="yyyy-MM-dd HH:mm"/>
			</td>
			<!-- 学员姓名 -->
			<td>
				<a name="studentView" studentId="${erpOrder.student.id}" href="javascript:;" >${erpOrder.student.name}</a>
			</td>
			<!-- 班级名称 -->
			<td>
				<a name="classForm" classId="${erpOrder.schoolClass.id}" href="javascript:;" >${erpOrder.schoolClass.className}</a>
			</td>
			<!-- 总金额 -->
			<td>
					${erpOrder.overallAmount}
			</td>
			<!-- 优惠金额 -->
			<td>
					${erpOrder.favorableAmount}
			</td>
			<!-- 学费应收 -->
			<td>
					${erpOrder.overallAmount - erpOrder.favorableAmount}
			</td>
			<!-- 付款类型 -->
			<td>
					${erp:getCommonsTypeName(erpOrder.payType)}
			</td>
			<!-- 学费实收 -->
			<td>
					${erpOrder.paymentAmount}
			</td>
				<%--<td>
					  <c:if test="${erpOrder.receivableBill.status == 0}">
						${erp:feeStatusName(1)}
					  </c:if>
					<c:if test="${erpOrder.receivableBill.status == 1}">
						${erp:feeStatusName(2)}
					</c:if>
				</td>--%>
			<!-- 合计欠款 -->
			<td>
					${erpOrder.overallAmount - erpOrder.favorableAmount - erpOrder.paymentAmount}
			</td>
			<!-- 缴费状态 -->
			<td>
					${erp:receivableBillName(erpOrder.receivableBill.status)}
			</td>
			<!-- 退款状态 -->
			<%--<td>refundStatusName
					${erp:(erpOrder.refundStatus)}
			</td>--%>
			<!-- 发票状态 -->
			<%--<td>
					${erp:InvoiceStatusName(erpOrder.invoice.status)}
			</td>--%>
			<!-- 订单状态 -->
			<%--<td>
					${erp:orderStatusName(erpOrder.status)}
			</td>--%>
			<!-- 操作 -->
			<td>
				<c:if test="${erpOrder.status == 4}">
					<a name="invoiceForm" orderId="${erpOrder.id}"  href="javascript:;">开具发票</a>
				</c:if>

				<a name="payRecordForm" orderId="${erpOrder.id}" href="javascript:;">交费记录</a>
				<a href="${ctx}/erp/studentOrder/infos?id=${erpOrder.id}">退费详情</a>
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
            $(this).click(function () {
                top.$.jBox("iframe:/erp/studentOrder/view?id="+orderId,{
                    title:"订单信息",
                    width:600,
                    height:550,
                    buttons:{}
                });
            });
        });

        $(document).find("a[name='studentView']").each(function () {
            var studentId = $(this).attr("studentId");
            $(this).click(function () {
                top.$.jBox("iframe:/school/student/info?id="+studentId,{
                    title:"学生信息",
                    width:1100,
                    height:600,
                    buttons:{}
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
                    buttons:{}
                });
            });
        });

        $(document).find("a[name='classForm']").each(function () {
            var classId = $(this).attr("classId");
            $(this).click(function () {
                top.$.jBox("iframe:/school/class/info?id="+classId+"&&tagFlag="+1,{
                    title:"班级信息",
                    width:1024,
                    height:600,
                    buttons:{}
                });
            });
        });



        $(document).find("a[name='payRecordForm']").each(function () {
            var orderId = $(this).attr("orderId");
            $(this).click(function () {
                top.$.jBox("iframe:/erp/studentOrder/paymentInfo?orderId="+orderId,{
                    title:"历史交费记录",
                    width:800,
                    height:500,
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
<script src="${ctxStatic}/officeNames/officeNames.js" type="text/javascript"></script>
</body>
</html>
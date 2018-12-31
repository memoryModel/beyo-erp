<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>账单详情</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
        $(document).ready(function() {
            var code  = '${orderRefund.receivableBill.financialCode}';
            var childrenCode = code.replace('BYFC','BC')
			$('td[code]').text(childrenCode);
			var result = '${result}';
			if(result == 'y'){
                $('a[operation="orderRefundDetails"]').parent().attr('class','active');
                $('div[orderRefundDetails]').show();
			    $('div[orderRefund],div[paymentBillList],div[expenditure]').hide();
			}
			$('a[operation]').each(function () {
				var operation = $(this).attr('operation');
				$(this).click(function () {
                    if(operation == 'orderRefundDetails'){
                        $('a[operation="orderRefundDetails"]').parent().attr('class','active');
                        $('a[operation="orderRefund"],a[operation="paymentBillList"],a[operation="expenditure"]').parent().removeAttr('class');
                        $('div[orderRefundDetails]').show();
                        $('div[orderRefund],div[paymentBillList],div[expenditure]').hide();
                    }
                    if(operation == 'orderRefund'){
                        $('a[operation="orderRefund"]').parent().attr('class','active');
                        $('a[operation="orderRefundDetails"],a[operation="paymentBillList"],a[operation="expenditure"]').parent().removeAttr('class');
                        $('div[orderRefund]').show();
                        $('div[orderRefundDetails],div[paymentBillList],div[expenditure]').hide();
                    }
                    if(operation == 'paymentBillList'){
                        $('a[operation="paymentBillList"]').parent().attr('class','active');
                        $('a[operation="orderRefundDetails"],a[operation="orderRefund"],a[operation="expenditure"]').parent().removeAttr('class');
                        $('div[paymentBillList]').show();
                        $('div[orderRefundDetails],div[orderRefund],div[expenditure]').hide();
                    }
                    if(operation == 'expenditure'){
                        $('a[operation="expenditure"]').parent().attr('class','active');
                        $('a[operation="orderRefundDetails"],a[operation="orderRefund"],a[operation="paymentBillList"]').parent().removeAttr('class');
                        $('div[expenditure]').show();
                        $('div[orderRefundDetails],div[orderRefund],div[paymentBillList]').hide();
					}
                });
            });
        });

	</script>
</head>
<body>
<ul class="nav nav-tabs">
	<li class=""><a href="javascript:;" operation="orderRefundDetails">总账单</a></li>
	<li class=""><a href="javascript:;" operation="orderRefund">退款账单</a></li>
	<li class=""><a href="javascript:;" operation="paymentBillList">收款记录</a></li>
	<li class=""><a href="javascript:;" operation="expenditure">付款记录</a></li>
</ul>
<div orderRefundDetails>
	<strong>总账单信息:</strong><br/>
	<table class="table table-striped table-bordered table-condensed">
		<thead>
		<tr>
			<th>财务账单编号</th>
			<th>合同编号</th>
			<th>业务类别</th>
			<th>应收总额</th>
			<th>实收总额</th>
			<th>欠款总额</th>
		</tr>
		</thead>
		<tr>
			<td>${orderRefund.receivableBill.financialCode}</td>
			<td>${orderRefund.order.contract.code}</td>
			<td>${erp:getTypeStatusName(orderRefund.type)}</td>
			<td>${orderRefund.receivableBill.receivableAmount}</td>
			<td>${orderRefund.receivableBill.deliveredAmount}</td>
			<td>${orderRefund.receivableBill.receivableAmount - orderRefund.receivableBill.deliveredAmount}</td>
		</tr>
	</table>
	<strong>订单信息:</strong><br/>
	<table class="table table-striped table-bordered table-condensed">
		<thead>
		<tr>
			<th>订单编号</th>
			<th>业务归属人</th>
			<th>业务归属部门</th>
			<th>下单时间</th>
			<th>缴费状态</th>
		</tr>
		</thead>
		<tr>
			<td>${orderRefund.order.orderCode}</td>
			<td>${orderRefund.order.student.teacher.name}</td>
			<td>${orderRefund.order.student.teacher.office.name}</td>
			<td><fmt:formatDate value="${orderRefund.order.createTime}" pattern="yyyy-MM-dd HH:mm"/></td>
			<td>${erp:receivableBillName(orderRefund.receivableBill.status)}</td>
		</tr>
	</table>
	<strong>客户信息:</strong><br/>
	<table class="table table-striped table-bordered table-condensed">
		<thead>
		<tr>
			<th>客户编号</th>
			<th>客户名称</th>
			<th>性别</th>
			<th>手机号码</th>
		</tr>
		</thead>
		<tr>
			<td>${orderRefund.order.student.studentNumber}</td>
			<td>${orderRefund.order.student.name}</td>
			<td>${erp:sexStatusName(orderRefund.order.student.sex)}</td>
			<td>${orderRefund.order.student.phone}</td>
		</tr>
	</table>
	<strong>预览账单:</strong><br/>
	<table class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>账单编号</th>
				<th>订单金额</th>
				<th>折扣优惠</th>
				<th>应收金额</th>
			</tr>
		</thead>
			<tr>
				<td code></td>
				<td>${orderRefund.order.overallAmount}</td>
				<td>${orderRefund.order.favorableAmount}</td>
				<td>${orderRefund.order.overallAmount - orderRefund.order.favorableAmount}</td>
			</tr>
	</table>
</div>
<div orderRefund>
	<strong>退款账单:</strong><br/>
	<table class="table table-striped table-bordered table-condensed">
		<thead>
		<tr>
			<th>退款单号</th>
			<th>业务类别</th>
			<th>退款类别</th>
			<th>应退金额</th>
			<th>扣款金额</th>
			<th>退款金额</th>
			<th>退款状态</th>
		</tr>
		</thead>
		<tr>
			<td>${orderRefund.financialBillsCode}</td>
			<td>${erp:getTypeStatusName(orderRefund.type)}</td>
			<td>${erp:getRefundTypeStatusName(orderRefund.refundType)}</td>
			<td>${orderRefund.tuitionWithholdAmount + orderRefund.miscellaneousWithholdAmount + orderRefund.grossAmount}</td>
			<td>${orderRefund.tuitionWithholdAmount + orderRefund.miscellaneousWithholdAmount}</td>
			<td>${orderRefund.grossAmount}</td>
			<td>${erp:refundStatusName(orderRefund.status)}</td>
		</tr>
	</table>
</div>

<div paymentBillList>
	<strong>收款记录:</strong><br/>
	<table class="table table-striped table-bordered table-condensed">
		<thead>
		<tr>
			<th>收款单号</th>
			<th>业务类别</th>
			<th>收款类别</th>
			<th>收款科目</th>
			<th>收款金额</th>
			<th>收款方式</th>
			<th>备注</th>
			<th>收款人</th>
			<th>收款时间</th>
			<th>收款状态</th>
			<th>收款确认人</th>
			<th>收款确认时间</th>
		</tr>
		</thead>
		<c:forEach items="${paymentBillList}" var="paymentBill">
			<tr>
				<td>${paymentBill.billsCode}</td>
				<td>培训服务</td>
				<td>${erp:getCommonsTypeName(paymentBill.erpPaymentBillRecord.payType)}</td>
				<td>${paymentBill.erpPaymentBillRecord.erpFinaceType.subjectName}</td>
				<td>${paymentBill.erpPaymentBillRecord.amount}</td>
				<td>${erp:getCommonsTypeName(paymentBill.typeId)}</td>
				<td></td>
				<td>${paymentBill.collectionEmployee.name}</td>
				<td><fmt:formatDate value="${paymentBill.createTime}" pattern="yyyy-MM-dd HH:mm"/></td>
				<td>${erp:billStatusName(paymentBill.status)}</td>
				<td>${paymentBill.confirmEmployee.name}</td>
				<td><fmt:formatDate value="${paymentBill.confirmTime}" pattern="yyyy-MM-dd HH:mm"/></td>
			</tr>
		</c:forEach>
	</table>
</div>
<div expenditure>
	<strong>付款记录:</strong><br/>
	<table class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>付款单号</th>
				<th>业务类别</th>
				<th>付款类别</th>
				<th>付款科目</th>
				<th>付款金额</th>
				<th>付款方式</th>
				<th>备注</th>
				<th>付款状态</th>
				<th>付款人</th>
				<th>付款时间</th>
			</tr>
		</thead>
		<c:forEach items="${expenditureList}" var="expenditure">
			<tr>
				<td>${expenditure.expenditureCode}</td>
				<td>${erp:getTypeStatusName(expenditure.orderRefund.type)}</td>
				<td>${erp:getRefundTypeStatusName(expenditure.orderRefund.refundType)}</td>
				<td>${erp:getCommonsTypeName(expenditure.payType)}</td>
				<td>${expenditure.amount}</td>
				<td>${erp:getCommonsTypeName(expenditure.typeId)}</td>
				<td>${expenditure.remark}</td>
				<td>${erp:expenditureStatusName(expenditure.status)}</td>
				<td>${expenditure.user.name}</td>
				<td><fmt:formatDate value="${expenditure.createTime}" pattern="yyyy-MM-dd HH:mm"/></td>
			</tr>
		</c:forEach>
	</table>
</div>
<div class="form-actions">
	<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
</div>
</body>
</html>
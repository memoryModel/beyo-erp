<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>退费申请</title>
	<meta name="decorator" content="default"/>
</head>

<body>
<form:form id="inputForm" modelAttribute="orderRefund" method="post" action="${ctx}/erp/orderRefund/doFinanceAudit" class="form-horizontal">
	<input type="hidden" name="id" value="${orderRefund.id}">
    <input type="hidden" name="platformId" value="${orderRefund.platformId}">
    <input type="hidden" name="financialBillsCode" value="${orderRefund.financialBillsCode}">
    <input type="hidden" name="order.id" value="${orderRefund.order.id}">
    <input type="hidden" name="paymentType" value="${orderRefund.paymentType}">
    <input type="hidden" name="billId" value="${orderRefund.billId}">
    <input type="hidden" name="tuitionReturnAmount" value="${orderRefund.tuitionReturnAmount}">
    <input type="hidden" name="miscellaneousReturnAmount" value="${orderRefund.miscellaneousReturnAmount}">
    <input type="hidden" name="grossAmount" value="${orderRefund.grossAmount}">
    <input type="hidden" name="auditEmployee.id" value="${orderRefund.auditEmployee.id}">
    <input type="hidden" name="expenditureEmployee.id" value="${orderRefund.expenditureEmployee.id}">
    <input type="hidden" name="expenditureTime" value="${orderRefund.expenditureTime}">
    <input type="hidden" name="paymentEmployee.id" value="${orderRefund.paymentEmployee.id}">
    <input type="hidden" name="paymentTime" value="${orderRefund.paymentTime}">
    <%--<input type="hidden" name="accountName" value="${orderRefund.accountName}">
    <input type="hidden" name="accountBank" value="${orderRefund.accountBank}">
    <input type="hidden" name="bankCardNumber" value="${orderRefund.bankCardNumber}">--%>
    <input type="hidden" name="receipts" value="${orderRefund.receipts}">
    <input type="hidden" name="createTime" value="<fmt:formatDate value="${orderRefund.createTime}" pattern="yyyy-MM-dd HH:mm"/>">
    <input type="hidden" name="createUser" value="${orderRefund.createUser}">
    <input type="hidden" name="paymentStatus" value="${orderRefund.paymentStatus}">
    <input type="hidden" name="expenditureStatus" value="${orderRefund.expenditureStatus}">
    <input type="hidden" name="status" value="${orderRefund.status}">
    <input type="hidden" name="remark" value="${orderRefund.remark}">
    <input type="hidden" name="reason" value="${orderRefund.reason}">
    <input type="hidden" name="type" value="${orderRefund.type}">
    <input type="hidden" name="refundType" value="${orderRefund.refundType}">
    <input type="hidden" name="financeCreateTime" value="<fmt:formatDate value="${orderRefund.financeCreateTime}" pattern="yyyy-MM-dd HH:mm"/>">
	<sys:message content="${message}"/>

	<div class="control-group">
		<label class="control-label">退款单号：</label>
		<div class="controls">
				${orderRefund.financialBillsCode}
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">订单编号：</label>
		<div class="controls">
				${orderRefund.order.orderCode}
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">退款类型：</label>
		<div class="controls">
				${erp:getRefundTypeStatusName(orderRefund.refundType)}
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">退款金额：</label>
		<div class="controls">
				${orderRefund.grossAmount}
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">付款金额：</label>
		<div class="controls">
				<input type="text" name="expenditure.amount" value="${orderRefund.grossAmount}" readonly="readonly">
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">付款科目:</label>
		<div class="controls">
				<form:select path="expenditure.payType" class="input-medium required">
					<form:options items="${erp:getCommonsTypeList(19)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
				</form:select>
			<font color="red">*</font>
			<label class="error" id="payTypeError"></label>
		</div>
	</div>

	<div class="control-group">
		<label class="control-label">收款方式:</label>
		<div class="controls">
			<form:select path="expenditure.typeId" class="input-medium required">
				<form:options items="${erp:getCommonsTypeList(18)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
			</form:select>
			<font color="red">*</font>
			<label class="error" id="payTypeError"></label>
		</div>
	</div>

	<div class="control-group">
		<label class="control-label">备注：</label>
		<div class="controls">
			<form:textarea path="expenditure.remark" htmlEscape="false" rows="4" maxlength="1024" class="input-xxlarge " style="width: 330px"/>
		</div>
	</div>


	<div class="control-group">
		<label class="control-label">收款人：</label>
		<div class="controls">
            <input type="text" name="accountName" value="${orderRefund.accountName}" class="required">
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
	</div>

	<div class="control-group">
		<label class="control-label">开户银行：</label>
		<div class="controls">
            <input type="text" name="accountBank" value="${orderRefund.accountBank}" class="required">
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">收款账号：</label>
		<div class="controls">
            <input type="text" name="bankCardNumber" value="${orderRefund.bankCardNumber}" class="required digits">
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
	</div>

    <div class="control-group">
        <label class="control-label">操作时间：</label>
        <div class="controls">
            <input  name="expenditure.createTime" type="text" class="input-medium Wdate "
                    value="<fmt:formatDate value="${orderRefund.expenditure.createTime}" pattern="yyyy-MM-dd"/>"
                    onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label">操作人：</label>
        <div class="controls">
            <sys:treeselect id="handleNameId" name="expenditure.createUser" value="${orderRefund.expenditure.user.id}"
                            labelName="infoCollectId.name" labelValue="${orderRefund.expenditure.user.name}"
                            title="用户" url="/sys/office/treeData?type=3" notAllowSelectParent="true" allowClear="true" cssClass="required"/>
            <span class="help-inline"><font color="red">*</font> </span>
        </div>
    </div>
	<div class="form-actions">
		<input id="btnSubmit" class="btn btn-primary" type="submit" value="提 交"/>
		<input id="" class="btn" type="button" value="取 消" onclick="history.go(-1)"/>
	</div>
</form:form>
<script  type="text/javascript">
    $(document).ready(function() {
        //$("#name").focus();
        $("#inputForm").validate({
            submitHandler: function(form){
                loading('正在提交，请稍等...');
                form.submit();
            },
            errorContainer: "#messageBox",
            errorPlacement: function(error, element) {
                $("#messageBox").text("输入有误，请先更正。");
                if (element.is(":checkbox")||element.is(":radio")){
                    error.appendTo(element.parent().parent());
                }else if(element.parent().is(".input-append")){
                    $(error).text("必填信息");
                    element.parents(".controls").append(error);
                } else {
                    error.insertAfter(element);
                }
            }
        });
    });
</script>
</body>
</html>
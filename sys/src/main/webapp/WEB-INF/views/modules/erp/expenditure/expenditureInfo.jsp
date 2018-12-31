<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>付款</title>
	<meta name="decorator" content="default"/>
</head>

<body>
<form:form id="inputForm" modelAttribute="expenditure" method="post" action="${ctx}/expenditure/expenditure/doPay" class="form-horizontal">
	<input type="hidden" name="id" name="id" value="${expenditure.id}">
	<sys:message content="${message}"/>

	<div class="control-group">
		<label class="control-label">付款单号：</label>
		<div class="controls">
				${expenditure.expenditureCode}
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">业务类别：</label>
		<div class="controls">
				${erp:getTypeStatusName(expenditure.orderRefund.type)}
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">付款类别：</label>
		<div class="controls">
				${erp:getRefundTypeStatusName(expenditure.orderRefund.refundType)}
		</div>
	</div>

	<strong>付款单</strong>
	<div class="control-group">
		<label class="control-label">付款金额：</label>
		<div class="controls">
				${expenditure.amount}
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">付款科目:</label>
		<div class="controls">
				${erp:getCommonsTypeName(expenditure.payType)}
		</div>
	</div>

	<div class="control-group">
		<label class="control-label">付款方式:</label>
		<div class="controls">
				${erp:getCommonsTypeName(expenditure.typeId)}
		</div>
	</div>

	<div class="control-group">
		<label class="control-label">备注：</label>
		<div class="controls">
				${expenditure.remark}
		</div>
	</div>


	<div class="control-group">
		<label class="control-label">收款人：</label>
		<div class="controls">
				${expenditure.orderRefund.accountName}
		</div>
	</div>

	<div class="control-group">
		<label class="control-label">开户银行：</label>
		<div class="controls">
				${expenditure.orderRefund.accountBank}
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">收款账号：</label>
		<div class="controls">
				${expenditure.orderRefund.bankCardNumber}
		</div>
	</div>

    <div class="control-group">
        <label class="control-label">付款时间：</label>
        <div class="controls">
            <input  name="payTime" type="text" class="input-medium Wdate "
                    value="<fmt:formatDate value="${expenditure.payTime}" pattern="yyyy-MM-dd"/>"
                    onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label">付款人：</label>
        <div class="controls">
            <sys:treeselect id="handleNameId" name="payUser.id" value="${expenditure.payUser.id}"
                            labelName="payUser.name" labelValue="${expenditure.payUser.name}"
                            title="用户" url="/sys/office/treeData?type=3" notAllowSelectParent="true" allowClear="true" cssClass="required"/>
            <span class="help-inline"><font color="red">*</font> </span>
        </div>
    </div>
	<div class="form-actions">
		<input id="btnSubmit" class="btn btn-primary" type="submit" value="提 交"/>
		<input id="" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
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

		var result = '${result}'
		if(result == 'y'){
		    $('#btnSubmit').hide();
		}

    });



</script>
</body>
</html>
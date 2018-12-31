<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>退费申请</title>
	<meta name="decorator" content="default"/>
</head>

<body>
<form:form id="inputForm" modelAttribute="orderRefund" method="post" class="form-horizontal">
	<form:hidden path="id"/>
	<input type="hidden" name="orderId" value="${order.id}">
	<input id="billJson" type="hidden" style="width:1230px;"/>
	<sys:message content="${message}"/>

	<div>
		<strong>收费账单:</strong><br/>
		<table id="contentTable" style="width: 78%">
			<td>
				<div class="control-group">
					<label class="control-label">学费订金:</label>
					<div class="controls">
							${order.schoolClass.prepaidAmount}
					</div>
				</div>
			</td>
			<td>
				<div class="control-group">
					<label class="control-label">学费优惠:</label>
					<div class="controls">
							${order.favorableAmount}
					</div>
				</div>
			</td>
			<td>
				<div class="control-group">
					<label class="control-label">付款类型:</label>
					<div class="controls">
							${erp:getCommonsTypeName(order.payType)}
					</div>
				</div>
			</td>
		</table>

		<table id="billsTable" class="table table-striped table-bordered table-condensed">
			<thead>
			<tr>
				<th>收款类别</th>
				<th>应收金额(元)</th>
				<th>实收金额(元)</th>
				<th>欠收金额(元)</th>
			</tr>
			</thead>
			<tbody>
			<tr>
				<th id="bb">学费</th>
				<td>${order.schoolClass.tuitionAmount - order.favorableAmount}</td>
				<td>${not empty tuitionAmount ? tuitionAmount:'0.00'}</td>
				<td id="tuitionAmounts">${order.schoolClass.tuitionAmount - order.favorableAmount - tuitionAmount}</td>
			</tr>
			<tr>
				<th id="cc">学杂费</th>
				<td>${order.schoolClass.miscellaneousAmount}</td>
				<td>${not empty miscellaneousAmount ? miscellaneousAmount:'0.00'}</td>
				<td id="miscellaneousAmounts">${order.schoolClass.miscellaneousAmount - miscellaneousAmount}</td>
			</tr>
			<tr>
				<th></th>
				<td>合计应收：${order.overallAmount}&nbsp;&nbsp;(元)</td>
				<td>合计实收：${order.paymentAmount}&nbsp;&nbsp;(元)</td>
				<td>合计欠收：${order.overallAmount-order.paymentAmount}&nbsp;&nbsp;(元)</td>
			</tr>
			</tbody>
		</table>

		<strong>退费:</strong><br/>
		<table id="billcontentTable" class="table table-striped table-bordered table-condensed">
			<thead>
			<tr>
				<th>退费类型</th>
				<th>应退金额(元)</th>
				<th>扣款金额(元)</th>
				<th>实退金额(元)</th>
			</tr>
			</thead>
			<tbody id="refundBillTable">
			<tr>
				<td>学费</td>
				<td tuitionAmount>${not empty tuitionAmount ? tuitionAmount:'0.00'}</td>
				<td><input type="text" name="tuitionChargeAmount" class="required number checkAmount">
					<span class="help-inline"><font color="red">*</font> </span>
				</td>
				<td tuitionReturnAmount></td>
			</tr>
			<tr>
				<td>学杂费</td>
				<td miscellaneousAmount>${not empty miscellaneousAmount ? miscellaneousAmount:'0.00'}</td>
				<td><input type="text" name="miscellaneousChargeAmount" class="required number checkAmount">
					<span class="help-inline"><font color="red">*</font> </span>
				</td>
				<td miscellaneousReturnAmount></td>
			</tr>
			</tbody>
		</table>
	</div>

	<strong>合计退费:<span grossAmount></span></strong><br/><br/>

	<strong>退款账户:</strong><br/>
	<div class="control-group">
		<label class="control-label">开户人：</label>
		<div class="controls">
			<form:input id="accountName" path="accountName" htmlEscape="false" maxlength="64" class="input-xlarge required"/>
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">开户银行：</label>
		<div class="controls">
			<form:input id="accountBank" path="accountBank" htmlEscape="false" maxlength="512" class="input-xlarge required"/>
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">银行卡号：</label>
		<div class="controls">
			<form:input id="bankCardNumber" path="bankCardNumber" htmlEscape="false" maxlength="512" class="input-xlarge required digits"/>
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
	</div>

	<strong>退费原因:</strong><br/>

	<div class="control-group">
		<label class="control-label">单据是否退还：</label>
		<div id="wrap" class="controls">
			<input type="radio"  name="receipts" value="0" checked="checked"/>已退还
			<input type="radio"  name="receipts" value="1"/>未退还
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">退费原因：</label>
		<div class="controls">
			<form:textarea id="remark" path="remark" htmlEscape="false" rows="4" maxlength="1024" class="input-xxlarge required" style="width: 330px"/>
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
	</div>

	<div class="form-actions">
		<input id="btnSubmit" onclick="submitSave()" class="btn btn-primary" type="button" value="退 费"/>&nbsp;
		<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
	</div>
</form:form>
<script  type="text/javascript">

	var billArray;


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

        $.validator.addMethod("checkAmount",function (value, element) {
			//debugger
            //实退学费
			var actualRefundTuitionAmount = $('td[tuitionAmount]').text() -
						$('input[name="tuitionChargeAmount"]').val();
			//实退学杂费
			var actualRefundMiscellaneousAmount = $('td[miscellaneousAmount]').text() -
                $('input[name="miscellaneousChargeAmount"]').val();

			if(actualRefundTuitionAmount <0 || actualRefundMiscellaneousAmount < 0){
			    return false;
			}

            var grossAmount = math.parser().eval(actualRefundTuitionAmount + '+' +actualRefundMiscellaneousAmount);

			$('td[tuitionReturnAmount]').text(actualRefundTuitionAmount);
            $('td[miscellaneousReturnAmount]').text(actualRefundMiscellaneousAmount);
            $('span[grossAmount]').text(grossAmount);

            return true;
        },"金额不符合要求");

    });

    function validform() {
        return $("#inputForm").validate();
    }

    function AddBillArray(){
        billArray = new Array();
        var tuitionReturnAmount = $('td[tuitionReturnAmount]').text();
        var miscellaneousReturnAmount = $('td[miscellaneousReturnAmount]').text();
        billArray.push({
				orderId:$('input[type="hidden"][name="orderId"]').val(),
            tuitionWithholdAmount:$('input[name="tuitionChargeAmount"]').val(),
			tuitionReturnAmount:tuitionReturnAmount,
            miscellaneousWithholdAmount:$('input[name="miscellaneousChargeAmount"]').val(),
            miscellaneousReturnAmount:miscellaneousReturnAmount,
			grossAmount:math.parser().eval(tuitionReturnAmount + "+" + miscellaneousReturnAmount),
			accountName:$('#accountName').val(),
            accountBank:$('#accountBank').val(),
			bankCardNumber:$('#bankCardNumber').val(),
            receipts:$('#wrap').find('input[type="radio"]:checked').val(),
            remark:$('#remark').val()
		})
	}


    //提交form表单
    function submitSave() {
        if(!validform().form()){
            return;
        }
        AddBillArray();
        var json = JSON.stringify(billArray);
        //console.log(json);
        $.ajax({
            type : "post",
            url : '${ctx}/erp/orderRefund/save',
            async:false,
            data:{"billJson":encodeURIComponent(json)},
            success : function(data) {
                if (data && data.result == "success") {
                    location.href ='${ctx}/erp/orderRefund/applyList';
                } else {
                    window.location.reload();
                }
            }
        })

    }



</script>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>收款账单</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">

	</script>
</head>
<body>
<ul class="nav nav-tabs">
	<li><a href="${ctx}/erp/paymentBill/list">收款单列表</a></li>
	<li class="active"><a href="${ctx}/erp/paymentBill/bill?orderId=${classAmount.id}">收款单<shiro:hasPermission name="erp:paymentBill:bill">${not empty erpPaymentBill.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="erp:paymentBill:bill">查看</shiro:lacksPermission></a></li>
</ul><br/>
<form:form id="inputForm" modelAttribute="paymentBill" action="${ctx}/erp/paymentBill/save" method="post" class="form-horizontal">
	<form:hidden path="id"/>
	<input type="hidden" id="orderId" path="orderId" value="${classAmount.id}"/>
	<input type="hidden" id="billJson" style="width:1140px;"/>
	<sys:message content="${message}"/>

	<table id="contentTable" style="width: 78%">
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">归属账单:</label>
					<div class="controls">
						<input value="${classAmount.orderCode}" type="text" readonly="readonly" style="width:250px;"/>
					</div>
				</div>
			</td>
			<td>
				<div class="control-group">
					<label class="control-label">订单类别:</label>
					<div class="controls">
						<input value="${erp:orderTypeName(classAmount.orderType)}" type="text" readonly="readonly" style="width:250px;"/>
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">客户名称:</label>
					<div class="controls">
						<input value="${classAmount.student.name}"
							   type="text" readonly="readonly" style="width:250px;"/>
					</div>
				</div>
			</td>
			<td>
				<div class="control-group">
					<label class="control-label">合同编号:</label>
					<div class="controls">
						<input value="${classAmount.contract.code}" type="text" readonly="readonly" style="width:250px;"/>
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">业务归属部门:</label>
					<div class="controls">
						<input value="${classAmount.student.teacher.office.name}"
							   type="text" readonly="readonly" style="width:250px;"/>
					</div>
				</div>
			</td>
			<td>
				<div class="control-group">
					<label class="control-label">业务归属人:</label>
					<div class="controls">
						<input value="${classAmount.student.teacher.name}"
							   type="text" readonly="readonly" style="width:250px;"/>
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">下单时间:</label>
					<div class="controls">
						<input name="classAmount.createTime" style="width:250px;" type="text" readonly="readonly"
							   value="<fmt:formatDate value="${classAmount.createTime}" pattern="yyyy-MM-dd HH:mm"/>"/>
					</div>
				</div>
			</td>
			<td>
				<div class="control-group">
					<label class="control-label">订单状态:</label>
					<div class="controls">
						<input id="status" style="width:250px;" type="text" readonly="readonly"
							   value="${erp:orderStatusName(classAmount.status)}"/>
							<%--<input id="status" name="status" style="width:250px;" type="text" readonly="readonly"
								   value="${paymentBill.status ==1 ? '已结清':'未结清'}"/>--%>
					</div>
				</div>
			</td>
		</tr>

	</table>


	<strong>应收账单:</strong><br/>
	<table id="billsTable" class="table table-striped table-bordered table-condensed" style="width: 78%;">
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
			<td>预定金</td>
			<td prepaidAmount>${classAmount.schoolClass.prepaidAmount}</td>
			<td></td>
			<td></td>
		</tr>
		<tr>
			<td>学费</td>
			<td>${classAmount.schoolClass.tuitionAmount - classAmount.favorableAmount}</td>
			<td>${not empty tuitionAmount ? tuitionAmount:'0.00'}</td>
			<td tuitionAmount>${classAmount.schoolClass.tuitionAmount - classAmount.favorableAmount - tuitionAmount}</td>
		</tr>
		<tr>
			<td>学杂费</td>
			<td>${classAmount.schoolClass.miscellaneousAmount}</td>
			<td>${not empty miscellaneousAmount ? miscellaneousAmount:'0.00'}</td>
			<td miscellaneousAmount>${classAmount.schoolClass.miscellaneousAmount - miscellaneousAmount}</td>
		</tr>
		<tr>
			<td>合计优惠：${classAmount.favorableAmount}&nbsp;&nbsp;(元)</td>
			<td>合计应收：${classAmount.overallAmount}&nbsp;&nbsp;(元)</td>
			<td>合计实收：${classAmount.paymentAmount}&nbsp;&nbsp;(元)</td>
			<td>合计欠收：${classAmount.overallAmount-classAmount.paymentAmount}&nbsp;&nbsp;(元)</td>
		</tr>
		</tbody>
	</table>


	<strong>收款单:</strong><br/>
	<div>
		<table id="billRecordTable">
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">收款单编号:</label>
						<div class="controls">
							<form:input id="billsCode" path="billsCode" value="${billsCode}" htmlEscape="false" maxlength="20" style="width:197px;" disabled="true" class="required"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">收款方式:</label>
						<div class="controls">
							<form:select path="typeId" id="typeId" class="input-large required" onchange="typeIdValidate()" style="width: 220px;" >
								<form:option value="" label="------请选择------"/>
								<form:options items="${erp:getCommonsTypeList(18)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
							</form:select>
							<font color="red">*</font>
							<label class="error" id="typeError"></label>
						</div>
					</div>
				</td>
				<td></td>
			</tr>
			<tr>
				<!-- 收入科目字段废除 为了改动量小把收入科目id和name写死 -->
				<input type="hidden" id="erpFinaceTypeId" value="200">
				<input type="hidden" id="erpFinaceTypeName" value="学费">
				<td>
					<div class="control-group">
						<label class="control-label">收款类型:</label>
						<div class="controls">
								<%--<c:if test="${type == null}">--%>
							<select name="erpPaymentBillRecord.payType" id="payType" class="input-large required" onchange="payTypeValidate()" style="width: 220px;">
							</select>
							<font color="red">*</font>
							<label class="error" id="payTypeError"></label>


						</div>

					</div>
				</td>

			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">收款金额:</label>
						<div class="controls">
							<input id="amount" type="text" name="erpPaymentBillRecord.amount" style="width:197px;" class="required money valid checkAmount" onchange="amountValidate()"/>
							<font color="red">*</font>
							<label class="error" id="billamountError"></label>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="3">
					<div class="control-group">
						<label class="control-label">备注:</label>
						<div class="controls">
							<form:textarea path="remark" htmlEscape="false" rows="4" class="input-xxlarge " style="width:700px;"/>
						</div>
					</div>
				</td>
			</tr>
		</table>
	</div>

	</div>



	<div class="form-actions">
		<input id="btnSubmit"  class="btn btn-primary" onclick="submitSave()" type="button" value="保 存"/>
	</div>
	<input type="hidden" id="options" name="options">
	<input type="hidden" id="optionContents" name="optionContents">
	<input type="hidden" id="statuses" name="statusess">
</form:form>



<script type="text/javascript">
    //收款类型数组
    var commonsTypeArray = ${fns:toJson(erp:getCommonsTypeList(19))};
    console.log(JSON.stringify(commonsTypeArray))
    var optionHTML = '<option value="">------请选择------</option>';
    //预定金
    var prepaidAmount = '${classAmount.schoolClass.prepaidAmount}'
    //实收的学费
    var tuitionAmount = '${tuitionAmount}'

    if(prepaidAmount != '' && prepaidAmount != undefined && prepaidAmount != null){
        prepaidAmount = parseInt(prepaidAmount)
    }
    if(tuitionAmount != '' && tuitionAmount != undefined && tuitionAmount != null){
        tuitionAmount = parseInt(tuitionAmount)
    }

    for(var i=0;i<commonsTypeArray.length;i++){
        //当实收的学费大于等于预定金的情况下，则收费类型没有预定金选项
        if(tuitionAmount>=prepaidAmount){
            if(commonsTypeArray[i].id != 2222){
                optionHTML = optionHTML + '<option value='+commonsTypeArray[i].id+'>'+commonsTypeArray[i].commonsName+'</option>'
            }
        }else{//否则 就是正常情况 所有的收费类型都有
            optionHTML = optionHTML + '<option value='+commonsTypeArray[i].id+'>'+commonsTypeArray[i].commonsName+'</option>'
        }
    }
    $('#payType').append(optionHTML);

    var count = 0;
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
                if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
                    error.appendTo(element.parent().parent());
                } else {
                    error.insertAfter(element);
                }
            },
        });

        jQuery.validator.addMethod("checkAmount", function(value, element) {
            var flag = true;
			var selectPayTypeName = $('#payType').find('option:selected').text();
			if(selectPayTypeName.indexOf('学费') != -1){
				//如果填入的学费大于欠收的金额 则不符合规则
				var badCropTuitionAmount = $('td[tuitionAmount]').text();
				if(parseFloat(value) > badCropTuitionAmount){
					flag = false;
				}
			}else if(selectPayTypeName.indexOf('保险') != -1){
				//如果填入的保险大于欠收的金额 则不符合规则
                var badCropInsuranceAmount = $('td[insuranceAmount]').text();
                if(parseFloat(value) > badCropInsuranceAmount){
                    flag = false;
                }
			}else if(selectPayTypeName.indexOf('保证金') != -1){
                //如果填入的保证金大于欠收的金额 则不符合规则
                var badCropDepositAmount = $('td[depositAmount]').text();
                if(parseFloat(value) > badCropDepositAmount){
                    flag = false;
                }
			}else if(selectPayTypeName.indexOf('学杂费') != -1){
				//如果填入的学杂费大于欠收的金额 则不符合规则
                var badCropMiscellaneousAmount = $('td[miscellaneousAmount]').text();
                if(parseFloat(value) > badCropMiscellaneousAmount){
                    flag = false;
                }
			}else if(selectPayTypeName.indexOf('预定金') != -1){
				//如果填入的预定金大于欠收的金额 则不符合规则
                var badCropPrepaidAmount = $('td[prepaidAmount]').text();
                if(parseFloat(value) > badCropPrepaidAmount){
                    flag = false;
                }
			}
            return flag;
        }, "收款金额不符合规则");

    });

    var billArray = new Array();


    //添加数据
	function addBillArray(){
        var pt = payTypeValidate();
        var e = erpFinaceTypeValidate();
        var am = amountValidate();
        if(pt && am && e && ($("#inputForm").valid())) {
            var billsCode = $("#billsCode").val();//收款单编号
            var orderId = $("#orderId").val();//订单ID
            var typeId = $("#typeId").val();//收款方式
            var payType = $("#payType").val();//收款类型ID
            //获取收款类型下拉框的选中文本
            var obj = document.getElementById("payType");
            for (i = 0; i < obj.length; i++) {//下拉框的长度就是它的选项数.
                if (obj[i].selected == true) {
                    var payTypeName = obj[i].text;//获取当前选择项的文本.收款类型名称
                }
            }
            var erpFinaceTypeId = $("#erpFinaceTypeId").val();//收款科目ID
            var erpFinaceTypeName = $("#erpFinaceTypeName").val();//收款科目名称
            var amount = $("#amount").val();//收款金额
            if(billArray.length == 0 && payType != null && payType!="" && erpFinaceTypeId != null && erpFinaceTypeId!="" && amount != null && amount!="" ){
                pushbillArray(billsCode,orderId,typeId,payType,payTypeName,erpFinaceTypeId,erpFinaceTypeName,amount);
            }
        }
	}


    //billArray追加数据
    function  pushbillArray(billsCode,orderId,typeId,payType,payTypeName,erpFinaceTypeId,erpFinaceTypeName,amount){
	    billArray = new Array();
        billArray.push({
            "billsCode":billsCode,//收款单编号
            "orderId":orderId,//订单ID
            "typeId":typeId,//收款方式
            "payType":payType,//收款类型ID
            "payTypeName":payTypeName,//收款类型名称
            "erpFinaceTypeId":erpFinaceTypeId,//收款科目ID
            "erpFinaceTypeName":erpFinaceTypeName,//收款科目名称
            "amount":amount//收款金额
        });
    }


    //验证收款方式是否为空
    function typeIdValidate(){
        var name = $("#typeId").val();
        if(null == name || "" == name){
            $("#typeError").html("请选收款方式！");
            return false;
        }else{
            $("#typeError").html("");
            return true;
        }
    }

    //验证收入科目是否为空
    function erpFinaceTypeValidate(){
        var name = $("#erpFinaceTypeId").val();
        if(null == name || "" == name){
            $("#erpFinaceTypeIdError").html("请选择收款科目！");
            return false;
        }else{
            $("#erpFinaceTypeIdError").html("");
            return true;
        }
    }

    //验证收款类型是否为空
    function payTypeValidate(){
        var name = $("#payType").val();
        if(null == name || "" == name){
            $("#payTypeError").html("请选择收款类型！");
            return false;
        }else{
            $("#payTypeError").html("");
            return true;
        }
    }

    //验证收款金额是否为空
    function amountValidate(){
        var name = $("#amount").val();
        if(null == name || "" == name){
            $("#billamountError").html("请输入收款金额！");
            return false;
        }else{
            $("#billamountError").html("");
            return true;
        }
    }


    //提交from表单
    function submitSave() {
        addBillArray();
        var json = JSON.stringify(billArray);
        var e = erpFinaceTypeValidate();
        var ti = typeIdValidate();
        var pt = payTypeValidate();
        var a = amountValidate();
        if(ti && pt && a && e){

            $.ajax({
                type:'post',
                url:'${ctx}/erp/paymentBill/save',
                async:false,
                data:{"billJson":encodeURIComponent(json)},
                success : function(data) {
                    if (data && data == "success") {
                        window.location.href = '${ctx}/erp/paymentBill/list';
                    } else {
                        window.location.reload();
                    }
                }
            })
        }

    }

</script>
</body>
</html>
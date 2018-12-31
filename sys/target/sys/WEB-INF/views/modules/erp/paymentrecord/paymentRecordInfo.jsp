<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>订单详情</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
        console.log("billRecordId:"+$("#billRecordId").val() + "orderId:"+$("#orderId").val());
        $(document).ready(function() {

        });
        function page(n,s){
            if(n) $("#pageNo").val(n);
            if(s) $("#pageSize").val(s);
            <%--$("#searchForm").attr("action","${ctx}/pro/schoolClass/info");--%>
            $("#searchForm").submit();
            return false;
        }


        var billArray = new Array();
        //提交from表单
        function submitSave() {
            console.log("billRecordId:"+$("#billRecordId").val() + "orderId:"+$("#orderId").val());
            //return;
            var orderId = $("#orderId").val();
            var billId = $("#paymentBillId").val();
            var billRecordId = $("#billRecordId").val();
            var payType = $("#payType").val();
            var subjectId = $("#erpFinaceTypeId").val();
            var amount = $("#amount").val();
            var typeId = $("#typeId").val();
            var collectionId = $("#collectionEmployeeId").val();
            var createTime = $("#createTime").val();
            var remark = $("#remark").val();

            console.log(billId+"----"+billRecordId+"----"+payType+"----"+subjectId+"----"+amount+"----"+typeId+"----"+collectionId+"----"+createTime+"----"+remark);

            billArray.push({
                "orderId":orderId,
                "billId":billId,
                "billRecordId":billRecordId,
                "payType":payType,
                "subjectId":subjectId,
                "amount":amount,
                "typeId":typeId,
                "collectionId":collectionId,
                "createTime":createTime,
                "remark":remark,

            });
            /*console.log("classId:"+schoolSchedule[i].classId+",startTime:"+ schoolSchedule[i].beginTime + ",endTime:"+ schoolSchedule[i].endTime);
             */

            if(${paymentBill.erpPaymentBillRecord.payType == 5555}){
                $.ajax({
                    type : 'post',
                    url : '${ctx}/erp/paymentBillRecord/save',
                    async:false,
                    data:{"billJson":encodeURIComponent(JSON.stringify(billArray))},
                    success : function(data) {
                        if (data && data.result == "success") {
                            location.href = '${ctx}/erp/paymentBillOtherRecord/list';
                        } else {
                            window.location.reload();
                        }
                    }
                })
            }else{
                $.ajax({
                    type : 'post',
                    url : '${ctx}/erp/paymentBillRecord/save',
                    async:false,
                    data:{"billJson":encodeURIComponent(JSON.stringify(billArray))},
                    success : function(data) {
                        if (data && data.result == "success") {
                            location.href = '${ctx}/erp/paymentBillRecord/list';
                        } else {
                            window.location.reload();
                        }
                    }
                })
            }

        }

	</script>
</head>
<body>
<div>
	<ul class="nav nav-tabs">
		<c:if test="${paymentBill.erpPaymentBillRecord.payType != null && paymentBill.erpPaymentBillRecord.payType == 5555}">
			<li><a href="${ctx}/erp/paymentBillOtherRecord/">其他收款列表</a></li>
		</c:if>
		<c:if test="${paymentBill.erpPaymentBillRecord.payType != null && paymentBill.erpPaymentBillRecord.payType != 5555}">
			<li><a href="${ctx}/erp/paymentBillRecord/">收款记账列表</a></li>
		</c:if>

		<%--<li><a href="${ctx}/erp/receivableBill/">应收账单列表</a></li>--%>
		<li class="active">
			<a href="${ctx}/erp/paymentBillRecord/form?id=${paymentBill.id}&&billRecordId=${paymentBill.erpPaymentBillRecord.id}&&orderId=${paymentBill.order.id}">收款记账</a>
		</li>
	</ul></div><br/><div>

	<form:form id="inputForm" modelAttribute="paymentBill" class="form-horizontal">
		<form:hidden path="id"/>
	<input type="hidden" id="billRecordId" value="${paymentBill.erpPaymentBillRecord.id}"/>
	<input type="hidden" id="orderId" value="${classAmount.id}"/>
	<input type="hidden" id="paymentBillId" value="${paymentBill.id}">
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
						<input value="${classAmount.student.name }"
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
						<input value="${classAmount.student.teacher.office.name }"
							   type="text" readonly="readonly" style="width:250px;"/>
					</div>
				</div>
			</td>
			<td>
				<div class="control-group">
					<label class="control-label">业务归属人:</label>
					<div class="controls">
						<input value="${classAmount.student.teacher.name }"
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
					</div>
				</div>
			</td>
		</tr>

	</table>



	<strong>收款项目:</strong><br/>
	<table id="billsTable" class="table table-striped table-bordered table-condensed" style="width:78%;">
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
			<td>${classAmount.schoolClass.tuitionAmount - classAmount.favorableAmount - tuitionAmount}</td>
		</tr>
		<tr>
			<td>学杂费</td>
			<td>${classAmount.schoolClass.miscellaneousAmount}</td>
			<td>${not empty miscellaneousAmount ? miscellaneousAmount:'0.00'}</td>
			<td>${classAmount.schoolClass.miscellaneousAmount - miscellaneousAmount}</td>
		</tr>
		<tr>
			<th>合计优惠：${classAmount.favorableAmount}&nbsp;&nbsp;(元)</th>
			<th>合计应收：${classAmount.overallAmount}&nbsp;&nbsp;(元)</th>
			<th>合计实收：${classAmount.paymentAmount}&nbsp;&nbsp;(元)</th>
			<th>合计欠收：${classAmount.overallAmount-classAmount.paymentAmount}&nbsp;&nbsp;(元)</th>
		</tr>
		</tbody>
	</table>

	<strong>收款单:</strong><br/>
	<div>
		<table id="billRecordTable" style="width:80%;">
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">收款类别:</label>
						<div class="controls">
							<form:select path="erpPaymentBillRecord.payType" id="payType" style="width: 200px;">
								<form:option value="" label="------请选择------"/>
								<form:options items="${erp:getCommonsTypeList(19)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
							</form:select>
								<%--<form:select path="erpPaymentBillRecord.payType" id="payType" class="input-large">
                                    <form:options items="${fns:getDictList('bill_pay_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                                </form:select>--%>
						</div>
					</div>
				</td>
				<!-- 收入科目字段废除 为了改动量小把收入科目id和name写死 -->
				<input type="hidden" id="erpFinaceTypeId" value="200">
				<input type="hidden" id="erpFinaceTypeName" value="学费">
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">收款金额:</label>
						<div class="controls">
							<form:input path="erpPaymentBillRecord.amount" id="amount" value="${paymentBill.erpPaymentBillRecord.amount}" type="text" style="width:188px;" class="money valid"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">收款方式:</label>
						<div class="controls">
							<form:select path="typeId" id="typeId" class="input-large" style="width: 205px">
								<form:option value="" label="------请选择------"/>
								<form:options items="${erp:getCommonsTypeList(18)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
							</form:select>
								<%--<form:select path="typeId" id="typeId" class="input-large">
                                    <form:options items="${fns:getDictList('bill_pay')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                                </form:select>--%>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">收款人:</label>
						<div class="controls">
							<sys:treeselect id="collectionEmployee" name="collectionEmployee.id" value="${paymentBill.collectionEmployee.id}"
											labelName="collectionEmployee.name" labelValue="${paymentBill.collectionEmployee.name}"
											title="收款人" url="/sys/office/treeData?type=3" cssClass="required" notAllowSelectParent="true"/>

								<%--<sys:employeeselect id="collectionEmployee" name="collectionEmployee.id" value="${erpPaymentBill.collectionEmployee.id}"
                                                    labelName="erpPaymentBill.collectionEmployee.name" labelValue="${erpPaymentBill.collectionEmployee.name}"
                                                    title="员工" url="/erp/employee/officeTreeData?type=3" notAllowSelectParent="true"/>--%>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">收款时间:</label>
						<div class="controls">
							<input id="createTime" name="createTime" type="text" maxlength="20" class="input-medium Wdate " style="width: 190px;"
								   value="<fmt:formatDate value="${paymentBill.createTime}" pattern="yyyy-MM-dd HH:mm"/>"
								   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div class="control-group">
						<label class="control-label">备注:</label>
						<div class="controls">
							<form:textarea path="remark" htmlEscape="false" rows="4" class="input-xxlarge " style="width: 730px;"/>
						</div>
					</div>
				</td>
			</tr>
		</table>
	</div>

	<div class="form-actions">
		<c:if test="${paymentBill.status != 1 && paymentBill.status != null}">
			<shiro:hasPermission name="erpreceivablebill:erpReceivableBill:edit">
				<button type="button" class="btn btn-primary" onclick="submitSave()">保存</button>&nbsp;
				<%--<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>--%>
			</shiro:hasPermission>
		</c:if>
		<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
	</div>

	</form:form>
</body>
</html>
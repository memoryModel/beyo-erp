<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title></title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
        $(document).ready(function() {
            //$("#asProCategoryButton").addClass("disabled");
            //$("#userButton").addClass("disabled");

        });
        function page(n,s){
            if(n) $("#pageNo").val(n);
            if(s) $("#pageSize").val(s);
            $("#searchForm").attr("action","${ctx}/pro/schoolClass/info");
            $("#searchForm").submit();
            return false;
        }
        function freeze() {
            var notarizeArray = new Array();
            var receivableBillId = ${erpReceivableBill.id};
            var status = 2;
            var remark = $("#remark").val();
            console.info("receivableBillId"+receivableBillId+"remark"+remark);
            notarizeArray.push({"remark":remark,"receivableBillId":receivableBillId,"status":status});
			if(confirm("确定要将账单挂起?")){
                $.ajax({
                    type:'post',
                    url : '${ctx}/erp/incomeNotarize/freeze/',
                    data:{"notarizeJson":encodeURIComponent(JSON.stringify(notarizeArray))},
                    success : function(data) {
                        if (data && data.result == "success") {
                            location.href = '${ctx}/erp/incomeNotarize/list';
                        } else {
                            window.location.reload();
                        }
                    }

                })
            }
        }
        /*确认收入								*/
        function affirm() {
            var notarizeArray = new Array();
            var receivableBillId = ${erpReceivableBill.id};
            var status = 3;
            var remark = $("#remark").val();
            console.info("receivableBillId"+receivableBillId+"remark"+remark);
            notarizeArray.push({"remark":remark,"receivableBillId":receivableBillId,"status":status});
            if(confirm("确认要将此账单收入?")){
            $.ajax({
                type:'post',
                url : '${ctx}/erp/incomeNotarize/freeze',
                data:{"notarizeJson":encodeURIComponent(JSON.stringify(notarizeArray))},
                success : function(data) {
                    if (data && data.result == "success") {
                        location.href = '/erp/incomeNotarize/list';
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
<input type="hidden" value="${erpReceivableBill.id}"   id="guaqiId"/>
<div>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/erp/incomeNotarize/">账单处理</a></li>
	</ul></div><br/><div>

	<form:form id="inputForm" modelAttribute="erpReceivableBill" class="form-horizontal">
		<form:hidden path="id"/>
	<table id="contentTable" style="width: 78%">
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">归属账单:</label>
					<div class="controls">
						<input value="${erpReceivableBill.order.orderCode}" type="text" readonly="readonly" style="width:250px;"/>
					</div>
				</div>
			</td>
			<td>
				<div class="control-group">
					<label class="control-label">订单类别:</label>
					<div class="controls">
						<input value="${erp:orderTypeName(erpReceivableBill.order.orderType)}" type="text" readonly="readonly" style="width:250px;"/>

					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">客户名称:</label>
					<div class="controls">
						<input value="${erpReceivableBill.order.student.name}" type="text" readonly="readonly" style="width:250px;"/>
					</div>
				</div>
			</td>
			<td>
				<div class="control-group">
					<label class="control-label">合同编号:</label>
					<div class="controls">
						<input value="${erpReceivableBill.order.contract.code}" type="text" readonly="readonly" style="width:250px;"/>
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">业务归属部门:</label>
					<div class="controls">
						<input value="${erpReceivableBill.order.student.teacher.office.name}" type="text" readonly="readonly" style="width:250px;"/>
					</div>
				</div>
			</td>
			<td>
				<div class="control-group">
					<label class="control-label">业务归属人:</label>
					<div class="controls">
						<input value="${erpReceivableBill.order.student.teacher.name}" type="text" readonly="readonly" style="width:250px;"/>
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">下单时间:</label>
					<div class="controls">
						<input id="erpReceivableBill.order.createTime" name="erpReceivableBill.order.createTime" style="width:250px;" type="text" readonly="readonly"
							   value="<fmt:formatDate value="${erpReceivableBill.order.createTime}" pattern="yyyy-MM-dd HH:mm"/>"/>
					</div>
				</div>
			</td>
			<td>
				<div class="control-group">
					<label class="control-label">结单时间:</label>
					<div class="controls">
						<input id="erpReceivableBill.order.orderTime" name="erpReceivableBill.order.createTime" style="width:250px;" type="text" readonly="readonly"
							   value="<fmt:formatDate value="${erpReceivableBill.order.createTime}" pattern="yyyy-MM-dd HH:mm"/>"/>
					</div>
				</div>
			</td>
		</tr>
		<tr>
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
	<table id="billsTable" class="table table-striped table-bordered table-condensed" style="width: 78%">
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
			<td>${classAmount.schoolClass.prepaidAmount}</td>
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
			<td>${classAmount.schoolClass.miscellaneousAmount - miscellaneousAmount}</td>
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
		<table id="billListTable" class="table table-striped table-bordered table-condensed" style="width: 78%">
			<thead>
			<tr>
				<th>收款类别</th>
				<th>收入科目</th>
				<th>收款金额(元)</th>
			</tr>
			</thead>
			<tbody>
			<c:forEach items="${page.list}" var="erpPaymentBill">
				<tr>
					<td>
							${erpPaymentBill.erpPaymentBillRecord.payType}
					</td>
					<td>
							${erpPaymentBill.erpPaymentBillRecord.erpFinaceType.subjectName}
					</td>
					<td>
							${erpPaymentBill.erpPaymentBillRecord.amount}
					</td>

				</tr>
			</c:forEach>
			</tbody>
		</table>

		<strong>账单处理:</strong><br/>
		<table>
			<tr>
				<div class="control-group">
					<label class="control-label">备注:</label>
					<div class="controls">
						<form:textarea id="remark" path="billHistory.remark" htmlEscape="false" rows="4" class="input-xxlarge "/>
					</div>
				</div>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">客户名称:</label>
						<div class="controls">
							<input value="${erpReceivableBill.order.student.name}" type="text" readonly="readonly" style="width:250px;"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">办理时间:</label>
						<div class="controls">
							<input id="erpReceivableBill.orderTime" name="erpReceivableBill.order.createTime" style="width:250px;" type="text" readonly="readonly"
								   value="<fmt:formatDate value="${erpReceivableBill.order.createTime}" pattern="yyyy-MM-dd HH:mm"/>"/>
						</div>
					</div>
				</td>
			</tr>

		</table>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a type="button" class="btn btn-primary" onclick="freeze()">账单挂起</a>&nbsp;&nbsp;&nbsp;&nbsp;
			<a type="button" class="btn btn-primary" onclick="affirm()">确认收入</a>&nbsp;&nbsp;&nbsp;&nbsp;
			<input id="btnCancel" class="btn btn-primary" type="button" value="返 回" onclick="history.go(-1)"/>


	</form:form>

</body>
</html>
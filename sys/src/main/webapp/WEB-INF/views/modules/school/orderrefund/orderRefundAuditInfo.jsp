<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>退费申请</title>
	<meta name="decorator" content="default"/>
</head>

<body>
<form:form id="inputForm" modelAttribute="orderRefund" method="post" action="${ctx}/erp/orderRefund/doAudit" class="form-horizontal">
	<form:hidden path="id"/>
	<input type="hidden" name="orderId" value="${orderRefund.order.id}">
	<sys:message content="${message}"/>

	<div>
		<strong>班级信息:</strong><br/>
		<table id="billsTable" class="table table-striped table-bordered table-condensed">
			<thead>
			<tr>
				<th>班级名称</th>
				<th>课程</th>
				<th>班主任</th>
				<th>学费</th>
				<th>付款类型</th>
				<th>学费优惠</th>
				<th>开班日期</th>
				<th>报名日期</th>
			</tr>
			</thead>
			<tr>
				<td>${orderRefund.order.student.schoolClassStudents.schoolClass.className}</td>
				<td>
					<c:forEach items="${classToLessonList}" var="classToLesson">
						${classToLesson.schoolClassLesson.lessonName}<br>
					</c:forEach>
				</td>
				<td>${orderRefund.order.student.schoolClassStudents.schoolClass.headteacher.name}</td>
				<td>${orderRefund.order.overallAmount}</td>
				<td>${erp:getCommonsTypeName(orderRefund.order.payType)}</td>
				<td>${orderRefund.order.favorableAmount}</td>
				<td>
					<fmt:formatDate value="${orderRefund.order.student.schoolClassStudents.schoolClass.realBeginTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
					<fmt:formatDate value="${orderRefund.order.student.schoolClassStudents.applyTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
			</tr>
			<tr>
				<td></td>
				<td>课程名称</td>
				<td>科目</td>
				<td>类型</td>
				<td>总课次</td>
				<td>已上课次</td>
				<td>剩余课次</td>
				<td></td>
			</tr>
			<c:forEach items="${classHourList}" var="classHour">
				<tr>
					<td></td>
					<td>${classHour.lessonName}</td>
					<td>${erp:getCommonsTypeName(classHour.lessonType)}</td>
					<td>基础</td>
					<td>${classHour.countNum}</td>
					<td>${classHour.joinCountNum}</td>
					<td>${classHour.countNum - classHour.joinCountNum}</td>
					<td></td>
				</tr>
			</c:forEach>
		</table>

		<strong>退费信息:</strong><br/>
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
				<td>${tuitionAmount - orderRefund.tuitionReturnAmount}</td>
				<td>${orderRefund.tuitionReturnAmount}</td>
			</tr>
			<tr>
				<td>学杂费</td>
				<td miscellaneousAmount>${not empty miscellaneousAmount ? miscellaneousAmount:'0.00'}</td>
				<td>${miscellaneousAmount - orderRefund.miscellaneousReturnAmount}</td>
				<td>${orderRefund.miscellaneousReturnAmount}</td>
			</tr>
			</tbody>
		</table>
	</div>

	<strong>退款账户:</strong><br/>
	<div class="control-group">
		<label class="control-label">开户人：</label>
		<div class="controls">
			${orderRefund.accountName}
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">开户银行：</label>
		<div class="controls">
			${orderRefund.accountBank}
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">银行卡号：</label>
		<div class="controls">
			${orderRefund.bankCardNumber}
		</div>
	</div>

	<strong>退费原因:</strong><br/>

	<div class="control-group">
		<label class="control-label">单据是否退还：</label>
		<div id="wrap" class="controls">
			<form:radiobutton disabled="true" path="receipts" value="0"></form:radiobutton>已退还
			<form:radiobutton disabled="true" path="receipts" value="1"></form:radiobutton>未退还
			<%--<input type="radio"  name="receipts" value="0"/>已退还
			<input type="radio"  name="receipts" value="1"/>未退还--%>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">退费原因：</label>
		<div class="controls">
			<form:textarea id="remark" readonly="true" path="remark" htmlEscape="false" rows="4" maxlength="1024" class="input-xxlarge " style="width: 330px"/>
		</div>
	</div>

	<strong>处理详情:</strong><br/>
	<table  class="table table-striped table-bordered table-condensed">
		<thead>
		<tr>
			<th>时间</th>
			<th>操作人</th>
			<th>操作</th>
			<th>备注</th>
		</tr>
		</thead>
		<tbody>
			<c:forEach items="#{orderRefund.orderRefundRecordList}" var="orderRefundRecord">
			<tr>
				<td><fmt:formatDate value="${orderRefundRecord.operationTime}" pattern="yyyy-MM-dd"/></td>
				<td>${orderRefundRecord.operater.name}</td>
				<td>${erp:getRefundRecordStatusName(orderRefundRecord.status)}</td>
				<td>${orderRefundRecord.remark}</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>

	<div reason>
		<strong>添加原因:</strong><br/>
		<div class="control-group">
			<label class="control-label">审核通过或不通过原因：</label>
			<div class="controls">
				<form:textarea id="reason"  path="reason" htmlEscape="false" rows="4" maxlength="1024" class="input-xxlarge required" style="width: 330px"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
	</div>

	<div class="form-actions">
		<input id="btnSubmit" class="btn btn-primary" type="button" onclick="orderRefundAudit(7)" value="审核通过"/>&nbsp;
		<input id="btnCancel" class="btn btn-primary" type="button" onclick="orderRefundAudit(3)" value="审核未通过"/>
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


        var readOnly = '${readOnly}'
		if(readOnly == 'y'){
            $('div[reason]').remove();
            $('#btnSubmit,#btnCancel').hide();
		}

    });

    function orderRefundAudit(result) {
        var hdHTML = '<input name="result" value='+result+'>';
		$('#inputForm').append(hdHTML);
        $('#inputForm').submit();
    }

</script>
</body>
</html>
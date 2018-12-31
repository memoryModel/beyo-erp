<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>单表管理</title>
	<meta name="decorator" content="default"/>

</head>
<body>
	<br/>
	<form:form id="inputForm" modelAttribute="erpOrder" action="${ctx}/erp/studentOrder/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">订单号：</label>
			<div class="controls">
				<form:input path="orderCode" htmlEscape="false" maxlength="128" class="input-xlarge " readonly="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">学生姓名：</label>
			<div class="controls">
				<form:input path="student.name" htmlEscape="false" maxlength="128" class="input-xlarge " readonly="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">班级名称：</label>
			<div class="controls">
				<form:input path="schoolClass.className" htmlEscape="false" maxlength="128" class="input-xlarge " readonly="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">总金额：</label>
			<div class="controls">
				<form:input path="overallAmount" htmlEscape="false" class="input-xlarge  number" readonly="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">优惠金额：</label>
			<div class="controls">
				<form:input path="favorableAmount" htmlEscape="false" class="input-xlarge  number" readonly="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">支付金额：</label>
			<div class="controls">
				<form:input path="paymentAmount" htmlEscape="false" class="input-xlarge  number" readonly="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">下单时间：</label>
			<div class="controls">
				<input name="createTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${erpOrder.createTime}" pattern="yyyy-MM-dd HH:mm"/>"
					   readonly="true"/>
			</div>
		</div>
		<div class="form-actions">
			<input name="closeWindows" class="btn" type="button" value="关 闭"/>
		</div>
	</form:form>
	<script type="text/javascript">
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
                }
            });
            $("input[name='closeWindows']").each(function () {
                $(this).click(function () {
                    top.$.jBox.close(true);
                });
            })
        });
	</script>
</body>
</html>
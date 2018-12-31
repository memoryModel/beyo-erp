<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>客户管理</title>
	<meta name="decorator" content="default"/>
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
            //选择客户表
            $("#selectcustomer").click(function () {
                studentJbox =  top.$.jBox.open("iframe:/crm/customer/select", "客户表", 1024, 520);<!--跳转到controller-->
            });
            //选择员工表
            $("#selectEmployee").click(function () {
                studentJbox =  top.$.jBox.open("iframe:/crm/customer/selectEmployee", "员工表", 1024, 520);<!--跳转到controller-->
            });
            $("#selectUser").click(function () {
                studentJbox =  top.$.jBox.open("iframe:/crm/customer/selectUser", "服务人员表", 1024, 520);<!--跳转到controller-->
            });

            jQuery.validator.addMethod("phoneExist", function(value, element) {
                var flag = false;
                $.ajax({
                    type:"POST",
                    async:false,
                    url:"/crm/customer/isExist",
                    data:"graphone="+value,
                    success: function(data){
                        console.log(data);
                        if(data=="success"){
                            flag = true;
                        }else{
                            flag = false;
                        }
                    }
                });
                return flag;
            }, "手机号码已存在");

		});

        function selectCustomerCallback(id,names){
            $("#empId").val(id);
            $("#employeeName").val(names);
        }
        function selectEmployeeCallback(id,names){
            $("#empId").val(id);
            $("#employeeName").val(name);
        }
        function selectUserCallback(id,name){
            $("#empId").val(id);
            $("#employeeName").val(name);
        }
	</script>
</head>
<body>
	<c:if test="${tagFlag == 0}">
		<ul class="nav nav-tabs">
			<li  class="active"><a href="${ctx}/erp/allOrder/list">全部订单列表</a></li>
		</ul><br/>
		<ul class="nav nav-tabs">
			<li><a href="${ctx}/erp/allOrder/form?id=${order.id}&&studentId=${order.student.id}&&tagFlag=${tagFlag}">订单信息</a></li>
			<li><a href="${ctx}/erp/allOrder/customerInfo?id=${order.id}&&studentId=${order.student.id}&&tagFlag=${tagFlag}">
				<c:if test="${order.orderType == 1}">
					学生信息
				</c:if>
				<c:if test="${order.orderType == 2}">
					客户信息
				</c:if>
			</a></li>
			<li  class="active"><a href="${ctx}/erp/allOrder/contractInfo?id=${order.id}&&studentId=${order.student.id}&&tagFlag=${tagFlag}">合同信息</a></li>
			<li><a href="${ctx}/erp/allOrder/receivableBillsInfo?id=${order.id}&&studentId=${order.student.id}&&tagFlag=${tagFlag}">结算信息</a></li>
				<%--<li><a href="${ctx}/erp/allOrder/form?orderId=${order.id}">服务信息</a></li>--%>
		</ul>
	</c:if>
	<c:if test="${tagFlag == 1}">
		<ul class="nav nav-tabs">
			<li  class="active"><a href="${ctx}/erp/allOrder/contractInfo?id=${order.id}&&tagFlag=${tagFlag}">合同信息</a></li>
			<li><a href="${ctx}/erp/allOrder/receivableBillsInfo?id=${order.id}&&tagFlag=${tagFlag}">财务信息</a></li>
		</ul><br/>
	</c:if>
	<form:form id="inputForm" modelAttribute="order" action="${ctx}/erp/allOrder/contractInfo" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<table style="width: 80%">
			<c:if test="${order.orderType == 1}">
				<tr>
					<td>

						<div class="control-group">
							<label class="control-label">学生姓名：</label>
							<div class="controls">
								<form:input path="student.name" htmlEscape="false" maxlength="200" class="required input-xlarge " style="width:230px" value="${order.student.name}" readonly="true"/>
								<span class="help-inline"><font color="red">*</font> </span>
							</div>
						</div>
					</td>
					<td>
						<div class="control-group">
							<label class="control-label">学生编号：</label>
							<div class="controls">
								<form:input path="student.stuNumber" htmlEscape="false" maxlength="200" class="required input-xlarge " style="width:230px"  value="${order.student.stuNumber}" readonly="true"/>
								<span class="help-inline"><font color="red">*</font> </span>
							</div>
						</div>
					</td>
				</tr>
			</c:if>
			<c:if test="${order.orderType == 2}">
				<tr>
					<td>

						<div class="control-group">
							<label class="control-label">客户姓名：</label>
							<div class="controls">
								<form:input path="customer.name" htmlEscape="false" maxlength="200" class="required input-xlarge " style="width:230px" value="${order.customer.name}" readonly="true"/>
								<span class="help-inline"><font color="red">*</font> </span>
							</div>
						</div>
					</td>
					<td>
						<div class="control-group">
							<label class="control-label">客户编号：</label>
							<div class="controls">
								<form:input path="customer.code" htmlEscape="false" maxlength="200" class="required input-xlarge " style="width:230px"  value="${order.customer.code}" readonly="true"/>
								<span class="help-inline"><font color="red">*</font> </span>
							</div>
						</div>
					</td>
				</tr>
			</c:if>

			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">合同名称：</label>
						<div class="controls">
							<form:input path="contract.title" htmlEscape="false" maxlength="200" class="required input-xlarge " style="width:230px" value="${order.contract.title}" readonly="true"/>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">合同编号：</label>
						<div class="controls">
							<form:input path="contract.code" htmlEscape="false" maxlength="200" class="required input-xlarge " style="width:230px" value="${order.contract.code}" readonly="true"/>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">签约日期：</label>
						<div class="controls">
							<input name="contract.signTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate " style="width:230px"
								   value="<fmt:formatDate value="${order.contract.signTime}" pattern="yyyy-MM-dd"/>"/>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div class="control-group">
						<label class="control-label">合同备注：</label>
						<div class="controls">
							<form:textarea path="contract.remark" htmlEscape="false" rows="4" maxlength="200" class="required input-xxlarge " style="width: 800px;" value="${order.contract.remark}" readonly="true"/>
						</div>
					</div>
				</td>
			</tr>
		</table>
		<table style="width: 80%">
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label" >订单金额合计:</label>
						<div class="controls">
							<form:input path="overallAmount" id="overallAmount"  value="${order.overallAmount}"  class="required digits valid" readonly="true" style="width: 100px;" />&nbsp;元
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label" >优惠金额:</label>
						<div class="controls">
							<form:input path="favorableAmount" id="favorableAmount" value="${order.favorableAmount}" class="required money valid" readonly="true" style="width: 100px;"/>&nbsp;元
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">支付金额:</label>
						<div class="controls">
							<form:input path="paymentAmount" id="paymentAmount"   value="${order.paymentAmount}" class="required money valid" readonly="true" style="width: 100px;"/>&nbsp;元
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
			</tr>
		</table>
	</form:form>
</body>
</html>
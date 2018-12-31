<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>员工加班管理</title>
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
            var jbox;
            $("#selectOrder").click(function () {
                jbox =  top.$.jBox.open("iframe:/crm/dispatch/findServiceOrderList", "选择订单", 1024, 520);
            });
            var jbox;
            $("#selectEmployee").click(function () {
                jbox =  top.$.jBox.open("iframe:/crm/employeeLeave/selectEmployee", "选择服务人员", 1024, 520);
            });
		});
        function selectEmployeeCallback(employeeId,name,code,phone,profession){
            console.log("#btnSelect"+employeeId+name,code,phone,profession);

            $("#employeeId").val(employeeId);
            $("#name").val(name);
            $("#code").val(code);
            $("#phone").val(phone);
            $("#profession").val(profession);
        }
        function selectOrderCallback(orderid,orderCode,cunNames,cunPhone,skillName){
            console.log("#btnSelect"+orderid+orderCode,cunNames,cunPhone,skillName);

            $("#orderid").val(orderid);
            $("#orderCode").val(orderCode);
            $("#cunNames").val(cunNames);
            $("#cunPhone").val(cunPhone);
            $("#skillName").val(skillName);
        }
	</script>
</head>
<body>
<ul class="nav nav-tabs">
	<li class="active"><a href="${ctx}/crm/employeework/list">服务确认</a></li>
	<li><a href="${ctx}/crm/employeeLeave/list">服务人员请假</a></li>
	<li><a href="${ctx}/crm/employeeOvertime/list">服务人员加班</a>
</ul><br/>
	<form:form id="inputForm" modelAttribute="employeeLeave" action="${ctx}/crm/employeeOvertime/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
	<table>
		<tr>
			<div class="control-group" style="float : left;">
				<label class="control-label">服务人员姓名：</label>
				<div class="controls">
					<input type="hidden" name="employee.id" id="employeeId" value="${employeeLeave.employee.id}">
					<input  type="text"  name="employee.name" id="name" value="${employeeLeave.employee.name}"
							style="width:150px;" class="required input-large " placeholder="选择服务人员" readonly=readonly/>&nbsp;&nbsp;&nbsp;&nbsp;
					<input id="selectEmployee" class="btn btn-primary" type="button" value="选择服务人员"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
		</tr>
		<tr>
			<div class="control-group" >
				<label class="control-label">服务人员编号：</label>
				<div class="controls">
					<input type="text" value="${employeeLeave.employee.code}" id="code" readonly="readonly" style="width: 200px;">
				</div>
			</div>
		</tr>
		<tr>
			<div class="control-group" style="float : left;">
				<label class="control-label">服务人员手机号码：</label>
				<div class="controls">
					<input type="text" value="${employeeLeave.employee.phone}" id="phone" readonly="readonly" style="width: 200px;">
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">服务人员类别：</label>
				<div class="controls">
					<input type="text" value="${erp:getCommonsTypeName(employeeLeave.employee.profession)}" id="profession" readonly="readonly">
				</div>
			</div>
		</tr>
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">服务订单：</label>
						<div class="controls">
							<input  type="hidden"  name="dispatch.id" id="orderid" value="${employeeLeave.dispatch.id}">
							<input  type="text"  name="employee.order.orderCode" id="orderCode" value="${employeeLeave.orderItem.order.orderCode}"
									style="width:150px;" class="required input-large " placeholder="选择订单" readonly=readonly/>&nbsp;&nbsp;
							<input id="selectOrder" class="btn btn-primary" type="button" value="选择服务订单"/>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">客户姓名：</label>
					<div class="controls">
						<input type="text" value="${employeeLeave.customer.name}" id="cunNames" readonly="readonly"/>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">客户手机号码：</label>
					<div class="controls">
						<input type="text" value="${employeeLeave.customer.phone}" id="cunPhone" readonly="readonly"/>
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="control-group" style="float : left;">
					<label class="control-label">服务项目：</label>
					<div class="controls">
						<input type="text" value="${employeeLeave.dispatch.skill.skillName}" id="skillName" readonly="readonly" style="width: 200px;">
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">开始时间：</label>
					<div class="controls">
						<input name="startTime" type="text" readonly="readonly" maxlength="20" class="required input-medium Wdate " style="width: 200px"
							value="<fmt:formatDate value="${employeeLeave.startTime}" pattern="yyyy-MM-dd HH:mm"/>"
							onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});" />
						<span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>
			</td>
			<td>
				<div class="control-group" style="float : left;">
					<label class="control-label">结束时间：</label>
					<div class="controls">
						<input name="endTime" type="text" readonly="readonly" maxlength="20" class="required input-medium Wdate " style="width: 200px"
							value="<fmt:formatDate value="${employeeLeave.endTime}" pattern="yyyy-MM-dd HH:mm"/>"
							onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});" />
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<div class="control-group">
					<label class="control-label">加班事由：</label>
					<div class="controls">
						<form:textarea path="reason" htmlEscape="false" maxlength="1024" rows="3" style="width:800px;"/>
					</div>
				</div>
			</td>
		</tr>
			<%--<c:if test="${employeeLeave.id != null}">
				<div class="control-group">
					<label class="control-label">状态：</label>
					<div class="controls">
						<form:select path="status" class="input-large ">
							<form:options items="${erp:employeeLeaveStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
						</form:select>
					</div>
				</div>
			</c:if>--%>
		<tr>
			<td>
			<div class="form-actions">
				<shiro:hasPermission name="crm:employeeLeave:save"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
				<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
			</div>
			</td>
		</tr>
	</table>
	</form:form>
</body>
</html>
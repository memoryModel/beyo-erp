<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>服务人员加班审批</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
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
		});
        <c:if test="${!empty readonly}">
        var readonly = ${readonly};
        </c:if>
        <c:if test="${empty readonly}">
        var readonly = false;
        </c:if>


	</script>
</head>
<body>

	<ul class="nav nav-tabs">
		<li class="active">
			<c:if test="${employeeLeave.category == 2}">
				<a href="${ctx}/crm/employeeLeave/getEmployeeLeaveInfo?id=${employeeLeave.id}">加班审批</a>
			</c:if>
			<c:if test="${employeeLeave.category == 1}">
				<a href="${ctx}/crm/employeeLeave/getEmployeeLeaveInfo?id=${employeeLeave.id}">请假审批</a>
			</c:if>
		</li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="employeeLeave" action="${ctx}/crm/employeeOvertime/agree" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
	<table>
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">服务人员姓名：</label>
					<div class="controls">
						<input type="text" value="${employeeLeave.employee.name}" id="employee.name" readonly="readonly" style="width: 200px;">
					</div>
				</div>
			</td>
			<td>
				<div class="control-group">
					<label class="control-label">服务人员编号：</label>
					<div class="controls">
						<input type="text" value="${employeeLeave.employee.code}" id="employee.code" readonly="readonly" style="width: 200px;">
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">服务人员类别：</label>
					<div class="controls">
						<input type="text" value="${employeeLeave.employee.profession}" id="employee.profession" readonly="readonly" style="width: 200px;">
					</div>
				</div>
			</td>
			<td>
				<div class="control-group">
					<label class="control-label">服务人员手机号码：</label>
					<div class="controls">
						<input type="text" value="${employeeLeave.employee.phone}" id="employee.phone" readonly="readonly" style="width: 200px;">
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">订单编号：</label>
					<div class="controls">
						<input type="text" value="${employeeLeave.order.orderCode}" id="orderCode" readonly="readonly" style="width: 200px;">
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
			</td>
			<td>
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
						<input type="text" value="${employeeLeave.skill.skillName}" id="skillName" readonly="readonly" style="width: 200px;">
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">开始时间：</label>
					<div class="controls">
						<input name="startTime" type="text" readonly="readonly" maxlength="20"  style="width: 200px"
							   value="<fmt:formatDate value="${employeeLeave.startTime}" pattern="yyyy-MM-dd HH:mm"/>"/>
					</div>
				</div>
			</td>
			<td>
				<div class="control-group">
					<label class="control-label">结束时间：</label>
					<div class="controls">
						<input name="endTime" type="text" readonly="readonly" maxlength="20" style="width: 200px"
							value="<fmt:formatDate value="${employeeLeave.endTime}" pattern="yyyy-MM-dd HH:mm"/>"/>
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="control-group" style="float : left;">
					<label class="control-label">小时：</label>
					<div class="controls">
						<input type="text" value="${employeeLeave.hours}" id="hours" readonly="readonly" style="width: 200px;">
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<div class="control-group">
					<label class="control-label">事由：</label>
					<div class="controls">
						<form:textarea path="reason" htmlEscape="false" maxlength="1024" rows="3" style="width:800px;" readonly="true"/>
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">状态：</label>
					<div class="controls">
						<input type="text" value="${erp:employeeLeaveStatusName(employeeLeave.status)}" id="status" readonly="readonly" style="width: 200px;">
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">管理老师审批：</label>
					<div class="controls">
						<input type="radio" name="status" value="4">生效
						<input type="radio" name="status" value="5">作废
						<span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<div class="control-group">
					<label class="control-label">审批意见:</label>
					<div class="controls">
						<form:textarea path="approveReason" htmlEscape="false" maxlength="1024" rows="3" style="width:800px;"/>
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">审批时间：</label>
					<div class="controls">
						<input name="approveTime" type="text" readonly="readonly" maxlength="20" class="required input-medium Wdate " style="width: 200px"
							   value="<fmt:formatDate value="${employeeLeave.approveTime}" pattern="yyyy-MM-dd HH:mm"/>"
							   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});" />
						<span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td>
			<td><c:if test="${empty readonly}">
				<shiro:hasPermission name="crm:employeeLeave:save">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="提 交"/>&nbsp;
				</shiro:hasPermission>
				</c:if>
				<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
			</td>
		</tr>
	</table>
	</form:form>
</body>
</html>
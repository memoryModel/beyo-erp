<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>员工续约审批管理</title>
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
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/crm/employeeRenew/approved?id=${employeeRenew.id}">员工续约审批</a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="employeeRenew" action="${ctx}/crm/employeeRenew/approvedRenew" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="alert alert-info" style="margin-bottom:15px;"><strong><h4>员工基本信息</h4></strong></div>
		<div class="control-group">
			<table class="table table-striped table-bordered table-condensed" style="width: 90%; text-align:left; margin:auto" border="1" cellpadding="2" cellspacing="1">
				<tr>
					<td>姓名</td>
					<td>性别</td>
					<td>手机号码</td>
					<td>工种</td>
					<td>来源</td>
					<td>出生日期</td>
				</tr>
				<tr>
					<td>${employeeRenew.employeeEntry.employee.name}</td>
					<td>${erp:sexStatusName(employeeRenew.employeeEntry.employee.sex)}</td>
					<td>${employeeRenew.employeeEntry.employee.phone}</td>
					<td>${erp:getCommonsTypeName(employeeRenew.employeeEntry.employee.profession)}</td>
					<td>${employeeRenew.employeeEntry.employee.customerResource.customerName}</td>
					<td><fmt:formatDate value="${employeeRenew.employeeEntry.employee.birthTime}" pattern="yyyy-MM-dd HH:mm"/></td>
				</tr>
			</table>
		</div>
		<div class="alert alert-info" style="margin-bottom:15px;"><strong><h4>员工定级和技能项信息</h4></strong></div>
		<div class="alert alert-info" style="margin-bottom:15px;"><strong><h4>薪资结构</h4></strong></div>
		<div class="control-group">
			<label class="control-label"><span class="help-inline"><font color="red">*</font> </span> &nbsp;员工性质：</label>
			<div class="controls">
				<form:input path="" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><span class="help-inline"><font color="red">*</font> </span> &nbsp;有无底薪：</label>
			<div class="controls">
				<form:select path="employeeEntry.basePayStatus" htmlEscape="false" style="width: 100px">
					<form:options items="${erp:basePayStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false" />
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><span class="help-inline"><font color="red">*</font> </span> &nbsp;底薪：</label>
			<div class="controls">
				<form:input path="employeeEntry.baseAmount" htmlEscape="false" readonly="true" maxlength="64" class="input-xlarge "  style="width: 50px;text-align: right;"/> &nbsp;元/月
			</div>
		</div>
		<div class="alert alert-info" style="margin-bottom:15px;"><strong><h4>持续周期</h4></strong></div>
		<div class="control-group">
			<label class="control-label"><font color="red">*</font> </span> &nbsp;原合同编号：</label>
			<div class="controls">
				<form:input path="employeeEntry.contractCode"  htmlEscape="false" readonly="true" class="required input-xlarge"  maxlength="64" style="width: 163px"/>
			</div>
		</div>
		<div class="control-group" style="float:left;">
			<label class="control-label"><font color="red">*</font> </span> &nbsp;签约生效日期：</label>
			<div class="controls">
				<input name="employeeEntry.takeTime" type="text" readonly="readonly" disabled="disabled" maxlength="20" class="input-medium Wdate "
					   value="<fmt:formatDate value="${employeeRenew.employeeEntry.takeTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><font color="red">*</font> </span> &nbsp;签约截止日期：</label>
			<div class="controls">
				<input name="employeeEntry.deadlineTime" type="text" disabled="disabled" readonly="readonly" maxlength="20" class="input-medium Wdate "
					   value="<fmt:formatDate value="${employeeRenew.employeeEntry.deadlineTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><font color="red">*</font> </span> &nbsp;续约合同编号：</label>
			<div class="controls">
				<form:input path="contractExtensionCode" htmlEscape="false" readonly="true" class="required input-xlarge"  maxlength="64" style="width: 163px"/>
			</div>
		</div>
		<div class="control-group" style="float:left;">
			<label class="control-label"><font color="red">*</font> </span> &nbsp;续约生效日期：</label>
			<div class="controls">
				<input name="extensionStartDate" type="text" readonly="readonly" disabled="disabled" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${employeeRenew.extensionStartDate}" pattern="yyyy-MM-dd "/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd ',isShowClear:true});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><font color="red">*</font> </span> &nbsp;续约截止日期：</label>
			<div class="controls">
				<input id="extensionEndDate" name="extensionEndDate" type="text" readonly="true" disabled="disabled" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${employeeRenew.extensionEndDate}" pattern="yyyy-MM-dd "/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd ',isShowClear:true});"/>
			</div>
		</div>
		<div class="control-group" style="float:left;">
			<label class="control-label"><font color="red">*</font> </span> &nbsp;续约操作人：</label>
			<div class="controls">
				<sys:treeselect id="user" name="user.id" disabled="disabled" value="${employeeRenew.user.id}"
								labelName="user.name" labelValue="${employeeRenew.user.name}"
								title="选择用户" url="/sys/office/treeData?type=3" notAllowSelectParent="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><font color="red">*</font> </span> &nbsp;操作时间：</label>
			<div class="controls">
				<input name="createTime" type="text" readonly="readonly" disabled="disabled" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${employeeRenew.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
			</div>
		</div>
		<div class="alert alert-info" style="margin-bottom:15px;"><center><strong><h4>审批意见</h4></strong></center></div>
		<div class="control-group">
			<label class="control-label"><span class="help-inline"><font color="red">*</font> </span> &nbsp;审批结果：</label>
			<div class="controls">
				<form:select path="approvedStatus" htmlEscape="false" style="width: 100px">
					<form:options items="${erp:approvedRenewList()}" itemLabel="name" itemValue="value" htmlEscape="false" />
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><span class="help-inline"><font color="red">*</font> </span> &nbsp;审批意见</label>
			<div class="controls">
				<form:textarea id="approvedOpinion" path="approvedOpinion" htmlEscape="false" maxlength="200" class="input-xlarge " rows="3" style="width: 620px;"/>
			</div>
		</div>
		<div class="control-group" style="float:left;">
			<label class="control-label"><font color="red">*</font> </span> &nbsp;审批人：</label>
			<div class="controls">
				<sys:treeselect id="approvedUser" name="approvedUser.id" value="${employeeRenew.approvedUser.id}"
								labelName="approvedUser.name" labelValue="${employeeRenew.approvedUser.name}"
								title="选择用户" url="/sys/office/treeData?type=3" notAllowSelectParent="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><font color="red">*</font> </span> &nbsp;审批时间：</label>
			<div class="controls">
				<input name="approvedTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					   value="<fmt:formatDate value="${employeeRenew.approvedTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
			</div>
		</div>
		<div class="form-actions">
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="提交审批意见"/>&nbsp;
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>
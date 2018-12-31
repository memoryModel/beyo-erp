<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>员工入职签约管理管理</title>
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
<%--
		<li><shiro:hasPermission name="crm:entry:list"><a href="${ctx}/crm/entry/list">入职签约管理</a></shiro:hasPermission></li>
--%>
		<li class="active"><shiro:hasPermission name="crm:entry:info"><a href="${ctx}/crm/entry/info?id=${entry.id}">详细信息</a></li></shiro:hasPermission>
		<li><shiro:hasPermission name="erp:employeeResume:experienceInfo"><a href="${ctx}/erp/employeeResume/view?employeeId=${entry.employee.id}&entryId=${entry.id}">资历信息</a></shiro:hasPermission></li>
		<li><shiro:hasPermission name="erp:employeeInfo:getEmployeeExperienceInfo"><a href="${ctx}/erp/employeeResume/viewSchool?employeeId=${entry.employee.id}&entryId=${entry.id}">培训信息</a></shiro:hasPermission></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="entry" action="${ctx}/crm/entry/saves" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="alert alert-info">基本信息</div>

		<div class="control-group">
			<table>
				<tr>
					<td>
						<div class="control-group">
							<label class="control-label">性别：</label>
							<div class="controls">
								<form:select path="employee.sex" class="required input-large" disabled="true">
									<form:options items="${erp:sexStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false" />
								</form:select>
							</div>
						</div>
					</td>
					<td>
						<div class="control-group">
							<label class="control-label">出生日期：</label>
							<div class="controls">
								<input name="employee.birthTime" type="text" readonly="readonly" maxlength="20" class="input-medium "
									   value="<fmt:formatDate value="${entry.employee.birthTime}" pattern="yyyy-MM-dd"/>"/>
							</div>
						</div>
					</td>
					<td>
						<div class="control-group">
							<label class="control-label">身份证号：</label>
							<div class="controls">
								<form:input path="employee.idcard" htmlEscape="false" maxlength="50"  class=" card input-large "   readonly="true"/>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="control-group">
							<label class="control-label">民族：</label>
							<div class="controls">
								<form:select path="employee.nation" class="required input-large" disabled="true">
									<form:options items="${erp:getCommonsTypeList(43)}" itemLabel="commonsName" itemValue="id" htmlEscape="false" />
								</form:select>
							</div>
						</div>
					</td>
					<td>
						<div class="control-group">
							<label class="control-label">学历：</label>
							<div class="controls">
								<form:select path="employee.education" class="required input-large" disabled="true">
									<form:options items="${erp:getCommonsTypeList(7)}" itemLabel="commonsName" itemValue="id" htmlEscape="false" />
								</form:select>
							</div>
						</div>
					</td>
					<td>
						<div class="control-group">
							<label class="control-label">婚姻状况：</label>
							<div class="controls">
								<form:select path="employee.marriage" class="required input-large " disabled="true">
									<form:options items="${erp:marriageStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false" />
								</form:select>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="control-group">
							<label class="control-label">星座：</label>
							<div class="controls">
								<form:input path="employee.constellation" htmlEscape="false" maxlength="50"  class="required input-large "   readonly="true"/>

							</div>
						</div>
					</td>
					<td>
						<div class="control-group">
							<label class="control-label">血型：</label>
							<div class="controls">
								<form:input path="employee.blood" htmlEscape="false" maxlength="50"  class="required input-large "   readonly="true"/>

							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="control-group">
							<label class="control-label">紧急联系人：</label>
							<div class="controls">
								<form:input path="employee.emergencyContact" htmlEscape="false" maxlength="50" class="required input-large " readonly="true"/>

							</div>
						</div>
					</td>
					<td>
						<div class="control-group">
							<label class="control-label">紧急联系人电话：</label>
							<div class="controls">
								<form:input path="employee.emergencyContactPhone" htmlEscape="false" maxlength="50" class="required mobile input-large" readonly="true"/>

							</div>
						</div>
					</td>
				</tr>
				<td>
					<div class="control-group">
						<label class="control-label">籍贯：</label>
						<div class="controls">
								${entry.employee.originalArea.name}

						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">籍贯地址：</label>
						<div class="controls">
							<form:input path="employee.originalStreet" htmlEscape="false"  maxlength="1024" class="required input-large " readonly="true"/>

						</div>
					</div>
				</td>
				</tr>
				<tr>
					<td>
						<div class="control-group">
							<label class="control-label">现居住地：</label>
							<div class="controls">
									${entry.employee.currentArea.name}

							</div>
						</div>
					</td>
					<td>
						<div class="control-group">
							<label class="control-label">现居住地地址：</label>
							<div class="controls">
								<form:input path="employee.currentStreet" htmlEscape="false"  maxlength="1024" class="required input-large " readonly="true"/>

							</div>
						</div>
					</td>
				</tr>
			</table>
		</div>

	<div class="form-actions">
		<shiro:hasPermission name="erp:employee:edit">&nbsp;</shiro:hasPermission>
		<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
	</div>
	</form:form>
</body>
</html>
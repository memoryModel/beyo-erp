<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>员工入职签约审批</title>
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
		<li><shiro:hasPermission name="crm:entryApprove:list"><a href="${ctx}/crm/entryApprove/list/">员工入职审批列表</a></shiro:hasPermission></li>
		<li  class="active"><shiro:hasPermission name="crm:entryApprove:getEmployeeInfo"><a href="${ctx}/crm/entryApprove/getEmployeeInfo?employeeId=${entry.employee.id}&&id=${entry.id}">员工入职签约审批</a></shiro:hasPermission></li>
		<li><shiro:hasPermission name="crm:entryApprove:getEmployeeExperienceInfo"><a href="${ctx}/crm/entryApprove/getEmployeeExperienceInfo?employeeId=${entry.employee.id}&&id=${entry.id}">资历信息</a></shiro:hasPermission></li>
		<li><shiro:hasPermission name="crm:entryApprove:getEmployeeAuthenticationInfo"><a href="${ctx}/crm/entryApprove/getEmployeeAuthenticationInfo?employeeId=${entry.employee.id}&&id=${entry.id}">认证信息</a></shiro:hasPermission></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="entry" action="${ctx}/crm/entry/saves" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="alert alert-info">基本信息</div>
		<table>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">员工编号：</label>
						<div class="controls">
								${entry.employee.code}
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">姓名：</label>
						<div class="controls">
							<form:input path="employee.name" htmlEscape="false" maxlength="50" class="input-large "  readonly="true" style="width:210px;" value="${entry.employee.name}"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">电话：</label>
						<div class="controls">
							<form:input path="employee.phone" htmlEscape="false" maxlength="50" class="input-large "  readonly="true" style="width:210px;" value="${entry.employee.phone}"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">身份证号：</label>
						<div class="controls">
							<form:input path="employee.idcard" htmlEscape="false" maxlength="50" class="input-large "  readonly="true" style="width:210px;" value="${entry.employee.idcard}"/>
						</div>
					</div>
				</td>
		    </tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">婚姻状态：</label>
						<div class="controls">
							<form:input path="employee.maritalStatus" htmlEscape="false" maxlength="50" class="input-large " readonly="true" style="width:210px;" value="${erp:marriageStatusName(entry.employee.maritalStatus)}"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">员工出生日期：</label>
						<div class="controls">
							<input name="birthTime" type="text" readonly="readonly" maxlength="20"  style="width:210pxpx;"
								   value="<fmt:formatDate value="${employee.birthTime}" pattern="yyyy-MM-dd"/>"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">最高学历：</label>
						<div class="controls">
							<form:input path="employee.education" htmlEscape="false" maxlength="50" class="input-large " readonly="true" style="width:210px;" value="${entry.employee.highestEducation.commonsName}"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">民族：</label>
						<div class="controls">
							<form:input path="employee.nation.id" htmlEscape="false" maxlength="20" class="input-large" style="width:210px;" readonly="true" value="${entry.employee.nation.commonsName}"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">籍贯：</label>
						<div class="controls">
							<form:input path="employee.originalArea.id" htmlEscape="false" maxlength="20" class="input-large" style="width:210px;" readonly="true" value="${entry.employee.originalArea.name}"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">详细地址：</label>
						<div class="controls">
							<form:input path="employee.originalStreet" htmlEscape="false"  maxlength="1024" readonly="true" class="input-xlarge " style="width:210px;"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">紧急联系人：</label>
						<div class="controls">
							<form:input path="employee.emergencyContact" htmlEscape="false" maxlength="50" class="input-large " style="width:210px;" readonly="true" value="${entry.employee.emergencyContact}"/>

						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">紧急联系电话：</label>
						<div class="controls">
							<form:input path="employee.emergencyContactPhone" htmlEscape="false" maxlength="50" readonly="true" class="input-large " style="width:210px;"  value="${entry.employee.emergencyContactPhone}"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">来源：</label>
						<div class="controls">
							<form:input path="employee.customerResource.id" htmlEscape="false" maxlength="50" class="input-large " style="width:210px;" readonly="true" value="${entry.employee.customerResource.customerName}"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">血型：</label>
						<div class="controls">
							<form:input path="employee.blood" htmlEscape="false" readonly="true" maxlength="50" class="input-xlarge " style="width:210px;" value="${entry.employee.blood}"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">年龄：</label>
						<div class="controls">
							<form:input path="employee.age" htmlEscape="false" readonly="true" maxlength="50" class="input-xlarge " style="width:210px;" value="${entry.employee.age}"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">座右铭：</label>
						<div class="controls">
							<form:input path="employee.motto" htmlEscape="false" readonly="true" maxlength="50" class="input-xlarge " style="width:210px;" value="${entry.employee.motto}"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">爱好：</label>
						<div class="controls">
							<form:input path="employee.hobby" htmlEscape="false" readonly="true" maxlength="50" class="input-xlarge " style="width:210px;" value="${entry.employee.hobby}"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">工种：</label>
						<div class="controls">
							<form:checkboxes path="employee.profession" items="${erp:getCommonsTypeList(21)}" itemLabel="commonsName" itemValue="id" htmlEscape="false" class="required"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">外语种类：</label>
						<div class="controls">
							<form:input path="employee.language" htmlEscape="false" readonly="true" maxlength="50" class="input-xlarge " style="width:210px;" value="${entry.employee.language}"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">外语等级：</label>
						<div class="controls">
							<form:input path="employee.englishLevel.id" htmlEscape="false" maxlength="50" class="input-large " readonly="true" style="width:210px;" value="${entry.employee.englishLevel.commonsName}"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">是否住宿：</label>
						<div class="controls">
							<input type="radio"  name="employee.dormStatus"  value="1" <c:if test="${entry.employee.dormStatus == 1}">checked</c:if>/>住宿
							<input type="radio"  name="employee.dormStatus"  value="0" <c:if test="${entry.employee.dormStatus == 0}">checked</c:if>/>不住宿
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">星座：</label>
						<div class="controls">
							<form:input path="employee.constellation" htmlEscape="false" readonly="true" maxlength="50" class="input-xlarge " style="width:210px;" value="${entry.employee.constellation}"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">服务城市：</label>
						<div class="controls">
							<form:input path="employee.serveCity" htmlEscape="false" readonly="true" maxlength="50" class="input-xlarge " style="width:210px;" value="${entry.employee.serveCity}"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">服务年限：</label>
						<div class="controls">
							<form:input path="employee.serviceTime" htmlEscape="false" readonly="true" maxlength="50" class="input-xlarge " style="width:210px;" value="${entry.employee.serviceTime}"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">员工性质：</label>
						<div class="controls">
							<form:input path="employee.employeeNature" htmlEscape="false" readonly="true" maxlength="50" class="input-xlarge " style="width:210px;" value="${erp:erviceStatusName(entry.employee.employeeNature)}"/>
						</div>
					</div>
				</td>
			</tr>
		</table>

	<div class="alert alert-info">合同信息</div>
        <div class="control-group">
            <label class="control-label">合同编号：</label>
            <div class="controls">
                <form:input path="code" htmlEscape="false" maxlength="50" readonly="true" value="${entry.code}" class="input-xlarge " style="width: 180px"/>
            </div>
        </div>
	<div class="alert alert-info">财务信息</div>
		<table>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">有无欠款：</label>
						<div class="controls">
							<form:input path="debtStatus" htmlEscape="false" maxlength="50" class="input-large " readonly="true" style="width:150px;" value="${erp:debtStatusName(entry.debtStatus)}"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">底薪(元): </label>
						<div class="controls">
							<form:input path="pay" htmlEscape="false" maxlength="50" class="input-large " readonly="true" style="width:150px;" value="${entry.pay}"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">工资卡号1: </label>
						<div class="controls">
							<form:input path="idCard" htmlEscape="false" maxlength="50" class="input-large " readonly="true" style="width:150px;" value="${entry.idCard}"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">所属银行1: </label>
						<div class="controls">
							<form:input path="bank" htmlEscape="false" maxlength="50" class="input-large " readonly="true"  style="width:150px;" value="${entry.bank}"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">工资卡号2: </label>
						<div class="controls">
							<form:input path="idCarda" htmlEscape="false" maxlength="50" class="input-large " readonly="true" style="width:150px;" value="${entry.idCarda}"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
					<label class="control-label">所属银行2: </label>
					<div class="controls">
						<form:input path="banka" htmlEscape="false" maxlength="50" class="input-large " readonly="true" style="width:150px;" value="${entry.banka}"/>
					</div>
					</div>
				</td>
			</tr>
		</table>

	<div class="alert alert-info">员工等级</div>
	<table  id="contentTable" class="table table-striped table-bordered table-condensed" style="width: 50%;">
		<thead>
		<tr>
			<th>基础服务技能项</th>
			<th>等级</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${employeeSkillList}" var="employeeSkill">
			<tr>
				<td>${employeeSkill.skill.skillName}</td>
				<td>${employeeSkill.serviceLevel.name}</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>

		<div class="alert alert-info">员工升降级记录</div>
		<table id="contentTable" class="table table-striped table-bordered table-condensed" style="width:90%;">
			<thead>
			<tr>
				<th>基础服务技能项</th>
				<th>原等级</th>
				<th>评测后级别</th>
				<th>原服务介绍价格</th>
				<th>测评后服务结算价格</th>
				<th>测评人</th>
				<th>测评时间</th>
				<th>测评结果</th>
				<th>审批人</th>
				<th>审批时间</th>
				<th>审批意见</th>
			</tr>
			</thead>
			<tbody>
			<c:forEach items="${employeeLevelApproveList}" var="employeeLevelApprove">
				<tr>
					<td>
							${employeeLevelApprove.skill.skillName}
					</td>
					<td>
							${employeeLevelApprove.serviceLevel.name}
					</td>
					<td>
						<%--	${employeeLevelApprove.serviceLevelLater.name}--%>
									${employeeLevelApprove.employeeSkill.serviceLevel.name}
					</td>
					<td>
							${employeeLevelApprove.employeeSkill.servicePrice}
					</td>

					<td>
							${employeeLevelApprove.newLevelAmount}
					</td>
					<td>
							${employeeLevelApprove.testName.name}
					</td>
					<td>
							<fmt:formatDate value="${employeeLevelApprove.evaluationTime}" pattern="yyyy-MM-dd HH:mm"/>
					</td>
					<td>
							${employeeLevelApprove.testResult}
					</td>
					<td>
							${employeeLevelApprove.approveName.name}
					</td>
					<td>
							<fmt:formatDate value="${employeeLevelApprove.approveTime}" pattern="yyyy-MM-dd HH:mm"/>
					</td>
					<td>
							${employeeLevelApprove.approveReason}
					</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>

		<div class="alert alert-info">技能项</div>
		<table  id="contentTable" class="table table-striped table-bordered table-condensed" style="width:50%;">
			<thead>
			<tr>
				<th>技能名称</th>
				<th>计价单位</th>
				<th>类型</th>
				<th>结算价格(元)</th>
			</tr>
			</thead>
			<tbody>
			<c:forEach items="${employeeSkillList1}" var="employeeSkill">
				<tr>
					<td>${employeeSkill.skill.skillName}</td>
					<td>${employeeSkill.skill.unit}</td>
					<td>${employeeSkill.skill.category}</td>
					<td>${employeeSkill.servicePrice}</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">基础服务结算方式：</label>
					<div class="controls">
						<c:if test="${entry.sttleStatus == 1}">按商品结算价结算</c:if>
						<c:if test="${entry.sttleStatus == 0}">按星级日薪结算</c:if>
					</div>

				</div>
			</td>
		</tr>

		<div class="alert alert-info">视频秀</div>
		<table style="width: 500px; height: 150px;">
			<tbody>
			<c:forEach items="${employeeInfoList}" var="employeeInfo">
				<c:if test="${employeeInfo.type == 4}">
					<tr>
						<td><img src='${employeeInfo.url}@100w_100h'/></td>
					</tr>
				</c:if>
			</c:forEach>
			</tbody>
		</table>
		<div class="alert alert-info">作品秀</div>
		<table>
			<tbody>
			<c:forEach items="${employeeInfoList}" var="employeeInfo">
				<c:if test="${employeeInfo.type == 5}">
					<tr>
						<td><img src='${employeeInfo.url}@100w_100h'/></td>
					</tr>
				</c:if>
			</c:forEach>
			</tbody>
		</table>

	<div class="form-actions">
		<shiro:hasPermission name="erp:employee:edit">&nbsp;</shiro:hasPermission>
		<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
	</div>
	</form:form>
</body>
</html>
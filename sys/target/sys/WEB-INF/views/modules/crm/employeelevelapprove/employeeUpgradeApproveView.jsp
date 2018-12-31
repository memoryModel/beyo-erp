<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>员工升降级审批管理</title>
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
	<li class="active"><a href="${ctx}/crm/employeeGradeApprove/upgradedList">已升级列表</a></li>
</ul><br/>
<form:form id="inputForm" modelAttribute="employeeGrade" action="${ctx}/crm/employeeGradeApprove/save" method="post" class="form-horizontal">
<form:hidden path="id"/>
<sys:message content="${message}"/>
<div class="alert alert-info">审批意见</div>
<table class="table table-striped table-bordered table-condensed">
	<thead>
		<tr>
			<th>审批状态</th>
			<th>审批意见</th>
			<th>审批人</th>
			<th>审批时间</th>
		</tr>

	</thead>
	<tbody>
		<c:forEach items="${approveList}" var="approve">
			<tr>
				<td>${erp:getApproveResultName(approve.approveResult)}</td>
				<td>${approve.approveReason}</td>
				<td>${approve.approveUserName}</td>
				<td><fmt:formatDate value="${approve.approveTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			</tr>

		</c:forEach>
	</tbody>
</table>

<div class="control-group">
	<label class="control-label">员工信息：</label>
	<div class="controls">
		<form:input path="employee.name" htmlEscape="false" maxlength="20" class="required input-large  " readonly="true"/>
		<span class="help-inline"><font color="red">*</font> </span>
	</div>
</div>
<div class="control-group">
	<div class="alert alert-info">原等级详情</div>
	<table class="table table-striped table-bordered table-condensed">
		<thead>
		<tr>
			<th>基础服务技能</th>
			<c:forEach items="${weightList}" var="weight" varStatus="index">
				<th>${weight.checkName}得分</th>
			</c:forEach>
			<th>综合得分</th>
			<th>服务单数</th>
			<th>完美单数</th>
			<th>系统测评定级</th>
			<th>人工定级</th>
			<th>员工服务结算单价</th>
			<th>定级操作人</th>
			<th>定级生效时间</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${beforeGradeSkillList}" var="beforeGradeSkill">
		<tr>
			<td>
					${beforeGradeSkill.skill.skillName}
			</td>
			<c:forEach items="${beforeGradeSkill.skillWeightList}" var="skillWeight">
			<td>
					${skillWeight.weightScore}
			</td>
			</c:forEach>
			<td>
					${beforeGradeSkill.score}
			</td>
			<td>
					${beforeGradeSkill.serviceNumber}
			</td>
			<td>
					${beforeGradeSkill.perfectNumber}
			</td>
			<td>
					${beforeGradeSkill.systemServiceLevel.name}
			</td>
			<td>
					${beforeGradeSkill.serviceLevel.name}
			</td>
			<td>
					${beforeGradeSkill.servicePrice}元/${erp:unitStatusName(beforeGradeSkill.skill.unit)}
			</td>
			<td>
					${beforeGradeSkill.skillUser.name}
			</td>
			<td>
				<fmt:formatDate value="${beforeGradeSkill.skillTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
			</td>
			</c:forEach>
		</tbody>
	</table>
</div>
<div class="control-group">
	<div class="alert alert-info">升级后等级详情</div>
	<table class="table table-striped table-bordered table-condensed">
		<thead>
		<tr>
			<th>基础服务技能</th>
			<c:forEach items="${weightList}" var="weight" varStatus="index">
				<th>${weight.checkName}得分</th>
			</c:forEach>
			<th>综合得分</th>
			<th>服务单数</th>
			<th>完美单数</th>
			<th>系统测评定级</th>
			<th>人工定级</th>
			<th>员工服务结算单价</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${upgradeSkillList}" var="upgradeSkill">
		<tr>
			<td>
					${upgradeSkill.skill.skillName}
			</td>
			<c:forEach items="${upgradeSkill.skillWeightList}" var="skillWeight">
			<td>
					${skillWeight.weightScore}
			</td>
			</c:forEach>
			<td>
					${upgradeSkill.score}
			</td>
			<td>
					${upgradeSkill.serviceNumber}
			</td>
			<td>
				    ${upgradeSkill.perfectNumber}
		    </td>
			<td>
					${upgradeSkill.systemServiceLevel.name}
			</td>
			<td>
					${upgradeSkill.serviceLevel.name}
			</td>
			<td>
					${upgradeSkill.servicePrice}元/${erp:unitStatusName(upgradeSkill.skill.unit)}
			</td>
			</c:forEach>
		</tbody>
	</table>

	<div class="control-group">
		<label class="control-label">升级原因：</label>
		<div class="controls">
			<form:select path="upgradeReason" class="input-large" disabled="true">
				<form:options items="${erp:getCommonsTypeList(50)}"  itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
			</form:select>
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">定级生效时间：</label>
		<div class="controls">
			<input name="entryTime" type="text" readonly="readonly" maxlength="20" class="required input-medium Wdate "
				   value="<fmt:formatDate value="${employeeGrade.entryTime}" pattern="yyyy-MM-dd HH:mm"/>"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">备注：</label>
		<div class="controls">
			<form:textarea path="remark" htmlEscape="false" rows="4" maxlength="256" class="input-xxlarge " readonly="true"/>
		</div>
	</div>
	<table>
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">升级操作人：</label>
					<div class="controls">
						<form:input path="gradePersonName" htmlEscape="false" maxlength="20" class="required input-large  digits" disabled="true" />
						<span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>
			</td>
			<td>
				<div class="control-group">
					<label class="control-label">升级操作时间：</label>
					<div class="controls">
						<input name="gradeTime" type="text" readonly="readonly" maxlength="20" class="required input-medium Wdate " disabled="disabled"
							   value="<fmt:formatDate value="${employeeGrade.gradeTime}" pattern="yyyy-MM-dd HH:mm"/>"
							   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>
			</td>
		</tr>
	</table>

	<div class="form-actions">
		<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
	</div>
	</form:form>
</body>
</html>
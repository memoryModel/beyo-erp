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
	<li><a href="${ctx}/crm/employeeGradeApprove/downgradeApproveList">降级待审批</a></li>
</ul><br/>
<form:form id="inputForm" modelAttribute="employeeGrade" action="${ctx}/crm/employeeGradeApprove/downgradeApproveSave" method="post" class="form-horizontal">
<form:hidden path="id"/>
<input type="hidden" name="approveUser" value="${userId}">
<input type="hidden" name="approveTime" value="<fmt:formatDate value="${approveTime}" pattern="yyyy-MM-dd HH:mm"/>">

<sys:message content="${message}"/>
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
	<div class="alert alert-info">降级后等级详情</div>
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
		<c:forEach items="${downgradeSkillLit}" var="downgradeSkill">
		<tr>
			<td>
					${downgradeSkill.skill.skillName}
			</td>
			<c:forEach items="${downgradeSkill.skillWeightList}" var="skillWeight">
			<td>
					${skillWeight.weightScore}
			</td>
			</c:forEach>
			<td>
					${downgradeSkill.score}
			</td>
			<td>
					${downgradeSkill.serviceNumber}
			</td>
			<td>
					${downgradeSkill.perfectNumber}
			</td>
			<td>
					${downgradeSkill.systemServiceLevel.name}
			</td>
			<td>
					${downgradeSkill.serviceLevel.name}
			</td>
			<td>
					${downgradeSkill.servicePrice}元/${erp:unitStatusName(downgradeSkill.skill.unit)}
			</td>
			</c:forEach>
		</tbody>
	</table>

	<div class="control-group">
		<label class="control-label">降级原因：</label>
		<div class="controls">
			<form:select path="downgradeReason" class="input-large" disabled="true">
				<form:options items="${erp:getCommonsTypeList(51)}"  itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
			</form:select>
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">定级生效时间：</label>
		<div class="controls">
			<input name="entryTime" type="text" readonly="readonly" maxlength="20" class="required input-medium Wdate "
				   value="<fmt:formatDate value="${employeeGrade.entryTime}" pattern="yyyy-MM-dd HH:mm"/>"/>
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
					<label class="control-label">降级操作人：</label>
					<div class="controls">
						<form:input path="gradePersonName" htmlEscape="false" maxlength="20" class="required input-large  digits"  readonly="true" />
						<span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>
			</td>
			<td>
				<div class="control-group">
					<label class="control-label">降级操作时间：</label>
					<div class="controls">
						<input name="gradeTime" type="text" readonly="readonly" maxlength="20" class="required input-medium Wdate "
							   value="<fmt:formatDate value="${employeeGrade.gradeTime}" pattern="yyyy-MM-dd HH:mm"/>"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>
			</td>
		</tr>
	</table>
	<div class="alert alert-info">降级审批</div>
	<table>
		<tr>
			<td colspan="2">
				<div class="control-group">
					<label class="control-label">审批结果：</label>
					<div class="controls">
						<input type="radio" name="approveResult" checked value="1">审批通过
						<input type="radio" name="approveResult" value="2">退回
						<span class="help-inline" style="margin-left: 70px"><font color="red">*</font> </span>
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<div class="control-group">
					<label class="control-label">审批意见：</label>
					<div class="controls">
						<textarea name="approveReason" htmlEscape="false" rows="2"  class="required input-xxlarge " maxlength="1024"></textarea>
						<span class="help-inline" style="margin-left: 70px"><font color="red">*</font> </span>
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">审批人：</label>
					<div class="controls">
						<input name="approveUserName" type="text" htmlEscape="false" maxlength="20" class="required input-large" disabled="true" value="${userName}" />
						<span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>
			</td>
			<td>
				<div class="control-group">
					<label class="control-label">审批时间：</label>
					<div class="controls">
						<input name="approveTime" type="text" readonly="readonly" maxlength="20" class="required input-medium Wdate " disabled="disabled"
							   value="<fmt:formatDate value="${approveTime}" pattern="yyyy-MM-dd HH:mm"/>"
							   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>
			</td>
		</tr>
	</table>
	<div class="form-actions">
		<shiro:hasPermission name="crm:employeeGradeApprove:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
		<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
	</div>
	</form:form>
</body>
</html>
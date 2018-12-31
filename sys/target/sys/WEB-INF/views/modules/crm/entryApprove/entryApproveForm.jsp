<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>员工签约审批</title>
	<meta name="decorator" content="default"/>
    <script type="text/javascript">
        var array = new Array();
    </script>
</head>
<body>

<form:form id="inputForm" modelAttribute="entry" action="${ctx}/crm/employeeEntry/save?tagFlag=2" method="post" class="form-horizontal">
	<form:hidden path="id"/>
	<form:hidden path="employee.id" id="employeeId"/>
	<input type="hidden" name="entry.approveStatus" value="${entry.approveStatus}">
	<sys:message content="${message}"/>
	<div class="alert alert-info">员工签约</div>
	<div class="control-group">
	</div>
	<table class="table table-striped table-bordered table-condensed">
		<thead>
		<tr>
			<th>姓名</th>
			<th>性别</th>
			<th>手机号码</th>
			<th>工种</th>
			<th>来源</th>
			<th>出生日期</th>
		</tr>
		</thead>
		<tr>
			<td>
					${entry.employee.name}
			</td>
			<td>
					${erp:sexStatusName(entry.employee.sex)}
			</td>
			<td>
					${entry.employee.phone}
			</td>
			<td>
				<c:forEach items="${entry.employee.getProfessionList()}" var="occId" varStatus="length">
					<c:if test="${length.index!=0}">
						,
					</c:if>
					${erp:getCommonsTypeName(occId)}
				</c:forEach>
			</td>
			<td>
					${entry.employee.customerResource.customerName}
			</td>
			<td>
				<fmt:formatDate value="${entry.employee.birthTime}" pattern="yyyy-MM-dd"/>
			</td>
		</tr>

	</table>

	<div class="alert alert-info">员工定级和技能项信息</div>
	基础服务技能定级
	<div class="control-group">
	</div>
	<div class="control-group">
		<table class="table table-striped table-bordered table-condensed">
			<thead>
			<tr>
				<th>基础服务技能</th>
				<c:forEach items="${weightList}" var="weight" varStatus="index">
					<th>${weight.checkName}得分</th>
				</c:forEach>
				<th>综合得分</th>
				<th>系统测评定级</th>
				<th>人工定级</th>
				<th>员工服务结算单价</th>
			</tr>
			</thead>
			<tbody tbodyName="besicSkill">
			<c:forEach items="${besicSkillList}" var="besicSkill">
				<tr>
					<td>
							${besicSkill.skill.skillName}
					</td>
					<c:forEach items="${besicSkill.skillWeightList}" var="skillWeight">
						<td>
								${skillWeight.weightScore}
						</td>
					</c:forEach>
					<td>
							${besicSkill.score}
					</td>
					<td>
							${besicSkill.systemServiceLevel.name}
					</td>
					<td>
							${besicSkill.serviceLevel.name}
					</td>
					<td>
							${besicSkill.servicePrice}元/${erp:unitStatusName(besicSkill.skill.unit)}
					</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>


	<div class="control-group">
		员工服务技能
	</div>
	<div class="control-group">
		<table  id="skillContentTable" class="table table-striped table-bordered table-condensed">
			<thead>
			<tr>
				<th>技能项名称</th>
				<th>计价单位</th>
				<th>类型</th>
				<th>服务结算单价</th>
			</tr>
			</thead>
			<tbody tbodyName="singleSkill">
			<c:forEach items="${singleSkillList}" var="singleSkill">
				<tr>
					<td>
							${singleSkill.skill.skillName}
					</td>
					<td>
							${erp:unitStatusName(singleSkill.skill.unit)}
					</td>
					<td>
						单项服务
					</td>
					<td>
							${singleSkill.servicePrice}元/${erp:unitStatusName(singleSkill.skill.unit)}
					</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>
	<div id="contentTable" class="alert alert-info">薪资结构</div>

	<div class="control-group">
		<table>
			<tr>
				<td colspan="2">
					<div class="control-group">
						<label class="control-label">员工性质：</label>
						<div class="controls">
							<form:select path="type" class="input-large" disabled="true" >
								<form:options items="${erp:employeeTypeList()}" itemLabel="name" itemValue="value"  htmlEscape="false" />
							</form:select>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">有无底薪：</label>
						<div class="controls">
							<form:select path="basePayStatus" class="input-large" disabled="true">
								<form:options items="${erp:basePayStatusList()}" itemLabel="name" itemValue="value"  htmlEscape="false"/>
							</form:select>
						</div>
					</div>
				</td>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">底薪(元): </label>
						<div class="controls">
							<form:input path="baseAmount" htmlEscape="false" class="required input-medium money" readonly="true"/>元/月
						</div>
					</div>
				</td>
			</tr>
		</table>
	</div>

	<div class="alert alert-info">签约周期</div>
	<div class="control-group">
		<table>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">合同编号: </label>
						<div class="controls">
								${entry.contractCode}
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">签约生效时间：</label>
						<div class="controls">
							<input name="takeTime" disabled="disabled" type="text" maxlength="20" readonly="true" class="required input-medium Wdate checkTime" style="width: 205px;"
								   value="<fmt:formatDate value="${entry.takeTime}" pattern="yyyy-MM-dd HH:mm"/>"
								   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>
						</div>
						<span class="help-inline"><font color="red">*</font> </span>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">签约截止时间：</label>
						<div class="controls">
							<input name="deadlineTime" disabled="disabled" type="text" maxlength="20" readonly="true" class="required input-medium Wdate checkTime" style="width: 205px;"
								   value="<fmt:formatDate value="${entry.deadlineTime}" pattern="yyyy-MM-dd HH:mm"/>"
								   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">签约操作人：</label>
						<div class="controls">
							<form:input path="user.name" htmlEscape="false" maxlength="20" class="input-medium " disabled="true" />
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">操作时间：</label>
						<div class="controls">
							<input name="createTime" type="text" readonly="readonly" maxlength="20" class="required input-medium Wdate " disabled="disabled"
								   value="<fmt:formatDate value="${entry.createTime}" pattern="yyyy-MM-dd HH:mm"/>"
								   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
			</tr>
		</table>
	</div>

	<div class="alert alert-info">审批意见</div>
	<div class="control-group">
		<table>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">审批结果：</label>
						<div class="controls">
							<input type="radio" name="approveStatus" value="1" checked="checked"/>审批通过
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="radio" name="approveStatus" value="2"  />退回
							<font color="red">*</font>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div class="control-group">
						<label class="control-label">审批意见：</label>
						<div class="controls">
							<form:textarea path="reason" htmlEscape="false" maxlength="1024" rows="3" style="width:800px;"/>
						</div>
					</div>
				</td>
			</tr>
		</table>
	</div>

	<div class="form-actions">
		<shiro:hasPermission name="crm:employeeEntry:update"><input id="btnSubmit" class="btn btn-primary" type="submit" value="提交审批意见"/>&nbsp;</shiro:hasPermission>
		<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
	</div>
    <input type="hidden" name="hdWeightListSize" value="${weightListSize}">
</form:form>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>员工入职签约管理管理</title>
	<meta name="decorator" content="default"/>
    <script type="text/javascript">
        var array = new Array();
        $(function () {
            $("#radioShow").click(function(){
                console.log($('div[name="formDiv"]'))
                $('div[name="formDiv"]').hide();
            });
            $("#radioHide").click(function(){
                $('div[name="formDiv"]').show();
            });
        })
    </script>
</head>
<body>

<form:form id="inputForm" modelAttribute="entry" action="${ctx}/crm/employeeEntry/save?tagFlag=1" method="post" class="form-horizontal">
	<form:hidden path="id"/>
	<form:hidden path="employee.id" id="employeeId"/>
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
							<input type="radio"  name="type"  value="1" checked="checked"/>员工制
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;
							<input type="radio"  name="type"  value="0" />劳务制
							<font color="red">*</font>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">有无底薪：</label>
						<div class="controls">
							<input type="radio"  id="radioHide" name="basePayStatus"  value="0" checked="checked"/>有
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="radio"  id="radioShow" name="basePayStatus"  value="1" />无
							<font color="red">*</font>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div name="formDiv" class="control-group">
						<label class="control-label">底薪(元): </label>
						<div class="controls">
							<form:input path="baseAmount" htmlEscape="false" class="required input-medium money"/>元/月
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
						<label class="control-label">合同编号：</label>
						<div class="controls">
							<form:input path="contractCode" htmlEscape="false" maxlength="200" readonly="true" class="required input-xlarge " style="width:208px"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">签约生效时间：</label>
						<div class="controls">
							<input name="birthTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
								   value="<fmt:formatDate value="${entry.takeTime}" pattern="yyyy-MM-dd HH:mm"/>"
							       onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">签约截止时间：</label>
						<div class="controls">
							<input name="birthTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
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
							<form:input path="user.name" htmlEscape="false"  maxlength="1024" class="input-large " readonly="true" value="${createUserName}"/>
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



	<div class="form-actions">
		<shiro:hasPermission name="crm:employeeEntry:update"><input id="btnSubmit" class="btn btn-primary" type="submit" value="提交签约审批"/>&nbsp;</shiro:hasPermission>
		<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
	</div>
    <input type="hidden" name="hdWeightListSize" value="${weightListSize}">
</form:form>
</body>
<script type="text/javascript">

</script>
</html>
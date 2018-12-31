<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>员工入职签约管理管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>

<form:form id="inputForm" modelAttribute="entry" action="${ctx}/crm/entry/passSkillInfoSave" method="post" class="form-horizontal">
	<form:hidden path="id"/>
	<form:hidden path="employee.id" id="employeeId"/>
	<sys:message content="${message}"/>
	<div class="alert alert-info">员工定级</div>
	<div class="control-group">
		<font color="red">*</font> &nbsp;定级员工:${entry.employee.name}
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
				<fmt:formatDate value="${entry.employee.birthTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
			</td>
		</tr>

	</table>

	<div class="alert alert-info">员工等级</div>
	<div class="control-group">
		基础服务技能定级
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

	<div id="contentTable" class="alert alert-info">技能项</div>
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

    <div class="control-group">
		<font color="red">*</font> &nbsp; 定级操作人：
            ${skillUser.name} &nbsp;&nbsp;&nbsp;&nbsp;
		<font color="red">*</font> &nbsp; 定级操作时间：
        <fmt:formatDate value="${skillTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
    </div>

    <div id="contentTable" class="alert alert-info">定级审核</div>
        <div class="control-group">
            <label><font color="red">*</font> &nbsp;审核结果：</label>
            <input type="radio" name="entryStatus" checked value="5">审核通过,提交签约
            <input type="radio" name="entryStatus" value="2">退回
        </div>
        <div>
			<font color="red">*</font> &nbsp;审核意见：
            <textarea name="passSkillContent" class="required" style="width: 60%;height: 50%"></textarea>
        </div>
        <div class="control-group">
            <label><font color="red">*</font> &nbsp;审核人：</label>
                ${interview.interviewers.name} &nbsp;&nbsp;&nbsp;&nbsp;
        </div>
        <div class="control-group">
            <label><font color="red">*</font> &nbsp;审核时间：</label>
            <fmt:formatDate value="${passSkillTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
        </div>
        <input type="hidden" name="passSkillPersonId" value="${interview.interviewers.id}">
        <input type="hidden" name="passSkillTime" value="<fmt:formatDate value="${passSkillTime}" pattern="yyyy-MM-dd HH:mm:ss"/>">

	<div class="form-actions">
		<shiro:hasPermission name="crm:entry:save"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
		<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
	</div>
</form:form>
<script type="text/javascript">
	$(function () {
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
    })
</script>
</body>
</html>
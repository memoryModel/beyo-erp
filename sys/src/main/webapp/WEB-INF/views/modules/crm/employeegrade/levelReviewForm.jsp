<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>星级测评</title>
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

            $(document).find("a[name='skillTest']").each(function () {
                var skillId = $(this).attr("skillId");
                var employeeId = $(this).attr("employeeId");
                var levelId = $(this).attr("levelId");
                $(this).click(function () {
                    top.$.jBox("iframe:/crm/employeeGradeManager/employeeSkill?id="+employeeId+"&&skillId="+skillId+"&&levelId="+levelId,
                        {
                            title:"技能等级综合评测",
                            width:700,
                            height:550,
                            buttons:{}
                        }
                    );
                });
            });

		});

	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="/crm/employeeGradeManager/list">升降级管理</a></li>
		<li class="active"><a href="${ctx}/crm/employeeGradeManager/levelReview?id=${employee.id}">星级评测</a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="employee" action="${ctx}/crm/employeeGradeManager/levelReview" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<input type="hidden" value="${employee.id}" name="employeeId" id="employeeId">
		<sys:message content="${message}"/>
		<table>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">员工姓名：</label>
						<div class="controls">
							<input type="text" value="${employee.name}" id="name" readonly="readonly" class="input-large">
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">员工编号：</label>
						<div class="controls">
							<input type="text" value="${employee.code}" id="code" readonly="readonly" class="input-large">
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">员工联系方式：</label>
						<div class="controls">
							<input type="text" value="${employee.phone}" id="phone" readonly="readonly" class="input-large">
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">工种：</label>
						<div class="controls">
							<input type="text" value="${erp:getCommonsTypeName(employee.profession)}" id="employee.profession" readonly="readonly" class="input-large">
						</div>
					</div>
				</td>
			</tr>
		</table>
		<table id="contentTable" class="table table-striped table-bordered table-condensed" style="width: 70%">
				<thead>
				<tr>
					<th>基础服务技能项</th>
					<th>星级</th>
					<th>服务结算价格(元)</th>
					<th>操作</th>
				</tr>
				</thead>
				<tbody>
					<c:forEach items="${employeeSkillList}" var="employeeSkill">
						<tr>
							<td>
									${employeeSkill.skill.skillName}
							</td>
							<td>
									${employeeSkill.serviceLevel.name}
							</td>
							<td>
									${employeeSkill.servicePrice}
							</td>
							<td>
								<shiro:hasPermission name="crm:employeeGrade:employeeSkill"><a name="skillTest" skillId="${employeeSkill.skill.id}" employeeId="${employee.id}" levelId="${employeeSkill.serviceLevel.id}"  href="javascript:;" class="btn">测评</a></shiro:hasPermission>
							</td>
						</tr>
				</c:forEach>
				</tbody>
		</table>
	</form:form>
</body>
</html>
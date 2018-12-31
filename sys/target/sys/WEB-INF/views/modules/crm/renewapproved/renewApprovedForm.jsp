<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>审批续约管理</title>
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
			load();
            radioCheck();
		});

		function load(){
		    var value = ${tagFlag};
		    //false为查看已续约信息
		    if (value == false){
		        $("#approvedOpinion").attr("disabled","disabled");
		        $("#approvedUser").attr("disabled","disabled");
		        $("#createTimeId").attr("disabled","disabled");
		        $("#approvedStatusIdOne").attr("disabled","disabled");
		        $("#approvedStatusIdTwo").attr("disabled","disabled");
		        $("#btnSubmit").hide();
		        $("#createUserIdOne").hide();
				var approvedStatus = $('#approvedStatusId').val();
		        if (approvedStatus == 0){
		            $('#approvedStatusIdOne').attr("checked","true");
                }else{
                    $('#approvedStatusIdTwo').attr("checked","true");
                }
			}else{
                $('#createUserIdTwo').hide();
            }
		}

        //员工性质、有无底薪页面加载检查
        function radioCheck(){
            var type = $("#typeId").val();
            if (type == 1){
                $("#typeOne").attr("checked","true");
            }else{
                $("#typeTwo").attr("checked","true");
            }
            var basePayStatus = $("#basePayStatusId").val();
            if (basePayStatus == 1){
                $("#basePayStatusOne").attr("checked","true");
            }else{
                $("#basePayStatusTwo").attr("checked","true");
            }
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<c:if test="${tagFlag == true}">
			<li class="active"><a href="${ctx}/crm/renewApproved/form?id=${renewApproved.id}">员工续约审批</a></li>
		</c:if>
		<c:if test="${tagFlag == false}">
			<li class="active"><a href="${ctx}/crm/renewApproved/viewRenew?id=${renewApproved.id}">员工续约</a></li>
		</c:if>
	</ul><br/>

	<form:form id="inputForm" modelAttribute="renewApproved" action="${ctx}/crm/renewApproved/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<input type="hidden" id="approvedStatusId" value="${renewApproved.approvedStatus}">
		<input type="hidden" id="typeId" value="${renewApproved.employeeEntry.type}">
		<input type="hidden" id="basePayStatusId" value="${renewApproved.employeeEntry.basePayStatus}">
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
					<td>${renewApproved.employeeEntry.employee.name}</td>
					<td>${erp:sexStatusName(renewApproved.employeeEntry.employee.sex)}</td>
					<td>${renewApproved.employeeEntry.employee.phone}</td>
					<td>
						<c:forEach items="${renewApproved.employeeEntry.employee.getProfessionList()}" var="occId" varStatus="length">
							<c:if test="${length.index!=0}">
								,
							</c:if>
							${erp:getCommonsTypeName(occId)}
						</c:forEach>
					</td>
					<td>${renewApproved.employeeEntry.employee.customerResource.customerName}</td>
					<td><fmt:formatDate value="${renewApproved.employeeEntry.employee.birthTime}" pattern="yyyy-MM-dd"/></td>
				</tr>
			</table>
		</div>
		<div class="alert alert-info" style="margin-bottom:15px;"><strong><h4>员工定级和技能项信息</h4></strong></div>
		<h5>基础服务技能定级</h5>
		<div class="control-group">
			<table class="table table-striped table-bordered table-condensed">
				<thead>
				<tr>
					<th>基础服务技能</th>
					<c:forEach items="${weightList}" var="weight" varStatus="index">
						<input type="hidden" name="hdWeightId" value="${weight.id}">
						<th>${weight.checkName}得分</th>
					</c:forEach>
					<th>综合得分</th>
					<th>系统测评定级</th>
					<th>人工定级</th>
					<th>员工服务结算单价</th>
				</tr>
				</thead>
				<tbody>
				<c:forEach items="${employeeSkillList}" var="employeeSkill">
					<c:if test="${employeeSkill.type == 2}">
						<tr>
							<td>
									${employeeSkill.skill.skillName}
								<input type="hidden" name="skillEd" value="${employeeSkill.skill.id}">
							</td>
							<c:forEach items="${employeeSkill.skillWeightList}" var="skillWeight">
								<td weightId="${skillWeight.weightId}">
										${skillWeight.weightScore}
								</td>
							</c:forEach>
							<td name="score">
									${employeeSkill.score}
							</td>
							<td name="levelName">
									${employeeSkill.systemServiceLevel.name}
							</td>
							<td name="appraisalLevelName">
									${employeeSkill.serviceLevel.name}
							</td>
							<td>
									${employeeSkill.servicePrice}元/${erp:unitStatusName(employeeSkill.skill.unit)}
							</td>
						</tr>
					</c:if>
				</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="control-group">
			<h5 style="float:left">员工服务技能 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h5>
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
				<c:forEach items="${employeeSkillList}" var="employeeSkill">
					<c:if test="${employeeSkill.type == 1 }">
						<tr id="">
							<td>
									${employeeSkill.skill.skillName}
								<input type="hidden" name="skillEd" value="${employeeSkill.skill.id}">
							</td>
							<td>
									${erp:unitStatusName(employeeSkill.skill.unit)}
							</td>
							<td>
								单项服务
							</td>
							<td>
									${employeeSkill.servicePrice}元/${erp:unitStatusName(employeeSkill.skill.unit)}
							</td>
						</tr>
					</c:if>
				</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="alert alert-info" style="margin-bottom:15px;"><strong><h4>薪资结构</h4></strong></div>
		<div class="control-group">
			<label class="control-label"><span class="help-inline"><font color="red">*</font> </span> &nbsp;员工性质：</label>
			<div class="controls">
				<input type="radio" disabled="disabled" id="typeOne">劳务制
				<input type="radio" disabled="disabled" id="typeTwo">员工制
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><span class="help-inline"><font color="red">*</font> </span> &nbsp;有无底薪：</label>
			<div class="controls">
				<input type="radio" disabled="disabled" id="basePayStatusOne">有底薪
				<input type="radio" disabled="disabled" id="basePayStatusTwo">无底薪
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><span class="help-inline"><font color="red">*</font> </span> &nbsp;底薪：</label>
			<div class="controls">
				<form:input path="employeeEntry.baseAmount" htmlEscape="false" readonly="true" maxlength="64" class="input-xlarge "  style="width: 80px;text-align: centre;"/> &nbsp;元/月
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
					   value="<fmt:formatDate value="${renewApproved.employeeEntry.takeTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><font color="red">*</font> </span> &nbsp;签约截止日期：</label>
			<div class="controls">
				<input name="employeeEntry.deadlineTime" type="text" disabled="disabled" readonly="readonly" maxlength="20" class="input-medium Wdate "
					   value="<fmt:formatDate value="${renewApproved.employeeEntry.deadlineTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><font color="red">*</font> </span> &nbsp;续约合同编号：</label>
			<div class="controls">
				<form:input path="employeeRenew.contractExtensionCode" htmlEscape="false" readonly="true" class="required input-xlarge"  maxlength="64" style="width: 163px"/>
			</div>
		</div>
		<div class="control-group" style="float:left;">
			<label class="control-label"><font color="red">*</font> </span> &nbsp;续约生效日期：</label>
			<div class="controls">
				<input name="employeeRenew.extensionStartDate" type="text" readonly="readonly" disabled="disabled" maxlength="20" class="input-medium Wdate "
					   value="<fmt:formatDate value="${renewApproved.employeeRenew.extensionStartDate}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><font color="red">*</font> </span> &nbsp;续约截止日期：</label>
			<div class="controls">
				<input id="employeeRenew.extensionEndDate" name="extensionEndDate" type="text" readonly="true" disabled="disabled" maxlength="20" class="input-medium Wdate "
					   value="<fmt:formatDate value="${renewApproved.employeeRenew.extensionEndDate}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			</div>
		</div>
		<div class="control-group" style="float:left;">
			<label class="control-label"><font color="red">*</font> </span> &nbsp;续约操作人：</label>
			<div class="controls">
				<input type="text" value="${renewApproved.employeeRenew.user.name}" readonly="readonly">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><font color="red">*</font> </span> &nbsp;操作时间：</label>
			<div class="controls">
				<input name="employeeRenew.createTime" type="text" readonly="readonly" disabled="disabled" maxlength="20" class="input-medium Wdate "
					   value="<fmt:formatDate value="${renewApproved.employeeRenew.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
			</div>
		</div>
		<div class="alert alert-info" style="margin-bottom:15px;"><center><strong><h4>审批意见</h4></strong></center></div>
		<div class="control-group">
			<label class="control-label"><span class="help-inline"><font color="red">*</font> </span> &nbsp;审批结果：</label>
			<div class="controls">
				<input type="radio" id="approvedStatusIdOne" class="required" name="approvedStatus" value="0">审批通过&nbsp;
				<input type="radio" id="approvedStatusIdTwo" class="required" name="approvedStatus" value="1">退回
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><span class="help-inline"><font color="red">*</font> </span> &nbsp;审批意见</label>
			<div class="controls">
				<form:textarea id="approvedOpinion" path="approvedOpinion" htmlEscape="false" maxlength="200" class="required input-xlarge " rows="3" style="width: 620px;"/>
			</div>
		</div>
		<div class="control-group" style="float:left;" id="createUserIdOne">
			<label class="control-label"><font color="red">*</font> </span> &nbsp;审批人：</label>
			<div class="controls">
				<sys:treeselect id="approvedUser" name="approvedUser.id" value="${renewApproved.approvedUser.id}"
								labelName="approvedUser.name" labelValue="${renewApproved.approvedUser.name}"
								title="选择用户" url="/sys/office/treeData?type=3" notAllowSelectParent="true"/>
			</div>
		</div>
		<div class="control-group" style="float:left;" id="createUserIdTwo">
			<label class="control-label"><font color="red">*</font> </span> &nbsp;审批人：</label>
			<div class="controls">
				<input type="text" value="${renewApproved.approvedUser.name}" readonly="readonly">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><font color="red">*</font> </span> &nbsp;审批时间：</label>
			<div class="controls">
				<input id="createTimeId" name="createTime" type="text" readonly="readonly" maxlength="20" class="required input-medium Wdate "
					   value="<fmt:formatDate value="${renewApproved.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
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
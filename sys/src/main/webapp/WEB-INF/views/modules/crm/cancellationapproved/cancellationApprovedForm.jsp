<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>解约申请审批管理</title>
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
            var sel=document.getElementById("selectId");
            var value = sel.options[sel.selectedIndex].text;
            $('#reasonOtherId').hide();
            if (value == '其他'){
                $('#reasonOtherId').show();
            }

            load();
            selectCheck();
            radioCheck();
		});

		function load(){
		    var tagFlag = ${tagFlag};
		    //查看解约信息
		    if (tagFlag == 1){
				$("#approvedOpinionId").attr("readonly","true");
				$("#createTimeById").attr("disabled","disabled");
				$("#divById").hide();
				$("#selectId").attr("disabled","disabled");
				$("#btnSubmit").hide();
				$("#approvedStatusIdOne").attr("disabled","disabled");
				$("#approvedStatusIdTwo").attr("disabled","disabled");
            }
            //审批功能
            if (tagFlag == 0){
                $("#selectId").attr("disabled","disabled");
                $("#inputById").hide();
            }
		}

		//检查审批通过状态
		function selectCheck(){
            var radioValue = $("#approvedStatusId").val();
		    if (radioValue == 0){
		        $("#approvedStatusIdOne").attr("checked",true);
            }else{
                $("#approvedStatusIdTwo").attr("checked",true);
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
		<c:if test="${tagFlag == 1}">
			<li class="active"><a href="${ctx}/crm/cancellationApproved/form?id=${cancellationApproved.id}">查看解约信息</a></li>
		</c:if>
		<c:if test="${tagFlag == 0}">
			<li class="active"><a href="${ctx}/crm/cancellationApproved/form?id=${cancellationApproved.id}">解约申请审批</a></li>
		</c:if>

	</ul><br/>
	<form:form id="inputForm" modelAttribute="cancellationApproved" action="${ctx}/crm/cancellationApproved/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<input type="hidden" id="approvedStatusId" value="${cancellationApproved.approvedStatus}">
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
					<td>${cancellationApproved.employeeEntry.employee.name}</td>
					<td>${erp:sexStatusName(cancellationApproved.employeeEntry.employee.sex)}</td>
					<td>${cancellationApproved.employeeEntry.employee.phone}</td>
					<td>
						<c:forEach items="${cancellationApproved.employeeEntry.employee.getProfessionList()}" var="occId" varStatus="length">
							<c:if test="${length.index!=0}">
								,
							</c:if>
							${erp:getCommonsTypeName(occId)}
						</c:forEach>
					</td>
					<td>${cancellationApproved.employeeEntry.employee.customerResource.customerName}</td>
					<td><fmt:formatDate value="${cancellationApproved.employeeEntry.employee.birthTime}" pattern="yyyy-MM-dd HH:mm"/></td>
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
					<c:if test="${employeeSkill.type == 1}">
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
				<form:input path="employeeEntry.baseAmount" htmlEscape="false" readonly="true" maxlength="64" class="input-xlarge "  style="width: 100px;"/> &nbsp;元/月
			</div>
		</div>
		<div class="alert alert-info" style="margin-bottom:15px;"><strong><h4>签约周期</h4></strong></div>
		<div class="control-group">
			<label class="control-label"><font color="red">*</font> </span> &nbsp;合同编号：</label>
			<div class="controls">
				<form:input path="employeeEntry.contractCode"  htmlEscape="false" readonly="true" class="input-xlarge"  maxlength="64" style="width: 163px"/>
			</div>
		</div>
		<div class="control-group" style="float:left;">
			<label class="control-label"><font color="red">*</font> </span> &nbsp;签约生效日期：</label>
			<div class="controls">
				<input name="employeeEntry.takeTime" type="text" disabled="disabled" readonly="readonly" maxlength="20" class="input-medium Wdate "
					   value="<fmt:formatDate value="${cancellationApproved.employeeEntry.takeTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><font color="red">*</font> </span> &nbsp;签约截止日期：</label>
			<div class="controls">
				<input name="employeeEntry.deadlineTime" type="text" disabled="disabled" readonly="readonly" maxlength="20" class="input-medium Wdate "
					   value="<fmt:formatDate value="${cancellationApproved.employeeEntry.deadlineTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
			</div>
		</div>
		<div class="control-group" style="float:left;">
			<label class="control-label"><font color="red">*</font> </span> &nbsp;签约操作人：</label>
			<div class="controls">
				<input type="text" value="${cancellationApproved.employeeEntry.user.name}" readonly="readonly">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><font color="red">*</font> </span> &nbsp;操作时间：</label>
			<div class="controls">
				<input name="createTime" type="text" readonly="readonly" disabled="disabled" maxlength="20" class="input-medium Wdate "
					   value="<fmt:formatDate value="${cancellationApproved.employeeCancellation.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
			</div>
		</div>
		<div class="alert alert-info" style="margin-bottom:15px;"><strong><h4><center>申请解约</center></h4></strong></div>
		<div class="control-group">
			<label class="control-label"><span class="help-inline"><font color="red">*</font> </span> &nbsp;解约原因：</label>
			<div class="controls" id="div1">
				<form:select id="selectId" path="employeeCancellation.cancellationReason" htmlEscape="false" style="width: 160px;">
					<form:options items="${erp:employeeCancellationList()}" itemLabel="name" itemValue="value" htmlEscape="false" />
				</form:select>
				<form:input path="employeeCancellation.reasonOther" id="reasonOtherId" htmlEscape="false" readonly="true"/>
			</div>

		</div>
		<div class="control-group">
			<label class="control-label"><font color="red">*</font> </span> &nbsp;解约生效日期：</label>
			<div class="controls">
				<input name="cancellationEffectiveTime" disabled="disabled" id="cancellationEffectiveTimeId" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					   value="<fmt:formatDate value="${cancellationApproved.employeeCancellation.cancellationEffectiveTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"></span> &nbsp;备注</label>
			<div class="controls">
				<form:textarea id="remarksId" readonly="true" path="employeeCancellation.remarks" htmlEscape="false" maxlength="200" class="input-xlarge " rows="3" style="width: 620px;"/>
			</div>
		</div>
		<div class="control-group" style="float:left;">
			<label class="control-label"><font color="red">*</font> </span> &nbsp;解约操作人：</label>
			<div class="controls">
				<input type="text" value="${cancellationApproved.employeeCancellation.user.name}" readonly="readonly">
			</div>
		</div>

		<div class="control-group">
			<label class="control-label"><font color="red">*</font> </span> &nbsp;操作时间：</label>
			<div class="controls">
				<input name="createTime" disabled="disabled" id="createTimeId" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					   value="<fmt:formatDate value="${cancellationApproved.employeeCancellation.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
			</div>
		</div>
		<div class="alert alert-info" style="margin-bottom:15px;"><strong><h4><center>审批意见</center></h4></strong></div>
		<div class="control-group">
			<label class="control-label"><font color="red">*</font> </span> &nbsp;审批结果：</label>
			<div class="controls">
				<input type="radio" id="approvedStatusIdOne" name="approvedStatus" value="0">审批通过&nbsp;&nbsp;
				<input type="radio" id="approvedStatusIdTwo" name="approvedStatus" value="1">退回
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"></span> <font color="red">*</font>&nbsp;审批意见</label>
			<div class="controls">
				<form:textarea path="approvedOpinion" id="approvedOpinionId" htmlEscape="false" maxlength="200" class="required input-xlarge " rows="3" style="width: 620px;"/>
			</div>
		</div>
		<div class="control-group" style="float:left;" id="divById">
			<label class="control-label"><font color="red">*</font> </span> &nbsp;审批人：</label>
			<div class="controls">
				<sys:treeselect id="user" name="user.id" value="${cancellationApproved.user.id}"
								labelName="user.name" labelValue="${cancellationApproved.user.name}"
								title="选择用户" url="/sys/office/treeData?type=3" notAllowSelectParent="true"/>
			</div>
		</div>

		<div class="control-group" style="float:left;" id="inputById">
			<label class="control-label"><font color="red">*</font> </span> &nbsp;审批人：</label>
			<div class="controls">
				<input type="text" value="${cancellationApproved.user.name}" readonly="readonly">
			</div>
		</div>

		<div class="control-group">
			<label class="control-label"><font color="red">*</font> </span> &nbsp;审批时间：</label>
			<div class="controls">
				<input name="createTime" id="createTimeById" type="text" readonly="readonly" maxlength="20" class="required input-medium Wdate "
					   value="<fmt:formatDate value="${cancellationApproved.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
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
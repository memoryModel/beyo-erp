<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>员工升降级审批管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
	</script>
</head>
<body>
<ul class="nav nav-tabs">
	<li><a href="${ctx}/crm/employeeGradeApprove/nopassDowngradeList">待降级列表</a></li>
</ul><br/>
<form:form id="inputForm" modelAttribute="employeeGrade" action="${ctx}/crm/employeeGradeApprove/nopassDowmgradeSave" method="post" class="form-horizontal">
<form:hidden path="id"/>
<input type="hidden" name="employeeId" value="${employee.id}"/>
<input type="hidden" name="skillId" id="skillId" value="${skill.id}"/>
<input type="hidden" name="skill.skillName" id="skillName" value="${skill.skillName}"/>
<input type="hidden" name="systemServiceLevelId" id="systemServiceLevelId" value=""/>
<input type="hidden" name="unit" id="unit" value="${skill.unit}">
<input type="hidden" name="category" id="category" value="${skill.category}">
<input type="hidden" name="hdDataJSON">
<input type="hidden" name="levelId">
<input type="hidden" name="score">
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
				<td><fmt:formatDate value="${approve.approveTime}" pattern="yyyy-MM-dd HH:mm"/></td>
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
	<tbody>
	<c:forEach items="${employeeList}" var="employee">
		<tr>
			<td>${employee.name}</td>
			<td>${erp:sexStatusName(employee.sex)}</td>
			<td>${employee.phone}</td>
			<td>
				<c:forEach items="${employee.getProfessionList()}" var="employeeId" varStatus="length">
					<c:if test="${length.index!=0}">
						,
					</c:if>
					${erp:getCommonsTypeName(employeeId)}
				</c:forEach>
			</td>
			<td>${employee.customerResource.customerName}</td>
			<td><fmt:formatDate value="${employee.birthTime}" pattern="yyyy-MM-dd HH:mm"/></td>
		</tr>
	</c:forEach>
	</tbody>
</table>
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
	<div class="alert alert-info">降级测评</div>
	<div class="control-group">
		<label class="control-label">基础服务技能：</label>
		<div class="controls" >
				${skill.skillName}
		</div>
	</div>
	<div class="control-group">
		<div class="controls" >
			<c:forEach items="${weightList}" var="weight" varStatus="index">
				${weight.checkName}(满分100):
				<c:forEach items="${crmSkillWeightList}" var="skillWeight">
					<c:if test="${weight.id == skillWeight.weightId}">
						<input id="points${index.index}" name="points" rate="${weight.percentage}" value="${skillWeight.weightScore}" skillWeightId="${skillWeight.id}" maxlength="3" class="required points valid" style="width: 50px;text-align: right;margin: 2%">
					</c:if>
				</c:forEach>
				<c:if test="${(index.index+1)%3 == 0}">
					<br>
				</c:if>
			</c:forEach>
			服务单数:<input name="employeeSkill1.serviceNumber" maxlength="3"  style="width: 50px;text-align: right;margin: 2%" readonly="readonly" value="${employeeSkill1.serviceNumber}">
			完美单数:<input name="employeeSkill1.perfectNumber" maxlength="3"  style="width: 50px;text-align: right;margin: 2%" readonly="readonly" value="${employeeSkill1.perfectNumber}">
			<br>
			<shiro:hasPermission name="crm:serviceLevel:findScore"><input id="skillTest" class="btn btn-warning" type="button" value="系统测评" />&nbsp;&nbsp;</shiro:hasPermission>

		</div>

	</div>


	<div class="control-group">
		<span style="margin-left: 17%">综合得分：</span>
		<span name="score" id="score" style="width: 2%;text-align: center;">

			</span>
		<span style="margin-left: 20%">系统测评定级：</span>
		<span name="result" style="width: 2%;text-align: center;">

			</span>
	</div>
	<div class="control-group">
		<label class="control-label">等级对应服务结算单价：</label>
		<span name="servicePrice" style="width: 2%;text-align: center;"></span>
	</div>
	<div class="control-group">
		<label class="control-label">人工定级：</label>
		<div class="controls">
			<form:select path="id" id="employeeSkillSelect" class="input-large">
				<form:options selectId="id" items="${serviceLevelList}" itemLabel="name" itemValue="id" htmlEscape="false"/>
			</form:select>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">当前员工服务结算单价：</label>
		<div class="controls">
			<input name="customServicePrice" type="text" class="input-large">
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">降级原因：</label>
		<div class="controls">
			<form:select path="downgradeReason" class="input-large" >
				<form:option value="" label="------请选择------"/>
				<form:options items="${erp:getCommonsTypeList(52)}"  itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
			</form:select>
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">定级生效时间：</label>
		<div class="controls">
			<input name="entryTime" type="text"  maxlength="20" class="required input-medium Wdate "
				   value="<fmt:formatDate value="${employeeGrade.entryTime}" pattern="yyyy-MM-dd HH:mm"/>"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">备注：</label>
		<div class="controls">
			<form:textarea path="remark" htmlEscape="false" rows="4" maxlength="256" class="input-xxlarge " />
		</div>
	</div>
	<table>
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">升级操作人：</label>
					<div class="controls">
						<form:input path="gradePersonName" htmlEscape="false" maxlength="20" class="required input-large"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>
			</td>
			<td>
				<div class="control-group">
					<label class="control-label">升级操作时间：</label>
					<div class="controls">
						<input name="gradeTime" type="text" readonly="readonly" maxlength="20" class="required input-medium Wdate "
							   value="<fmt:formatDate value="${employeeGrade.gradeTime}" pattern="yyyy-MM-dd HH:mm"/>"
							   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>
			</td>
		</tr>
	</table>

	<div class="form-actions">
		<shiro:hasPermission name="crm:employeeGrade:edit"><input type="button" id="btnSubmit" class="btn btn-primary" value="提交审核"/>&nbsp;</shiro:hasPermission>
		<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
	</div>
	</form:form>
	<script type="text/javascript">
		var level;
        $(document).ready(function() {
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
            jQuery.validator.addClassRules("points", {range:[1,100]});

            $("#skillTest").click(function () {
                if(!$("#inputForm").valid())return;
                var score = 0;
                var pointArray = $("input[name='points']");
                for(i=0;i<pointArray.length;i++){
                    p = parseInt($(pointArray[i]).val());
                    r = parseInt($(pointArray[i]).attr("rate"));
                    score += parseFloat(p*(r/100));
                }
                //渲染等级
                $.ajax({
                    url:'/crm/serviceLevel/findScore',
                    data:{"score":score},
                    type:'post',
                    async:false,
                    dataType:'json',
                    success:function (data) {
                        if (data || data.status=="success"){
                            if (!data.serviceLevel){
                                showMessage("error","评测失败，分数错误或过低无法计算等级");
                                return;
                            }
                            level = data.serviceLevel;
                            $('[name="result"]').text(level.name);
                            $("#systemServiceLevelId").val(level.id);
                        }else{
                            showMessage("error","请求失败");
                        }
                    },
                    error:function () {
                        showMessage("error","请求失败");
                    }
                });

                //渲染得分
                $('[name="score"]').text(score);

                //渲染结算单价
                var skillId = $("#skillId").val();
                $.ajax({
                    url:'/crm/skill/skillInfo',
                    data:{"id":skillId},
                    type:'post',
                    dataType:'json',
                    async:false,
                    success:function (data) {
                        if (data || data.status=="success"){
                            showSkillPrice(data);
                        }else{
                            showMessage("error","请求失败");
                        }
                    },
                    error:function () {
                        showMessage("error","请求失败");
                    }
                })

            });
            var unit = $("#unit").val();
            var unitName = '';
            if(unit == "1"){
                unitName = "元/天";
            }else{
                unitName = "元/次";
            }
            $('[name="costomServicePrice"]').after(unitName);

            //保存
            $('input[type="button"][id="btnSubmit"]').click(function () {
                var pointsValueArray = new Array();
                $('input[name="points"]').each(function () {
                    var skillWeightId = $(this).attr("skillWeightId");
                    var weightScore = $(this).val();
					var skillWeight = new Object();
					skillWeight.id = skillWeightId;
					skillWeight.weightScore = weightScore;
					pointsValueArray.push(skillWeight)

                })

                var hdDataJSONStr = JSON.stringify(pointsValueArray);
                var appraisalLevelId = $('#employeeSkillSelect').find('option:selected').val();
                var score=$("#score");
                $('input[type="hidden"][name="score"]').val(score.text());
                $('input[type="hidden"][name="levelId"]').val(appraisalLevelId);
                $('input[type="hidden"][name="hdDataJSON"]').val(hdDataJSONStr);
                $('#inputForm').submit();
            });

        });
        function showSkillPrice(data) {
            var skill = data.skill;
            if(!skill){
                showMessage("error","请求失败");
                return;
            }
            var skillId = $("#skillId").val();
            var servicePrice = 0;
            var levelId = 0;
            if (skill.category == 1){
                servicePrice = skill.settlementPrice;
            }else{
                var levelArray = data.levelList;
                for(var k=0;k<levelArray.length;k++){
                    if(levelArray[k].id == $('#systemServiceLevelId').val()){
                        levelId = levelArray[k].id;
                        servicePrice = levelArray[k].levelAmount;
                        break;
                    }
                }
            }
            var category = $("#unit").val();
            $('[name="servicePrice"]').text(servicePrice);
            $('[name="customServicePrice"]').val(servicePrice)
        }
        function showMessage(status,message) {
            $("#messageBox").remove();
            $('[name="servicePrice"]').parent().parent().after('<div id="messageBox" class="alert alert-'+status+'"><button data-dismiss="alert" class="close">×</button>'+message+'</div>');
        }
	</script>
</body>
</html>
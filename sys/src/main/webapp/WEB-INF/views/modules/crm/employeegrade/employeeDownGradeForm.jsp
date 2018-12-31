<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html>
<head>
	<title>升降级管理管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
        var weightIdArray = new Array();

	</script>
</head>
<body>
<ul class="nav nav-tabs">
	<li class="active"><a href="${ctx}/crm/employeeGrade/form?id=${employeeGrade.id}">升降级管理<shiro:hasPermission name="crm:employeeGrade:edit">${not empty employeeGrade.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="crm:employeeGrade:edit">查看</shiro:lacksPermission></a></li>
</ul><br/>
<form:form id="inputForm" modelAttribute="employeeGrade" action="${ctx}/crm/employeeGrade/downgradeSave" method="post" class="form-horizontal">
	<form:hidden path="id"/>
	<input type="hidden" name="hdDataJSON">
	<input type="hidden" name="gradePersonId" value="${userId}">
	<input type="hidden" name="gradeTime" value="<fmt:formatDate value="${gradeTime}" pattern="yyyy-MM-dd HH:mm"/>">
	<sys:message content="${message}"/>
	<div class="control-group">
		<label class="control-label">员工姓名：</label>
		<div class="controls">
			<input type="hidden" name="employee.id" id="employeeId">
			<input  type="text"   id="employeeName" name="employeeGrade.employee.name"   class="required input-large"  placeholder="点击选择添加员工" />
			<input id="selectEmployee" class="btn btn-primary" type="button"  value="选择降级员工"/>
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
	</div>
	<div class="control-group">
		<table class="table table-striped table-bordered table-condensed" id="employeeTable">
			<tr>
				<th>姓名</th>
				<th>性别</th>
				<th>手机号码</th>
				<th>工种</th>
				<th>来源</th>
			</tr>
			<c:if test="${employeeGrade.id != null}">
				<tr>
					<td>${employeeGrade.employee.name}</td>
					<td>${erp:sexStatusName(employeeGrade.employee.sex)}</td>
					<td>${employeeGrade.employee.phone}</td>
					<td><c:forEach items="${employeeGrade.employee.getProfessionList()}" var="occId" varStatus="length">
						<c:if test="${length.index!=0}">
							,
						</c:if>
						${erp:getCommonsTypeName(occId)}
					</c:forEach></td>
					<td>${employeeGrade.customerResource.customerName}</td>
				</tr>
			</c:if>
		</table>
	</div>

	<div class="control-group">
		<table class="table table-striped table-bordered table-condensed">
			<h6>基础技能服务等级</h6>
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
				<th>定级操作人</th>
				<th>定级生效时间</th>
			</tr>
			</thead>
			<tbody id="tbody-result">

			</tbody>
		</table>
	</div>
	<div class="control-group">
		<label class="control-label">待降级基础服务技能：</label>
		<div class="controls" name="skillType">
		</div>

	</div>
	<div class="alert alert-info">降级测评</div>
	<div class="control-group">
		<div class="controls">
			<input id="skillTest" class="btn btn-primary" type="button" value="降级测评"></input>
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
		<table class="table table-striped table-bordered table-condensed">
			<h6>降级后等级</h6>
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
			<tbody id="skill_result">

			</tbody>
		</table>
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
			<input name="entryTime" type="text" readonly="readonly" maxlength="20" class="required input-medium Wdate "
				   value="<fmt:formatDate value="${employeeGrade.entryTime}" pattern="yyyy-MM-dd HH:mm"/>"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">备注：</label>
		<div class="controls">
			<form:textarea path="remark" htmlEscape="false" rows="4" maxlength="256" class="input-xxlarge "/>
		</div>
	</div>
	<table>
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">降级操作人：</label>
					<div class="controls">
						<form:input path="gradePersonName" htmlEscape="false" maxlength="20" class="required input-large " disabled="true" />
						<span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>
			</td>
			<td>
				<div class="control-group">
					<label class="control-label">降级操作时间：</label>
					<div class="controls">
						<input name="" type="text" readonly="readonly" maxlength="20" class="checkSkill required input-medium Wdate "
							   value="<fmt:formatDate value="${employeeGrade.gradeTime}" pattern="yyyy-MM-dd HH:mm"/>"
							   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>
			</td>
		</tr>
	</table>

	<div class="form-actions">
		<shiro:hasPermission name="crm:employeeGrade:edit"><input type="submit" id="btnSubmit" class="btn btn-primary" value="提交审核"/>&nbsp;</shiro:hasPermission>
		<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
	</div>
</form:form>
<script type="text/javascript">
    $('input[type="hidden"][name="hdWeightId"]').each(function () {
        weightIdArray.push($(this).val())
    })

    $(function () {
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
        var jbox;
        $("#selectEmployee").click(function () {
            var employeeId = ''
            var trHtml = $('#employeeTable').find('tr:gt(0)');
            employeeId = $(trHtml).attr('id');
            jbox =  top.$.jBox.open("iframe:/crm/employeeGrade/selectEmployee?employeeId="+employeeId, "选择降级员工", 1024, 520);
        });
        $("#skillTest").click(function () {
            $("#skill_result").empty();
            var employeeSkillId =  $('input[name="employeeSkillId"]:checked').val();
            var employeeId = $("#employeeId").val();
            var tdHTML = '';
            for(var i=0;i<weightIdArray.length;i++){
                tdHTML = tdHTML + '<td weightId='+weightIdArray[i]+'></td>';
            }
            var trHTML = '<tr><td name="skillName"><input type="hidden" name="skillEd" value='+employeeSkillId+'></td>'+tdHTML+'<td name="score"></td>' +
                '<td name="levelName"></td><td name="appraisalLevelName"></td><td name="costomServicePrice"></td><input type="hidden" name="levelId">' +
                '<input type="hidden" name="appraisalLevelId"></tr>'
            $("#skill_result").append(trHTML);
            jbox =  top.$.jBox.open("iframe:/crm/employeeGrade/skillTest?employeeSkillId="+employeeSkillId+"&&employeeId="+employeeId, "降级测评", 700, 520);
        });


        //验证是否升级测评
        jQuery.validator.addMethod("checkSkill", function (value, element) {
            var flag = true;
            var trHTML = $('#skill_result').find('tr');
            if(trHTML == null || trHTML == '' || ('undefined' == typeof trHTML) || trHTML.length<=0){
                flag = false;
            }
            if(flag == true){
                submitData();
            }
            return flag;
        }, "请点击降级测评");
    });
    //保存
    function submitData() {
        var dataJSON = new Array();
        //拼接基础服务的json

        var trHTML = $('#skill_result').find('tr');
        var weightArray = new Array();
        var trJSON = new Object();
        var tdHTML = $(trHTML).find('td');
        for (var j=0;j<tdHTML.length;j++){
            var weightId = $(tdHTML[j]).attr('weightId');
            if(weightId != null && weightId != '' && ('undefined' != typeof weightId)){
                for(var z=0;z<weightIdArray.length;z++){
                    if(weightIdArray[z] == weightId){
                        var weight = new Object();
                        weight.weightId = weightId;
                        weight.score = $(tdHTML[j]).text();
                        weightArray.push(weight);
                        break;
                    }
                }
            }
        }
        var employeeSkillId = $(trHTML).find('input[type="hidden"][name="skillEd"]').val();
        trJSON.type = 2;
        trJSON.employeeSkillId = employeeSkillId;
        trJSON.score = $(trHTML).find('td[name="score"]').text();
        trJSON.levelId = $(trHTML).find('input[type="hidden"][name="levelId"]').val();
        trJSON.appraisalLevelId = $(trHTML).find('input[type="hidden"][name="appraisalLevelId"]').val();
        var priceAndUnit = $(trHTML).find('td[name="costomServicePrice"]').text();
        trJSON.costomServicePrice = priceAndUnit.substring(0,priceAndUnit.indexOf('元'));
        trJSON.skillPersonId = $('input[type="hidden"][name="skillPersonId"]').val();
        trJSON.skillTime = $('input[type="hidden"][name="skillTime"]').val();
        trJSON.weightArray = weightArray;
        dataJSON.push(trJSON);
        var hdDataJSONStr = JSON.stringify(dataJSON);
        $('input[type="hidden"][name="hdDataJSON"]').val(hdDataJSONStr);
    }


    function selectEmployeeCallback(trHtml,selectFlag){
        var id = $(trHtml).attr('id');
        var employeeName = $(trHtml).find('td:first').text();
        $("#employeeTable  tr:not(:first)").html("");
        if(selectFlag == '选择'){
            $("#employeeId").val(id);
            $("#employeeName").val(employeeName);
            $('#employeeTable').append(trHtml);
            $('#employeeTable').find('tr[id='+id+']').find('input[type="button"]').bind("click",function () {
                $(this).parent().parent().remove();
            })
            findSkill(id);
        }
        if(selectFlag == '取消选择'){
            $('#employeeTable').find('tr[id='+id+']').remove();
            $('#tbody-result').empty("");
            $("#employeeId").val("");
            $("#employeeName").val("");

        }


    }
    function findSkill(id){
        $('#tbody-result').empty("");
        $.ajax({
            type:"POST",
            dataType: "json",
            async:false,
            url:"/crm/employeeGrade/findEmployeeSkillList",
            data:"employeeId="+id,
            success:function(data){
                $('[name="skillType"]').empty();
                for(var i=0; i<data.length;i++){
                    var employeeSkillId = data[i].id
                    var skillId = data[i].skill.id
                    var skillName = data[i].skill.skillName
                    var skillWeightList = data[i].skillWeightList
                    var score = data[i].score
                    var systemServiceLevelName = data[i].systemServiceLevel.name
                    var serviceLevelName = data[i].serviceLevel.name
                    var servicePrice = data[i].servicePrice
                    var skillPersonName = data[i].skillUser.name
                    var skillTime = new Date(data[i].skillTime).Format("yyyy-MM-dd hh:mm:ss");
                    var weightsHTML = ''
                    for(var j=0; j<skillWeightList.length;j++){
                        weightsHTML = weightsHTML + '<td>'+skillWeightList[j].weightScore+'</td>'
                    }
                    var trHTML = '<tr><td>'+skillName+'</td>'+weightsHTML+'<td>'+score+'</td><td>'+systemServiceLevelName+'</td><td>'+serviceLevelName+'</td>' +
                        '<td>'+servicePrice+'</td><td>'+skillPersonName+'</td><td>'+skillTime+'</td></tr>'
                    $('#tbody-result').append(trHTML);
                    $('[name="skillType"]').append('<input type="radio" required="true" name="employeeSkillId" id="employeeSkillId" value="'+employeeSkillId+'" checked=checked>'+skillName)
                }
                $('[name="skillType"]').append('<span class="help-inline"><font color="red">*</font> </span>')
                if(employeeSkillId == null){
                    $("#skillTest").attr("disabled","true");
                }
            }
        });


    }
    //基础技能评测后回调
    function employeeSkillCallback(skillId,skillName,pointsValueArray,score,levelId,levelName,
                                   servicePrice,appraisalLevelId,appraisalLevelName,costomServicePrice,unit) {
        if(unit == "1"){
            unit = "元/天";
        }else{
            unit = "元/次";
        }
        for(var i=0;i<pointsValueArray.length;i++){
            $("#skill_result").find('td:eq('+(i+1)+')').text(pointsValueArray[i]);
        }
        $("#skill_result").find('td[name="skillName"]').text(skillName);
        $("#skill_result").find('td[name="score"]').text(score);
        $("#skill_result").find('td[name="levelName"]').text(levelName);
        $("#skill_result").find('td[name="appraisalLevelName"]').text(appraisalLevelName);
        $("#skill_result").find('td[name="costomServicePrice"]').text(costomServicePrice+unit);
        $("#skill_result").find('input[type="hidden"][name="levelId"]').val(levelId);
        $("#skill_result").find('input[type="hidden"][name="appraisalLevelId"]').val(appraisalLevelId);
    }
</script>
</body>
</html>
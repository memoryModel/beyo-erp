<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>申请解约页面</title>
	<meta name="decorator" content="default"/>

</head>
<body>
<ul class="nav nav-tabs">
	<li class="active">
		<a href=""><font>申请解约</font></a>
	</li>
</ul>
<form:form id="inputForm" modelAttribute="employeeCancellation" action="${ctx}/crm/employeeCancellation/save" method="post" class="form-horizontal">
	<form:hidden path="id"/>
	<sys:message content="${message}"/>
	<input type="hidden" id="employeeEntryId" name="employeeEntry.id">
	<div class="alert alert-info" style="margin-bottom:15px;"><strong><h4>员工基本信息</h4></strong></div>
	<div class="control-group">
		<label class="control-label"><span class="help-inline"><font color="red">*&nbsp;</font> </span>员工姓名：</label>
		<div class="controls">
			<input type="hidden" id="employeeId">
			<input  type="text" id="employeeName" readonly="readonly" value="${employeeCancellation.employeeEntry.employee.name}"  class="required input-large"  placeholder="点击选择添加员工" />
			<input id="selectEmployee" class="btn btn-primary" type="button"  value="选择解约员工"/>
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
				<th>出生日期</th>
			</tr>
			<c:if test="${employeeCancellation.id != null}">
				<tr>

				</tr>
			</c:if>
		</table>
	</div>
	<div class="alert alert-info" style="margin-bottom:15px;"><strong><h4>员工定级和技能项信息</h4></strong></div>
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
			</tr>
			</thead>
			<tbody id="tbody-result">

			</tbody>
		</table>
	</div>
	<div class="control-group">
		<table class="table table-striped table-bordered table-condensed">
			<h6>员工服务技能</h6>
			<thead>
			<tr>
				<th>技能项名称</th>
				<th>计价单位</th>
				<th>类型</th>
				<th>服务结算单价</th>
			</tr>
			</thead>
			<tbody id="tbody-service">

			</tbody>
		</table>
	</div>
	<div class="alert alert-info" style="margin-bottom:15px;"><strong><h4>薪资结构</h4></strong></div>
	<div class="control-group">
		<label class="control-label"><span class="help-inline"><font color="red">*</font> </span> &nbsp;员工性质：</label>
		<div class="controls">
			<input type="radio" id="radio1" disabled="disabled">劳务制&nbsp;&nbsp;
			<input type="radio" id="radio2" disabled="disabled">员工制
		</div>
	</div>
	<div class="control-group">
		<label class="control-label"><span class="help-inline"><font color="red">*</font> </span> &nbsp;有无底薪：</label>
		<div class="controls">
			<input type="radio" id="haveSalaryId" disabled="disabled">有底薪&nbsp;&nbsp;
			<input type="radio" id="noSalaryId" disabled="disabled">无底薪
		</div>
	</div>
	<div class="control-group">
		<label class="control-label"><span class="help-inline"><font color="red">*</font> </span> &nbsp;底薪：</label>
		<div class="controls">
			<input type="text" readonly="readonly" id="baseAmountId" name="baseAmountName"> &nbsp;元/月
		</div>
	</div>
	<div class="alert alert-info" style="margin-bottom:15px;"><strong><h4>持续周期</h4></strong></div>
	<div class="control-group">
		<label class="control-label"><font color="red">*</font> </span> &nbsp;原合同编号：</label>
		<div class="controls">
			<input type="text" id="code" readonly="readonly">
		</div>
	</div>
	<div class="control-group" style="float:left;">
		<label class="control-label"><font color="red">*</font> </span> &nbsp;签约生效日期：</label>
		<div class="controls">
			<input type="text" id="signingEffectiveTime" readonly="readonly" pattern="yyyy-MM-dd HH:mm:ss">
		</div>
	</div>
	<div class="control-group">
		<label class="control-label"><font color="red">*</font> </span> &nbsp;签约截止日期：</label>
		<div class="controls">
			<input type="text" id="signingDeadlineTime" readonly="readonly" pattern="yyyy-MM-dd HH:mm:ss">
		</div>
	</div>
	<div class="control-group" style="float:left;">
		<label class="control-label"><font color="red">*</font> </span> &nbsp;签约操作人：</label>
		<div class="controls">
			<form:input path="" id="createUser" htmlEscape="false" readonly="true" class="input-xlarge"  maxlength="64" style="width: 163px"/>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label"><font color="red">*</font> </span> &nbsp;操作时间：</label>
		<div class="controls">
			<input type="text" id="createTimeId" readonly="readonly" pattern="yyyy-MM-dd HH:mm:ss">
		</div>
	</div>
	<div class="alert alert-info" style="margin-bottom:15px;"><strong><h4><center>申请解约</center></h4></strong></div>
	<div class="control-group">
		<label class="control-label"><span class="help-inline"><font color="red">*</font> </span> &nbsp;解约原因：</label>
		<div class="controls" id="div1">
			<form:select id="selectId" path="cancellationReason" htmlEscape="false" style="width: 160px;">
				<form:options items="${erp:employeeCancellationList()}" itemLabel="name" itemValue="value" htmlEscape="false" />
			</form:select>
			<form:input path="reasonOther" id="reasonOtherId" htmlEscape="false"/>
		</div>

	</div>
	<div class="control-group">
		<label class="control-label"><font color="red">*</font> </span> &nbsp;解约生效日期：</label>
		<div class="controls">
			<input name="cancellationEffectiveTime" id="cancellationEffectiveTimeId" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
				   value="<fmt:formatDate value="${employeeCancellation.cancellationEffectiveTime}" pattern="yyyy-MM-dd"/>"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label"></span> &nbsp;备注</label>
		<div class="controls">
			<form:textarea path="remarks" htmlEscape="false" maxlength="200" class="input-xlarge " rows="3" style="width: 620px;"/>
		</div>
	</div>
	<div class="control-group" style="float:left;">
		<label class="control-label"><font color="red">*</font> </span> &nbsp;解约操作人：</label>
		<div class="controls">
			<sys:treeselect id="user" name="user.id" value="${employeeCancellation.user.id}"
							labelName="user.name" labelValue="${employeeCancellation.user.name}"
							title="选择用户" url="/sys/office/treeData?type=3" cssClass="required" notAllowSelectParent="true"/>
		</div>
	</div>

	<div class="control-group">
		<label class="control-label"><font color="red">*</font> </span> &nbsp;操作时间：</label>
		<div class="controls">
			<input name="createTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
				   value="<fmt:formatDate value="${employeeCancellation.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
		</div>
	</div>
	<div class="form-actions">
		<input id="btnSubmit" class="btn btn-primary" type="submit" value="提交解约申请"/>&nbsp;
		<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
	</div>
</form:form>
<script type="text/javascript">
    $(function() {
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

        lod();


        $("#selectEmployee").click(function (){
            var employeeId = $('#employeeId').val();
            top.$.jBox("iframe:/crm/employeeCancellation/selectEmployeeInService?employeeId="+employeeId,{
                title:"选择解约员工",
                width:1024,
                height:520,
                buttons:{}
            });
        });
    });

    function selectEmployeeCallback(trHtml,selectFlag){
        var id = $(trHtml).attr('id');
        var employeeName = $(trHtml).find('td:first').text();
        $("#employeeId").val(id);
        $("#employeeName").val(employeeName);
        $("#employeeTable  tr:not(:first)").html("");
        if(selectFlag == '选择'){
            $('#employeeTable').append(trHtml);
            findSkill(id);
        }
        if(selectFlag == '取消选择'){
            $('#employeeTable').find('tr[id='+id+']').remove();
            $('#tbody-result').empty("");
            $('#tbody-service').empty("");
            $('#employeeName').val("");
            $('#employeeId').val("");
        }


    }

    function findSkill(id){
        $('#tbody-result').empty("");
        $.ajax({
            type:"POST",
            dataType: "json",
            async:false,
            url:"/crm/employeeCancellation/findEmployeeSkillList",
            data:"employeeId="+id,
            success:function(data){
                $('[name="skillType"]').empty();
                for(var i=0; i<data.length;i++){
                    if (data[i].type == 2){
                        var employeeSkillId = data[i].id
                        var skillId = data[i].skill.id
                        var skillName = data[i].skill.skillName
                        var skillWeightList = data[i].skillWeightList
                        var score = data[i].score
                        var systemServiceLevelName = data[i].systemServiceLevel.name
                        var serviceLevelName = data[i].serviceLevel.name
                        var servicePrice = data[i].servicePrice

                        var weightsHTML = ''
                        for(var j=0; j<skillWeightList.length;j++){
                            weightsHTML = weightsHTML + '<td>'+skillWeightList[j].weightScore+'</td>'
                        }
                        var trHTML = '<tr><td>'+skillName+'</td>'+weightsHTML+'<td>'+score+'</td><td>'+systemServiceLevelName+'</td><td>'+serviceLevelName+'</td>' +
                            '<td>'+servicePrice+'</td></tr>'


                        $('#tbody-result').append(trHTML);
                    }
                    if (data[i].type == 1){
                        $('#tbody-service').empty("");
                        var employeeSkillId = data[i].id
                        var skillId = data[i].skill.id
                        var skillName = data[i].skill.skillName
                        var skillUnitName = data[i].skill.unitName
                        var servicePrice = data[i].servicePrice
                        var trHTML = '<tr><td>'+skillName+'</td><td>'+skillUnitName+'</td><td>'+"单项服务"+'</td><td>'+servicePrice+'</td></tr>';
                        $('#tbody-service').append(trHTML);
                    }
                }
                var type = data[0].entry.type
                if (type == 1){
                    $('#radio1').attr("checked",true);
                }else{
                    $('#radio2').attr("checked",true);
                }
                var basePayStatus = data[0].entry.basePayStatus
                if (basePayStatus == 1){
                    $('#haveSalaryId').attr("checked",true);
                }else{
                    $('#noSalaryId').attr("checked",true);
                }

                //将entry信息带出到本页面
                var baseAmount = data[0].entry.baseAmount;
                var code = data[0].entry.contractCode;
                var takeTime = new Date(data[0].entry.takeTime).Format("yyyy-MM-dd");
                var deadlineTime = new Date(data[0].entry.deadlineTime).Format("yyyy-MM-dd");
                var createTime = new Date(data[0].entry.createTime).Format("yyyy-MM-dd hh:mm:ss");
                var createUser = data[0].entry.user.name;
                var entryId = data[0].entry.id;

                $('#baseAmountId').val(baseAmount);
                $('#code').val(code);
                $('#signingEffectiveTime').val(takeTime);
                $('#signingDeadlineTime').val(deadlineTime);
                $('#createTimeId').val(createTime);
                $('#createUser').val(createUser);
                $('#employeeEntryId').val(entryId);
            }

        });
        //选择员工之后把解约生效日期获取到
        subDeadlineTime();
    }

    //解约原因下拉框控制
    function lod(){
        var sel=document.getElementById("selectId");
        var value = sel.options[sel.selectedIndex].text;
        $('#reasonOtherId').hide();
        if (value == '其他'){
            $('#reasonOtherId').show();
            $('#reasonOtherId').attr("class","required");
        }else{
            $('#reasonOtherId').hide();
        }
        $('#selectId').change(function () {
            var value = sel.options[sel.selectedIndex].text;
            if (value == '其他'){
                $('#reasonOtherId').show();
                $('#reasonOtherId').attr("class","required");
            }else{
                $('#reasonOtherId').hide();
            }
        })

    }

    //解约生效时间：签约截止日期+1天
    function subDeadlineTime(){
        var date = new Date($('#signingDeadlineTime').val());
        date.setDate(date.getDate() + 1);
        var time = date.Format("yyyy-MM-dd");
        $('#cancellationEffectiveTimeId').val(time);
    }

</script>
</body>
</html>
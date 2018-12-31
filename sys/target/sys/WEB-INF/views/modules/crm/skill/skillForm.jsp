<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>技能项管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
		    $("#btnSubmit").click(function(){
		        var category =  $('input[name="category"]:checked').val();
                //提交之前获取选中的checkbox
                var chk_inp_value = new Array();
                var amount;
                $('input[name="serviceLevelId"]:checked').each(function(){
                    $("#serviceLevel"+$(this).val()).addClass("required money valid");
                    amount = $("#serviceLevel"+$(this).val()).val();
                    chk_inp_value.push($(this).val()+";"+amount);
                });
                $("#idsAndAmount").val(chk_inp_value.toString());
                if(chk_inp_value.length == 0 && category == '2' ){
                    $("#message").text("请勾选服务人员结算的级别以及填写计算单价");
					return false;
				}else{
                    return true;
				}
			});
            $('input[name="category"]:checked').each(function(){
                if(this.value == '2'){
                    $("#basics").hide();
                    $("#unit2").removeAttr("checked","checked");
                    $("#unit1").attr("checked","checked");
                    $("#individual").show();

                }else{
                    $("#individual").hide();
                    $("#unit1").removeAttr("checked","checked");
                    $("#unit2").attr("checked","checked");
                    $("#basics").show();
                }
            });

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
		function check(){
            $('input[name="category"]:checked').each(function(){
                if(this.value == '2'){
                    $("#basics").hide();
                    $("#unit2").removeAttr("checked","checked");
                    $("#unit1").attr("checked","checked");

                    $("#individual").show();
                }else{
                    $("#individual").hide();
                    $("#unit1").removeAttr("checked","checked");
                    $("#unit2").attr("checked","checked");
                    $("#basics").show();
                }
            });

        }

	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/crm/skill/list">技能项列表</a></li>
		<li class="active"><a href="${ctx}/crm/skill/form?id=${crmSkill.id}">技能项<shiro:hasPermission name="crm:skill:form">${not empty crmSkill.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="crm:skill:form">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="crmSkill" action="${ctx}/crm/skill/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<input type="hidden" id="idsAndAmount" name="idsAndAmount"/>
		<div class="control-group">
			<label class="control-label">技能项名称：</label>
			<div class="controls">
				<form:input path="skillName" htmlEscape="false" maxlength="512" class="required input-large " style="width: 195px;"/>
				<span class="help-inline"><font color="red">*</font> </span>

			</div>
		</div>
		<div class="control-group">
			<label class="control-label">计价单位：</label>
			<div class="controls">
				<input type="radio"  name="unit" id="unit1" value="1" />天
				<input type="radio"  name="unit" id="unit2" value="2" checked="checked"/>次
				<span class="help-inline" style="margin-left: 30px"><font color="red">*</font> </span>

			</div>
		</div>
		<div class="control-group">
			<label class="control-label">类型：</label>
			<div class="controls">
				<form:radiobuttons path="category" name="category" id="category" items="${erp:skillCatageryList()}" itemLabel="name" itemValue="value" htmlEscape="false" class="required" onchange="check()"/>
				<span class="help-inline" style="margin-left: 70px"><font color="red">*</font> </span>

			</div>
		</div>
		<c:if test="${crmSkill.id != null }">
		<div class="control-group">
			<label class="control-label">状态：</label>
			<div class="controls">
				<form:select path="status" class="input-large ">
					<form:options items="${erp:commonsStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>

			</div>
		</div>
		</c:if>
		<div class="control-group">
			<label class="control-label">服务人员结算单价：</label>
			<div class="controls">
				<div id="basics">
					<input  name="settlementPrice" id="settlementPrice" style="width: 80px" value="${crmSkill.settlementPrice}" class="required money valid">&nbsp;&nbsp;&nbsp;&nbsp;元/次
					<span class="help-inline" style="margin-left: 30px"><font color="red">*</font> </span>
				</div>
				<div id="individual" style="width: 400px;" hidden="hidden">
					<table class="table table-striped table-bordered table-condensed">
						<tr>
							<th></th>
							<th>级别</th>
							<th>计算单价</th>
						</tr>
						<c:forEach items="${crmServiceLevelList}" var="crmServiceLevel">
							<tr>

								<td>
									<input type="checkbox" name="serviceLevelId" value="${crmServiceLevel.id}"
									<c:forEach items="${crmSkillToLevelList}" var="crmSkillToLevel">
										   <c:if test="${crmServiceLevel.id == crmSkillToLevel.levelId}">checked
									</c:if>
									</c:forEach>
									/>

								</td>
								<td>${crmServiceLevel.name}</td>
								<td>
									<input name="serviceLevel${crmServiceLevel.id}" id="serviceLevel${crmServiceLevel.id}" style="width: 80px" value="${crmServiceLevel.levelAmount}">&nbsp;&nbsp;&nbsp;&nbsp;元/天
								</td>
							</tr>
						</c:forEach>


					</table>
				</div>
			</div>
			<div style="margin-left: 190px">
				<span id="message" style="color: red; align-content: center"></span>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="crm:skill:save"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>
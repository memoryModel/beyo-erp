<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>服务等级管理</title>
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
            jQuery.validator.addClassRules("points", {range:[1,100]});
            jQuery.validator.addMethod("nameIsExist", function(value, element) {
                if($("#oldName").val()==value)return true;
                var flag = false;
                $.ajax({
                    type:"POST",
                    async:false,
                    url:"/crm/serviceLevel/isExist",
                    data:"gradename="+value,
                    success: function(data){

                        if(data=="success"){
                            flag = true;
                        }else{
                            flag = false;
                        }
                    }
                });
                return flag;
            }, "等级名称已存在");

		});



	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/crm/serviceLevel/list">服务等级管理列表</a></li>
		<li class="active"><a href="${ctx}/crm/serviceLevel/form?id=${serviceLevel.id}">服务等级管理<shiro:hasPermission name="crm:serviceLevel:form">${not empty serviceLevel.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="crm:serviceLevel:form">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="serviceLevel" action="${ctx}/crm/serviceLevel/save" method="post" class="form-horizontal" >
		<form:hidden path="id"/>
		<input type="hidden" id="oldName" value="${serviceLevel.name}">
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">等级名称：</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" maxlength="215" class="required input-large nameIsExist" id="name"/>
				<span   id="grade"></span>
				<span class="help-inline"  id="gradeInfo"><font color="red" >*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">达标服务单数：</label>
			<div class="controls">
				<form:input path="orderNumber" htmlEscape="false" maxlength="20" class="required input-large  digits" style="width: 50px;text-align: right;"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">达标完美单数比例：</label>
			<div class="controls">
				<form:input path="orderBili" htmlEscape="false" maxlength="20" class="required input-large  points"  style="width: 50px;text-align: right;"/>&nbsp;%
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">达标最低分：</label>
			<div class="controls">
				<form:input path="minScore" htmlEscape="false" maxlength="20" class="required input-large digits"  style="width: 50px;text-align: right;"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">达标上限分：</label>
			<div class="controls">
				<form:input path="maxScore" htmlEscape="false" maxlength="20" class="required input-large  digits" style="width: 50px;text-align: right;" />
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">描述：</label>
			<div class="controls">
				<form:textarea path="description" htmlEscape="false" rows="4" maxlength="215"  style="width:330px"/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="crm:serviceLevel:save"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>
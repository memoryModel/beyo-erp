<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>考核权重管理</title>
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
		});
		function check(){
			var v = $("#percentage").val();
			if(v<0 || v > 100){
                $("#message").text("请填写正确的数字 0-100");
				return false;
			}else{
				return true;
			}
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/crm/weight/list">考核权重列表</a></li>
		<li class="active"><a href="${ctx}/crm/weight/form?id=${crmWeight.id}">考核权重<shiro:hasPermission name="crm:weight:form">${not empty crmWeight.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="crm:weight:form">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="crmWeight" action="${ctx}/crm/weight/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">考核指标：</label>
			<div class="controls">
				<form:input path="checkName" htmlEscape="false" maxlength="1024" class="required input-xlarge "/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">比例：</label>
			<div class="controls">
				<input  name="percentage" id="percentage" style="width: 50px;" value="${crmWeight.percentage}" onchange="check()" class="required">%
				<span id="message" style="color: red"></span>
				<span class="help-inline"><font color="red">*</font> </span>

			</div>
		</div>
		<div class="control-group">
			<label class="control-label">描述：</label>
			<div class="controls">
				<form:textarea path="remark" htmlEscape="false" maxlength="1024" rows="4" style="width:700px;"/>
			</div>
		</div>
		<c:if test="${crmWeight.id != null }">
			<div class="control-group">
				<label class="control-label">状态：</label>
				<div class="controls">
					<form:select path="status" class="input-large ">
						<form:options items="${erp:commonsStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
		</c:if>
		<div class="form-actions">
			<shiro:hasPermission name="crm:weight:save"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>
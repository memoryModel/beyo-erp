<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>单表管理</title>
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
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/erp/dorm/list">宿舍列表</a></li>
		<li class="active"><a href="${ctx}/erp/dorm/form?id=${erpDorm.id}">宿舍<shiro:hasPermission name="erp:dorm:form">${not empty erpDorm.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="erp:dorm:form">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="erpDorm" action="${ctx}/erp/dorm/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="status"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">归属区域:</label>
			<div class="controls">
				<sys:treeselect id="area" name="area.id" value="${erpDorm.area.id}"
								labelName="area.name" labelValue="${erpDorm.area.name}"
								title="区域" url="/sys/area/treeData" cssClass="required" allowClear="true"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		</div>
		<div class="control-group">
			<label class="control-label">管理员姓名：</label>
			<div class="controls">
				<sys:treeselect id="managerId" name="user.id" value="${erpDorm.user.id}"
								labelName="user.name" labelValue="${erpDorm.user.name}"
								title="用户" url="/sys/office/treeData?type=3" cssClass="required" allowClear="true" notAllowSelectParent="true"/>
				<span class="help-inline"><font color="red">*</font> </span>
				</li>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">宿舍名称：</label>
			<div class="controls">
				<form:input path="dormName" htmlEscape="false" maxlength="1024" style="width:250px;"  class="required input-xlarge " />
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">宿舍地址：</label>
			<div class="controls">
				<form:textarea path="dormAddress" htmlEscape="false" maxlength="1024" rows="2" style="width:750px;" class="required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">交通信息：</label>
			<div class="controls">
				<form:textarea path="trafficInfo" htmlEscape="false" rows="5" style="width:750px;" maxlength="1024" />
			</div>
		</div>
			<%--<div class="control-group">
				<label class="control-label">状态：</label>
				<div class="controls">
					<form:select path="status" class="input-large ">
						<form:options items="${erp:commonsStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>--%>
		<div class="form-actions">
			<shiro:hasPermission name="erp:dorm:save"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>
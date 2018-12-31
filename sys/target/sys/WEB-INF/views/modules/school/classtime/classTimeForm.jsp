<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>上课时段管理</title>
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
	<li><a href="${ctx}/school/classTime/list">上课时段列表</a></li>
	<li class="active"><a href="${ctx}/school/classTime/form?id=${classTime.id}">上课时段<shiro:hasPermission name="school:classTime:form">${not empty classTime.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="school:classTime:form">查看</shiro:lacksPermission></a></li>
</ul><br/>
<form:form id="inputForm" modelAttribute="classTime" action="${ctx}/school/classTime/save" method="post" class="form-horizontal">
	<form:hidden path="id"/>
	<sys:message content="${message}"/>
	<div class="control-group">
		<label class="control-label">名称：</label>
		<div class="controls">
			<form:input path="lessonName" htmlEscape="false" maxlength="255" class="required input-xlarge " style="width: 200px"/>
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">开始时间：</label>
		<div class="controls">
			<input name="startTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required" style="width: 200px"
				   value="${classTime.startTime}"
				   onclick="WdatePicker({dateFmt:'HH:mm',isShowClear:true});"/>
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">结束时间：</label>
		<div class="controls">
			<input name="endTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required" style="width: 200px"
				   value="${classTime.endTime}"
				   onclick="WdatePicker({dateFmt:'HH:mm',isShowClear:true});"/>
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
	</div>
	<c:if test="${classTime.id != null }">
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
	<div class="form-actions">
		<shiro:hasPermission name="school:classTime:save"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
		<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
	</div>
</form:form>
</body>
</html>
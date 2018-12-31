<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>入住管理管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
            var date = new Date();
            var currentTime = date.Format("yyyy-MM-dd hh:mm");
            $("#liveTime").val(currentTime);
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
            $("#selectStudent").click(function () {
                jbox =  top.$.jBox.open("iframe:/erp/dormStudentLive/selectStudent", "添加学员", 1024, 520);
            });
        });
        function selectStudentCallback(studentId,name,studentNumber,phone,userName,userPhone,nativePlaces){
            console.log("#btnSelect"+studentId+name,studentNumber,phone,userName,userPhone,nativePlaces);

            $("#studentId").val(studentId);
            $("#name").val(name);
            $("#studentNumber").val(studentNumber);
            $("#phone").val(phone);
            $("#userName").val(userName);
            $("#userPhone").val(userPhone);
            $("#nativePlaces").val(nativePlaces);
        }

	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/erp/dormStudentLive/form?id=${dormStudentLive.id}">新增学员入住<shiro:hasPermission name="erp:dormStudentLive:form">${not empty dormStudentLive.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="erp:dormStudentLive:form">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="dormStudentLive" action="${ctx}/erp/dormStudentLive/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">学员姓名：</label>
			<div class="controls">
				<input type="hidden" name="erpStudentEnroll.id" id="studentId" value="${dormStudentLive.erpStudentEnroll.id}">
				<input  type="text"  name="erpStudentEnroll.name" id="name" value="${dormStudentLive.erpStudentEnroll.name}"
						style="width:150px;" placeholder="点击选择添加学员" readonly=readonly class="required"/>&nbsp;&nbsp;
				<input id="selectStudent" class="btn btn-primary" type="button" value="选择学员"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">学员编号：</label>
			<div class="controls">
				<input type="text" value="${dormStudentLive.erpStudentEnroll.studentNumber}" id="studentNumber" readonly="readonly">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">学员联系方式：</label>
			<div class="controls">
				<input type="text" value="${dormStudentLive.erpStudentEnroll.phone}" id="phone" readonly="readonly">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">班主任：</label>
			<div class="controls">
				<input type="text" value="${dormStudentLive.erpStudentEnroll.schoolClassStudents.schoolClass.headteacher.name}" id="userName" readonly="readonly">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">班主任电话：</label>
			<div class="controls">
               <input type="text" value="${dormStudentLive.erpStudentEnroll.schoolClassStudents.schoolClass.headteacher.phone}" id="userPhone" readonly="readonly">			</div>
		</div>
		<div class="control-group">
			<label class="control-label">籍贯：</label>
			<div class="controls">
				<input type="text" value="${dormStudentLive.area.name}" id="nativePlaces" readonly="readonly">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">入住时间：</label>
			<div class="controls">
				<input name="liveTime" id="liveTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate " style="width: 205px;"
					   value="<fmt:formatDate value="${dormStudentLive.liveTime}" pattern="yyyy-MM-dd HH:mm"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:false});" class="required"/>
			</div>
		</div>
			<%--<div class="control-group">
				<label class="control-label">状态：</label>
				<div class="controls">
					<form:select path="status" class="input-large ">
						<form:options items="${erp:liveStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
					</form:select>
				</di v>
			</div>
--%>
		<div class="form-actions">
			<shiro:hasPermission name="erp:dormStudentLive:save"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>
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

            var jbox;
            $("#selectEnroll").click(function () {
                jbox =  top.$.jBox.open("iframe:/erp/packageDeposit/selectEnroll", "添加学员", 1024, 520);
            });
            $("#selectEmployee").click(function () {
                jbox =  top.$.jBox.open("iframe:/erp/packageDeposit/selectEmployee", "添加员工", 1024, 520);
            });
        });

        function selectEnrollCallback(studentId,name,phone,stuNumber){
            console.log("#btnSelect"+studentId+name,phone,stuNumber);
            $("#type").val(2);
            $("#studentId").val(studentId);
            $("#name").val(name);
            $("#phone").val(phone);
            $("#card").val(stuNumber);
        }
        function selectEmployeeCallback(employeeId,name,phone,empCard){
            console.log("#btnSelect"+employeeId+name,phone,empCard);
            $("#type").val(1);
            $("#employeeId").val(employeeId);
            $("#name").val(name);
            $("#phone").val(phone);
            $("#card").val(empCard);
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/erp/packageDeposit/list">寄取管理列表</a></li>
		<li class="active"><a href="${ctx}/erp/packageDeposit/form?id=${packageDeposit.id}">新增寄件<shiro:hasPermission name="erp:packageDeposit:form">${not empty packageDeposit.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="erp:packageDeposit:form">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="packageDeposit" action="${ctx}/erp/packageDeposit/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<input type="hidden"  name="type" id="type"/>
		<table id="contentTable">
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">行李编号：</label>
						<div class="controls">
							<form:input path="packageCode" htmlEscape="false" maxlength="64" class="required input-large " style="width: 240px;"/>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">所属人：</label>
						<div class="controls">
							<div id="type1">
								<input type="hidden" name="erpStudentEnroll.id" id="studentId" >
								<input type="hidden" name="employee.id" id="employeeId">
								<input  type="text"  name="name" id="name"
										style="width:150px;" placeholder="点击添加学员/员工" readonly="readonly" class="required"/>&nbsp;&nbsp;
								<input id="selectEnroll" class="btn btn-primary" type="button" value="选择学员"/>
								<input id="selectEmployee" class="btn btn-primary" type="button" value="选择员工"/>
								<span class="help-inline"><font color="red">*</font> </span>
							</div>
					     </div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">联系方式：</label>
						<div class="controls">
							<input type="text" id="phone"  readonly="readonly" style="width: 240px;">
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">身份证号：</label>
						<div class="controls">
							<input type="text" id="card"  readonly="readonly" style="width: 240px;">
						</div>
					</div>
				</td>
		    </tr>
			<tr>
				<td colspan="3">
					<div class="control-group">
						<label class="control-label">物品清单：</label>
						<div class="controls">
							<form:textarea path="packages" htmlEscape="false" rows="4" style="width:690px;" maxlength="1024" class="required"/>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
			</tr>
		</table>
		<div class="form-actions">
			<shiro:hasPermission name="erp:packageDeposit:save"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>
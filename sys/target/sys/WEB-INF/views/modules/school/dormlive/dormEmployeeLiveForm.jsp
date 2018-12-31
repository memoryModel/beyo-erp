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
            $("#selectEmployee").click(function () {
                jbox =  top.$.jBox.open("iframe:/erp/dormEmployeeLive/selectEmployee", "添加学员", 1024, 520);
            });
        });

        var flag = 0;
        function selectEmployeeCallback(id){
            $.get("/erp/employee/employeeInfo",{"id":id},function (data) {
                console.log(data);
                if (data.status == "success"){
                    showEmployee(data.employee);

                }else{
                    loading('加载失败');
                    setTimeout("closeLoading()",2000);
                }
            }).error(function() {
                loading('加载失败');
                setTimeout("closeLoading()",2000);
            });

            flag = 0;

        }

        function showEmployee(employee) {
            $("#employeeId").val(employee.id);
            $("#name").val(employee.name);
            $("#code").val(employee.code);
            $("#phone").val(employee.phone);
            $("#empCard").val(employee.idcard);
            if(employee.originalArea){
                $("#originalAreaId").val(employee.originalArea.name);
            }
            if(employee.profession && employee.profession!=""){
                var array = employee.profession.split(",");
                for(var i=0;i<array.length;i++){
                    $("input[name='professionName'][value='"+array[i]+"']").attr("checked",true);

                }

            }
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/erp/dormEmployeeLive/form?id=${dormEmployeeLive.id}">新增员工入住<shiro:hasPermission name="erp:dormEmployeeLive:form">${not empty dormEmployeeLive.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="erp:dormEmployeeLive:form">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="dormEmployeeLive" action="${ctx}/erp/dormEmployeeLive/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<div class="control-group">
			<label class="control-label">员工姓名：</label>
			<div class="controls">
				<input type="hidden" name="erpEmployee.id" id="employeeId" value="${dormEmployeeLive.erpEmployee.id}">
				<input  type="text"  name="erpEmployee.name" id="name" value="${dormEmployeeLive.erpEmployee.name}"
						style="width:150px;" placeholder="点击选择添加员工" readonly=readonly class="required"/>&nbsp;&nbsp;
				<input id="selectEmployee" class="btn btn-primary" type="button" value="选择员工"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">员工编号：</label>
			<div class="controls">
				<input type="text" value="${dormEmployeeLive.erpEmployee.code}" id="code" readonly="readonly">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">员工联系方式：</label>
			<div class="controls">
				<input type="text" value="${dormEmployeeLive.erpEmployee.phone}" id="phone" readonly="readonly">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">专业：</label>
			<div class="controls">
				<form:checkboxes path="professionName" items="${erp:getCommonsTypeList(21)}" itemLabel="commonsName" itemValue="id" htmlEscape="false" disabled="true"/>

			</div>
		</div>
		<div class="control-group">
			<label class="control-label">身份证号：</label>
			<div class="controls">
				<input type="text" value="${dormEmployeeLive.erpEmployee.idcard}" id="empCard" readonly="readonly">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">籍贯：</label>
			<div class="controls">
				<input type="text" value="${dormEmployeeLive.erpEmployee.originalArea.name}" id="originalAreaId" readonly="readonly">
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">管理老师：</label>
			<div class="controls">
				<sys:treeselect id="handleNameId" name="handleName.id" value="${dormEmployeeLive.handleName.id}"
								labelName="handleName.name" labelValue="${dormEmployeeLive.handleName.name}"
								title="用户" url="/sys/office/treeData?type=3" notAllowSelectParent="true" allowClear="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">入住时间：</label>
			<div class="controls">
				<input name="liveTime" id="liveTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate " style="width: 205px;"
					   value="<fmt:formatDate value="${dormEmployeeLive.liveTime}" pattern="yyyy-MM-dd HH:mm"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:false});" class="required"/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="erp:dormEmployeeLive:save"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>
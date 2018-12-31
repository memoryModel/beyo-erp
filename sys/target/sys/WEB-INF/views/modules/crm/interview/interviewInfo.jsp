<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>面试管理管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
        $(document).ready(function() {

            $(document).find("a[name='saleForm']").each(function () {

                var id = $(this).attr("id");
                $(this).click(function () {
                    top.$.jBox("iframe:/crm/interview/selectDelegate?id="+id,
						{
                            title:"选择面试",
                            width:500,
                            height:550,
							buttons:{}
						}
                    );
                });
            });

        });

		$(document).ready(function() {
            $.validator.addMethod("checkTime",function (value, element) {

                var interviewTime = $("#interviewTime").val();
                if(!interviewTime)return true;

                var interviewDate = new Date(interviewTime);
                if(interviewDate.getTime()>(new Date()).getTime()){
					return false;
                }

                return true;
            },"面试时间不能超过当前时间!");

			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")){
						error.appendTo(element.parent().parent());
					}else if(element.parent().is(".input-append")){
                        $(error).text("必填信息");
                        element.parents(".controls").append(error);
                    } else {
						error.insertAfter(element);
					}
				}
			});
            $("#selectEmployee").click(function () {
                jbox =  top.$.jBox("iframe:/crm/interview/selectEmployee",
					{
                        title:"添加员工",
						width:1024,
						height:520,
						buttons:{}
					});
            });
		});


        function selectEmployeeCallback(id,phone,name,sex,profession,customerResource){
            $("#employeeId").val(id);
            $("#phone").val(phone);
            $("#name").val(name);
            $("#sex").val(sex);
            $("#profession").val(profession);
            $("#customerResource").val(customerResource);
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/crm/interview/list">面试管理列表</a></li>
<%--
		<li class="active"><a href="${ctx}/crm/interview/form?id=${interview.id}">面试管理<shiro:hasPermission name="crm:interview:form">${not empty interview.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="crm:interview:form">查看</shiro:lacksPermission></a></li>
--%>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="interview" action="${ctx}/crm/interview/save" method="post" class="form-horizontal">
		<%--<form:hidden path="id"/>--%>
		<input type="hidden" name="employee.id" id="employeeId" value="${interview.employee.id}">
		<input type="hidden" name="id" value="${interview.id}">
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">员工姓名：</label>
			<div class="controls">
				<input type="hidden" name="employee.id" id="id" value="${employee.id}">
				<input  type="text"   id="name" value="${interview.employee.name}"  class="required input-large" readonly="true"   placeholder="点击选择添加员工" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">员工手机：</label>
			<div class="controls">
				<input  type="text" id="phone" readonly="true" value="${interview.employee.phone}"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">性别：</label>
			<div class="controls">
				<input  type="text"  id="sex" readonly="true" value="${erp:sexStatusName(interview.employee.sex)}"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">工种：</label>
			<div class="controls">
				<input  type="text"  id="profession" readonly="true" value="${erp:getCommonsTypeName(interview.employee.profession)}"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">来源：</label>
			<div class="controls">
				<input  type="text"  id="customerResource" readonly="true" value="${interview.customerResource.customerName}"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">面试时间：</label>
			<div class="controls">
				<input id="interviewTime" name="interviewTime" type="text" maxlength="20" class="required input-medium Wdate checkTime" style="width: 205px;"
					   value="<fmt:formatDate value="${interview.interviewTime}" pattern="yyyy-MM-dd HH:mm"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">面试结果：</label>
			<div class="controls">
				<form:select path="interviewStatus" class="required input-large "  style="width: 220px">
					<form:options items="${erp:interviewStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">面试人：</label>
			<div class="controls">
				<sys:treeselect id="interviewers" name="interviewers.id" value="${interview.interviewers.id}"
								labelName="interviewers.name" labelValue="${interview.interviewers.name}"
								title="选择用户" url="/sys/office/treeData?type=3" notAllowSelectParent="true" cssClass="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remark" htmlEscape="false" maxlength="200" class="input-xlarge " rows="3" style="width: 620px;"/>
			</div>
		</div>
		<div class="form-actions">
			<%--<shiro:hasPermission name="crm:interview:save">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
			</shiro:hasPermission>--%>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>
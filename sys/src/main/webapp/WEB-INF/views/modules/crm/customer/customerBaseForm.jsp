<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>客户管理</title>
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
            $("#selectCustomer").click(function () {
                jbox =  top.$.jBox.open("iframe:/erp/employee/selectCustomer", "选择客户", 1024, 520);
            });
            $("#selectUser").click(function () {
                jbox =  top.$.jBox.open("iframe:/erp/employee/selectUser", "选择员工", 1024, 520);
            });
            $("#selectServicePeople").click(function () {
                jbox =  top.$.jBox.open("iframe:/erp/employee/selectServicePeople", "选择服务人员", 1024, 520);
            });

            jQuery.validator.addMethod("phoneExist", function(value, element) {
                if($("#oldPhone").val()==value)return true;
                var flag = false;
                $.ajax({
                    type:"POST",
                    async:false,
                    url:"/crm/customer/isExist",
                    data:"graphone="+value,
                    success: function(data){
                        console.log(data);
                        if(data=="success"){
                            flag = true;
                        }else{
                            flag = false;
                        }
                    }
                });
                return flag;
            }, "手机号码已存在");

        });

        function selectCustomerCallback(customerId,names){
            console.log("#btnSelect"+customerId+names);
            $("#tableType").val("1");
            $("#recommendId").val(customerId);
            $("#recommendName").val(names);
        }
        function selectUserCallback(userId,name){
            console.log("#btnSelect"+userId+name);
            $("#tableType").val("2");
            $("#recommendId").val(userId);
            $("#recommendName").val(name);

        }

        function selectServicePeopleCallback(servicePeopleId,name){
            console.log("#btnSelect"+servicePeopleId+name);
            $("#tableType").val("3");
            $("#recommendId").val(servicePeopleId);
            $("#recommendName").val(name);
        }

	</script>
</head>
<body>
<ul class="nav nav-tabs">
	<%--<li><a href="${ctx}/crm/customer/list">客户列表</a></li>--%>
	<li class="active"><a href="${ctx}/crm/customer/baseCustomerForm?id=${customer.id}">客户<shiro:hasPermission name="crm:customer:form">${not empty customer.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="crm:customer:form">查看</shiro:lacksPermission></a></li>

</ul><br/>
<form:form id="inputForm" modelAttribute="customer" action="${ctx}/crm/customer/saveBaseCustomerInfo" method="post" class="form-horizontal">
	<form:hidden path="id"/>
	<form:hidden path="status"/>
	<input type="hidden" value="${employee.createTime}" id="createTime" name="createTime">
	<input type="hidden" id="recommendId" name="recommendId" >
	<input type="hidden" value="${customer.phone}" id="oldPhone">
	<sys:message content="${message}"/>
	<div class="alert alert-info">基本信息</div>
	<div>
		<table>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">客户编号：</label>
						<div class="controls">
							<form:input path="code" htmlEscape="false" maxlength="200" readonly="true" class="required input-large "/>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">客户姓名：</label>
						<div class="controls">
							<form:input path="name" htmlEscape="false" maxlength="50" class="required input-large " />
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">手机号码：</label>
						<div class="controls">
							<form:input path="phone"  id="phone"  htmlEscape="false" maxlength="50" class="required mobile phoneExist valid"/>
							<span id="grade"></span>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>

			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">客户性别：</label>
						<div class="controls">
							<form:select path="sex" class="required input-large" >
								<form:options items="${erp:sexStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
							</form:select>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">出生日期：</label>
						<div class="controls">
							<input name="birthTime" type="text" maxlength="20" class="input-medium Wdate "
								   value="<fmt:formatDate value="${customer.birthTime}" pattern="yyyy-MM-dd"/>"
								   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
						</div>
					</div>
				</td>

			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">QQ号码：</label>
						<div class="controls">
							<form:input path="qqCode" htmlEscape="false" maxlength="50"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">邮箱地址：</label>
						<div class="controls">
							<form:input path="email" htmlEscape="false" maxlength="128" class="email valid "/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">客户来源：</label>
						<div class="controls">
							<sys:treeselect id="customerResource" name="customerResource.id" value="${customer.customerResource.id}"
											labelName="customerResource.customerName" labelValue="${customer.customerResource.customerName}"
											title="来源名称" url="/erp/customerResource/treeData" cssClass="required"/>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">客户类别：</label>
						<div class="controls">
							<form:select path="type" class="required input-large" >
								<form:options items="${erp:customerTypeList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
							</form:select>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div class="control-group">
						<label class="control-label">推荐人：</label>

						<div class="controls">
							<c:if test="${customer.id == null || customer.recommendId == null}">
								<input  type="text"   id="recommendName"
										style="width:200px;" readonly="readonly" />&nbsp;&nbsp;
							</c:if>
							<c:if test="${customer.id != null }">
								<c:if test="${customer.tableType == 1}">
									<input  type="text"   id="recommendName"
											style="width:200px;" readonly="readonly" value="${customer.customer.names}"/>&nbsp;&nbsp;
								</c:if>
								<c:if test="${customer.tableType == 2}">
									<input  type="text"   id="recommendName"
											style="width:200px;" readonly="readonly" value="${customer.user.name}"/>&nbsp;&nbsp;
								</c:if>
								<c:if test="${customer.tableType == 3}">
									<%-- <form:input path="" htmlEscape="false" maxlength="50" class="input-large" readonly="true" value="${recommonedName}"/>--%>
									<input  type="text"   id="recommendName"
											style="width:200px;" readonly="readonly" value="${recommendNames}"/>&nbsp;&nbsp;
								</c:if>
							</c:if>
							<input id="selectCustomer" class="btn btn-primary" type="button" value="从客户中选择"/>
							<input id="selectUser" class="btn btn-primary" type="button" value="从员工中选择"/>
							<input id="selectServicePeople" class="btn btn-primary" type="button" value="从服务人员中选择"/>
						</div>

					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">所在地区：</label>
						<div class="controls">
							<sys:treeselect id="area" name="area.id" value="${crmCustomerManagement.area.id}"
											labelName="area.name" labelValue="${crmCustomerManagement.area.name}"
											title="区域" url="/sys/area/treeData" cssClass="required" allowClear="true"/>
							<span class="help-inline" style="margin-left: 20px"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">详情地址：</label>
						<div class="controls">
							<form:textarea path="address" htmlEscape="false" rows="4" maxlength="200" class="required input-xxlarge "/>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">信息获取人：</label>
						<div class="controls" id="divHandleNameId">
							<sys:treeselect id="handleNameId" name="infoCollect.id" value="${customer.infoCollect.id}"
											labelName="infoCollect.name" labelValue="${customer.infoCollect.name}"
											title="用户" url="/sys/office/treeData?type=3" notAllowSelectParent="true" allowClear="true" cssClass="required"/>
							<span class="help-inline"><font color="red">*</font> </span>
							<input id="hdNameValue" type="hidden" value="${customer.infoCollect.name}">
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div class="controls">
						<input type="checkbox" id="checkBoxId" name="checkBoxId">委派自己为客户跟进人
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">信息添加人：</label>
						<div class="controls">
							<form:input path="creater.name" htmlEscape="false"  maxlength="1024" class="input-large " readonly="true" value="${createUserName}"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">添加时间：</label>
						<div class="controls">
							<input  name="createTime" type="text"  class="input-medium Wdate "
									value="<fmt:formatDate value="${customer.createTime}" pattern="yyyy-MM-dd HH:mm"/>" readonly="readonly"/>
						</div>
					</div>
				</td>
			</tr>
		</table>
	</div>
	</table>

	<div class="form-actions">
		<shiro:hasPermission name="crm:customer:save">
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
		</shiro:hasPermission>
		<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
	</div>

</form:form>
</body>
</html>
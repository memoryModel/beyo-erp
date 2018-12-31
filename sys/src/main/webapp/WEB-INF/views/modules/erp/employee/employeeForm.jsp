<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>员工列表管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
		    //自动获取的时间
            /*var date = new Date();
            var currentTime = date.Format("yyyy-MM-dd hh:mm");
            $("#entryTime").val(currentTime);*/
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
		<li><a href="${ctx}/erp/employee/list">员工列表</a></li>
		<li class="active"><a href="${ctx}/erp/employee/form?id=${employee.id}">员工<shiro:hasPermission name="erp:employee:form">${not empty employee.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="erp:employee:form">修改</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="employee" action="${ctx}/erp/employee/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<table>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">员工编号：</label>
						<div class="controls">
								${employee.code}
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">员工出生日期：</label>
						<div class="controls">
							<input name="birthTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate " style="width: 210px"
								   value="<fmt:formatDate value="${employee.birthTime}" pattern="yyyy-MM-dd"/>"
								   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">员工姓名：</label>
						<div class="controls">
							<form:input path="name" htmlEscape="false" maxlength="50" class="required input-xlarge " style="width: 210px;"/>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">户口性质：</label>
						<div class="controls">
							<form:select path="familyNature" class="input-large" style="width: 220px">
								<form:options items="${erp:getCommonsTypeList(48)}" itemLabel="commonsName"  itemValue="id" htmlEscape="false"/>
							</form:select>
						</div>
					</div>
				</td>
		    </tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">入职日期：</label>
						<div class="controls">
							<input name="entryTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate " style="width: 210px"
								   value="<fmt:formatDate value="${employee.entryTime}" pattern="yyyy-MM-dd"/>"
								   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">性别：</label>
						<div class="controls">
							<form:select path="sex" class="required input-xlarge " style="width: 220px">
								<form:options items="${erp:sexStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
							</form:select>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>

				<td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">身份证号：</label>
						<div class="controls">
							<form:input path="idcard" htmlEscape="false" maxlength="128" class="required card valid " style="width: 210px;"/>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">政治面貌：</label>
						<div class="controls">
							<form:select path="politicalOutlook" class="input-large" style="width: 220px">
								<form:options items="${erp:getCommonsTypeList(47)}" itemLabel="commonsName"  itemValue="id" htmlEscape="false"/>
							</form:select>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">毕业学校：</label>
						<div class="controls">
							<form:input path="graduationSchool" htmlEscape="false" maxlength="50" class="input-xlarge " style="width: 210px;"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">员工状态：</label>
						<div class="controls">
							<form:select path="employeeStatus" class="required input-xlarge " style="width: 220px">
								<form:options items="${erp:employeeStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
							</form:select>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">参加工作日期：</label>
						<div class="controls">
							<input name="jobTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate " style="width: 210px"
								   value="<fmt:formatDate value="${employee.jobTime}" pattern="yyyy-MM-dd"/>"
								   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>

						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">民族：</label>
						<div class="controls">
							<form:select path="nation.id" class="input-large" style="width: 220px">
								<form:options items="${erp:getCommonsTypeList(43)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
							</form:select>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">住宅电话：</label>
						<div class="controls">
							<form:input path="homePhone" htmlEscape="false" maxlength="50" class=" simplePhone valid " style="width: 210px;"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">婚姻状况：</label>
						<div class="controls">
							<form:select path="marriage" class="input-large " style="width: 220px">
								<form:options items="${erp:marriageStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
							</form:select>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">手机号码：</label>
						<div class="controls">
							<form:input path="phone" htmlEscape="false" maxlength="50" class="required mobile valid " style="width: 210px;"/>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">最高学历：</label>
						<div class="controls">
							<form:select path="education" class="input-large" style="width: 220px">
								<form:options items="${erp:getCommonsTypeList(7)}" itemLabel="commonsName"  itemValue="id" htmlEscape="false"/>
							</form:select>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">紧急联系人：</label>
						<div class="controls">
							<form:input path="emergencyContact" htmlEscape="false" maxlength="50" class="required input-xlarge " style="width: 210px;"/>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">专业：</label>
						<div class="controls">
							<form:select path="profession" class="input-large" style="width: 220px">
								<form:options items="${erp:getCommonsTypeList(21)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
							</form:select>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">电子邮箱：</label>
						<div class="controls">
							<form:input path="email" htmlEscape="false" maxlength="50" class="email valid " style="width: 210px;"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">来源：</label>
						<div class="controls">
							<sys:treeselect id="customerResource" name="customerResource.id" value="${employee.customerResource.id}"
											labelName="customerResource.customerName" labelValue="${employee.customerResource.customerName}"
											title="来源名称" url="/erp/customerResource/treeData"  />

						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">紧急联系人电话：</label>
						<div class="controls">
							<form:input path="emergencyContactPhone" htmlEscape="false" maxlength="50" class="required simplePhone valid " style="width: 210px;"/>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
		    </tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">现居住地：</label>
						<div class="controls">
							<sys:treeselect id="area1" name="currentArea.id" value="${employee.currentArea.id}"
											labelName="currentArea.name" labelValue="${employee.currentArea.name}"
											title="区域" url="/sys/area/treeData" />
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">籍贯：</label>
						<div class="controls">
							<sys:treeselect id="area" name="originalArea.id" value="${employee.originalArea.id}"
											labelName="originalArea.name" labelValue="${employee.originalArea.name}"
											title="区域" url="/sys/area/treeData" />
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">居住地(文本)：</label>
						<div class="controls">
							<form:textarea path="currentStreet" htmlEscape="false" rows="4"  class="required input-xlarge " maxlength="1024"  style="width:350px"/>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">籍贯(文本)：</label>
						<div class="controls">
							<form:textarea path="originalStreet" htmlEscape="false" rows="4"  class="required input-xlarge " maxlength="1024"  style="width:350px"/>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
		    </tr>
		</table>
		<div class="form-actions">
			<shiro:hasPermission name="erp:employee:save"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>
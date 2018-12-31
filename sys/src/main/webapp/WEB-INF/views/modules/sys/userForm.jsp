<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用户管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#no").focus();
			$("#inputForm").validate({
				rules: {
					loginName: {remote: "${ctx}/sys/user/checkLoginName?oldLoginName=" + encodeURIComponent('${user.loginName}')}
				},
				messages: {
					loginName: {remote: "用户登录名已存在"},
					confirmNewPassword: {equalTo: "输入与上面相同的密码"}
				},
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
            jQuery.validator.addMethod("idCardExist", function(value, element) {
                if($("#oldIdCard").val()==value)return true;
                var flag = false;
                $.ajax({
                    type:"POST",
                    async:false,
                    url:"/sys/user/idCardExist",
                    data:"idcard="+value,
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
            }, "身份证号已存在");
            jQuery.validator.addMethod("modileExist", function(value, element) {
                if($("#oldPhone").val()==value)return true;
                var flag = false;
                $.ajax({
                    type:"POST",
                    async:false,
                    url:"/sys/user/mobileExist",
                    data:"phone="+value,
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
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/sys/user/list">用户列表</a></li>
		<li class="active"><a href="${ctx}/sys/user/form?id=${user.id}">用户<shiro:hasPermission name="sys:user:edit">${not empty user.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="sys:user:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="user" action="${ctx}/sys/user/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="no"/>
		<form:hidden path="platformId"/>
		<form:hidden path="userType"/>
		<form:hidden path="createDate"/>
		<input type="hidden" id="oldIdCard" value="${user.idcard}"/>
		<input type="hidden" id="oldPhone" value="${user.mobile}"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">归属公司:</label>
			<div class="controls">
				<sys:treeselect id="company" name="company.id" value="${user.company.id}" labelName="company.name" labelValue="${user.company.name}"
								title="公司" url="/sys/office/treeData?type=1" cssClass="required" notAllowSelectParent="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">归属部门:</label>
			<div class="controls">
				<sys:treeselect id="office" name="office.id" value="${user.office.id}" labelName="office.name" labelValue="${user.office.name}"
								title="部门" url="/sys/office/treeData?type=2" parentId="company" cssClass="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">员工级别:</label>
			<div class="controls">

				<form:select path="employeeLevelId">
					<form:options items="${levels}" itemLabel="jobName" itemValue="id" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">姓名:</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" maxlength="50" class="required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">登录名:</label>
			<div class="controls">
				<input id="oldLoginName" name="oldLoginName" type="hidden" value="${user.loginName}">
				<form:input path="loginName" htmlEscape="false" maxlength="50" class="required userName"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">密码:</label>
			<div class="controls">
				<input id="newPassword" name="newPassword" type="password" value="" maxlength="50" minlength="3" class="${empty user.id?'required':''}"/>
				<c:if test="${empty user.id}"><span class="help-inline"><font color="red">*</font> </span></c:if>
				<c:if test="${not empty user.id}"><span class="help-inline">若不修改密码，请留空。</span></c:if>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">确认密码:</label>
			<div class="controls">
				<input id="confirmNewPassword" name="confirmNewPassword" type="password" value="" maxlength="50" minlength="3" equalTo="#newPassword"/>
				<c:if test="${empty user.id}"><span class="help-inline"><font color="red">*</font> </span></c:if>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">手机:</label>
			<div class="controls">
				<form:input path="mobile" htmlEscape="false" maxlength="100" cssClass="required modileExist"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">邮箱:</label>
			<div class="controls">
				<form:input path="email" htmlEscape="false" maxlength="100" class="email"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">电话:</label>
			<div class="controls">
				<form:input path="phone" htmlEscape="false" maxlength="100"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">是否允许登录:</label>
			<div class="controls">
				<form:select path="loginFlag">
					<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> “是”代表此账号允许登录，“否”则表示此账号不允许登录</span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">用户角色:</label>
			<div class="controls" style="width: 600px;">
				<form:checkboxes path="roleIdList" items="${allRoles}" itemLabel="name" itemValue="id" htmlEscape="false" class="required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注:</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="input-xlarge"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">身份证号：</label>
			<div class="controls">
				<form:input path="idcard" htmlEscape="false" maxlength="128" class="card idCardExist"  style="width: 210px;"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">出生日期：</label>
			<div class="controls">
				<input  name="birthTime" type="text" style="width: 210px" class="input-medium Wdate "
						value="<fmt:formatDate value="${user.birthTime}" pattern="yyyy-MM-dd"/>"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">参加工作日期：</label>
			<div class="controls">
				<input name="jobTime" type="text"  style="width: 210px" class="input-medium Wdate "
					   value="<fmt:formatDate value="${user.jobTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">入职日期：</label>
			<div class="controls">
				<input name="entryTime" type="text"  style="width: 210px" class="input-medium Wdate "
					   value="<fmt:formatDate value="${user.entryTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">民族：</label>
			<div class="controls">
				<form:select path="nation" class="input-large" style="width: 220px;">
					<form:options items="${erp:getCommonsTypeList(43)}" readonly="true" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">性别：</label>
			<div class="controls">
				<form:select path="sex" class="required" style="width: 210px;">
					<form:options items="${erp:sexStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">最高学历：</label>
			<div class="controls">
				<form:select path="education" class="input-large" style="width: 220px">
					<form:options items="${erp:getCommonsTypeList(7)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">婚姻状况：</label>
			<div class="controls">
				<form:select path="marriage" class="input-large ">
					<form:options items="${erp:marriageStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">户口性质：</label>
			<div class="controls">
				<form:select path="registerPlace" class="input-large" style="width: 220px">
					<form:options items="${erp:getCommonsTypeList(48)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">政治面貌：</label>
			<div class="controls">
				<form:select path="political" class="input-large" style="width: 220px">
					<form:options items="${erp:getCommonsTypeList(47)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">毕业院校:</label>
			<div class="controls">
				<form:input path="graduationSchool" htmlEscape="false" maxlength="100" class=""/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">所修专业:</label>
			<div class="controls">
				<form:input path="schoolMajor" htmlEscape="false" maxlength="100" class=""/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">籍贯：</label>
			<div class="controls">
				<sys:treeselect id="area" name="originalArea.id" value="${user.originalArea.id}"
								labelName="originalArea.name" labelValue="${user.originalArea.name}"
								title="区域" url="/sys/area/treeData" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">详细地址：</label>
			<div class="controls">
				<form:input path="originalStreet" htmlEscape="false"  maxlength="1024" class="input-xlarge " style="width: 210px;"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">现居住地：</label>
			<div class="controls">
				<sys:treeselect id="area1" name="currentArea.id" value="${user.currentArea.id}"
								labelName="currentArea.name" labelValue="${user.currentArea.name}"
								title="区域" url="/sys/area/treeData"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">现居住地地址：</label>
			<div class="controls">
				<form:input path="currentStreet" htmlEscape="false"  maxlength="1024" class="input-xlarge " style="width: 210px;"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">最后登陆:</label>
			<div class="controls">
				<label class="lbl">IP: ${user.loginIp}&nbsp;&nbsp;&nbsp;&nbsp;时间：<fmt:formatDate value="${user.loginDate}" pattern="yyyy-MM-dd HH:ss"/></label>
			</div>
		</div>


		</table>
        <div class="form-actions">
            <shiro:hasPermission name="sys:user:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
            <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
        </div>
	</form:form>
</body>
</html>
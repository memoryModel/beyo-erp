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
	<li><a href="${ctx}/school/studentInfo/list">学员信息管理</a></li>
	<li class="active"><a href="${ctx}/school/studentInfo/form?id=${student.id}">学员基本信息<shiro:hasPermission name="school:studentInfo:form">${not empty student.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="school:studentInfo:form">查看</shiro:lacksPermission></a></li>

</ul><br/>
<form:form id="inputForm" modelAttribute="student" action="${ctx}/school/studentInfo/save" method="post" class="form-horizontal">
	<form:hidden path="id"/>
	<sys:message content="${message}"/>
	<table>
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">学号:</label>
					<div class="controls">
						${student.studentNumber}
					</div>
				</div>
			</td>

			<td>
				<div class="control-group">
					<label class="control-label">姓名:</label>
					<div class="controls">
						<form:input path="name" htmlEscape="false" style="width: 180px" class="required input-xlarge "/>
						<span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">性别:</label>
					<div class="controls">
						<form:select path="sex" class="required" style="width: 190px">
							<form:options items="${erp:sexStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
						</form:select>
						<span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>
			</td>
			<td>
				<div class="control-group">
					<label class="control-label">出生日期:</label>
					<div class="controls">
						<input  name="dateBirth" type="text" readonly="readonly" style="width: 180px" class="input-medium Wdate "
								value="<fmt:formatDate value="${student.dateBirth}" pattern="yyyy-MM-dd"/>"
								onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
					</div>
				</div>
			</td>

		</tr>
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">手机号码:</label>
					<div class="controls">
						<form:input path="phone" htmlEscape="false" style="width: 180px" class="required mobile valid "/>
						<span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>
			</td>
			<td>
				<div class="control-group">
					<label class="control-label">身份证号:</label>
					<div class="controls">
						<form:input path="stuNumber" htmlEscape="false" style="width: 180px" class="card valid "/>
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">职业方向：</label>
					<div class="controls">
						<c:if test="${not empty student.id}">
							<form:checkboxes path="occupationList" items="${erp:getCommonsTypeList(12)}" itemLabel="commonsName" itemValue="id" htmlEscape="false" class="required"/>
						</c:if>
						<c:if test="${empty student.id}">
							<form:checkboxes path="occupationId" items="${erp:getCommonsTypeList(12)}" itemLabel="commonsName" itemValue="id" htmlEscape="false" class="required"/>
						</c:if>
						<span class="help-inline"><font color="red">*</font></span>
					</div>
				</div>
			</td>
			<td>

				<div class="control-group">
					<label class="control-label">籍贯:</label>
					<div class="controls">
						<sys:treeselect id="nativePlace" name="nativePlace.id"
										value="${student.nativePlace.id}"
										labelName="student.nativePlace.name" labelValue="${student.nativePlace.name}"
										title="区域" url="/sys/area/treeData" cssStyle="width: 180px"/>
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">生活城市:</label>
					<div class="controls">
						<sys:treeselect id="stuCity" name="stuCity.id" value="${student.stuCity.id}"
										labelName="stuCity.name" labelValue="${student.stuCity.name}"
										title="区域" url="/sys/area/treeData" cssStyle="width: 180px"/>
					</div>
				</div>
			</td>
			<td>
				<div class="control-group">
					<label class="control-label">QQ号码:</label>
					<div class="controls">
						<form:input path="qqNumber" htmlEscape="false" style="width: 180px" class="qq valid"/>
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">学历:</label>
					<div class="controls">
						<form:select path="education" class="input-large" style="width: 190px">
							<form:options items="${erp:getCommonsTypeList(7)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
						</form:select>
					</div>
				</div>
			</td>
			<td>
				<div class="control-group">
					<label class="control-label">紧急联系人:</label>
					<div class="controls">
						<form:input path="emergencyContact" htmlEscape="false" style="width: 180px" class="input-xlarge "/>
					</div>
				</div>
			</td>


		</tr>

		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">所属校区:</label>
					<div class="controls">
						<form:select path="areas.id" class="required" style="width: 220px">
							<form:options items="${areasList}" itemLabel="areaName" class="required" itemValue="id" htmlEscape="false"/>
						</form:select>
						<span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>
			</td>

			<td>
				<div class="control-group">
					<label class="control-label">紧急联络人电话:</label>
					<div class="controls">
						<form:input path="urgencyPhone" htmlEscape="false" style="width: 180px" class="mobile valid"/>
					</div>
				</div>
			</td>

		</tr>
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">报名日期:</label>
					<div class="controls">
						<input name="applyTime" type="text" disabled="disabled" style="width: 180px" class="required input-medium disabled Wdate "
							   value="<fmt:formatDate value="${student.schoolClassStudents.applyTime}" pattern="yyyy-MM-dd"/>"
							   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>
			</td>
			<td>
				<div class="control-group">
					<label class="control-label">学管师:</label>
					<div class="controls">
						${student.learningTeacher.name}
					</div>
				</div>
			</td>

		</tr>

		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">学员状态:</label>
					<div class="controls">
							${erp:studentStatusName(student.status)}
					</div>
				</div>
			</td>
			<td>
				<div class="control-group">
					<label class="control-label">住宿状态:</label>
					<div class="controls">
							${erp:resideStatusName(student.dormitory)}
					</div>
				</div>
			</td>

		</tr>
		<tr>


			<td>
				<div class="control-group">
					<label class="control-label">入住日期:</label>
					<div class="controls">
						<fmt:formatDate value="${student.dormStudentLive.liveTime}" pattern="yyyy-MM-dd"/>
					</div>
				</div>
			</td>
			<td>
				<div class="control-group">
					<label class="control-label">搬离日期:</label>
					<div class="controls">
						<fmt:formatDate value="${student.dormLiveHistory.leaveTime}" pattern="yyyy-MM-dd"/>
					</div>
				</div>
			</td>
		</tr>
	</table>
	<div class="form-actions">
		<shiro:hasPermission name="school:studentInfo:save"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
		<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
	</div>
</form:form>

</body>
</html>
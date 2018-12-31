<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>班级管理</title>
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
            $("#selectLesson").click(function () {
                jbox =  top.$.jBox.open("iframe:/school/class/selectLesson", "添加课程", 1024, 520);
            });

        });

		function selectScheduleCallback(lessonId,lessonName){
            console.log("#btnSelect"+lessonId+lessonName);

            $("#lessonId").val(lessonId);
            $("#lessonName").val(lessonName);
        }


	</script>
</head>
<body>
	<div>
		<ul class="nav nav-tabs">
			<li><a href="${ctx}/school/class/list">班级列表</a></li>
			<li class="active"><a href="${ctx}/school/class/form?id=${schoolClass.id}">班级
				<shiro:hasPermission name="school:class:form">${not empty schoolClass.id?'修改':'添加'}</shiro:hasPermission>
				<shiro:lacksPermission name="school:class:form">查看</shiro:lacksPermission></a>
			</li>
		</ul><br/>
	</div>
	<div>
		<ul class="nav nav-tabs">
			<li class="active"><a href="/school/class/form?id=${schoolClass.id}">基本信息</a></li>
			<li><a href="${ctx}/school/class/classInstall?id=${schoolClass.id}&&tagFlag=2">班级设置</a></li>
		</ul>
	</div><br/>

	<form:form id="inputForm" modelAttribute="schoolClass" action="${ctx}/school/class/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<table id="contentTable">
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">班级名称：</label>
						<div class="controls">
							<form:input path="className" htmlEscape="false" maxlength="512" class="input-xlarge required" style="width: 210px;"/>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">班型：</label>
						<div class="controls">
							<form:select path="classType" class="required input-medium">
								<form:option value="" label="--请选择--"/>
								<form:options items="${erp:getCommonsTypeList(50)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
							</form:select>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>

			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">实际招收人数：</label>
						<div class="controls">
							<form:input path="classRealNum" htmlEscape="false" maxlength="20" class="input-xlarge digits" style="width: 210px;" disabled="true"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">班级最大人数：</label>
						<div class="controls">
							<form:input path="classMaxNum" htmlEscape="false" maxlength="20" class="input-xlarge digits" style="width: 210px;" disabled="true"/>
						</div>
					</div>
				</td>

			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">班级预计招收人数：</label>
						<div class="controls">
							<form:input path="classMinNum" htmlEscape="false" maxlength="20" class="input-xlarge digits" style="width: 210px;" disabled="true"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">计划开班日期：</label>
						<div class="controls">
							<input name="planBeginTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required" style="width: 210px"
								   value="<fmt:formatDate value="${schoolClass.planBeginTime}" pattern="yyyy-MM-dd"/>"
								   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});" disabled="disabled"/>
						</div>
					</div>
				</td>

			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">实际开班日期：</label>
						<div class="controls">
							<input name="realBeginTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required" style="width: 210px;"
								   value="<fmt:formatDate value="${schoolClass.realBeginTime}" pattern="yyyy-MM-dd"/>"
								   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});" disabled="disabled"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">计划结业日期：</label>
						<div class="controls">
							<input name="planEndTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate " style="width: 210px;"
								   value="<fmt:formatDate value="${schoolClass.planEndTime}" pattern="yyyy-MM-dd"/>"
								   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});" disabled="disabled"/>
						</div>
					</div>
				</td>

			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">实际结业日期：</label>
						<div class="controls">
							<input name="realEndTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate " style="width: 210px"
								   value="<fmt:formatDate value="${schoolClass.realEndTime}" pattern="yyyy-MM-dd"  />"
								   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});" disabled="disabled"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">状态：</label>
						<div class="controls">
							<form:select path="status" class="input-medium" style="width: 220px" disabled="true">
								<form:options items="${erp:classStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false" />
							</form:select>
						</div>
					</div>
				</td>

			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">课时：</label>
						<div class="controls">
							<form:input path="classTime" htmlEscape="false" maxlength="20" class="input-xlarge digits" style="width: 210px;" disabled="true"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">班主任：</label>
						<div class="controls">
							<sys:employeeselect id="headteacher" name="headteacher.id" value="${schoolClass.headteacher.id}"
												labelName="schoolClass.headteacher.name" labelValue="${schoolClass.headteacher.name}"
												title="员工" url="/erp/employee/officeTreeData?type=3" allowClear="true" notAllowSelectParent="true" cssClass="required"/>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>

			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">指导老师：</label>
						<div class="controls">
							<sys:employeeselect id="instructor" name="instructor.id" value="${schoolClass.instructor.id}"
												labelName="schoolClass.instructor.name" labelValue="${schoolClass.instructor.name}"
												title="员工" url="/erp/employee/officeTreeData?type=3" allowClear="true" notAllowSelectParent="true" cssClass="required"/>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">管理老师：</label>
						<div class="controls">
							<sys:employeeselect id="manager" name="manager.id" value="${schoolClass.manager.id}"
												labelName="schoolClass.manager.name" labelValue="${schoolClass.manager.name}"
												title="员工" url="/erp/employee/officeTreeData?type=3" allowClear="true" notAllowSelectParent="true" cssClass="required"/>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>

			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">督导老师：</label>
						<div class="controls">
							<sys:employeeselect id="supervisor" name="supervisor.id" value="${schoolClass.supervisor.id}"
												labelName="schoolClass.supervisor.name" labelValue="${schoolClass.supervisor.name}"
												title="员工" url="/erp/employee/officeTreeData?type=3" allowClear="true" notAllowSelectParent="true" cssClass="required"/>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
			</tr>
		</table>




		<div class="control-group">
			<label class="control-label">学费：</label>
			<div class="controls">
				<table id="contentTable" class="table table-striped table-bordered table-condensed">
					<thead>
					<tr>
						<th>定金(元)</th>
						<th>学费(元)</th>
						<th>学杂费(元)</th>
					</tr>
					</thead>
					<tbody>
						<tr>
							<td>
								<form:input path="prepaidAmount" htmlEscape="false" maxlength="20" class="input-xlarge" disabled="true"/>
							</td>
							<td>
								<form:input path="tuitionAmount" htmlEscape="false" maxlength="20" class="input-xlarge" disabled="true"/>
							</td>
							<td>
								<form:input path="miscellaneousAmount" htmlEscape="false" maxlength="20" class="input-xlarge" disabled="true"/>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>

		<%--<div class="control-group">
			<label class="control-label">代收：</label>
			<div class="controls">
				<table id="contentTable" class="table table-striped table-bordered table-condensed">
					<thead>
					<tr>
						<td>保证金(元)</td>
						<td>保险费(元)</td>
					</tr>
					</thead>
					<tbody>
					<tr>
						<td>
							<form:input path="depositAmount" htmlEscape="false" maxlength="20" class="input-xlarge" disabled="true"/>
						</td>
						<td>
							<form:input path="insuranceAmount" htmlEscape="false" maxlength="20" class="input-xlarge" disabled="true"/>
						</td>
					</tr>
					</tbody>
				</table>
			</div>
		</div>--%>


		<div class="control-group">
			<label class="control-label">备注:</label>
			<div class="controls">
				<form:textarea path="remark"  rows="4" style="width:709px;" maxlength="1000"/>
			</div>
		</div>

		<%--<div class="control-group">
			<label class="control-label">课程名称：</label>
			<div class="controls">
				<input type="hidden" name="schoolClassToLesson.schoolClassLesson.id" id="lessonId" value="${schoolClass.schoolClassToLesson.schoolClassLesson.id}">
				<input type="text"  name="schoolClassToLesson.schoolClassLesson.lessonName" id="lessonName" value="${schoolClass.schoolClassToLesson.schoolClassLesson.lessonName}"
					    style="width:392px;" placeholder="点击选择添加课程" readonly=readonly/>&nbsp;&nbsp;
				<input id="selectLesson" class="btn btn-primary" type="button" value="选择课程"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div><br/>--%>



		<div class="form-actions">
			<shiro:hasPermission name="school:class:save"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>



</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>保存面试记录成功管理</title>
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
		<c:if test="${tagFlag == 1}">
			<li class="active"><a href="${ctx}/crm/interviewRecord/form?id=${interviewRecord.id}">面试记录${not empty interviewRecord.id?'修改':'添加'}</a></li>
		</c:if>
		<c:if test="${tagFlag == 2}">
			<li class="active"><a href="${ctx}/crm/interviewRecord/form?interview.id=${interviewRecord.interview.id}">面试记录${not empty interviewRecord.id?'修改':'添加'}</a></li>
		</c:if>
		<c:if test="${tagFlag == 3}">
			<li class="active"><a href="${ctx}/crm/interviewRecord/info?id=${interviewRecord.id}">面试记录查看</a></li>
		</c:if>
	</ul><br/>

	<form:form id="inputForm" modelAttribute="interviewRecord" action="${ctx}/crm/interviewRecord/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<input type="hidden" name="interview.id" value="${interviewRecord.interview.id}">
		<sys:message content="${message}"/>
		<div class="control-group">

			<label class="control-label"><span class="help-inline"><font color="red">*</font> </span> &nbsp;&nbsp;面试员工：</label>
			<div class="controls">

			</div>
		</div>
		<div class="control-group">
			<table class="table table-striped table-bordered table-condensed" style="width: 80%; text-align:center; margin:auto" border="1" cellpadding="2" cellspacing="1">
				<tr>
					<td>姓名</td>
					<td>性别</td>
					<td>手机号码</td>
					<td>工种</td>
					<td>来源</td>
				</tr>
				<tr>
					<td>${interviewRecord.interview.employee.name}</td>
					<td>${erp:sexStatusName(interviewRecord.interview.employee.sex)}</td>
					<td>${interviewRecord.interview.employee.phone}</td>
					<td>
						<c:forEach items="${interviewRecord.interview.employee.getProfessionList()}" var="occId" varStatus="length">
							<c:if test="${length.index!=0}">
								,
							</c:if>
							${erp:getCommonsTypeName(occId)}
						</c:forEach>
					</td>
					<td>${interviewRecord.interview.employee.customerResource.customerName}</td>
				</tr>
			</table>
		</div>
		<div class="control-group">
			<label class="control-label"><span class="help-inline"><font color="red">*</font> </span> &nbsp;&nbsp;面试人：</label>
			<div class="controls">
				<sys:treeselect id="interviewers" name="interviewers.id" value="${interviewRecord.interview.interviewers.id}"
								labelName="interviewers.name" labelValue="${interviewRecord.interview.interviewers.name}"
								title="选择用户" url="/sys/office/treeData?type=3" cssClass="required" notAllowSelectParent="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><span class="help-inline"><font color="red">*</font> </span> &nbsp;&nbsp;面试时间：</label>
			<div class="controls">
				<input name="interviewTime" type="text" readonly="readonly" maxlength="20" class="required input-medium Wdate "
					value="<fmt:formatDate value="${interviewRecord.interviewTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><span class="help-inline"><font color="red">*</font> </span> &nbsp;&nbsp;人工核定结果：</label>
			<div class="controls">
				<form:select path="status" class="required" style="width: 220px">
					<form:options items="${erp:interviewStatusList()}" itemLabel="name" class="required" itemValue="value" htmlEscape="false" />
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<form:textarea id="remark" path="remark" htmlEscape="false" maxlength="200" class="input-xlarge " rows="3" style="width: 620px;"/>
			</div>
		</div>
		<div class="control-group" style="float:left;">
			<label class="control-label"><span class="help-inline"><font color="red">*</font> </span> &nbsp;&nbsp;添加人：</label>
			<div class="controls">
				<input type="hidden" value="${interviewRecord.user.id}">
				<sys:treeselect id="user" name="user.id" value="${interviewRecord.user.id}"
								labelName="user.name" labelValue="${interviewRecord.user.name}"
								title="选择用户" url="/sys/office/treeData?type=3" cssClass="required" notAllowSelectParent="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><span class="help-inline"><font color="red">*</font> </span> &nbsp;&nbsp;添加时间：</label>
			<div class="controls">
				<input name="createTime" type="text" readonly="readonly" maxlength="20" class="required input-medium Wdate "
					value="<fmt:formatDate value="${interviewRecord.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
			</div>
		</div>
		<div class="form-actions">
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>

	<form:form id="inputForm2" modelAttribute="interviewRecord" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<input type="hidden" name="interview.id" value="${interviewRecord.interview.id}">
		<sys:message content="${message}"/>
		<div class="control-group">

			<label class="control-label"><span class="help-inline"><font color="red">*</font> </span> &nbsp;&nbsp;面试员工：</label>
			<div class="controls">

			</div>
		</div>
		<div class="control-group">
			<table class="table table-striped table-bordered table-condensed" style="width: 80%; text-align:center; margin:auto" border="1" cellpadding="2" cellspacing="1">
				<tr>
					<td>姓名</td>
					<td>性别</td>
					<td>手机号码</td>
					<td>工种</td>
					<td>来源</td>
				</tr>
				<tr>
					<td>${interviewRecord.interview.employee.name}</td>
					<td>${erp:sexStatusName(interviewRecord.interview.employee.sex)}</td>
					<td>${interviewRecord.interview.employee.phone}</td>
					<td>
						<c:forEach items="${interviewRecord.interview.employee.getProfessionList()}" var="occId" varStatus="length">
							<c:if test="${length.index!=0}">
								,
							</c:if>
							${erp:getCommonsTypeName(occId)}
						</c:forEach>
					</td>
					<td>${interviewRecord.interview.employee.customerResource.customerName}</td>
				</tr>
			</table>
		</div>
		<div class="control-group">
			<label class="control-label"><span class="help-inline"><font color="red">*</font> </span> &nbsp;&nbsp;面试人：</label>
			<div class="controls">
				<input type="text" readonly="readonly" value="${interviewRecord.interview.interviewers.name}">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><span class="help-inline"><font color="red">*</font> </span> &nbsp;&nbsp;面试时间：</label>
			<div class="controls">
				<input name="interviewTime" type="text" readonly="readonly" maxlength="20" class="required input-medium Wdate "
					   value="<fmt:formatDate value="${interviewRecord.interviewTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><span class="help-inline"><font color="red">*</font> </span> &nbsp;&nbsp;人工核定结果：</label>
			<div class="controls">
				<c:if test="${interviewRecord.status == 0}">
					<input type="text" readonly="readonly" value="通过">
				</c:if>
				<c:if test="${interviewRecord.status == 1}">
					<input type="text" readonly="readonly" value="未通过">
				</c:if>
				<c:if test="${interviewRecord.status == 2}">
					<input type="text" readonly="readonly" value="待定">
				</c:if>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<form:textarea id="remark" readonly="true" path="remark" htmlEscape="false" maxlength="200" class="input-xlarge " rows="3" style="width: 620px;"/>
			</div>
		</div>
		<div class="control-group" style="float:left;">
			<label class="control-label"><span class="help-inline"><font color="red">*</font> </span> &nbsp;&nbsp;添加人：</label>
			<div class="controls">
				<input type="text"  readonly="readonly" value="${interviewRecord.user.name}">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><span class="help-inline"><font color="red">*</font> </span> &nbsp;&nbsp;添加时间：</label>
			<div class="controls">
				<input name="createTime" type="text" readonly="readonly" maxlength="20" class="required input-medium Wdate "
					   value="<fmt:formatDate value="${interviewRecord.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
			</div>
		</div>
		<div class="form-actions">
			<input id="btnCancel2" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
	<script type="text/javascript">
        var formValue = ${tagFlag};
		if (formValue == 1){
		    $("#inputForm2").hide();
		}else if(formValue == 2){
            $("#inputForm2").hide();
		}else{
            $("#inputForm").hide();
		}
	</script>
</body>
</html>
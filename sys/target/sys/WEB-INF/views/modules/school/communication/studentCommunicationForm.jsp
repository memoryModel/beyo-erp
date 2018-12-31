<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>单表管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
        function validform() {
            return $("#inputForm").validate();
        }
		$(document).ready(function() {
            $(validform());
            $("#btnSubmit").click(function () {
                if(validform().form()){
                    submitSave();
                }else{
                    return;
                }
            });
		});
		function submitSave() {
			$.ajax({
				type:'post',
				url:'${ctx}/school/communication/saveCommunication',
				async:false,
				data:{"studentId":$("#studentEnrollId").val(),"commonsTypeId":$("#commonsTypeId").val(),"nextType":$("#nextType").val(),"nextTime":$("#nextTime").val(),"status":$("#status").val(),"content":$("#content").val()},
				success:function(data){
                    if (data && data.result == "success") {
                        location.href="${ctx}/school/communication/";
						window.location.reload();
                    } else {
                        window.location.reload();
                    }
                }
			})
        }
	</script>
</head>
<body>

	<ul class="nav nav-tabs">
		<li class="active"><shiro:hasPermission name="school:communication:form"><a href="${ctx}/school/communication/form?erpStudentEnrollId=${communication.student.id}">沟通记录</a>&nbsp;&nbsp;</shiro:hasPermission></li>
	</ul><br/>

	<form:form id="inputForm" modelAttribute="communication" method="post" class="form-horizontal">
		<input type="hidden" name="student.id" id="studentEnrollId" value="${communication.student.id}">
		<input type="hidden" value="${communication.user.id}" style="width: 210px"/>
		<sys:message content="${message}"/>

		<table alien="center"  class="table table-striped table-bordered table-condensed" align="right">
			<tr>
				<div class="control-group">
					<label class="control-label">沟通类型：</label>
					<div class="controls">
						<form:select id="commonsTypeId" path="commonsTypeId" class="required" style="width: 210px">
							<form:options items="${erp:getCommonsTypeList(1)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
						</form:select>
						<span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>
			</tr>
			<tr>
				<div class="control-group">
					<label class="control-label">下次跟进类型：</label>
					<div class="controls">
						<form:select id="nextType" path="nextType" style="width: 210px">
							<form:options items="${erp:getCommonsTypeList(1)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
						</form:select>
					</div>
				</div>
			</tr>

			<tr>
				<div class="control-group">
					<label class="control-label">下次跟进日期：</label>
					<div class="controls">
						<input name="nextTime" id="nextTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
							   value="<fmt:formatDate value="${studentCommunication.nextTime}" pattern="yyyy-MM-dd"/>"
							   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'%y-%M-%d',isShowClear:true});" style="width: 195px"/>
					</div>
				</div>
			</tr>
			<tr>
				<div class="control-group">
					<label class="control-label">客户状态：</label>
					<div class="controls">
						<form:select id="status" path="status" class="input-large ">
							<form:options items="${erp:clientStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
						</form:select>
					</div>
				</div>
			</tr>

			<tr>
				<div class="control-group">
					<label class="control-label">沟通内容：</label>
					<div class="controls">
						<form:textarea id="content" path="content" htmlEscape="false" rows="4" maxlength="1024" class="required input-xxlarge"/>
						<span class="help-inline"><font color="red">*</font></span>
					</div>
				</div>
			</tr>

			<tr>
				<div class="form-actions">
					<shiro:hasPermission name="school:communication:save"><input id="btnSubmit" class="btn btn-primary" type="button" value="保 存"/>&nbsp;</shiro:hasPermission>
					<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
				</div>
			</tr>

		</table>



		<table id="contentTable" class="table table-striped table-bordered table-condensed" align="center"   style="width:80%; font-size:14px;" >

			<thead>
				<th>沟通时间</th>
				<th>操作人员</th>
				<th>沟通类型</th>
				<th>下次跟进类型</th>
				<th>下次跟进日期</th>
				<th>沟通内容</th>
			</thead>
			<tbody>
			<c:forEach items="${page.list}" var="communication">
				<tr>
					<td><fmt:formatDate value="${communication.createTime}" pattern="yyyy-MM-dd"/></td>
					<td>${communication.user.name}</td>
					<td>${erp:getCommonsTypeName(communication.commonsTypeId)}</td>
					<td>${erp:getCommonsTypeName(communication.nextType)}</td>
					<td><fmt:formatDate value="${communication.nextTime}" pattern="yyyy-MM-dd"/></td>
					<td>${communication.content}</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>

	</form:form>
	<%--展示沟通记录历史表--%>


</body>
</html>
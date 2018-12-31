<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>员工解约管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {

		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>

	<style type="text/css">

	</style>
</head>

<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/crm/employeeCancellation/list">员工解约列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="employeeCancellation" action="${ctx}/crm/employeeCancellation/list" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>员工姓名：</label>
				<form:input path="employeeEntry.employee.name" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>手机号码：</label>
				<form:input path="employeeEntry.employee.phone" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>性别：</label>
				<form:select path="employeeEntry.employee.sex" class="input-medium ">
					<form:option value="" label="------请选择------"/>
					<form:options items="${erp:sexStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>工种：</label>
				<form:select path="employeeEntry.employee.profession" class="input-mediun">
					<form:option value="" label="------请选择------"/>
					<form:options items="${erp:getCommonsTypeList(21)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>解约原因：</label>
				<form:select path="cancellationReason" class="input-mediun">
					<form:option value="" label="------请选择------"/>
					<form:options items="${erp:employeeCancellationList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>状态：</label>
				<form:select path="status" class="input-mediun">
					<form:option value="" label="------请选择------"/>
					<form:options items="${erp:employeeCancellationStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li>&nbsp;&nbsp;&nbsp;&nbsp;签约截止日期：
				<input name="signingDeadlineStartTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${employeeCancellation.signingDeadlineStartTime}" pattern="yyyy-MM-dd HH:mm"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>--
				<input name="signingDeadlineEndTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${employeeCancellation.signingDeadlineEndTime}" pattern="yyyy-MM-dd HH:mm"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>
			</li>
			<li>&nbsp;&nbsp;&nbsp;&nbsp;解约生效日期：
				<input name="cancellationEffectiveStartTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${employeeCancellation.cancellationEffectiveStartTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>--
				<input name="cancellationEffectiveEndTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${employeeCancellation.cancellationEffectiveEndTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			</li>
			<li>&nbsp;&nbsp;&nbsp;&nbsp;提交审批日期：
				<input name="submitApprovalStartTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${employeeCancellation.submitApprovalStartTime}" pattern="yyyy-MM-dd HH:mm"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>--
				<input name="submitApprovalEndTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${employeeCancellation.submitApprovalEndTime}" pattern="yyyy-MM-dd HH:mm"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>
			</li>
			<li><label>员工性质：</label>
				<form:select path="employeeEntry.type" class="input-medium ">
					<form:option value="" label="------请选择------"/>
					<form:options items="${erp:employeeTypeList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
		<tr>
			<td>员工编号</td>
			<td>员工姓名</td>
			<td>性别</td>
			<td>手机号码</td>
			<td>工种</td>
			<td>员工性质</td>
			<td>签约截止日期</td>
			<td>解约生效日期</td>
			<td>解约原因</td>
			<td>提交审批时间</td>
			<td>状态</td>
			<shiro:hasPermission name="crm:employeeRenew:edit"><th>操作</th></shiro:hasPermission>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="employeeCancellation">
			<tr>
				<td>${employeeCancellation.employeeEntry.employee.code}</td>
				<td>${employeeCancellation.employeeEntry.employee.name}</td>
				<td>${erp:sexStatusName(employeeCancellation.employeeEntry.employee.sex)}</td>
				<td>${employeeCancellation.employeeEntry.employee.phone}</td>
				<td>
					<c:forEach items="${employeeCancellation.employeeEntry.employee.getProfessionList()}" var="occId" varStatus="length">
					<c:if test="${length.index!=0}">
					,
					</c:if>
						${erp:getCommonsTypeName(occId)}
					</c:forEach>
				<td>${erp:employeeTypeName(employeeCancellation.employeeEntry.type)}</td>
				<td><fmt:formatDate value="${employeeCancellation.employeeEntry.deadlineTime}" pattern="yyyy-MM-dd HH:mm"/></td>
				<td><fmt:formatDate value="${employeeCancellation.cancellationEffectiveTime}" pattern="yyyy-MM-dd"/></td>
				<td>${erp:employeeCancellationName(employeeCancellation.cancellationReason)}</td>
				<td><fmt:formatDate value="${employeeCancellation.createTime}" pattern="yyyy-MM-dd HH:mm"/></td>
				<td>${erp:employeeCancellationStatusName(employeeCancellation.status)}</td>
				<td>
					<c:if test="${employeeCancellation.status == 0 || employeeCancellation.status == 2}">
						<a href="${ctx}/crm/employeeCancellation/form?id=${employeeCancellation.id}">查看</a>
					</c:if>
					<c:if test="${employeeCancellation.status == 1}">
						<a href="${ctx}/crm/employeeCancellation/form?id=${employeeCancellation.id}">重新提交</a>
					</c:if>

				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
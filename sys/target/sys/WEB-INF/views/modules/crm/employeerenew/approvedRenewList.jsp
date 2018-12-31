<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>员工续约管理</title>
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
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/crm/employeeRenew/approvedList">员工续约列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="employeeRenew" action="${ctx}/crm/employeeRenew/approvedList" method="post" class="breadcrumb form-search">
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
			<li><label>服务状态：</label>
				<form:select path="employeeEntry.employee.employeeStatus" class="input-medium ">
					<form:option value="" label="------请选择------"/>
					<form:options items="${erp:employeeTypeList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>工种：</label>
				<form:select path="employeeEntry.employee.profession" class="input-mediun">
					<form:option value="" label="------请选择------"/>
					<form:options items="${erp:getCommonsTypeList(21)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
				</form:select>
			</li>
			<li>&nbsp;&nbsp;&nbsp;&nbsp;签约生效日期：
				<input name="startTakeTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${employeeRenew.startTakeTime}" pattern="yyyy-MM-dd HH:mm"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>--
				<input name="endTakeTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${employeeRenew.endTakeTime}" pattern="yyyy-MM-dd HH:mm"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>
			</li>
			<li>签约截止日期：
				<input name="startDeadlineTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${employeeRenew.startDeadlineTime}" pattern="yyyy-MM-dd HH:mm"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>--
				<input name="endDeadlineTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${employeeRenew.endDeadlineTime}" pattern="yyyy-MM-dd HH:mm"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>
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
				<td>服务状态</td>
				<td>续约生效日期</td>
				<td>续约截止日期</td>
				<td>提交审批时间</td>
				<shiro:hasPermission name="crm:employeeRenew:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="employeeRenew">
			<tr>
				<td>${employeeRenew.employeeEntry.employee.code}</td>
				<td>${employeeRenew.employeeEntry.employee.name}</td>
				<td>${erp:sexStatusName(employeeRenew.employeeEntry.employee.sex)}</td>
				<td>${employeeRenew.employeeEntry.employee.phone}</td>
				<td>${erp:getCommonsTypeName(employeeRenew.employeeEntry.employee.profession)}</td>
				<td>${erp:employeeTypeName(employeeRenew.employeeEntry.employee.employeeStatus)}</td>
				<td>${erp:employeeStatusName(employeeRenew.employeeEntry.employee.employeeStatus)}</td>
				<td><fmt:formatDate value="${employeeRenew.extensionStartDate}" pattern="yyyy-MM-dd HH:mm"/></td>
				<td><fmt:formatDate value="${employeeRenew.extensionEndDate}" pattern="yyyy-MM-dd HH:mm"/></td>
				<td><fmt:formatDate value="${employeeRenew.createTime}" pattern="yyyy-MM-dd HH:mm"/></td>
				<td><a href="${ctx}/crm/crm/renewApproved/form?id=${employeeRenew.id}">审批</a></td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
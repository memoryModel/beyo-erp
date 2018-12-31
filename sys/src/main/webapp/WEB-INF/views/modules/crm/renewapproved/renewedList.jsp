<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>已续约列表管理</title>
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
	<li class="active"><a href="${ctx}/crm/renewApproved/renewedList">已续约列表</a></li>
</ul>
<form:form id="searchForm" modelAttribute="renewApproved" action="${ctx}/crm/renewApproved/renewedList" method="post" class="breadcrumb form-search">
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
		<li>&nbsp;&nbsp;&nbsp;&nbsp;续约生效日期：
			<input name="employeeRenew.extensionEffectiveStartDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
				   value="<fmt:formatDate value="${renewApproved.employeeRenew.extensionEffectiveStartDate}" pattern="yyyy-MM-dd"/>"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>--
			<input name="employeeRenew.extensionEffectiveEndDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
				   value="<fmt:formatDate value="${renewApproved.employeeRenew.extensionEffectiveEndDate}" pattern="yyyy-MM-dd"/>"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
		</li>
		<li>续约截止日期：
			<input name="employeeRenew.extensionDeadlineStartDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
				   value="<fmt:formatDate value="${renewApproved.employeeRenew.extensionDeadlineStartDate}" pattern="yyyy-MM-dd"/>"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>--
			<input name="employeeRenew.extensionDeadlineEndDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
				   value="<fmt:formatDate value="${renewApproved.employeeRenew.extensionDeadlineEndDate}" pattern="yyyy-MM-dd"/>"
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
		<td>审批通过时间</td>
		<shiro:hasPermission name="crm:employeeRenew:edit"><th>操作</th></shiro:hasPermission>
	</tr>
	</thead>
	<tbody>
	<c:forEach items="${page.list}" var="renewApproved">
		<tr>
			<td>${renewApproved.employeeEntry.employee.code}</td>
			<td>${renewApproved.employeeEntry.employee.name}</td>
			<td>${erp:sexStatusName(renewApproved.employeeEntry.employee.sex)}</td>
			<td>${renewApproved.employeeEntry.employee.phone}</td>
			<td>
				<c:forEach items="${renewApproved.employeeEntry.employee.getProfessionList()}" var="occId" varStatus="length">
					<c:if test="${length.index!=0}">
						,
					</c:if>
					${erp:getCommonsTypeName(occId)}
				</c:forEach>
			</td>
			<td>${erp:employeeTypeName(renewApproved.employeeEntry.employee.employeeStatus)}</td>
			<td>${erp:employeeStatusName(renewApproved.employeeEntry.employee.employeeStatus)}</td>
			<td><fmt:formatDate value="${renewApproved.employeeRenew.extensionStartDate}" pattern="yyyy-MM-dd"/></td>
			<td><fmt:formatDate value="${renewApproved.employeeRenew.extensionEndDate}" pattern="yyyy-MM-dd"/></td>
			<td><fmt:formatDate value="${renewApproved.createTime}" pattern="yyyy-MM-dd HH:mm"/></td>
			<td><a href="${ctx}/crm/renewApproved/viewRenew?id=${renewApproved.id}&myStatus=2">查看续约信息</a></td>
		</tr>
	</c:forEach>
	</tbody>
</table>
	<div class="pagination">${page}</div>
</body>
</html>
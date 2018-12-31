<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>员工列表管理</title>
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
		<li class="active"><a href="${ctx}/erp/employee/list">员工列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="employee" action="${ctx}/erp/employee/list" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>员工编号：</label>
				<form:input path="code" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>员工姓名：</label>
				<form:input path="name" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>工种：</label>
				<form:select path="profession" class="input-medium">
					<form:option value="" label="------请选择------"/>
					<form:options items="${erp:getCommonsTypeList(21)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
				</form:select>
			</li>
			<%--<li><label>薪资结构：</label>
				<form:select path="entry.debtStatus" class="input-large ">
					<form:option value="">请选择</form:option>
					<form:options items="${erp:debtStatusesList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>--%>
			<li>
				<label>员工状态：</label>
				<form:select path="status" class="input-large ">
					<form:option value="">请选择</form:option>
					<form:options items="${erp:employeeListStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>创建时间：</label>
				<input name="startTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${employee.startTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>至
				<input name="endTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${employee.endTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>员工编号</th>
				<th>员工姓名</th>
				<th>联系电话</th>
				<th>名族</th>
				<th>工种</th>
				<th>级别</th>
				<th>员工状态</th>
				<th>创建时间</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="erpEmployee">
			<tr>
				<td>
						${erpEmployee.code}
				</td>
				<td>
						${erpEmployee.name}
				</td>
				<td>
						${erpEmployee.phone}
				</td>
				<td>
						${erpEmployee.nation.commonsName}
				</td>
				<td>
						${erp:getCommonsTypeName(employee.profession)}
				</td>
				<td>
						${erpEmployee.employeeSkill.skill.skillName}
				</td>
				<td>
						${erp:employeeStatusName(erpEmployee.status)}
				</td>
				<td>
					<fmt:formatDate value="${erpEmployee.createTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
					<shiro:hasPermission name="erp:employee:getEmployeeInfo"><a href="${ctx}/erp/employee/getEmployeeInfo?id=${erpEmployee.id}">查看</a></shiro:hasPermission>
					<shiro:hasPermission name="erp:employee:form"> <a href="${ctx}/erp/employee/form?id=${erpEmployee.id}">修改</a></shiro:hasPermission>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
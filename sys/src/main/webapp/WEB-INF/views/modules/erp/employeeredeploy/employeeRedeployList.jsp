<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>单表管理</title>
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
		<li class="active"><a href="${ctx}/erp/employeeRedeploy/">单表列表</a></li>
		<shiro:hasPermission name="erpemployeeredeploy:erpEmployeeRedeploy:edit"><li><a href="${ctx}/erp/employeeRedeploy/form">单表添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="erpEmployeeRedeploy" action="${ctx}/erp/employeeRedeploy/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<%--<li><label>创建时间：</label>
				<input name="createTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${erpEmployeeRedeploy.createTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			<li>
			<li><label>状态：</label>
				<form:select path="status" class="input-medium">
					<form:option value="" label="------请选择------"/>
					<form:options items="${fns:getDictList('sys_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>--%>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<a>批量导出</a>&nbsp;&nbsp;&nbsp;<a>新增职位调动</a>&nbsp;&nbsp;&nbsp;<a>新增部门调动</a>

		<thead>
			<tr>

				<th>类型</th>
				<th>员工编号</th>
				<th>员工姓名</th>
				<th>员工状态</th>
				<th>生效时间</th>
				<th>调动前部门</th>
				<th>调动后部门</th>
				<th>调动前职位</th>
				<th>调动后职位</th>
				<th>调动原因</th>
				<th>创建人</th>
				<th>操作时间</th>
				<th>创建时间</th>
				<shiro:hasPermission name="erpemployeeredeploy:erpEmployeeRedeploy:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="erpEmployeeRedeploy">
			<tr>
				<td>
					${fns:getDictLabel(erpEmployeeRedeploy.redeployType, 'redeploy_type', '')}
				</td>
				<td>
					${erpEmployeeRedeploy.employee.code}
				</td>
				<td>
					${erpEmployeeRedeploy.employee.name}
				</td>
				<td>
					${fns:getDictLabel(erpEmployeeRedeploy.employee.status, 'emp_status', '')}
				</td>
				<td>
					<fmt:formatDate value="${erpEmployeeRedeploy.effectiveTime}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					${erpEmployeeRedeploy.office.name}<%--调动前职位--%>
				</td>
				<td>
					${erpEmployeeRedeploy.officeLater.name}
				</td>
				<td>
					${erpEmployeeRedeploy.positionFront}
				</td>
				<td>
					${erpEmployeeRedeploy.positionLater}
				</td>
				<td>
					${erpEmployeeRedeploy.redeployCause}
				</td>
				<td>
					${erpEmployeeRedeploy.createUser}
				</td>

				<td>
					<fmt:formatDate value="${erpEmployeeRedeploy.operationTime}" pattern="yyyy-MM-dd"/>
				</td>

				<td>
					<fmt:formatDate value="${erpEmployeeRedeploy.createTime}" pattern="yyyy-MM-dd"/>
				</td>
				<shiro:hasPermission name="erpEmployeeRedeploy:erpEmployeeRedeploy:edit"><td>
    				<a href="${ctx}/erp/employeeRedeploy/form?id=${erpEmployeeRedeploy.id}">部门调动</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
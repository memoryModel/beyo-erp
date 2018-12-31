<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>职级管理</title>
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
		<li class="active"><a href="${ctx}/erp/employeeLevel/list">职工级别列表</a></li>
		<shiro:hasPermission name="erp:employeeLevel:form"><li><a href="${ctx}/erp/employeeLevel/form">职工级别添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="employeeLevel" action="${ctx}/erp/employeeLevel/list" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>级别名称：</label>
				<form:input path="jobName" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>创建时间：</label>
				<input name="startTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${employeeLevel.startTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>至
				<input name="endTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${employeeLevel.endTime}" pattern="yyyy-MM-dd"/>"
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
				<th>级别名称</th>
				<th>描述</th>
				<th>级别</th>
				<th>创建时间</th>
				<%--<th>状态</th>--%>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="employeeLevel">
			<tr>
				<td>
					${employeeLevel.jobName}
				</td>
				<td>
					${employeeLevel.description}
				</td>
				<td>
					${employeeLevel.jobLevel}
				</td>
				<td>
					<fmt:formatDate value="${employeeLevel.createTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<%--<td>
					${erp:commonsStatusName(employeeLevel.status)}
				</td>--%>
				<td>
					<shiro:hasPermission name="erp:employeeLevel:form"><a href="${ctx}/erp/employeeLevel/form?id=${employeeLevel.id}">修改</a></shiro:hasPermission>
					<shiro:hasPermission name="erp:employeeLevel:delete"><a href="${ctx}/erp/employeeLevel/delete?id=${employeeLevel.id}" onclick="return confirmx('确认要删除职工级别吗？', this.href)">删除</a></shiro:hasPermission>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
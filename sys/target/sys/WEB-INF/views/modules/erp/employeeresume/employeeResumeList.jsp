<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>员工简历管理</title>
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
		<li class="active"><a href="${ctx}/erp/employeeResume/">员工简历列表</a></li>
		<shiro:hasPermission name="erp:employeeResume:form"><li><a href="${ctx}/erp/employeeResume/form">员工简历添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="employeeResume" action="${ctx}/erp/employeeResume/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>公司名称</th>
				<th>职位名称</th>
				<th>type</th>
				<th>开始时间</th>
				<th>结束时间</th>
				<th>备注</th>
				<th>状态</th>
				<th>创建时间</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="employeeResume">
			<tr>
				<td><a href="${ctx}/erp/employeeResume/form?id=${employeeResume.id}">
					${employeeResume.companyTitle}
				</a></td>
				<td>
					${employeeResume.title}
				</td>
				<td>
						${erp:resumeStatusName(employeeResume.type)}
				</td>
				<td>
					<fmt:formatDate value="${employeeResume.startTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
					<fmt:formatDate value="${employeeResume.endTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
					${employeeResume.remarks}
				</td>
				<td>
					${erp:commonsStatusName(employeeResume.status)}
				</td>
				<td>
					<fmt:formatDate value="${employeeResume.createTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
					<shiro:hasPermission name="erp:employeeResume:form"><a href="${ctx}/erp/employeeResume/form?id=${employeeResume.id}">修改</a></shiro:hasPermission>
					<shiro:hasPermission name="erp:employeeResume:delete"><a href="${ctx}/erp/employeeResume/delete?id=${employeeResume.id}" onclick="return confirmx('确认要删除该员工简历吗？', this.href)">删除</a></shiro:hasPermission>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
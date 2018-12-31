<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>上户员工管理</title>
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
		<li class="active"><a href="${ctx}/crm/dispatchemployee/">上户员工列表</a></li>
		<shiro:hasPermission name="crm:dispatchemployee:dispatchEmployee:edit"><li><a href="${ctx}/crm/dispatchemployee/form">上户员工添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="dispatchEmployee" action="${ctx}/crm/dispatchemployee/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>create_time：</label>
				<input name="createTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${dispatchEmployee.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
			</li>
			<li><label>推荐状态：</label>
				<form:input path="recommendStatus" htmlEscape="false" maxlength="1" class="input-medium"/>
			</li>
			<li><label>派工状态：</label>
				<form:input path="serviceStatus" htmlEscape="false" maxlength="1" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>上户预约Id</th>
				<th>上户员工Id</th>
				<th>落选原因</th>
				<th>create_time</th>
				<th>推荐状态</th>
				<th>派工状态</th>
				<shiro:hasPermission name="crm:dispatchemployee:dispatchEmployee:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="dispatchEmployee">
			<tr>
				<td><a href="${ctx}/crm/dispatchemployee/form?id=${dispatchEmployee.id}">
					${dispatchEmployee.dispatchId}
				</a></td>
				<td>
					${dispatchEmployee.employeeId}
				</td>
				<td>
					${dispatchEmployee.reason}
				</td>
				<td>
					<fmt:formatDate value="${dispatchEmployee.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${dispatchEmployee.recommendStatus}
				</td>
				<td>
					${dispatchEmployee.serviceStatus}
				</td>
				<td>
    				<a href="${ctx}/crm/dispatchemployee/form?id=${dispatchEmployee.id}">修改</a>
					<a href="${ctx}/crm/dispatchemployee/delete?id=${dispatchEmployee.id}" onclick="return confirmx('确认要删除该上户员工吗？', this.href)">删除</a>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
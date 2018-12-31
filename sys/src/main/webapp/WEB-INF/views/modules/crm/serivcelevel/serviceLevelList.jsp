<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>星级管理</title>
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
		<li class="active"><a href="${ctx}/crm/serviceLevel/list">星级管理列表</a></li>
		<li><a href="${ctx}/crm/serviceLevel/form">星级管理添加</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="serviceLevel" action="${ctx}/crm/serviceLevel/list" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>等级名称：</label>
				<form:input path="name" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>创建时间：</label>
				<input name="startTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${serviceLevel.startTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>至
				<input name="endTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${serviceLevel.endTime}" pattern="yyyy-MM-dd"/>"
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
				<th>等级名称</th>
				<th>达标服务单数</th>
				<th>达标完美单数比例</th>
				<th>达标最低分</th>
				<th>达标上限分</th>
				<th>描述</th>
				<th>状态</th>
				<th>创建时间</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="serviceLevel">
			<tr>
				<td><a href="${ctx}/crm/serviceLevel/form?id=${serviceLevel.id}">
					${serviceLevel.name}
				</a></td>
				<td>
					${serviceLevel.orderNumber}
				</td>
				<td>
					${serviceLevel.orderBili}&nbsp;%
				</td>
				<td>
					${serviceLevel.minScore}
				</td>
				<td>
					${serviceLevel.maxScore}
				</td>
				<td>
					${serviceLevel.description}
				</td>
				<td>
					${erp:commonsStatusName(serviceLevel.status)}
				</td>
				<td>
					<fmt:formatDate value="${serviceLevel.createTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
					<shiro:hasPermission name="crm:serviceLevel:form"><a href="${ctx}/crm/serviceLevel/form?id=${serviceLevel.id}">修改</a></shiro:hasPermission>
					<shiro:hasPermission name="crm:serviceLevel:delete"><a href="${ctx}/crm/serviceLevel/delete?id=${serviceLevel.id}" onclick="return confirmx('确认要删除该星级吗？', this.href)">删除</a></shiro:hasPermission>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
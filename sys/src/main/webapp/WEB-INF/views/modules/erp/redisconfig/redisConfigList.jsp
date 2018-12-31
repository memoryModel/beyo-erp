<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>缓存配置管理</title>
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
		<li class="active"><a href="${ctx}/erp/redisconfig/list">缓存配置列表</a></li>
		<shiro:hasPermission name="erp:redisconfig:redisConfig:edit"><li><a href="${ctx}/erp/redisconfig/form">缓存配置添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="redisConfig" action="${ctx}/erp/redisconfig/list" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>名称：</label>
				<form:input path="name" htmlEscape="false" maxlength="256" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>名称</th>
				<th>配置</th>
				<th>备注</th>
				<th>创建人</th>
				<th>创建时间</th>
				<shiro:hasPermission name="erp:redisconfig:redisConfig:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="redisConfig">
			<tr>
				<td><a href="${ctx}/erp/redisconfig/form?id=${redisConfig.id}">
					${redisConfig.name}
				</a></td>
				<td>
					${redisConfig.config}
				</td>
				<td>
					${redisConfig.statement}
				</td>
				<td>
					${redisConfig.user.name}
				</td>
				<td>
					<fmt:formatDate value="${redisConfig.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="erp:redisconfig:redisConfig:edit"><td>
    				<a href="${ctx}/erp/redisconfig/form?id=${redisConfig.id}">修改</a>
					<a href="${ctx}/erp/redisconfig/delete?id=${redisConfig.id}" onclick="return confirmx('确认要删除该缓存配置吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
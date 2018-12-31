<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>宿舍管理管理</title>
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
		<li class="active"><a href="${ctx}/erp/dormRoomBed/">宿舍管理列表</a></li>
		<shiro:hasPermission name="dormroombed:dormRoomBed:edit"><li><a href="${ctx}/erp/dormRoomBed/form">宿舍管理添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="dormRoomBed" action="${ctx}/erp/dormRoomBed/" method="post" class="breadcrumb form-search">
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
				<th>房间id</th>
				<th>床位号</th>
				<th>状态</th>
				<shiro:hasPermission name="dormroombed:dormRoomBed:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="dormRoomBed">
			<tr>
				<td><a href="${ctx}/erp/dormRoomBed/form?id=${dormRoomBed.id}">
					${dormRoomBed.roomId}
				</a></td>
				<td>
					${dormRoomBed.bedCode}
				</td>
				<td>
					${dormRoomBed.createUser}
				</td>
				<td>
					<fmt:formatDate value="${dormRoomBed.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${dormRoomBed.status}
				</td>
				<shiro:hasPermission name="dormroombed:dormRoomBed:edit"><td>
    				<a href="${ctx}/erp/dormRoomBed/form?id=${dormRoomBed.id}">修改</a>
					<a href="${ctx}/erp/dormRoomBed/delete?id=${dormRoomBed.id}" onclick="return confirmx('确认要删除该宿舍管理吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
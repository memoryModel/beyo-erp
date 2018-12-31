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
		<li><a href="${ctx}/erp/dorm/list">宿舍管理</a></li>
		<li class="active"><a href="${ctx}/erp/dormRoom/list?dormId=${dormRoom.erpDorm.id}">房间管理</a></li>
	</ul><br/>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/erp/dormRoom/list?dormId=${dormRoom.erpDorm.id}&&id=${dormRoom.id}">房间列表</a></li>
		<shiro:hasPermission name="erp:dormRoom:form">
			<li><a href="${ctx}/erp/dormRoom/form?dormId=${dormRoom.erpDorm.id}&&id=${dormRoom.id}">房间新增</a></li>
		</shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="dormRoom" action="${ctx}/erp/dormRoom/list?dormId=${dormRoom.erpDorm.id}&&id=${dormRoom.id}" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>房间名称：</label>
				<form:input path="roomName" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>创建时间：</label>

				<input name="startTime" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   value="<fmt:formatDate value="${dormRoom.startTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>-
				<input name="endTime" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   value="<fmt:formatDate value="${dormRoom.endTime}" pattern="yyyy-MM-dd"/>"
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
				<th>房间</th>
				<th>可入住人数</th>
				<th>床位数量</th>
				<th>已入住人数</th>
				<th>状态</th>
				<th>创建时间</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="dormRoom">
			<tr>
				<td>
					${dormRoom.roomName}
				</td>
				<td>
					${dormRoom.availableNumber}
				</td>
				<td>
					${dormRoom.bedNumber}
				</td>
				<td>
					${dormRoom.alreadyNumber}
				</td>

				<td>
						${erp:commonsStatusName(dormRoom.status)}
				</td>
				<td>
					<fmt:formatDate value="${dormRoom.createTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
					<shiro:hasPermission name="erp:dormRoom:dormRoomInfo"><a href="${ctx}/erp/dormRoom/dormRoomInfo?id=${dormRoom.id}">查看</a></shiro:hasPermission>
					<shiro:hasPermission name="erp:dormRoom:form"><a href="${ctx}/erp/dormRoom/form?dormId=${dormRoom.erpDorm.id}&&id=${dormRoom.id}">修改</a></shiro:hasPermission>
					<c:if test="${dormRoom.status == 0}">
						<shiro:hasPermission name="erp:dormRoom:delete"><a href="${ctx}/erp/dormRoom/delete?id=${dormRoom.id}" onclick="return confirmx('确认要删除该单表吗？', this.href)">删除</a></shiro:hasPermission>
					</c:if>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
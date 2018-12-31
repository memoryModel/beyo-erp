<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>入住管理管理</title>
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
	<li class="active"><a href="${ctx}/erp/dormLiveHistory/leaveList">退房记录</a></li>
	<shiro:hasPermission name="erp:dormEmployeeLive:leaveList">
	<li><a href="${ctx}/erp/dormEmployeeLive/leaveList">办理员工退宿</a></li>
	</shiro:hasPermission>
	<shiro:hasPermission name="erp:dormStudentLive:leaveList">
	<li><a href="${ctx}/erp/dormStudentLive/leaveList">办理学员退宿</a></li>
	</shiro:hasPermission>
</ul><br/>
	<form:form id="searchForm" modelAttribute="dormLiveHistory" action="${ctx}/erp/dormLiveHistory/leaveList" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>宿舍：</label>
				<form:input path="dormRoomBed.dormRoom.erpDorm.dormName" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>房间：</label>
				<form:input path="dormRoomBed.dormRoom.roomName" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>姓名</th>
				<th>入住日期</th>
				<th>退房日期</th>
			    <th>经办人</th>
				<th>宿舍</th>
				<th>房间</th>
				<th>床位</th>
				<%--<shiro:hasPermission name="erp:live:edit"><th>操作</th></shiro:hasPermission>--%>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="dormLiveHistory">
			<tr createUser="${dormLiveHistory.createUser}" id="${dormLiveHistory.id}">
				<td>
						${dormLiveHistory.dormStudentLive.erpStudentEnroll != null ? dormLiveHistory.dormStudentLive.erpStudentEnroll.name : dormLiveHistory.dormEmployeeLive.erpEmployee.name}
				</td>
				<td>
					<fmt:formatDate value="${dormLiveHistory.dormStudentLive.erpStudentEnroll != null ? dormLiveHistory.dormStudentLive.liveTime : dormLiveHistory.dormEmployeeLive.liveTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>

				<td>
					<fmt:formatDate value="${dormLiveHistory.leaveTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
						${dormLiveHistory.user.name}
				</td>
				<td>
						${dormLiveHistory.dormRoomBed.dormRoom.erpDorm.dormName}
				</td>
				<td>
						${dormLiveHistory.dormRoomBed.dormRoom.roomName}
				</td>
				<td>
						${dormLiveHistory.dormRoomBed.bedCode}
				</td>
				<%--<shiro:hasPermission name="erp:live:edit"><td>
    				&lt;%&ndash;<a href="${ctx}/dormlivehistory/dormLiveHistory/form?id=${dormLiveHistory.id}">修改</a>
					<a href="${ctx}/dormlivehistory/dormLiveHistory/delete?id=${dormLiveHistory.id}" onclick="return confirmx('确认要删除该入住管理吗？', this.href)">删除</a>&ndash;%&gt;
				</td></shiro:hasPermission>--%>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
<script src="${ctxStatic}/officeNames/officeNames.js" type="text/javascript"></script>
</body>
</html>
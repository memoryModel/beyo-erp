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
	<li><a href="${ctx}/erp/dormEmployeeLive/list">待入住员工</a></li>
	<li><a href="${ctx}/erp/dormStudentLive/list">待入住学员</a></li>
	<li  class="active"><a href="${ctx}/erp/dormLiveHistory/list">入住申请记录</a></li>
</ul><br/>
	<form:form id="searchForm" modelAttribute="dormLiveHistory" action="${ctx}/erp/dormLiveHistory/list" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>宿舍：</label>
				<form:input path="dormRoomBed.dormRoom.erpDorm.dormName" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>房间：</label>
				<form:input path="dormRoomBed.dormRoom.roomName" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>类型：</label>
				<form:select path="type" class="input-large ">
					<form:option value="">请选择</form:option>
					<form:options items="${erp:liveTypeList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>类型</th>
				<th>姓名</th>
				<th>宿舍</th>
				<th>房间</th>
				<th>床位</th>
				<th>入住日期</th>
			    <th>经办人</th>
<%--				<shiro:hasPermission name="erp:live:edit"><th>操作</th></shiro:hasPermission>--%>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="dormLiveHistory">
			<tr createUser="${dormLiveHistory.createUser}" id="${dormLiveHistory.id}">
				<td>
						${erp:liveTypeName(dormLiveHistory.type)}
				</td>
				<td>
						${dormLiveHistory.dormStudentLive.erpStudentEnroll != null ? dormLiveHistory.dormStudentLive.erpStudentEnroll.name : dormLiveHistory.dormEmployeeLive.erpEmployee.name}
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
				<td>
					<fmt:formatDate value="${dormLiveHistory.dormStudentLive.erpStudentEnroll != null ? dormLiveHistory.dormStudentLive.liveTime : dormLiveHistory.dormEmployeeLive.liveTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
					${dormLiveHistory.user.name}
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
<script src="${ctxStatic}/officeNames/officeNames.js" type="text/javascript"></script>
</body>
</html>
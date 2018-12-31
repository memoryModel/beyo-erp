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
	<li class="active"><a href="${ctx}/erp/dormStudentLive/list">待入住学员</a></li>
	<li><a href="${ctx}/erp/dormLiveHistory/list">入住申请记录</a></li>
</ul><br/>
<ul class="nav nav-tabs">
	<li class="active"><a href="${ctx}/erp/dormRoomBed/handleStudentLive">床位列表</a></li>
</ul>
<form:form id="searchForm" modelAttribute="dormRoomBed" action="${ctx}/erp/dormRoomBed/handleStudentLive?dormStudentLiveId=${dormStudentLiveId}" method="post" class="breadcrumb form-search">
	<ul class="ul-form">
		<li><label>宿舍名称：</label>
			<form:input path="dormRoom.erpDorm.dormName" htmlEscape="false" maxlength="20" class="input-medium"/>
		</li>
		<li><label>房间名称：</label>
			<form:input path="dormRoom.roomName" htmlEscape="false" maxlength="20" class="input-medium"/>
		</li>
		<li><label>创建时间：</label>
			<input name="startTime" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
				   value="<fmt:formatDate value="${dormRoomBed.startTime}" pattern="yyyy-MM-dd"/>"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			<input name="endTime" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
				   value="<fmt:formatDate value="${dormRoomBed.endTime}" pattern="yyyy-MM-dd"/>"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
		</li>
		</li>
		<li><label>状态：</label>
			<form:select path="status" class="input-large ">
				<form:option value="">请选择</form:option>
				<form:options items="${erp:liveStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
			</form:select>
		</li>
		<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
		<li class="clearfix"></li>
	</ul>
</form:form>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
	<thead>
	<tr>
		<th>宿舍名称</th>
		<th>房间名称</th>
		<th>床位号</th>
		<th>状态</th>
		<th>操作</th>
	</tr>
	</thead>
	<tbody>
	<c:forEach items="${dormRoomBedeList}" var="dormRoomBed">
		<tr>
			<td>
					${dormRoomBed.dormRoom.erpDorm.dormName}
			</td>
			<td>
					${dormRoomBed.dormRoom.roomName}
			</td>
			<td>
					${dormRoomBed.bedCode}
			</td>
			<td>
					${erp:liveStatusName(dormRoomBed.status)}
			</td>
			<td>
				    <shiro:hasPermission name="erp:dormStudentLive:saveStudentLive"><a class="btn btn-primary" class="btn btn-primary" href="${ctx}/erp/dormStudentLive/saveStudentLive?dormRoomBedId=${dormRoomBed.id}&&dormStudentLiveId=${dormStudentLiveId}&&roomId=${dormRoomBed.dormRoom.id}" onclick="return confirmx('是否确认？', this.href)">选择</a></shiro:hasPermission>
			</td>

			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
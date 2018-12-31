<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>单表管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/erp/erpDorm/list">宿舍管理</a></li>
		<li class="active"><a href="${ctx}/erp/dormRoom/list?dormId=${dormRoom.erpDorm.id}">房间管理</a></li>
	</ul><br/>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/erp/dormRoom/list?dormId=${dormRoom.erpDorm.id}">房间列表</a></li>
		<li class="active"><a href="${ctx}/erp/dormRoom/dormRoomInfo?id=${dormRoom.id}">房间详情</a></li>
		</li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="dormRoom" action="${ctx}/erp/dormRoom/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">房间：</label>
			<div class="controls">
				<input value="${dormRoom.roomName}" type="text" readonly="readonly" style="width:250px;"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">床位数量：</label>
			<div class="controls">
				<input value="${dormRoom.bedNumber}" type="text" readonly="readonly" style="width:250px;"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">可入住人数：</label>
			<div class="controls">
				<input value="${dormRoom.availableNumber}" type="text" readonly="readonly" style="width:250px;"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">已入住人数：</label>
			<div class="controls">
				<input value="${dormRoom.alreadyNumber}" type="text" readonly="readonly" style="width:250px;"/>
			</div>
		</div>
	</form:form>
		<table id="contentTable" class="table table-striped table-bordered table-condensed">
			<thead>
			<tr>
				<th>床位编号</th>
				<th>姓名</th>
				<th>经办人</th>
			</tr>
			</thead>
			<tbody>
			<c:forEach items="${dormLiveHistoryList}" var="dormLiveHistory">
				<tr>
					<td>
							${dormLiveHistory.dormRoomBed.bedCode}
					</td>
					<td>
							${dormLiveHistory.dormStudentLive.erpStudentEnroll != null ? dormLiveHistory.dormStudentLive.erpStudentEnroll.name : dormLiveHistory.dormEmployeeLive.erpEmployee.name}
					</td>
					<td>
						 ${dormLiveHistory.user.name}
					</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>

</body>
</html>
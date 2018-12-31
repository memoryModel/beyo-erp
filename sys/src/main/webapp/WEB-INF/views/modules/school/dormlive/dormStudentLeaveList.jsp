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
	<li><a href="${ctx}/erp/dormLiveHistory/leaveList">退房记录</a></li>
	<li><a href="${ctx}/erp/dormEmployeeLive/leaveList">办理员工退宿</a></li>
	<li class="active"><a href="${ctx}/erp/dormStudentLive/leaveList">办理学员退宿</a></li>
</ul><br/>
	<form:form id="searchForm" modelAttribute="dormStudentLive" action="${ctx}/erp/dormStudentLive/leaveList" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>学员编号：</label>
				<form:input path="erpStudentEnroll.studentNumber" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>学员姓名：</label>
				<form:input path="erpStudentEnroll.name" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>联系方式：</label>
				<form:input path="erpStudentEnroll.phone" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>创建时间：</label>
				<input name="startTime" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   value="<fmt:formatDate value="${dormStudentLive.startTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>-
				<input name="endTime" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   value="<fmt:formatDate value="${dormStudentLive.endTime}" pattern="yyyy-MM-dd"/>"
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
			<th>学员编号</th>
			<th>学员姓名</th>
			<th>学员联系方式</th>
			<th>班主任</th>
			<th>班主任电话</th>
			<th>籍贯</th>
			<th>状态</th>
			<th>创建时间</th>
			<th>操作</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="dormStudentLive">
			<tr>
				<td>
						${dormStudentLive.erpStudentEnroll.studentNumber}
				</td>
				<td>
						${dormStudentLive.erpStudentEnroll.name}
				</td>
				<td>
						${dormStudentLive.erpStudentEnroll.phone}
				</td>
				<td>
						${dormStudentLive.erpStudentEnroll.schoolClassStudents.schoolClass.headteacher.name}
				</td>
				<td>
						${dormStudentLive.erpStudentEnroll.schoolClassStudents.schoolClass.headteacher.phone}
				</td>
				<td>
						${dormStudentLive.area.name}
				</td>
				<td>
						${erp:liveStatusName(dormStudentLive.status)}
				</td>
				<td>
					<fmt:formatDate value="${dormStudentLive.createTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
					<shiro:hasPermission name="erp:dormStudentLive:handleLeave"><a class="btn btn-primary" href="${ctx}/erp/dormStudentLive/handleLeave?id=${dormStudentLive.id}" onclick="return confirmx('确认要办理退宿吗？', this.href)">办理退宿</a></shiro:hasPermission>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
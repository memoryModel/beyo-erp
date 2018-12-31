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
		<li class="active"><a href="${ctx}/erp/dorm/list">宿舍列表</a></li>
		<shiro:hasPermission name="erp:dorm:form"><li><a href="${ctx}/erp/dorm/form">宿舍添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="dorm" action="${ctx}/erp/dorm/list" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>城市：</label>
				<form:input path="detailAddress" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>宿舍名称：</label>
				<form:input path="dormName" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>创建时间：</label>
				<input name="startTime" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   value="<fmt:formatDate value="${dorm.startTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>-
				<input name="endTime" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   value="<fmt:formatDate value="${dorm.endTime}" pattern="yyyy-MM-dd"/>"
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
				<th>城市</th>
				<th>宿舍名称</th>
				<th>管理员姓名</th>
				<th>管理员联系方式</th>
				<th>当日入住</th>
				<th>当日退房</th>
				<th>可住人数</th>
				<th>实住人数</th>
				<th>空床数量</th>
				<th>状态</th>
				<th>创建时间</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="erpDorm">
			<tr createUser="${erpDorm.createUser}" id="${erpDorm.id}">
				<td>
						${erpDorm.detailAddress}
				</td>
				<td>
					${erpDorm.dormName}
				</td>
				<td>
						${erpDorm.user.name}
				</td>
				<td>
						${erpDorm.user.phone}
				</td>
				<td>
					${erpDorm.todayCheck}
				</td>
				<td>
					${erpDorm.todayLeave}
				</td>
				<td>
					${erpDorm.liveNumber}
				</td>
				<td>
						${erpDorm.realLiveNumber}
				</td>
				<td>
						${erpDorm.emptyBedNumber}
				</td>

				<td>
						${erp:commonsStatusName(erpDorm.status)}
				</td>
				<td>
					<fmt:formatDate value="${erpDorm.createTime}" pattern="yyyy-MM-dd HH:mm"/>

				</td>
				<td>
					<shiro:hasPermission name="erp:dormRoom:list"><a href="${ctx}/erp/dormRoom/list?dormId=${erpDorm.id}">房间管理</a></shiro:hasPermission>
					<shiro:hasPermission name="erp:dorm:form"><a href="${ctx}/erp/dorm/form?id=${erpDorm.id}">修改</a></shiro:hasPermission>
					<c:if test="${erpDorm.status == 0}">
						<shiro:hasPermission name="erp:dorm:delete"><a href="${ctx}/erp/dorm/delete?id=${erpDorm.id}" onclick="return confirmx('确认要删除该宿舍吗？', this.href)">删除</a></shiro:hasPermission>
					</c:if>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
<script src="${ctxStatic}/officeNames/officeNames.js" type="text/javascript"></script>
</body>
</html>
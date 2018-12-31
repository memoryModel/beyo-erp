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
		<li class="active"><a href="${ctx}/erp/dormCost/list">宿舍成本列表</a></li>
		<shiro:hasPermission name="erp:dormCost:form"><li><a href="${ctx}/erp/dormCost/form">宿舍成本添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="dormCost" action="${ctx}/erp/dormCost/list" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>城市：</label>
				<form:input path="erpDorm.detailAddress" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>宿舍：</label>
				<form:input path="erpDorm.dormName" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>类型：</label>
				<form:select path="type" style="width: 210px;">
					<form:option value="" label="------请选择------"/>
					<form:options items="${erp:getCommonsTypeList(14)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>创建时间：</label>
				<input name="startTime" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   value="<fmt:formatDate value="${dormCost.startTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>-
				<input name="endTime" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   value="<fmt:formatDate value="${dormCost.endTime}" pattern="yyyy-MM-dd"/>"
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
				<th>宿舍</th>
				<th>类型</th>
				<th>支出</th>
				<th>日期</th>
				<th>记录人</th>
				<th>状态</th>
				<%--<shiro:hasPermission name="erp:dormCost:edit"><th>操作</th></shiro:hasPermission>--%>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="dormCost">
			<tr createUser="${dormCost.createUser}" id="${dormCost.id}">
				<td>
						${dormCost.erpDorm.detailAddress}
				</td>
				<td>
					${dormCost.erpDorm.dormName}
				</td>
				<td>
						${erp:getCommonsTypeName(dormCost.type)}
				</td>
				<td>
					${dormCost.expenditureAmount}
				</td>
				<td>
					<fmt:formatDate value="${dormCost.expenditureTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
					${dormCost.user.loginName}
				</td>
				<td>
						${erp:commonsStatusName(dormCost.status)}
				</td>
				<%--<shiro:hasPermission name="erp:dormCost:edit"><td>
    				<a href="${ctx}/erp/dormcost/form?id=${dormCost.id}">修改</a>
					<a href="${ctx}/erp/dormcost/delete?id=${dormCost.id}" onclick="return confirmx('确认要删除该单表吗？', this.href)">删除</a>
				</td></shiro:hasPermission>--%>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
<script src="${ctxStatic}/officeNames/officeNames.js" type="text/javascript"></script>
</body>
</html>
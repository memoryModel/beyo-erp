<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>题库管理管理</title>
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
		<li class="active"><a href="${ctx}/school/examineStore/list">题库管理列表</a></li>
		<li><a href="${ctx}/school/examineStore/form">题库管理添加</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="examineStore" action="${ctx}/school/examineStore/list" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>科目：</label>
				<form:select path="subject" class="input-medium">
					<c:if test="${empty examineStore.id}">
						<form:option value="" label="--请选择--"/>
					</c:if>
					<form:options items="${erp:getCommonsTypeList(50)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>题库类型：</label>
				<form:select path="type" class="input-medium">
					<c:if test="${empty examineStore.id}">
						<form:option value="" label="--请选择--"/>
					</c:if>
					<form:options items="${erp:examTypeList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li class="clearfix"></li>
			<li><label>题库状态：</label>
				<form:select path="status" class="input-medium">
					<form:options items="${erp:commonsStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>

			<li><label>创建时间：</label>
				<input name="createTimeStart" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   value="<fmt:formatDate value="${examineStore.createTimeStart}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>-
				<input name="createTimeEnd" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   value="<fmt:formatDate value="${examineStore.createTimeEnd}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>题库名称</th>
				<th>科目</th>
				<th>类型</th>
				<th>试题数量</th>
				<th>状态</th>
				<th>创建时间</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="examineStore">
			<tr createUser="${examineStore.createUser}" id="${examineStore.id}">
				<td>${examineStore.name}</td>
				<td>
					${erp:getCommonsTypeName(examineStore.subject)}
				</td>
				<td>
					${erp:examTypeName(examineStore.type)}
				</td>
				<td>
					${examineStore.questionCount}
				</td>
				<td>
					${erp:commonsStatusName(examineStore.status)}
				</td>
				<td>
					<fmt:formatDate value="${examineStore.createTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
					<c:if test="${examineStore.type==1}"><a href="${ctx}/school/examineStore/form?id=${examineStore.id}">修改</a></c:if>
					<a href="${ctx}/school/examineStore/delete?id=${examineStore.id}" onclick="return confirmx('确认要删除该题库管理吗？', this.href)">删除</a>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
<script src="${ctxStatic}/officeNames/officeNames.js" type="text/javascript"></script>
</body>
</html>
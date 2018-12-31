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
		<li class="active"><a href="${ctx}/school/quitClass/">单表列表</a></li>
		<shiro:hasPermission name="quitclass:schoolQuitClass:edit"><li><a href="${ctx}/school/quitClass/form">单表添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="classStudents" action="${ctx}/school/classStudents/save" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>创建时间：</label>
				<input name="createTimeStart" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>-
				<input name="createTimeEnd" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			</li>
			<li><label>状态：</label>
				<form:select path="status" class="input-medium">
					<form:option value="" label="------请选择------"/>
					<form:options items="${fns:getDictList('sys_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
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
				<th>退班原因</th>
				<th>退班日期</th>
				<th>创建时间</th>
				<th>备注</th>
				<th>状态</th>
				<shiro:hasPermission name="quitclass:schoolQuitClass:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="schoolQuitClass">
			<tr>
				<td><a href="${ctx}/school/quitClass/form?id=${schoolQuitClass.id}">
					${schoolQuitClass.cause}
				</a></td>
				<td>
					<fmt:formatDate value="${schoolQuitClass.quitTime}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					<fmt:formatDate value="${schoolQuitClass.createTime}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					${schoolQuitClass.description}
				</td>
				<td>${fns:getDictLabel(schoolQuitClass.status, 'sys_status', '')}</td>
				<shiro:hasPermission name="quitclass:schoolQuitClass:edit"><td>
    				<a href="${ctx}/school/quitClass/form?id=${schoolQuitClass.id}">修改</a>
					<a href="${ctx}/school/quitClass/delete?id=${schoolQuitClass.id}" onclick="return confirmx('确认要删除该单表吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
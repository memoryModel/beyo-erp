<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>上课时段管理</title>
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
	<li class="active"><a href="${ctx}/school/classTime/list">上课时段设置</a></li>
	<shiro:hasPermission name="school:classTime:form"><li><a href="${ctx}/school/classTime/form">上课时段添加</a></li></shiro:hasPermission>
</ul>
<form:form id="searchForm" modelAttribute="classTime" action="${ctx}/school/classTime/list" method="post" class="breadcrumb form-search">
	<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	<ul class="ul-form">
		<li><label>名称：</label>
			<form:input path="lessonName" htmlEscape="false" maxlength="20" class="input-medium"/>
		</li>
		<li><label>创建时间：</label>
			<input name="createTimeStart" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
				   value="<fmt:formatDate value="${classTime.createTimeStart}" pattern="yyyy-MM-dd"/>"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>至
			<input name="createTimeEnd" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
				   value="<fmt:formatDate value="${classTime.createTimeEnd}" pattern="yyyy-MM-dd"/>"
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
		<th>名称</th>
		<th>开始时间</th>
		<th>结束时间</th>
		<th>创建时间</th>
		<%--<th>状态</th>--%>
		<th>操作</th>
	</tr>
	</thead>
	<tbody>
	<c:forEach items="${page.list}" var="classTime">
		<tr>
			<td>
				${classTime.lessonName}
			</td>
			<td>
					${classTime.startTime}
			</td>
			<td>
					${classTime.endTime}
			</td>
			<td>
				<fmt:formatDate value="${classTime.createTime}" pattern="yyyy-MM-dd HH:mm"/>
			</td>
			<%--<td>
					${erp:commonsStatusName(classTime.status)}
			</td>--%>
			<td>
				<shiro:hasPermission name="school:classTime:form"><a href="${ctx}/school/classTime/form?id=${classTime.id}">修改</a></shiro:hasPermission>
				<shiro:hasPermission name="school:classTime:delete"><a href="${ctx}/school/classTime/delete?id=${classTime.id}" onclick="return confirmx('确认要删除该上课时段吗？', this.href)">删除</a></shiro:hasPermission>
			</td>
		</tr>
	</c:forEach>
	</tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>
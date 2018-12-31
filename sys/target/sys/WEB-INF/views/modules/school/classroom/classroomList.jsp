<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>教室设置管理</title>
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
	<li class="active"><a href="${ctx}/school/classroom/list">教室设置列表</a></li>
	<shiro:hasPermission name="school:classroom:form"><li><a href="${ctx}/school/classroom/form">教室添加</a></li></shiro:hasPermission>
</ul>
<form:form id="searchForm" modelAttribute="classroom" action="${ctx}/school/classroom/list" method="post" class="breadcrumb form-search">
	<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	<ul class="ul-form">
		<li><label>教室名称：</label>
			<form:input path="classroomName" htmlEscape="false" maxlength="20" class="input-medium"/>
		</li>
		<li><label>创建时间：</label>
			<input name="startTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
				   value="<fmt:formatDate value="${classroom.startTime}" pattern="yyyy-MM-dd"/>"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>至
			<input name="endTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
				   value="<fmt:formatDate value="${classroom.endTime}" pattern="yyyy-MM-dd"/>"
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
		<th>教室名称</th>
		<th>容纳人数</th>
		<th>创建时间</th>
		<%--<th>状态</th>--%>
		<th>操作</th>
	</tr>
	</thead>
	<tbody>
	<c:forEach items="${page.list}" var="classroom">
		<tr>
			<td>
					${classroom.classroomName}
			</td>
			<td>
					${classroom.marksNumber}
			</td>
			<td>
				<fmt:formatDate value="${classroom.createTime}" pattern="yyyy-MM-dd HH:mm"/>
			</td>
			<%--<td>
					${erp:commonsStatusName(classroom.status)}
			</td>--%>
			<td>
				<shiro:hasPermission name="school:classroom:form"><a href="${ctx}/school/classroom/form?id=${classroom.id}">修改</a></shiro:hasPermission>
				<shiro:hasPermission name="school:classroom:delete"><a href="${ctx}/school/classroom/delete?id=${classroom.id}" onclick="return confirmx('确认要删除该教室设置吗？', this.href)">删除</a></shiro:hasPermission>
			</td>
		</tr>
	</c:forEach>
	</tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>
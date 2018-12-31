<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>考试试题管理</title>
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
		<li class="active"><a href="${ctx}/school/examQuestion/">考试试题列表</a></li>
		<shiro:hasPermission name="examineitems:examQuestion:edit"><li><a href="${ctx}/school/examQuestion/form">考试试题添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="examQuestion" action="${ctx}/school/examQuestion/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>考试题库ID</th>
				<th>类型</th>
				<th>题干</th>
				<th>答案id</th>
				<th>状态</th>
				<shiro:hasPermission name="examineitems:examQuestion:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="examQuestion">
			<tr>
				<td><a href="${ctx}/school/examQuestion/form?id=${examQuestion.id}">
					${examQuestion.examineStore.id}
				</a></td>
				<td>
					${examQuestion.type}
				</td>
				<td>
					${examQuestion.title}
				</td>
				<td>
					<%--${examQuestion.answerId}--%>
				</td>
				<td>
					${examQuestion.status}
				</td>
				<shiro:hasPermission name="examineitems:examQuestion:edit"><td>
    				<a href="${ctx}/school/examQuestion/form?id=${examQuestion.id}">修改</a>
					<a href="${ctx}/school/examQuestion/delete?id=${examQuestion.id}" onclick="return confirmx('确认要删除该考试试题吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
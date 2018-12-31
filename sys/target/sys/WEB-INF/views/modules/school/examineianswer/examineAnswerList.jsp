<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>试题答案管理</title>
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
		<li class="active"><a href="${ctx}/school/examineAnswer/">试题答案列表</a></li>
		<shiro:hasPermission name="examineianswer:examineAnswer:edit"><li><a href="${ctx}/school/examineAnswer/form">试题答案添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="examineAnswer" action="${ctx}/school/examineAnswer/" method="post" class="breadcrumb form-search">
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
				<th>选项</th>
				<th>选项内容</th>
				<th>答案id</th>
				<th>items_id</th>
				<shiro:hasPermission name="examineianswer:examineAnswer:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="examineAnswer">
			<tr>
				<td><a href="${ctx}/school/examineAnswer/form?id=${examineAnswer.id}">
					${examineAnswer.option}
				</a></td>
				<td>
					${examineAnswer.optionContent}
				</td>
				<td>
					${examineAnswer.answerId}
				</td>
				<td>
					${examineAnswer.itemsId}
				</td>
				<shiro:hasPermission name="examineianswer:examineAnswer:edit"><td>
    				<a href="${ctx}/school/examineAnswer/form?id=${examineAnswer.id}">修改</a>
					<a href="${ctx}/school/examineAnswer/delete?id=${examineAnswer.id}" onclick="return confirmx('确认要删除该试题答案吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
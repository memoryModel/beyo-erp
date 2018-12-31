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
		<li class="active"><a href="${ctx}/school/subject/list">课程科目列表</a></li>
		<shiro:hasPermission name="school:subject:form"><li><a href="${ctx}/school/subject/form">课程科目添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="subject" action="${ctx}/school/subject/list" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>科目名称：</label>
				<form:input path="subjectName" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>创建时间：</label>
				<input name="startTime" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   value="<fmt:formatDate value="${subject.startTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>-
				<input name="endTime" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   value="<fmt:formatDate value="${subject.endTime}" pattern="yyyy-MM-dd"/>"
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
				<th>描述</th>
				<th>创建时间</th>
				<th>状态</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="schoolSubject">
			<tr>
				<td>
					${schoolSubject.subjectName}
				</td>
				<td>
					${schoolSubject.description}
				</td>
				<td>
					<fmt:formatDate value="${schoolSubject.createTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
						${erp:commonsStatusName(schoolSubject.status)}
				</td>
				<td>
					<shiro:hasPermission name="school:subject:form"><a href="${ctx}/school/subject/form?id=${schoolSubject.id}">修改</a></shiro:hasPermission>
					<shiro:hasPermission name="school:subject:delete"><a href="${ctx}/school/subject/delete?id=${schoolSubject.id}" onclick="return confirmx('确认要删除该单表吗？', this.href)">删除</a></shiro:hasPermission>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
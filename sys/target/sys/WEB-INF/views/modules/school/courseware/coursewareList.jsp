<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>知识管理</title>
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
		<li class="active"><a href="${ctx}/school/courseware/list">${courseware.category==2 ? '课件':'答疑'}列表</a></li>
		<shiro:hasPermission name="school:courseware:form"><li>
			<c:if test="${courseware.category == 2}">
				<a href="${ctx}/school/courseware/form">课件添加</a>
			</c:if>
		</li></shiro:hasPermission>
		<shiro:hasPermission name="school:answerQuestion:form"><li>
			<c:if test="${courseware.category == 1}">
				<a href="${ctx}/school/answerQuestion/form">答疑添加</a>
			</c:if>
		</li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="courseware" action="${ctx}/school/courseware/list" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>名称：</label>
				<form:input path="title" htmlEscape="false" maxlength="524" class="input-medium"/>
			</li>

			<li><label>创建时间：</label>
				<input name="startTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${courseware.startTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>至
				<input name="endTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${courseware.endTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			</li>
			<%--<li><label>状态：</label>
				<form:select path="status" class="input-medium">
					<form:option value="" label="------请选择------"/>
					<form:options items="${erp:commonsStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>--%>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>


		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>

				<c:if test="${courseware.category == 2}">
					<th>课件名称</th>
				</c:if>
				<th>科目</th>
				<th>课件内容</th>
				<th>创建人</th>
				<th>创建时间</th>
				<th>状态</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="schoolCourseware">
			<tr createUser="${schoolCourseware.createUser}" id="${schoolCourseware.id}">
				<td><a href="${ctx}/school/courseware/coursewareInfo?id=${schoolCourseware.id}">
					${schoolCourseware.title}
				</a></td>
				<td>
					${schoolCourseware.schoolSubject.subjectName}
				</td>
				<td>
					${schoolCourseware.content}
				</td>
				<td>
					${schoolCourseware.user.name}
				</td>
				<td>
					<fmt:formatDate value="${schoolCourseware.createTime}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
						${erp:commonsStatusName(schoolCourseware.status)}
				</td>
				<td>
					<shiro:hasPermission name="school:courseware:form"><a href="${ctx}/school/courseware/form?id=${schoolCourseware.id}">修改</a></shiro:hasPermission>
					<c:if test="${schoolCourseware.category == 1}">
						<shiro:hasPermission name="school:answerQuestion:delete"><a href="${ctx}/school/answerQuestion/delete?id=${schoolCourseware.id}" onclick="return confirmx('确认要删除该答疑吗？', this.href)">删除</a></shiro:hasPermission>
					</c:if>
					<c:if test="${schoolCourseware.category == 2}">
						<shiro:hasPermission name="school:courseware:delete"><a href="${ctx}/school/courseware/delete?id=${schoolCourseware.id}" onclick="return confirmx('确认要删除该课件吗？', this.href)">删除</a></shiro:hasPermission>
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
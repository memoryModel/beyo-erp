<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>课程管理</title>
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
	<li class="active"><a href="${ctx}/school/lesson/list">课程列表</a></li>
	<li><a href="${ctx}/school/lesson/form">课程添加</a></li>
</ul>
<form:form id="searchForm" modelAttribute="classLesson" action="${ctx}/school/lesson/list" method="post" class="breadcrumb form-search">
	<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	<ul class="ul-form">
		<li><label>课程名称：</label>
			<form:input path="lessonName" htmlEscape="false" maxlength="512" class="input-medium"/>
		</li>
		<li><label class="control-label">班型：</label>
			<div class="controls">
				<form:select path="schoolLessonType" class="required input-medium">
					<form:option value="" label="--请选择--"/>
					<form:options items="${erp:getCommonsTypeList(50)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
				</form:select>
			</div>
		</li>
		<li><label>创建时间：</label>
			<input name="createTimeStart" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
				   value="<fmt:formatDate value="${classLesson.createTimeStart}" pattern="yyyy-MM-dd"/>"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>-
			<input name="createTimeEnd" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
				   value="<fmt:formatDate value="${classLesson.createTimeEnd}" pattern="yyyy-MM-dd"/>"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
		</li>
		</li>
			<%--<li class="clearfix"></li>--%>

		<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
		<li class="clearfix"></li>
	</ul>

</form:form>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
	<thead>
	<tr>
		<th>课程名称</th>
		<th>授课老师</th>
		<%--<th>年份</th>
        <th>期段</th>--%>
		<th>类型</th>
		<%--<th>科目</th>--%>
		<th>创建时间</th>
		<th>状态</th>
		<th>操作</th>
	</tr>
	</thead>
	<tbody>
	<c:forEach items="${page.list}" var="classLesson">
		<tr createUser="${classLesson.createUser}" id="${classLesson.id}">
			<td>
					<a href="${ctx}/school/lesson/info?id=${classLesson.id}">${classLesson.lessonName}</a>
					<%--<a href="${ctx}/school/lesson/form?id=${classLesson.id}">
						${classLesson.lessonName}
					</a>--%>
			</td>
			<td>
					${classLesson.teacherNames}
			</td>
				<%--<td>
					<fmt:formatDate value="${classLesson.createTime}" pattern="yyyy"/>
				</td>
				<td>
					<fmt:formatDate value="${classLesson.createTime}" pattern="MMMM"/>
				</td>--%>
			<td>
					${erp:getCommonsTypeName(classLesson.schoolLessonType)}
			</td>
				<%--<td>
					${classLesson.schoolSubject.subjectName}
				</td>--%>
			<td>
				<fmt:formatDate value="${classLesson.createTime}" pattern="yyyy-MM-dd HH:mm"/>
			</td>
			<td>
					${erp:commonsStatusName(classLesson.status)}
			</td>
			<td>
				<a href="${ctx}/school/lesson/info?id=${classLesson.id}">详情</a>
				<a href="${ctx}/school/lesson/form?id=${classLesson.id}">修改</a>
				<a href="${ctx}/school/lessonPlans/list?lessonId=${classLesson.id}">授课计划</a>
				<a href="${ctx}/school/lesson/delete?id=${classLesson.id}" onclick="return confirmx('确认要删除该课程吗？', this.href)">删除</a>
			</td>
		</tr>
	</c:forEach>
	</tbody>
</table>
<div class="pagination">${page}</div>
<script src="${ctxStatic}/officeNames/officeNames.js" type="text/javascript"></script>
</body>
</html>
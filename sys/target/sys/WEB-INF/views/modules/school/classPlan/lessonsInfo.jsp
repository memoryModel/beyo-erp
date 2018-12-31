<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>学员信息</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#asProCategoryButton").addClass("disabled");
			//$("#userButton").addClass("disabled");
			
		});
		function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			$("#searchForm").submit();
	    	return false;
	    }
	</script>
</head>
<body>
	<div>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/lesson/schoolClassLesson/">班级列表</a></li>
		<li class="active"><a href="${ctx}/lesson/schoolClassLesson/info?id=${schoolClassLesson.id}">班级详情</a></li>
	</ul></div><br/><div>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/lesson/schoolClassLesson/info?id=${schoolClassLesson.id}">基本信息</a></li>
		<li><a href="#">学员信息</a></li>
		<li class="active"><a href="#">上课信息</a></li>
	</ul></div><br/>

	<form:form id="searchForm" modelAttribute="class" action="${ctx}/lesson/schoolClassLesson/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>授课老师：</label>
				<form:input path="headteacherId" placeholder="请选择授课老师" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>授课开始时间：</label>
					<input id="startTime" type="text" class="input-medium Wdate " onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
			</li>
			<li><label>授课结束时间：</label>
				<input  id="endTime" type="text" class="input-medium Wdate " onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
		<tr>
			<th>课程</th>
			<th>日期</th>
			<th>星期</th>
			<th>上课时间</th>
			<th>授课老师</th>
			<th>教室</th>
			<th>状态</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="schoolClass">
			<tr>
				<td><a href="${ctx}/lesson/schoolClassLesson/form?id=${schoolClassLesson.id}">
						${schoolClassLesson.lessonName}
				</td>
				<td>
						<fmt:formatDate value="${schoolClassLesson.createTime}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
						<fmt:formatDate value="${schoolClassLesson.createTime}" pattern="E"/>
				</td>
				<td>
						<fmt:formatDate value="${schoolClassLesson.createTime}" pattern="HH:mm:ss"/>
				</td>
				<td>
						${schoolClassLesson.teacherId}
				</td>
				<td>
						${schoolClassLesson.subjectId}
				</td>
				<td>
						${schoolClassLesson.status}
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>

</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>学员信息</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
        var tagFlag = 0;
        if(${not empty tagFlag}) tagFlag = ${tagFlag}; //标签页标记 0:显示标签页 1.隐藏标签页
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
	<c:if test="${tagFlag != 1}">
		<div>
			<ul class="nav nav-tabs">
				<li><a href="${ctx}/school/class/list">班级列表</a></li>
				<li class="active"><a href="${ctx}/school/class/info?id=${student.schoolClassStudents.schoolClass.id}">班级详情</a></li>
			</ul>
		</div><br/>
	</c:if>
	<div>
		<ul class="nav nav-tabs">
			<li><a href="${ctx}/school/class/info?id=${student.schoolClassStudents.schoolClass.id}&&tagFlag=${tagFlag}">基本信息</a></li>
			<li class="active"><a href="${ctx}/school/class/studentInfo?id=${student.schoolClassStudents.schoolClass.id}&&tagFlag=${tagFlag}">学员信息</a></li>
			<li><a href="${ctx}/school/class/lessonInfo?id=${student.schoolClassStudents.schoolClass.id}&&tagFlag=${tagFlag}">上课信息</a></li>
			<li><a href="${ctx}/school/class/classInstall?id=${student.schoolClassStudents.schoolClass.id}&&tagFlag=${tagFlag}">班级设置</a></li>
		</ul>
	</div><br/>

	<form:form id="searchForm" modelAttribute="student" action="${ctx}/school/class/studentInfo?id=${student.schoolClassStudents.schoolClass.id}" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li hidden="hidden"><label>班级：</label>
				<form:input path="schoolClassStudents.schoolClass.className" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>学员姓名：</label>
				<form:input path="name" placeholder="请输入学员姓名/编号" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
		<tr>
			<th>学员姓名</th>
			<th>学号</th>
			<th>性别</th>
			<th>已经上课次</th>
			<th>入班日期</th>
			<th>结业状态</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="erpStudentEnroll" varStatus="">
			<tr>
				<td>
						${erpStudentEnroll.name}
				</td>
				<td>
						${erpStudentEnroll.studentNumber}
				</td>
				<td>
						${erp:sexStatusName(erpStudentEnroll.sex)}
				</td>
				<td>
						<%--${not empty erpStudentEnroll.schoolClassStudents.classSchedule.signCount? erpStudentEnroll.schoolClassStudents.classSchedule.signCount:"0"} 次--%>
						${erpStudentEnroll.schoolClassStudents.classSchedule.lessonSignNum - erpStudentEnroll.classLessonSignHistory.absenceNum} 次
				</td>
				<td>
						<fmt:formatDate value="${erpStudentEnroll.schoolClassStudents.applyTime}" pattern="yyyy-MM-dd"/>
						<%--<fmt:formatDate value="${erpStudentEnroll.classTimeId}" pattern="yyyy-MM-dd HH:mm"/>--%>
				</td>
				<td>
                        ${erp:ClassStudentsName(erpStudentEnroll.schoolClassStudents.status)}
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>

</body>
</html>
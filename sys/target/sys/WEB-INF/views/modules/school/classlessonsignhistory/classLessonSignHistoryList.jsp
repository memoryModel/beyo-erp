<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>补课管理</title>
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
	<li class="active"><a href="${ctx}/school/classLessonSignHistory/list">补课管理列表</a></li>

	<shiro:hasPermission name="school:classLessonSignHistory:classNew"><li><a href="${ctx}/school/classLessonSignHistory/classNew">新开班补课</a></li></shiro:hasPermission>
	<shiro:hasPermission name="school:classLessonSignHistory:followClass"><li><a href="${ctx}/school/classLessonSignHistory/followClass">跟班补课</a></li></shiro:hasPermission>

</ul>
<form:form id="searchForm" modelAttribute="classLessonSignHistory" action="${ctx}/school/classLessonSignHistory/list" method="post" class="breadcrumb form-search">
	<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	<ul class="ul-form">
		<li><label>课程：</label>
			<form:select path="classLessonSign.schoolClassLesson.id" style="width: 210px" class="input-medium">
				<form:option value="">请选择</form:option>
				<form:options items="${lessonList}" itemLabel="lessonName" itemValue="id" htmlEscape="false"/>
			</form:select>
		</li>
		<li><label>学员姓名：</label>
			<form:input path="erpStudentEnroll.name"  placeholder="请输入学员姓名/学号" htmlEscape="false" maxlength="20" class="input-medium"/>
		</li>
		<li><label>缺勤日期：</label>
			<input name="createTimeStart" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
				   value="<fmt:formatDate value="${classLessonSignHistory.createTimeStart}" pattern="yyyy-MM-dd"/>"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>-
			<input name="createTimeEnd" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
				   value="<fmt:formatDate value="${classLessonSignHistory.createTimeEnd}" pattern="yyyy-MM-dd"/>"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
		</li>
		<li><label>缺勤原因：</label>
			<form:select path="absenceReason" class="input-large" style="width: 210px">
				<form:option value="">请选择</form:option>
				<form:options items="${erp:getCommonsTypeList(4)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
			</form:select>
		</li>
		<li><label>补课状态：</label>
			<form:select path="arrangeStatus" class="input-large" style="width: 180px">
				<form:option value="">请选择</form:option>
				<form:options items="${erp:lessonStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
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
		<th>姓名</th>
		<th>学号</th>
		<th>班级名称</th>
		<th>课程</th>
		<th>授课老师</th>
		<th>上课时间</th>
		<th>上课时长</th>
		<th>缺勤原因</th>
		<th>缺勤日期</th>
		<th>补课状态</th>
		<th>操作</th>
	</tr>
	</thead>
	<tbody>
	<c:forEach items="${page.list}" var="classLessonSignHistory">
		<tr createUser="${classLessonSignHistory.createUser}" id="${classLessonSignHistory.id}">
			<td>
					${classLessonSignHistory.erpStudentEnroll.name}
			</td>
			<td>
					${classLessonSignHistory.erpStudentEnroll.studentNumber}
			</td>

			<td>
					${classLessonSignHistory.classLessonSign.schoolClass.className}
			</td>
			<td>
					${classLessonSignHistory.classLessonSign.schoolClassLesson.lessonName}
			</td>
			<td>
					${classLessonSignHistory.classSchedule.teacher.name}
			</td>
			<td>
				<fmt:formatDate value="${classLessonSignHistory.classLessonSign.beginTime}" pattern="yyyy-MM-dd HH:mm"/>~<br/>
				<fmt:formatDate value="${classLessonSignHistory.classLessonSign.endTime}" pattern="yyyy-MM-dd HH:mm"/>
			</td>
			<td>
				<fmt:formatNumber value="${(classLessonSignHistory.classLessonSign.endTime.getTime()-classLessonSignHistory.classLessonSign.beginTime.getTime())/1000/60}" pattern="#0"/>分钟
			</td>
			<td>
					${erp:getCommonsTypeName(classLessonSignHistory.absenceReason)}
			</td>
			<td>
				<fmt:formatDate value="${classLessonSignHistory.createTime}" pattern="yyyy-MM-dd HH:mm"/>
			</td>
			<td>
					${erp:lessonStatusName(classLessonSignHistory.arrangeStatus)}
			</td>
			<td>
				<c:if test="${classLessonSignHistory.arrangeStatus == 1}">
					<shiro:hasPermission name="school:classLessonSignHistory:signLessonList"><a href="${ctx}/school/classLessonSignHistory/signLessonList?studentId=${classLessonSignHistory.erpStudentEnroll.id}&&scheduleId=${classLessonSignHistory.classSchedule.id}">补课详情</a></shiro:hasPermission>
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
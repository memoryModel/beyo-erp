<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>签到管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
        $(document).ready(function() {
            $(document).find("a[name='beginInfo']").each(function () {
                var scheduleId = $(this).attr("scheduleId");
                var classId = $(this).attr("classId");
                var lessonId = $(this).attr("lessonId");
                $(this).click(function () {
                    top.$.jBox("iframe:/school/classLessonSign/signInfo?id="+scheduleId+"&&classId="+classId+"&&lessonId="+lessonId,{
                        title:"开课详情",
                        width:768,
                        height:700,
                        buttons:{}
                    });
                });
            });
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
	<li class="active"><a href="${ctx}/school/classLessonSign/list/">签到管理列表</a></li>
</ul>
<form:form id="searchForm" modelAttribute="classSchedule" action="${ctx}/school/classLessonSign/list/" method="post" class="breadcrumb form-search">
	<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	<ul class="ul-form">
		<li><label>班级名称：</label>
			<form:input path="schoolClass.className" cssClass="input-medium"/>
		</li>
		<li><label>课程：</label>
			<form:input path="schoolClassLesson.lessonName" cssClass="input-medium"/>
		</li>
		<li>
			<label>授课老师：</label>
			<form:input path="teacher.name" cssClass="input-medium"/>
		</li>
		<li class="clearfix"></li>
		<li><label>上课教室：</label>
			<form:input path="schoolClassroom.classroomName" cssClass="input-medium"/>

		</li>
		<li><label>状态：</label>
			<form:select path="status" class="input-medium">
				<form:option value="">请选择</form:option>
				<form:options items="${erp:lessonsStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
			</form:select>
		</li>
		<li><label>上课时间：</label>
			<input name="createTimeStart" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
				   value="<fmt:formatDate value="${classSchedule.createTimeStart}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>-
			<input name="createTimeEnd" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
				   value="<fmt:formatDate value="${classSchedule.createTimeEnd}" pattern="yyyy-MM-dd"/>"   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
		</li>
		<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
		<li class="clearfix"></li>
	</ul>
</form:form>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
	<thead>
	<tr>
		<th>班级名称</th>
		<th>课程</th>
		<th>授课老师</th>
		<th>上课时间</th>
		<th>上课时长</th>
		<th>上课教室</th>
		<th>签到/上课人数</th>
		<th>状态</th>
		<th>操作</th>
	</tr>
	</thead>
	<tbody>
	<c:forEach items="${page.list}" var="schoolClassSchedule">
		<tr createUser="${schoolClassSchedule.createUser}" id="${schoolClassSchedule.id}">
			<td>
					${schoolClassSchedule.schoolClass.className}
			</td>
			<td>
					${schoolClassSchedule.schoolClassLesson.lessonName}
			</td>
			<td>
					${schoolClassSchedule.teacher.name}
			</td>
			<td>
				<fmt:formatDate value="${schoolClassSchedule.beginTime}" pattern="yyyy-MM-dd HH:mm"/> ~~
				<fmt:formatDate value="${schoolClassSchedule.endTime}" pattern="HH:mm"/>
			</td>
			<td>
				<fmt:formatNumber value="${(schoolClassSchedule.endTime.getTime()-schoolClassSchedule.beginTime.getTime())/1000/60}" pattern="#0"/>分钟
			</td>
			<td>
					${schoolClassSchedule.schoolClassroom.classroomName}
			</td>
			<td>
					<%--<a href="${ctx}/school/classLessonSign/sign?id=${schoolClassSchedule.id}&&classId=${schoolClassSchedule.schoolClass.id}&&lessonId=${schoolClassSchedule.schoolClassLesson.id}&&tagFlag=1&&modify=1">
					--%><a name="beginInfo" scheduleId="${schoolClassSchedule.id}" classId="${schoolClassSchedule.schoolClass.id}" lessonId="${schoolClassSchedule.schoolClassLesson.id}" href="javascript:;" >
					${schoolClassSchedule.signCount}&nbsp;/&nbsp;${schoolClassSchedule.studentCount}
			</a>
			</td>
			<td>
					${erp:lessonsStatusName(schoolClassSchedule.status)}
			</td>

				<td>
					<c:if test="${schoolClassSchedule.status==0}">
						<shiro:hasPermission name="school:classLessonSign:signInfo">
							<a href="${ctx}/school/classLessonSign/sign?id=${schoolClassSchedule.id}&&classId=${schoolClassSchedule.schoolClass.id}&&lessonId=${schoolClassSchedule.schoolClassLesson.id}&&modify=1">签到上课</a>
						</shiro:hasPermission>
					</c:if>
					<c:if test="${schoolClassSchedule.status==1}">
						<shiro:hasPermission name="school:classLessonSign:info">
							<a name="beginInfo" scheduleId="${schoolClassSchedule.id}" classId="${schoolClassSchedule.schoolClass.id}" lessonId="${schoolClassSchedule.schoolClassLesson.id}" href="javascript:;" >开课详情</a>
						</shiro:hasPermission>
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
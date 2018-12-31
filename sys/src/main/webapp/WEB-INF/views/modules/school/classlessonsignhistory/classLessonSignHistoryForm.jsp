<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>签到历史管理管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
        $(document).ready(function() {
            //$("#name").focus();
            $("#inputForm").validate({
                submitHandler: function(form){
                    loading('正在提交，请稍等...');
                    form.submit();
                },
                errorContainer: "#messageBox",
                errorPlacement: function(error, element) {
                    $("#messageBox").text("输入有误，请先更正。");
                    if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
                        error.appendTo(element.parent().parent());
                    } else {
                        error.insertAfter(element);
                    }
                }
            });
        });
	</script>
</head>
<body>
<ul class="nav nav-tabs">
	<li><a href="${ctx}/school/classLessonSignHistory/list">补课列表</a></li>
	<li class="active"><a href="${ctx}/school/classLessonSignHistory/signLessonList?studentId=${classLessonSignHistory.erpStudentEnroll.id}">补课详情</li>
</ul><br/>
<form:form id="inputForm" modelAttribute="classLessonSignHistory" method="post" class="form-horizontal">
	<form:hidden path="id"/>
	<sys:message content="${message}"/>
	<div class="control-group">
		<label class="control-label">姓名：</label>
		<div class="controls">
			<form:input path="erpStudentEnroll.name" readonly="true" htmlEscape="false" maxlength="20" class="input-xlarge"/>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">学号：</label>
		<div class="controls">
			<form:input path="erpStudentEnroll.studentNumber" readonly="true" htmlEscape="false" maxlength="20" class="input-xlarge"/>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">课程：</label>
		<div class="controls">
			<form:input path="classSchedule.schoolClassLesson.lessonName" readonly="true" htmlEscape="false" maxlength="512" class="input-xlarge"/>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">班级：</label>
		<div class="controls">
			<form:input path="classSchedule.schoolClass.className" htmlEscape="false" readonly="true" maxlength="1000" class="input-xlarge "/>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">状态：</label>
		<div class="controls">
			<c:set var="nowDate" value="<%=System.currentTimeMillis()%>"></c:set>
			<c:choose>
				<c:when test="${nowDate-classLessonSignHistory.classSchedule.beginTime.getTime() > 0}">
					<span class="STYLE1">已上课</span>
				</c:when>
				<c:otherwise>
					<span class="STYLE2">未上课</span>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">上课时间：</label>
		<div class="controls">
			<input name="classSchedule.beginTime" type="text" style="width:140px;" readonly="readonly" maxlength="20"
				   value="<fmt:formatDate value="${classLessonSignHistory.classSchedule.beginTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>~
			<input name="classSchedule.endTime" type="text"  style="width:105px;"  readonly="readonly" maxlength="20"
				   value="<fmt:formatDate value="${classLessonSignHistory.classSchedule.endTime}" pattern="HH:mm:ss EEEEE"/>"/>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">授课老师：</label>
		<div class="controls">
			<form:input path="classSchedule.teacher.name"  htmlEscape="false" readonly="true"  class="input-xlarge"/>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">上课教室：</label>
		<div class="controls">
			<form:input path="classSchedule.schoolClassroom.classroomName" readonly="true" htmlEscape="false"  class="input-xlarge"/>
		</div>
	</div>
</form:form>
</body>
</html>
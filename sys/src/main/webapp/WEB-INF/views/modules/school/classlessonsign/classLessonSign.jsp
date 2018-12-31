<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>签到上课管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">

		$(document).ready(function() {
            //$("#name").focus();
            $("#inputForm").validate({
                submitHandler: function (form) {
                    loading('正在提交，请稍等...');
                    form.submit();
                },
                errorContainer: "#messageBox",
                errorPlacement: function (error, element) {
                    $("#messageBox").text("输入有误，请先更正。");
                    if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-append")) {
                        error.appendTo(element.parent().parent());
                    } else {
                        error.insertAfter(element);
                    }
                }
            });

			})
        var a="";
		var b="";
		var studentList = ${enrollList};
		var signHistoryList;
		var erpStudentEnroll;
        function sub(){
            for(var i=0;i<studentList.length;i++) {
                var obj = studentList[i];
                signHistoryList.erpStudentEnroll.id = obj.id;
                signHistoryList.classSchedule.id = ${classSchedule.id};

            }

        }


        function counts(sttatusId,studentId){
           var checks = document.getElementsByName("sttatus");
            n = 0;
            for(i=0;i<checks.length;i++){
                if(checks[i].checked)
                    n++;
            }

            if($('input[name="sttatus"]').prop("checked")) {
				a+=sttatusId+",";
				b+=studentId+",";
            }

            var st = $("#st").val();
            $("#sta").val(st-n);
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/school/classLessonSign/">签到管理列表</a></li>
		<li class="active"><a href="${ctx}/school/classLessonSign/signInfo?id=${classSchedule.id}">签到<shiro:hasPermission name="classlessonsign:schoolClassLessonSign:edit">${not empty schoolClassLessonSign.id?'修改':'上课'}</shiro:hasPermission><shiro:lacksPermission name="classlessonsign:schoolClassLessonSign:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="classSchedule" onsubmit="sub()" action="${ctx}/school/classLessonSign/save"  method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">班级：</label>
			<div class="controls">
				<input type="hidden" id="schoolClassId" name="schoolClassIds" value="${classSchedule.schoolClass.id}">
				${classSchedule.schoolClass.className}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">课程：</label>
			<div class="controls">
				<input type="hidden" id="classLessonId" name="classLessonIds" value="${classSchedule.schoolClassLesson.id}">
				${classSchedule.schoolClassLesson.lessonName}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">授课老师：</label>
			<div class="controls">
				<input type="hidden" id="teacherId" name="teacherIds" value="${classSchedule.schoolClassLesson.teacher.id}">
				${classSchedule.schoolClassLesson.teacher.name}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">上课时间：</label>
			<div class="controls">
				<input type="hidden" id="beginTime" name="beginTimes" value="${classSchedule.beginTime}"/>
				<input type="hidden" id="endTime" name="endTimes" value="${classSchedule.endTime}"/>
				<fmt:formatDate  value="${classSchedule.beginTime}" pattern="yyyy-MM-dd HH:mm"/>~
				<fmt:formatDate value="${classSchedule.endTime}" pattern="HH:mm"/>
				<font><b>【</b></font>
				<fmt:formatDate value="${classSchedule.beginTime}" pattern="EEEE"/>
				<font><b>】</b></font>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">上课内容：</label>
			<div class="controls">
				<form:textarea path="" htmlEscape="false" id="lessonContent" name="lessonContent" rows="4" maxlength="512" class="input-xxlarge " />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<form:textarea path="" id="remark" htmlEscape="false" rows="4" name="remark" maxlength="512" class="input-xxlarge " />
			</div>
		</div>
		<table id="contentTable" class="table table-striped table-bordered table-condensed">
			<thead>
			<tr>
				<th>id</th>
				<th>姓名</th>
				<th>学号</th>
				<th>联系电话</th>
				<th>是否缺勤</th>
				<th>缺勤原因</th>
			</tr>
			</thead>
			<tbody id="tbodyId">
			<c:forEach items="${enrollList}" var="studentEnroll">
				<tr id="myclass">
					<td>
						<c:out value="${studentEnroll.id}"></c:out>
					</td>
					<td>
						<c:out value="${studentEnroll.name}"></c:out>
					</td>
					<td>
						<c:out value="${studentEnroll.studentNumber}"></c:out>
					</td>
					<td>
						<c:out value="${studentEnroll.phone}"></c:out>
					</td>
					<td>
						<input type="checkbox" name="sttatus" value="0" onclick="counts(this.value,${studentEnroll.id})" id="status">缺勤
					</td>
					<td>
						<form:select  name="absenceReason" path=""  id="absenceReason" class="input-large" style="width: 130px">
							<form:option value="">请选择</form:option>
							<form:options items="${erp:getCommonsTypeList(4)}" itemLabel="commonsName"  itemValue="id" htmlEscape="false"/>
						</form:select>
					</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		<div class="control-group">
			<label class="control-label">总人数：</label>
			<div class="controls">
				共<input type="text" readonly="readonly" id="st" style="width: 20px" name="" value="${classSchedule.signCount}">人&nbsp;&nbsp;&nbsp;
				实际出勤<input type="text" readonly="readonly" style="width: 20px" id="sta" value="${classSchedule.signCount}">人
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="classlessonsign:schoolClassLessonSign:edit"><input id="btnSubmit" class="btn btn-primary" type="submit"  value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
		<input type="text" id="stuId" name="studentId">
		<input type="text" id="absenceReasons" name="absenceReasons">
		<input type="text" id="statuses" name="statusess">
	</form:form>
</body>
</html>
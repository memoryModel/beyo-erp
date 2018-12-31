<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>签到上课管理</title>
	<meta name="decorator" content="default"/>

</head>
<body>
	<c:if test="${empty modify}">
		<ul class="nav nav-tabs">
			<li><a href="${ctx}/school/classLessonSign/list">签到管理</a></li>
			<li class="active"><a href="${ctx}/school/classLessonSign/sign?id=${classSchedule.id}">签到<shiro:hasPermission name="school:classLessonSign:signInfo">${not empty schoolClassLessonSign.id?'修改':'上课'}</shiro:hasPermission><shiro:lacksPermission name="school:classLessonSign:signInfo">查看</shiro:lacksPermission></a></li>
		</ul>
	</c:if>
	<c:if test="${!empty modify && modify == 1}">
		<ul class="nav nav-tabs">
			<li><a href="${ctx}/school/schedule/list">课表管理</a></li>
			<li class="active"><a href="${ctx}/school/classLessonSign/sign?id=${classSchedule.id}&&modify=1">修改签到记录</a></li>
		</ul>
	</c:if>
	<br/>
	<form:form id="inputForm" modelAttribute="classSchedule"  action="${ctx}/school/classLessonSign/save/"  method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<input type="hidden" name="classLessonSignId" value="${classLessonSign.id}">
		<sys:message content="${message}"/>
		<input type="hidden" name="modify" value="${modify}">
		<div class="control-group">
			<label class="control-label">班级：</label>
			<div class="controls">
				<input type="hidden" id="schoolClassId" name="schoolClass.id" value="${classSchedule.schoolClass.id}">
				${classSchedule.schoolClass.className}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">课程：</label>
			<div class="controls">
				<input type="hidden" id="classLessonId" name="schoolClassLesson.lessonName" value="${classSchedule.schoolClassLesson.id}">
				${classSchedule.schoolClassLesson.lessonName}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">授课老师：</label>
			<div class="controls">
				<input type="hidden" id="teacherId" name="teacher.name" value="${classSchedule.teacher.id}">
				${classSchedule.teacher.name}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">上课时间：</label>
			<div class="controls">
				<input type="hidden" id="beginTime" name="beginTimes" value="${classSchedule.beginTime}"/>
				<input type="hidden" id="endTime" name="endTimes" value="${classSchedule.endTime}"/>
				<fmt:formatDate  value="${classSchedule.beginTime}" pattern="yyyy-MM-dd HH:mm"/>~
				<fmt:formatDate value="${classSchedule.endTime}" pattern="HH:mm"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">上课内容：</label>
			<div class="controls">
				<c:if test="${empty classLessonSign}">
					<textarea name="content" htmlEscape="false" id="lessonContent" name="lessonContent" rows="4" maxlength="512" class="input-xxlarge " ></textarea>
				</c:if>
				<c:if test="${!empty classLessonSign}">
					<textarea name="content" readonly="readonly" htmlEscape="false" id="lessonContent" name="lessonContent" rows="4" maxlength="512" class="input-xxlarge " >${classLessonSign.lessonContent}</textarea>
				</c:if>

			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<c:if test="${empty classLessonSign}">
					<textarea name="remark" id="remark" htmlEscape="false" rows="4" name="remark" maxlength="512" class="input-xxlarge " ></textarea>
				</c:if>
				<c:if test="${!empty classLessonSign}">
					<textarea name="remark" id="remark" htmlEscape="false" rows="4" name="remark" maxlength="512" class="input-xxlarge " >${classLessonSign.remark}</textarea>
				</c:if>

			</div>
		</div>
		<div class="control-group">
			<table id="contentTable" class="table table-striped table-bordered table-condensed" >
				<thead>
				<tr>

					<th>学号</th>
					<th>姓名</th>
					<th>联系电话</th>
					<th>是否缺勤</th>
					<th>缺勤原因</th>
				</tr>
				</thead>
				<tbody>
				<c:forEach items="${studentList}" var="student">
					<tr id="myclass">

						<td>
								${student.studentNumber}
						</td>
						<td>
								${student.name}
						</td>
						<td>
								${student.phone}
						</td>
						<td>
							<input type="hidden" name="studentId" value="${student.id}">
							<input type="checkbox"  name="statusCheck" onchange="check(this)" <c:if test="${!empty student.classLessonSignHistory && student.classLessonSignHistory.status==1}">checked="checked"</c:if>>缺勤
							<c:if test="${!empty student.classLessonSignHistory && modify==1}">
								<input type="hidden" name="status" value="${student.classLessonSignHistory.status}">
								<input type="hidden" name="absenceReasons" value="${student.classLessonSignHistory.absenceReason}">
							</c:if>
							<c:if test="${empty student.classLessonSignHistory}">
								<input type="hidden" name="status" value="0">
								<input type="hidden" name="absenceReasons" value=" ">
							</c:if>
						</td>
						<td>
							<c:if test="${!empty student.classLessonSignHistory}">
								<select name="selectReason" class="required" onchange="selectReasonChange(this)" <c:if test="${student.classLessonSignHistory.status==0}">disabled="disabled"</c:if>>
									<option value="">请选择</option>
									<c:forEach items="${erp:getCommonsTypeList(28)}" var="commonsType">
										<<option value="${commonsType.id}" <c:if test="${student.classLessonSignHistory.absenceReason==commonsType.id}">selected="selected"</c:if>>${commonsType.commonsName}</option>
									</c:forEach>
								</select>
							</c:if>
							<c:if test="${empty student.classLessonSignHistory}">
								<select name="selectReason" class="required" onchange="selectReasonChange(this)" disabled="disabled">
									<option value="">请选择</option>
									<c:forEach items="${erp:getCommonsTypeList(28)}" var="commonsType">
										<<option value="${commonsType.id}">${commonsType.commonsName}</option>
									</c:forEach>
								</select>
							</c:if>

						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>


		<div class="control-group">
			<label class="control-label">总人数：</label>
			<div class="controls">
				共<input type="text" readonly="readonly" id="studentCount" style="width: 20px" name="" value="${studentList.size()}">&nbsp;人&nbsp;&nbsp;&nbsp;
				实际出勤:<input type="text" readonly="readonly" style="width: 20px" id="signCount" value="${studentList.size()}">&nbsp;人
			</div>
		</div>

		<div class="form-actions">
			<shiro:hasPermission name="school:classLessonSign:save">
				<input id="btnSubmit" class="btn btn-primary" type="submit"  value="保 存"/>&nbsp;
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
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

        function check(obj){
            var checked = $(obj).attr("checked");
			var objSelect = $(obj).parents("tr").find("select[name='selectReason']")[0];
            var objReason = $(obj).parents("tr").find("input[name='absenceReasons']")[0];
            var objStatus = $(obj).parents("tr").find("input[name='status']")[0];
            if (checked == "checked"){
                $(objStatus).val("1");
                $(objSelect).attr("disabled",false);
				$(objReason).val($(objSelect).val());
			}else{
                $(objStatus).val("0");
                $(objSelect).attr("disabled",true);
                $(objReason).val(" ");
			}
            n = 0;
			$("input[name='statusCheck']").each(function () {
                if($(this).attr("checked") == "checked"){
					n++;
				}
            })

            var studentCount = $("#studentCount").val();

            studentCount = parseInt(studentCount);
            n = studentCount-n;
			$("#signCount").val(n);
        }

        function selectReasonChange(obj) {
			var reason = $(obj).val();
			$(obj).parents("tr").find("input[name='absenceReasons']").val(reason);
        }
	</script>
</body>
</html>
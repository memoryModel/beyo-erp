<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>成绩录入</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">

		$(document).ready(function() {
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

            jQuery.validator.addMethod("grade", function (value, element) {
				var grades = ${grades};
				if(value<=grades){
					return true;
				}else{
					return false;
				}
		}, "超出了卷面分");
        })

	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/school/examineInfo/list">考试管理列表</a></li>
		<li class="active"><a href="${ctx}/school/examineInfo/studentScore?id=${examineInfo.id}">成绩录入</a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="examineInfo"   class="form-horizontal" action="/school/examineInfo/studentScoreSave">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">考试名称：</label>
			<div class="controls">
				${examineInfo.examineName}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">通过分数：</label>
			<div class="controls">
					${examineInfo.passingGrade}
			</div>
		</div>
		<table id="contentTable" class="table table-striped table-bordered table-condensed" style="width: 50%">
			<thead>
			<tr>
				<th>班级</th>
				<th>姓名</th>
				<th>学号</th>
				<th>得分</th>
			</tr>
			</thead>
			<tbody>
			<c:forEach items="${examineStudentsList}" var="examineStudent">
				<tr id="myclass">
					<td>${examineStudent.schoolClass.className}
					</td>
					<td>${examineStudent.student.name}
					</td>
					<td>${examineStudent.student.studentNumber}
					</td>
					<td>
						<input type="hidden" name="studentId" value="${examineStudent.student.id}">
						<input  type="text" id="${examineStudent.student.id}" name="grade" class="required grade digits" style="width: 50px;text-align: right;" value="${examineStudent.grade}"/>&nbsp;分
					</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>

		<div class="form-actions" style="text-align: center">
			<shiro:hasPermission name="school:examineInfo:save"><input id="button" class="btn btn-primary"  type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>
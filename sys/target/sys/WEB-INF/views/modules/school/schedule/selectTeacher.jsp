<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>单表管理</title>
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

            $("#btnSave").click(function () {
                	var teacherId = $('#teacherId').val();
                	var teacherName = $('#teacherName').val();
                	if(!$("#inputForm").valid())return;
                    parent.window.frames["mainFrame"].selectTeacherCallback(teacherId,teacherName);
                    top.$.jBox.close(true);
            })


            $("input[name='closeWindows']").click(function () {
                    top.$.jBox.close(true);
            })
        });


	</script>
</head>
<body>
<br/>
<form:form id="inputForm" action="#" method="post" class="form-horizontal">
	<div class="control-group">
		<label class="control-label">授课老师：</label>
		<div class="controls" teacher>
			<%--<input type="hidden" id="teacherId" value="${schoolClassSchedule.schoolClassLesson.teacher.id}">
			<input type="text" id="teacherName" value="${schoolClassSchedule.schoolClassLesson.teacher.name}" />--%>
			<sys:treeselect id="teacher" name="teacher.id" value=""
							labelName="teacher.name" labelValue=""
							title="选择用户" url="/sys/office/treeData?type=3"
							notAllowSelectParent="true" cssClass="required"/>
				<span class="help-inline"><font color="red">*</font> </span>
		</div>
	</div>
			<div class="form-actions">
					<input id="btnSave" class="btn btn-primary" type="button" value="保 存"/>&nbsp;
				<input name="closeWindows" class="btn" type="button" value="关 闭"/>
			</div>
</form:form>
</body>
</html>
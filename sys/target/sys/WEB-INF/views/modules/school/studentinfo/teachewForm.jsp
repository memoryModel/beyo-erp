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


            $("input[name='closeWindows']").each(function () {
                $(this).click(function () {
                    parent.window.frames["mainFrame"].selectDelegatesCallback();
                    top.$.jBox.close(true);

                });
            })
        });


	</script>
</head>
<body>
	<br/>
	<form:form id="inputForm" action="${ctx}/school/studentInfo/teacherSave" method="post" class="form-horizontal">
		<input type="hidden" name="id" value="${student.id}"/>
		<sys:message content="${message}"/>
		<c:if test="${empty result}">
			<div class="control-group">
				<label class="control-label">学管师：</label>
				<div class="controls">
					<c:if test="${student.learningTeacher == null}">
						<sys:treeselect id="learningTeacher" name="learningTeacher.id" value="${student.schoolClassStudents.schoolClass.headteacher.id}"
										labelName="student.learningTeacher.name" labelValue="${student.schoolClassStudents.schoolClass.headteacher.name}"
										title="学管师" url="/sys/office/treeData?type=3" cssClass="required" notAllowSelectParent="true"/>
					</c:if>
					<c:if test="${student.learningTeacher != null}">
						<sys:treeselect id="learningTeacher" name="learningTeacher.id" value="${student.learningTeacher.id}"
										labelName="student.learningTeacher.name" labelValue="${student.learningTeacher.name}"
										title="学管师" url="/sys/office/treeData?type=3" cssClass="required" notAllowSelectParent="true"/>
					</c:if>


				</div>
			</div>
			<div class="form-actions">
				<shiro:hasPermission name="school:studentInfo:teacherSave">
					<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
				</shiro:hasPermission>
				<input name="closeWindows" class="btn" type="button" value="返 回" />
			</div>
		</c:if>
		<c:if test="${!empty result}">
			<div class="form-actions">
				<c:choose>
					<c:when test="${result == 'success'}">
						<div id="messageBox" class="alert alert-success"><button data-dismiss="alert" class="close">×</button>指派成功</div>
					</c:when>
					<c:otherwise>
						<div id="messageBox" class="alert alert-success"><button data-dismiss="alert" class="close">×</button>指派失败</div>
					</c:otherwise>
				</c:choose>

				<input name="closeWindows" class="btn" type="button" value="关 闭"/>
			</div>
		</c:if>
	</form:form>
</body>
</html>
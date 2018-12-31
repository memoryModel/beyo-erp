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
	<form:form id="inputForm" modelAttribute="student" action="${ctx}/school/student/followSave" method="post" class="form-horizontal">
		<input type="hidden" name="id" value="${student.id}"/>
		<input type="hidden" name="ids" value="${ids}"/>
		<sys:message content="${message}"/>
		<c:if test="${empty result}">
			<div class="control-group">
				<label class="control-label">跟进人：</label>
				<div class="controls">
					<sys:treeselect id="follow" name="follow.id" value="${student.follow.id}"
									labelName="student.follow.name" labelValue="${student.follow.name}"
									title="跟进人" url="/sys/office/treeData?type=3" cssClass="required" notAllowSelectParent="true"/>

				</div>
			</div>
			<div class="form-actions">
				<shiro:hasPermission name="school:student:followSave">
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
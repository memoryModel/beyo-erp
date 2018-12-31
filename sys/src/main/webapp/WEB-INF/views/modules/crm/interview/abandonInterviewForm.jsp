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

            if (${ids != null}){
                $('#inputForm').attr("action","${ctx}/crm/interview/batchSaveAbandonInterview");
            }else{
                $('#inputForm').attr("action","${ctx}/crm/interview/saveAbandonInterview");
            }
        });


	</script>
</head>
<body>
	<br/>
	<form:form id="inputForm" modelAttribute="interview" method="post" class="form-horizontal">
		<input type="hidden" name="id" value="${interview.id}"/>
		<input type="hidden" name="ids" value="${ids}"/>
		<sys:message content="${message}"/>

		<c:if test="${empty result}">
			<div class="control-group">
				<label class="control-label">放弃面试原因：</label>
				<div class="controls">
					<form:textarea path="abandonCause" htmlEscape="false" rows="4" class="required input-xxlarge"/>
					<span class="help-inline"><font color="red">*</font></span>
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
						<div id="messageBox" class="alert alert-success"><button data-dismiss="alert" class="close">×</button>放弃面试成功</div>
					</c:when>
					<c:otherwise>
						<div id="messageBox" class="alert alert-success"><button data-dismiss="alert" class="close">×</button>放弃面试失败</div>
					</c:otherwise>
				</c:choose>

				<input name="closeWindows" class="btn" type="button" value="关 闭"/>
			</div>
		</c:if>

	</form:form>

</body>
</html>
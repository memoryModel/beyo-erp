<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>放弃客户跟进</title>
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
	<form:form id="inputForm" modelAttribute="customer" action="${ctx}/crm/customer/updateAbandonReason" method="post" class="form-horizontal">
		<br/>
		<input type="hidden" name="id" value="${customer.id}">
		<sys:message content="${message}"/>
		<c:if test="${empty result}">
			<div class="control-group">
				<label class="control-label"><font color="red">*</font> &nbsp;放弃原因：</label>
				<div class="controls">
					<form:textarea path="abandonReason" htmlEscape="false" rows="4" maxlength="50" class="required input-xxlarge " style="width: 350px;"/>
				</div>
			</div>
			<div class="form-actions">
				<shiro:hasPermission name="crm:customer:save">
					<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
				</shiro:hasPermission>
				<input name="closeWindows" class="btn" type="button" value="返 回" />
			</div>
		</c:if>
		<c:if test="${!empty result}">
			<div class="form-actions">
				<c:choose>
					<c:when test="${result == 'success'}">
						<div id="messageBox" class="alert alert-success"><button data-dismiss="alert" class="close">×</button>放弃跟进成功</div>
					</c:when>
					<c:otherwise>
						<div id="messageBox" class="alert alert-success"><button data-dismiss="alert" class="close">×</button>放弃跟进失败</div>
					</c:otherwise>
				</c:choose>

				<input name="closeWindows" class="btn" type="button" value="关 闭"/>
			</div>
		</c:if>
	</form:form>
</body>
</html>
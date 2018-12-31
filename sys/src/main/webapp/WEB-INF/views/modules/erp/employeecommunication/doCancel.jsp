<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>撤回到待指派</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
            $("input[name='closeWindows']").each(function () {
                $(this).click(function () {
                    top.$.jBox.close(true);
                });
            })

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

            jQuery.validator.addMethod("cancelReasonRequired", function(value, element) {

                var flag = true;
                var content = $('textarea[name="cancelReason"]').val();
                if(content == null || content == ""){
                    flag = false;
				}
                return flag;
            }, "必填信息");
		});

	</script>
</head>
<body>
	<form:form id="inputForm" modelAttribute="employee" action="${ctx}/erp/employeeCommunication/doCancel" method="post" class="breadcrumb form-search">
		<c:if test="${empty result}">
			<table>
				<tr>
					<td>
						撤回原因:
							<input type="hidden" name="id" id="id" value="${employee.id}">
							<textarea name="cancelReason" class="cancelReasonRequired"></textarea>
							<span class="help-inline"><font color="red">*</font> </span>
					</td>
				</tr>

			</table>
		<div class="form-actions">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
			<input name="closeWindows" class="btn" type="button" value="关闭"/>
		</div>
		</c:if>
		<c:if test="${!empty result}">
			<div class="form-actions">
				<c:choose>
					<c:when test="${result == 'success'}">
						<div id="messageBox" class="alert alert-success"><button data-dismiss="alert" class="close">×</button>撤回成功</div>
					</c:when>
					<c:otherwise>
						<div id="messageBox" class="alert alert-success"><button data-dismiss="alert" class="close">×</button>撤回失败</div>
					</c:otherwise>
				</c:choose>

				<input name="closeWindows" class="btn" type="button" value="关 闭"/>
			</div>
		</c:if>
	</form:form>
	<sys:message content="${message}"/>
</body>
</html>
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
                    parent.window.frames["mainFrame"].selectDelegateCallback();
                    top.$.jBox.close(true);
                });
            })
        });

	</script>
</head>
<body>
	<br/>
	<form:form id="inputForm" modelAttribute="leave" action="${ctx}/school/leave/updateStatus?id=${leave.id}&&leaveStatus=2" method="post" class="form-horizontal">
		<sys:message content="${message}"/>
		<c:if test="${empty result}">
			<div class="control-group">
				<label class="control-label">名称：</label>
				<div class="controls">
						${leave.student.name}
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">学号：</label>
				<div class="controls">
						${leave.student.studentNumber}
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">请假时间：</label>
				<div class="controls">
					<fmt:formatDate value="${leave.startTime}" pattern="yyyy-MM-dd HH:mm"/> --
					<fmt:formatDate value="${leave.endTime}" pattern="yyyy-MM-dd HH:mm"/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">请假原因：</label>
				<div class="controls">
					<c:forEach items="${erp:getCommonsTypeList(28)}" var="commonsType">
						<c:if test="${commonsType.id == leave.leaveReason}">
							${commonsType.commonsName}
						</c:if>
					</c:forEach>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">销假时间：</label>
				<div class="controls">
					<input  name="destroyTime" type="text" readonly="readonly" style="width: 210px" class="input-medium Wdate "
							value="<fmt:formatDate value="${leave.destroyTime}" pattern="yyyy-MM-dd HH:mm"/>"
							onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>
				</div>
			</div>
			<div class="form-actions">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
				<input name="closeWindows" class="btn" type="button" value="返 回" />
			</div>
		</c:if>
		<c:if test="${!empty result}">
			<div class="form-actions">
				<c:choose>
					<c:when test="${result == 'success'}">
						<div id="messageBox" class="alert alert-success"><button data-dismiss="alert" class="close">×</button>指派成功</div>
					</c:when>
				</c:choose>

				<input name="closeWindows" class="btn" type="button" value="关 闭"/>
			</div>
		</c:if>
	</form:form>
</body>
</html>
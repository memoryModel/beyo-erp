<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>指派沟通人</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {

            $("input[name='closeWindows']").each(function () {
                $(this).click(function () {
                    top.$.jBox.close(true);
                });
            })
		});

	</script>
</head>
<body>
	<form:form id="searchForm" modelAttribute="employee" action="${ctx}/erp/employeeCommunication/doAppointCommunicate" method="post" class="breadcrumb form-search">
		<c:if test="${empty result}">
			<table>
				<tr>
					<td>
							沟通人:
								<input type="hidden" name="id" id="id" value="${employee.id}">
								<input type="hidden" name="employeeCommunication.id" value="${employee.employeeCommunication.id}">
								<sys:treeselect id="interviewers" name="employeeCommunication.communicationId" value="${interview.interviewers.id}"
												labelName="employeeCommunication.communicationName" labelValue="${interview.interviewers.name}"
												title="选择用户" url="/sys/office/treeData?type=3" notAllowSelectParent="true" cssClass="required"/>
								<span class="help-inline"><font color="red">*</font> </span>
					</td>
				</tr>
				<tr>
					<td>
							备  注:
								<textarea name="employeeCommunication.remark" style="width: 80%;height: 80%"></textarea>
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
						<div id="messageBox" class="alert alert-success"><button data-dismiss="alert" class="close">×</button>指派沟通人成功</div>
					</c:when>
					<c:otherwise>
						<div id="messageBox" class="alert alert-success"><button data-dismiss="alert" class="close">×</button>指派沟通人失败</div>
					</c:otherwise>
				</c:choose>

				<input name="closeWindows" class="btn" type="button" value="关 闭"/>
			</div>
		</c:if>
	</form:form>
	<sys:message content="${message}"/>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>招工沟通历史记录表管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});

	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/employeecommunicationhistory/employeeCommunicationHistory/">招工沟通历史记录表列表</a></li>
		<shiro:hasPermission name="employeecommunicationhistory:employeeCommunicationHistory:edit"><li><a href="${ctx}/employeecommunicationhistory/employeeCommunicationHistory/form">招工沟通历史记录表添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="employeeCommunicationHistory" action="${ctx}/employeecommunicationhistory/employeeCommunicationHistory/" method="post" class="breadcrumb form-search">
		员工姓名: ${employee.name}&nbsp;&nbsp;手机号码: ${employee.phone}
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>沟通人</th>
				<th>沟通时间</th>
				<th>沟通方式</th>
				<th>签约意向</th>
				<th>联系主题</th>
				<th>下次沟通安排</th>
				<th>下次沟通方式</th>
				<th>下次沟通时间</th>
				<th>操作</th>
				<%--<shiro:hasPermission name="employeecommunicationhistory:employeeCommunicationHistory:edit"></shiro:hasPermission>--%>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${list}" var="employeeCommunicationHistory">
			<tr>
				<td>
						${employeeCommunicationHistory.communicationName}
				</td>
				<td>
						<fmt:formatDate value="${employeeCommunicationHistory.communicationTime}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
						${erp:communicationModeStatusName(employeeCommunicationHistory.communicationMode)}
				</td>
				<td>
						${erp:signingIntentionStatusName(employeeCommunicationHistory.signingIntention)}
				</td>
				<td>
						${employeeCommunicationHistory.theme}
				</td>
				<td>
						${erp:nextCommunicationArrangementStatusName(employeeCommunicationHistory.nextCommunicationArrangement)}
				</td>
				<td>
						<c:if test="${employeeCommunicationHistory.nextCommunicationMode == null || employeeCommunicationHistory.nextCommunicationMode == ''}">
							无
						</c:if>
						<c:if test="${employeeCommunicationHistory.nextCommunicationMode != null}">
							${erp:communicationModeStatusName(employeeCommunicationHistory.nextCommunicationMode)}
						</c:if>
				</td>
				<td>
						<c:if test="${employeeCommunicationHistory.nextCommunicationTime == null}">
							无
						</c:if>
						<c:if test="${employeeCommunicationHistory.nextCommunicationTime != null}">
							${employeeCommunicationHistory.nextCommunicationTime}
						</c:if>
				</td>
				<%--<shiro:hasPermission name="employeecommunicationhistory:employeeCommunicationHistory:edit">
					<td>
    					<a href="${ctx}/employeecommunicationhistory/employeeCommunicationHistory/form?id=${employeeCommunicationHistory.id}">修改</a>
						<a href="${ctx}/employeecommunicationhistory/employeeCommunicationHistory/delete?id=${employeeCommunicationHistory.id}" onclick="return confirmx('确认要删除该招工沟通历史记录表吗？', this.href)">删除</a>
					</td>
				</shiro:hasPermission>--%>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<input id="btnCancel" class="btn btn-primary" type="button" value="返 回" onclick="history.go(-1)">
</body>
</html>
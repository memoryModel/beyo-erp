<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>解约申请审批管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/crm/cancellationApproved/list">解约待审批列表</a></li>
		<shiro:hasPermission name="cancellationapproved:cancellationApproved:edit"><li><a href="${ctx}/cancellationapproved/cancellationApproved/form">解约申请审批添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="cancellationApproved" action="${ctx}/crm/cancellationApproved/list" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>员工姓名：</label>
				<form:input path="employeeEntry.employee.name" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>手机号码：</label>
				<form:input path="employeeEntry.employee.phone" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>性别：</label>
				<form:select path="employeeEntry.employee.sex" class="input-medium ">
					<form:option value="" label="------请选择------"/>
					<form:options items="${erp:sexStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>工种：</label>
				<form:select path="employeeEntry.employee.profession" class="input-mediun">
					<form:option value="" label="------请选择------"/>
					<form:options items="${erp:getCommonsTypeList(21)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>解约原因：</label>
				<form:select path="employeeCancellation.cancellationReason" class="input-mediun">
					<form:option value="" label="------请选择------"/>
					<form:options items="${erp:employeeCancellationList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>员工性质：</label>
				<form:select path="employeeEntry.type" class="input-medium ">
					<form:option value="" label="------请选择------"/>
					<form:options items="${erp:employeeTypeList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li>&nbsp;&nbsp;&nbsp;&nbsp;签约截止日期：
				<input name="signingDeadlineStartTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${employeeCancellation.signingDeadlineStartTime}" pattern="yyyy-MM-dd HH:mm"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>--
				<input name="signingDeadlineEndTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${employeeCancellation.signingDeadlineEndTime}" pattern="yyyy-MM-dd HH:mm"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>
			</li>
			<li>&nbsp;&nbsp;&nbsp;&nbsp;解约生效日期：
				<input name="cancellationEffectiveStartTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${employeeCancellation.cancellationEffectiveStartTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>--
				<input name="cancellationEffectiveEndTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${employeeCancellation.cancellationEffectiveEndTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			</li>
			<li>&nbsp;&nbsp;&nbsp;&nbsp;提交审批日期：
				<input name="submitApprovalStartTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${employeeCancellation.submitApprovalStartTime}" pattern="yyyy-MM-dd HH:mm"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>--
				<input name="submitApprovalEndTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${employeeCancellation.submitApprovalEndTime}" pattern="yyyy-MM-dd HH:mm"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>
			</li>

			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
		<tr>
			<td>员工编号</td>
			<td>员工姓名</td>
			<td>性别</td>
			<td>手机号码</td>
			<td>工种</td>
			<td>员工性质</td>
			<td>签约截止日期</td>
			<td>解约生效日期</td>
			<td>解约原因</td>
			<c:if test="${flag == null}">
				<td>提交审批时间</td>
			</c:if>
			<c:if test="${flag == 1}">
				<td>审批通过时间</td>
			</c:if>
			<th>操作</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="cancellationApproved">
			<tr>
				<td>${cancellationApproved.employeeEntry.employee.code}</td>
				<td>${cancellationApproved.employeeEntry.employee.name}</td>
				<td>${erp:sexStatusName(cancellationApproved.employeeEntry.employee.sex)}</td>
				<td>${cancellationApproved.employeeEntry.employee.phone}</td>
				<td>
					<c:forEach items="${cancellationApproved.employeeEntry.employee.getProfessionList()}" var="occId" varStatus="length">
					<c:if test="${length.index!=0}">
					,
					</c:if>
						${erp:getCommonsTypeName(occId)}
					</c:forEach>
				<td>${erp:employeeTypeName(cancellationApproved.employeeEntry.type)}</td>
				<td><fmt:formatDate value="${cancellationApproved.employeeEntry.deadlineTime}" pattern="yyyy-MM-dd HH:mm"/></td>
				<td><fmt:formatDate value="${cancellationApproved.employeeCancellation.cancellationEffectiveTime}" pattern="yyyy-MM-dd"/></td>
				<td>${erp:employeeCancellationName(cancellationApproved.employeeCancellation.cancellationReason)}</td>
				<c:if test="${flag == null}">
					<td><fmt:formatDate value="${cancellationApproved.employeeCancellation.createTime}" pattern="yyyy-MM-dd HH:mm"/></td>
				</c:if>
				<c:if test="${flag == 1}">
					<td><fmt:formatDate value="${cancellationApproved.createTime}" pattern="yyyy-MM-dd HH:mm"/></td>
				</c:if>
				<c:if test="${flag == null}">
					<td>
						<a href="${ctx}/crm/cancellationApproved/form?id=${cancellationApproved.id}">审批</a>
					</td>
				</c:if>
				<c:if test="${flag == 1}">
					<td>
						<a href="${ctx}/crm/cancellationApproved/form?id=${cancellationApproved.id}">查看解约信息</a>
					</td>
				</c:if>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
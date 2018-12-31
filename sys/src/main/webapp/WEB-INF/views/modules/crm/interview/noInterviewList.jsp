<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>待面试列表</title>
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
	<li class="active"><a href="${ctx}/crm/interview/notInterviewList">待面试列表</a></li>
</ul><br/>
<form:form id="searchForm" modelAttribute="interview" action="${ctx}/crm/interview/notInterviewList" method="post" class="breadcrumb form-search">
	<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	<ul class="ul-form">
		<li><label>员工姓名：</label>
			<form:input path="employee.name" htmlEscape="false" maxlength="20" class="input-medium"/>
		</li>
		<li><label>手机号码：</label>
			<form:input path="employee.phone" htmlEscape="false" maxlength="20" class="input-medium"/>
		</li>
		<li>
			<label>来源：</label>
			<sys:treeselect id="customerResource" name="customerResource.id" value="${employee.customerResource.id}"
							labelName="customerResource.customerName" labelValue="${employee.customerResource.customerName}"
							title="来源名称" url="/erp/customerResource/treeData"  allowClear="true"/>
		</li>
		<li><label>性别：</label>
			<form:select path="employee.sex" class="input-medium ">
				<form:option value="" label="------请选择------"/>
				<form:options items="${erp:sexStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
			</form:select>
		</li>
		<li>预约面试时间：
			<input name="startAppointInterviewTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
				   value="<fmt:formatDate value="${interview.startAppointInterviewTime}" pattern="yyyy-MM-dd HH:mm"/>"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>--
			<input name="endAppointInterviewTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
				   value="<fmt:formatDate value="${interview.endAppointInterviewTime}" pattern="yyyy-MM-dd HH:mm"/>"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
		</li>

		<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
	</ul>
</form:form>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
	<thead>
	<tr>
		<th>姓名</th>
		<th>性别</th>
		<th>手机号码</th>
		<th>工种</th>
		<th>来源</th>
		<th>面试人</th>
		<th>预约面试时间</th>
		<th>计划添加人</th>
		<th>计划添加时间</th>
		<th>操作</th>
	</tr>

	</thead>
	<tbody>
	<c:forEach items="${page.list}" var="interview">
		<tr>
			<td>
					${interview.employee.name}
			</td>
			<td>
					${erp:sexStatusName(interview.employee.sex)}
			</td>
			<td>
					${interview.employee.phone}
			</td>
			<td>
				<c:forEach items="${interview.employee.getProfessionList()}" var="occId" varStatus="length">
					<c:if test="${length.index!=0}">
						,
					</c:if>
					${erp:getCommonsTypeName(occId)}
				</c:forEach>
			</td>
			<td>
					${interview.customerResource.customerName}
			</td>
			<td>
					${interview.user.name}
			</td>
			<td>
					<fmt:formatDate value="${interview.appointInterviewTime}" pattern="yyyy-MM-dd HH:mm"/>
			</td>
			<td>
					${interview.addPlanUser.name}
			</td>
			<td>
					<fmt:formatDate value="${interview.createTime}" pattern="yyyy-MM-dd HH:mm"/>
			</td>
			<td>
				<a href="${ctx}/crm/interviewRecord/form?interview.id=${interview.id}">添加面试记录</a>&nbsp;&nbsp;
			</td>
		</tr>
	</c:forEach>
	</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
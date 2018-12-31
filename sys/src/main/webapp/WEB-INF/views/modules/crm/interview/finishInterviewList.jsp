<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>已完成面试列表</title>
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
	<li class="active"><a href="${ctx}/crm/interviewRecord/interviewList">已面试列表</a></li>
</ul><br/>
<form:form id="searchForm" modelAttribute="interviewRecord" action="${ctx}/crm/interviewRecord/interviewList" method="post" class="breadcrumb form-search">

	<li><label>员工姓名：</label>
		<form:input path="interview.employee.name" htmlEscape="false" maxlength="20" class="input-medium"/>
	</li>
	<li><label>手机号码：</label>
		<form:input path="interview.employee.phone" htmlEscape="false" maxlength="20" class="input-medium"/>
	</li>
	<li>
		<label>来源：</label>
		<sys:treeselect id="customerResource" name="interview.employee.customerResource.id" value="${interviewRecord.interview.employee.customerResource.id}"
						labelName="interview.employee.customerResource.customerName" labelValue="${interviewRecord.interview.employee.customerResource.customerName}"
						title="来源名称" url="/erp/customerResource/treeData"  allowClear="true"/>
	</li>
	<li><label>性别：</label>
		<form:select path="interview.employee.sex" class="input-medium ">
			<form:option value="" label="------请选择------"/>
			<form:options items="${erp:sexStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
		</form:select>
	</li>
	<li>预约面试时间：
		<input name="startInterviewTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
			   value="<fmt:formatDate value="${interviewRecord.startInterviewTime}" pattern="yyyy-MM-dd HH:mm"/>"
			   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>--
		<input name="endInterviewTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
			   value="<fmt:formatDate value="${interviewRecord.endInterviewTime}" pattern="yyyy-MM-dd HH:mm"/>"
			   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
	</li>
	<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
	<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	<ul class="ul-form">

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
		<th>面试时间</th>
		<th>面试结果</th>
		<th>提交状态</th>
		<th>计划添加人</th>
		<th>计划添加时间</th>
		<th>操作</th>
	</tr>

	</thead>
	<tbody>
	<c:forEach items="${page.list}" var="interviewRecord">
		<tr>
			<td>
					${interviewRecord.interview.employee.name}
			</td>
			<td>
					${erp:sexStatusName(interviewRecord.interview.employee.sex)}
			</td>
			<td>
					${interviewRecord.interview.employee.phone}
			</td>
			<td>
				<c:forEach items="${interviewRecord.interview.employee.getProfessionList()}" var="occId" varStatus="length">
					<c:if test="${length.index!=0}">
						,
					</c:if>
					${erp:getCommonsTypeName(occId)}
				</c:forEach>
			</td>
			<td>
					${interviewRecord.interview.employee.customerResource.customerName}
			</td>
			<td>
					${interviewRecord.interview.interviewers.name}
			</td>
			<td>
					<fmt:formatDate value="${interviewRecord.interviewTime}" pattern="yyyy-MM-dd HH:mm"/>
			</td>
			<td>
					${erp:interviewStatusName(interviewRecord.status)}
			</td>
			<td>
					${erp:interviewSubmitStatusName(interviewRecord.submitStatus)}
			</td>
			<td>
					${interviewRecord.user.name}
			</td>
			<td>
				<fmt:formatDate value="${interviewRecord.createTime}" pattern="yyyy-MM-dd HH:mm"/>
			</td>
			<td>
				<c:if test="${interviewRecord.submitStatus == 0 }">
					<a href="${ctx}/crm/interviewRecord/form?id=${interviewRecord.id}">修改面试结果</a>&nbsp;&nbsp;
				</c:if>
				<c:if test="${interviewRecord.status == 0 && interviewRecord.submitStatus == 0}">
					<a href="${ctx}/crm/interviewRecord/submitGrading?id=${interviewRecord.id}" onclick="return confirmx('提交定级后，面试记录将不可修改，确定提交员工定级？', this.href)">提交定级</a>&nbsp;&nbsp;
				</c:if>
				<c:if test="${interviewRecord.submitStatus == 1}">
					<a href="${ctx}/crm/interviewRecord/info?id=${interviewRecord.id}">查看</a>&nbsp;&nbsp;
				</c:if>
			</td>
		</tr>
	</c:forEach>
	</tbody>
</table>
	<div class="pagination">${page}</div>
</body>
</html>
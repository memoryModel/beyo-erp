<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>面试管理管理</title>
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
	<li class="active"><a href="${ctx}/crm/interview/list">面试管理列表</a></li>
	<li><a href="${ctx}/crm/interview/form?id=${interview.id}">面试管理<shiro:hasPermission name="crm:interview:form">${not empty interview.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="crm:interview:form">查看</shiro:lacksPermission></a></li>
	<li><a href="${ctx}/crm/interview/toBeNotifiedList">待通知列表</a></li>
	<li><a href="${ctx}/crm/interview/informList">已通知列表</a></li>
	<li><a href="${ctx}/crm/interview/notInterviewList">待面试列表</a></li>
	<li><a href="${ctx}/crm/interview/interviewList">已面试列表</a></li>
</ul><br/>
	<form:form id="searchForm" modelAttribute="interview" action="${ctx}/crm/interview/list" method="post" class="breadcrumb form-search">
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
			<%--<li class="clearfix"></li>--%>
			<li><label>性别：</label>
				<form:select path="employee.sex" class="input-medium ">
					<form:option value="" label="------请选择------"/>
					<form:options items="${erp:sexStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>工种：</label>
				<form:select path="employee.profession" class="input-medium">
					<form:option value="" label="------请选择------"/>
					<form:options items="${erp:getCommonsTypeList(21)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>面试结果：</label>
				<form:select path="interviewStatus" class="input-medium ">
					<form:option value="-1" label="------请选择------"/>
					<form:options items="${erp:interviewStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>

			<%--<li class="clearfix"></li>--%>

			<li><label>面试时间：</label>
				<input name="startInterviewTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${interview.startInterviewTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>至
				<input name="endInterviewTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${interview.endInterviewTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			</li>
			<li><label>创建时间：</label>
				<input name="startTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${interview.startTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>至
				<input name="endTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${interview.endTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			</li>

			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<%--<li class="clearfix"></li>--%>
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
				<th>面试时间</th>
				<th>面试结果</th>
				<th>面试人</th>
				<th>创建人</th>
				<th>创建时间</th>
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
					${erp:getCommonsTypeName(interview.employee.profession)}
				</td>
				<td>
					${interview.customerResource.customerName}
				</td>
				<td>
					<fmt:formatDate value="${interview.interviewTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
						${erp:interviewStatusName(interview.interviewStatus)}
				</td>
				<td>
						${interview.interviewers.name}
				</td>
				<td>
						${interview.user.name}
				</td>
				<td>
					<fmt:formatDate value="${interview.createTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
					<c:if test="${interview.interviewStatus == 1}"><%--面试通过--%>
						<shiro:hasPermission name="crm:interview:form"><a href="${ctx}/crm/interview/info?id=${interview.id}">查看</a></shiro:hasPermission>
					</c:if>
					<c:if test="${interview.interviewStatus == 2}"><%--面试未通过--%>
						<shiro:hasPermission name="crm:interview:form"><a href="${ctx}/crm/interview/form?id=${interview.id}">编辑</a></shiro:hasPermission>
						<shiro:hasPermission name="crm:interview:form"><a href="${ctx}/crm/interview/info?id=${interview.id}">查看</a></shiro:hasPermission>
					</c:if>
					<c:if test="${interview.interviewStatus == 3}"><%--待定--%>
						<shiro:hasPermission name="crm:interview:form"><a href="${ctx}/crm/interview/form?id=${interview.id}">编辑</a></shiro:hasPermission>
						<shiro:hasPermission name="crm:interview:form"><a href="${ctx}/crm/interview/info?id=${interview.id}">查看</a></shiro:hasPermission>
					</c:if>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
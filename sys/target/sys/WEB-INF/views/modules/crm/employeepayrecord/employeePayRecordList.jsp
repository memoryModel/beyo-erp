<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>工资结算管理</title>
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

		<li <c:if test="${not empty employeePayRecord.statusFlag && employeePayRecord.statusFlag==1}">class="active"</c:if>>
			<a href="${ctx}/crm/employeepayrecord/list?statusFlag=1">待确认工资</a>
		</li>
		<li <c:if test="${not empty employeePayRecord.statusFlag && employeePayRecord.statusFlag==2}">class="active"</c:if>>
			<a href="${ctx}/crm/employeepayrecord/list?statusFlag=2">待结算工资</a>
		</li>
		<li <c:if test="${not empty employeePayRecord.statusFlag && employeePayRecord.statusFlag==3}">class="active"</c:if>>
			<a href="${ctx}/crm/employeepayrecord/list?statusFlag=3">已结算工资</a>
		</li>

		<%--<shiro:hasPermission name="crm:employeepayrecord:employeePayRecord:edit">
			<li><a href="${ctx}/crm/employeepayrecord/form">工资结算添加</a></li>
			</shiro:hasPermission>--%>
	</ul>
	<form:form id="searchForm" modelAttribute="employeePayRecord" action="${ctx}/crm/employeepayrecord/list?statusFlag=${statusFlag}" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>工号：</label>
				<form:input path="employee.code" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>人员姓名：</label>
				<form:input path="employee.name" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>人员手机号：</label>
				<form:input path="employee.phone" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li>
				<label>人员类别：</label>
				<form:select path="employee.entry.type" class="input-medium">
					<form:option value="" label="------请选择------"/>
					<form:options items="${erp:employeeTypeList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>


			<li><label>创建时间：</label>
				<input name="createTimeStart" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   value="<fmt:formatDate value="${employeeLeave.createTimeStart}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>-
				<input name="createTimeEnd" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   value="<fmt:formatDate value="${employeeLeave.createTimeEnd}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>工号</th>
				<th>服务人员姓名</th>
				<th>手机号</th>
				<th>服务人员类别</th>
				<th>结算日期起</th>
				<th>结算日期至</th>
				<th>服务单数</th>
				<th>应发工资</th>
				<%--<c:if test="${not empty employeePayRecord.statusFlag && employeePayRecord.statusFlag !=2}">
					<th>增项合计</th>
					<th>扣款合计</th>
					<th>实发工资</th>
				</c:if>--%>
				<th>结算状态</th>
				<shiro:hasPermission name="crm:employeepayrecord:employeePayRecord:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="employeePayRecord">
			<tr>
				<td>
					${employeePayRecord.employee.code}
				</td>
				<td>
					${employeePayRecord.employee.name}
				</td>
				<td>
					${employeePayRecord.employee.phone}
				</td>
				<td>
					${erp:employeeTypeName(employeePayRecord.employee.entry.type)}
				</td>
				<td>
					<fmt:formatDate value="${employeePayRecord.dispatchEmployee.dispatch.realStartTime}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					<fmt:formatDate value="${employeePayRecord.dispatchEmployee.dispatch.realEndTime}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					${employeePayRecord.dispatchEmployee.dispatch.usedNum}
				</td>
				<td>
					${employeePayRecord.planAmount}
				</td>
<%--				<c:if test="${not empty employeePayRecord.statusFlag && employeePayRecord.statusFlag !=2}">
					<td>${employeePayRecord.dispatchEmployee.dispatch.usedNum}</td>
					<td>${employeePayRecord.dispatchEmployee.dispatch.usedNum}</td>
					<td>${employeePayRecord.dispatchEmployee.dispatch.usedNum}</td>
				</c:if>--%>

				<td>
					${erp:EmployeePayRecordStatusName(employeePayRecord.status)}
				</td>
				<td>
				<shiro:hasPermission name="crm:employeepayrecord:employeePayRecord:edit">

						<c:if test="${not empty statusFlag && statusFlag == 1}">
							<a href="${ctx}/crm/employeepayrecord/form?id=${employeePayRecord.id}">工资确认</a>
						</c:if>
						<%--<a href="${ctx}/crm/employeepayrecord/delete?id=${employeePayRecord.id}" onclick="return confirmx('确认要删除该工资结算吗？', this.href)">删除</a>--%>
					<c:if test="${not empty statusFlag && statusFlag == 2}">
						<a href="${ctx}/crm/employeepayrecord/info?id=${employeePayRecord.id}">查看</a>
					</c:if>
					<c:if test="${not empty statusFlag && statusFlag == 3}">
						<a href="${ctx}/crm/employeepayrecord/info?id=${employeePayRecord.id}">查看</a>
					</c:if>
				</shiro:hasPermission>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
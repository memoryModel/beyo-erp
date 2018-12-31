<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>签约待审批列表</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
            $(document).find("a[name='entryForm']").each(function () {
                var entryId = $(this).attr("entryId");
                $(this).click(function () {
                    top.$.jBox("iframe:/crm/entry/info?id="+entryId,{
                        title:"员工信息",
                        width:976,
                        height:680,
                        buttons:{}
                    });
                });
            });
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
		<li class="active"><a href="${ctx}/crm/entryApprove/list/">签约待审批列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="entry" action="${ctx}/crm/entryApprove/list" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>员工姓名：</label>
				<form:input path="employee.name" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li>
				<label>性别：</label>
				<form:select path="employee.sex"  class="input-large">
					<form:option value="" label="------请选择------"/>
					<form:options items="${erp:sexStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>联系方式：</label>
				<form:input path="employee.phone" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>工种：</label>
				<form:select path="employee.profession" class="input-medium">
					<form:option value="" label="------请选择------"/>
					<form:options items="${erp:getCommonsTypeList(21)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>来源：</label>
				<sys:treeselect id="customerResource" name="customerResource.id" value="${entry.customerResource.id}"
								labelName="customerResource.customerName" labelValue="${entry.customerResource.customerName}"
								title="来源名称" url="/erp/customerResource/treeData" allowClear="true"/>
			</li>
			<%--<li><label>薪资结构：</label>
				<form:select path="basePayStatus" class="input-medium">
					<form:option value="" label="------请选择------"/>
					<form:options items="${erp:basePayStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>--%>
			<%--<li><label>状态：</label>
				<select name="entryStatus" class="input-medium">
					<option value="-1">------请选择------</option>
					<c:forEach items="${entryStatusList}" var="entryStatusMap">
						<option value="${entryStatusMap.value}" <c:if test="${entryStatus == entryStatusMap.value }">selected</c:if>>${entryStatusMap.name}</option>
					</c:forEach>
				</select>
			</li>--%>
			<li><label>创建时间：</label>
				<input name="startTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${interview.startTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>至
				<input name="endTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${interview.endTime}" pattern="yyyy-MM-dd"/>"
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
				<th>员工姓名</th>
				<th>性别</th>
				<th>手机号码</th>
				<th>工种</th>
				<th>来源</th>
				<th>签约周期</th>
				<th>签约操作人</th>
				<th>提交审批时间</th>
				<%--<th>工资结算方式</th>--%>
				<%--<th>状态</th>--%>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="entry">
			<tr>
				<td>
					<a href="javascript:;" name="entryForm" entryId="${entry.id}">${entry.employee.name}</a>
				</td>
				<td>
						${erp:sexStatusName(entry.employee.sex)}
				</td>
				<td>
						${entry.employee.phone}
				</td>
				<td>
					<c:forEach items="${entry.employee.getProfessionList()}" var="occId" varStatus="length">
						<c:if test="${length.index!=0}">
							,
						</c:if>
						${erp:getCommonsTypeName(occId)}
					</c:forEach>
				</td>
				<td>
						${entry.employee.customerResource.customerName}
				</td>
				<%--<td>
						${not empty entry.serviceLevel.name ? entry.serviceLevel.name:'未定'}
				</td>--%>
				<td>
						<fmt:formatDate value="${entry.takeTime}" pattern="yyyy-MM-dd"/>至
						<fmt:formatDate value="${entry.deadlineTime}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
						${entry.user.name}
				</td>
				<td>
						<fmt:formatDate value="${entry.approveTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<%--<td>
						${erp:settleStatusName(entry.settleStatus)}
				</td>
				<td>
						${erp:entryStatusName(entry.entryStatus)}
				</td>--%>
				<td>
						<%--<shiro:hasPermission name="crm:entryApprove:getEmployeeInfo"><a href="javascript:;" name="entryForm" entryId="${entry.id}">查看</a></shiro:hasPermission>
						<shiro:hasPermission name="crm:entryApprove:save"><a href="${ctx}/crm/entryApprove/save?id=${entry.id}" onclick="return confirmx('确定签约？', this.href)">签约</a></shiro:hasPermission>
						<shiro:hasPermission name="crm:entryApprove:delete"><a href="${ctx}/crm/entryApprove/delete?id=${entry.id}" onclick="return confirmx('确认要退回申请吗？', this.href)">退回</a></shiro:hasPermission>--%>
						<shiro:hasPermission name="crm:entryApprove:form"><a href="${ctx}/crm/entryApprove/form?id=${entry.id}">审批</a></shiro:hasPermission>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
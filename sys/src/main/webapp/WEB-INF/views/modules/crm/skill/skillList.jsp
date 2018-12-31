<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>技能项管理</title>
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
		<li class="active"><a href="${ctx}/crm/skill/list">技能项列表</a></li>
		<shiro:hasPermission name="crm:skill:form"><li><a href="${ctx}/crm/skill/form">技能项添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="skill" action="${ctx}/crm/skill/list" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>技能项名称：</label>
				<form:input path="skillName" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>计价单位：</label>
				<form:select path="unit" class="input-medium">
					<form:option value="" label="------请选择------"/>
					<form:options items="${erp:unitStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>

			<li><label>类型：</label>
				<form:select path="category" class="input-medium">
					<form:option value="" label="------请选择------"/>
					<form:options items="${erp:skillCatageryList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>

			<li><label>创建时间：</label>
				<input name="startTime" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   value="<fmt:formatDate value="${skill.startTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>-
				<input name="endTime" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   value="<fmt:formatDate value="${skill.endTime}" pattern="yyyy-MM-dd"/>"
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
				<th>技能项名称</th>
				<th>计价单位</th>
				<th>类型</th>
				<th>服务人员结算单价</th>
				<th>状态</th>
				<th>创建时间</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="crmSkill">
			<tr>
				<td>
					${crmSkill.skillName}
				</td>
				<td>
						${erp:unitStatusName(crmSkill.unit)}

				</td>
				<td>
						${erp:skillCatageryName(crmSkill.category)}
				</td>
				<td>
						${crmSkill.settlementTotalPrice}
				</td>
				<td>
						${erp:commonsStatusName(crmSkill.status)}
				</td>
				<td>
					<fmt:formatDate value="${crmSkill.createTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
					<shiro:hasPermission name="crm:skill:form"><a href="${ctx}/crm/skill/form?id=${crmSkill.id}">修改</a></shiro:hasPermission>
					<shiro:hasPermission name="crm:skill:delete"><a href="${ctx}/crm/skill/delete?id=${crmSkill.id}" onclick="return confirmx('确认要删除该技能项吗？', this.href)">删除</a></shiro:hasPermission>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
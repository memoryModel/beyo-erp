<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>员工升降级审批管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
            $(document).find("a[name='viewInfo']").each(function () {
                var rid = $(this).attr("id");
                $(this).click(function () {
                    top.$.jBox("iframe:/crm/employeeLevelApprove/view?id="+rid,{
                        title:"查看审批信息",
                        width:976,
                        height:570,
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
		<li class="active"><a href="${ctx}/crm/employeeGradeApprove/upgradeApproveList">升级待审批列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="employeeGrade" action="${ctx}/crm/employeeGradeApprove/upgradeApproveList" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li>
				<label>来源：</label>
				<sys:treeselect id="customerResource" name="customerResource.id" value="${employeeGrade.customerResource.id}"
								labelName="customerResource.customerName" labelValue="${employeeGrade.customerResource.customerName}"
								title="来源名称" url="/erp/customerResource/treeData" allowClear="true"/>
			</li>
			<li>
				<label>性别：</label>
				<form:select path="employee.sex"  class="input-large">
					<form:option value="" label="------请选择------"/>
					<form:options items="${erp:sexStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li>
				<label>工种：</label>
				<form:select path="employee.profession"  class="input-large">
					<form:option value="" label="------请选择------"/>
					<form:options items="${erp:getCommonsTypeList(21)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
				</form:select>
			</li>
			<li>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;升级技能项：
				<form:select path="skill.id"  class="input-medium" id="skillTypeId">
					<form:option value="" label="------请选择------"/>
					<form:options items="${crmSkillList}" itemLabel="skillName" itemValue="id" htmlEscape="false" />
				</form:select>
			</li>
			<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;提交审批时间：
				<input name="submitApproveStartTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${employeeGrade.submitApproveStartTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>至
				<input name="submitApproveEndTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${employeeGrade.submitApproveEndTime}" pattern="yyyy-MM-dd"/>"
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
				<th>员工编号</th>
				<th>员工姓名</th>
				<th>性别</th>
				<th>联系电话</th>
				<th>工种</th>
				<th>升级技能项</th>
				<th>当前级别</th>
				<th>升级后级别</th>
				<th>升级操作人</th>
				<th>提交审批时间</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="employeeGrade">
			<tr>
				<td>
					${employeeGrade.employee.code}
				</td>
				<td>
					${employeeGrade.employee.name}
				</td>
				<td>
					${erp:sexStatusName(employeeGrade.employee.sex)}
				</td>
				<td>
						${employeeGrade.employee.phone}
				</td>
				<td>
					<c:forEach items="${employeeGrade.employee.getProfessionList()}" var="occId" varStatus="length">
						<c:if test="${length.index!=0}">
							,
						</c:if>
						${erp:getCommonsTypeName(occId)}
					</c:forEach>
				</td>
				<td>
						${employeeGrade.skill.skillName}
				</td>
				<td>
						${employeeGrade.beforeLevelName}
				</td>
				<td>
						${employeeGrade.upgradeLevelName}
				</td>
				<td>
						${employeeGrade.gradePersonName}
				</td>
				<td>
					<fmt:formatDate value="${employeeGrade.submitApproveTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
					<shiro:hasPermission name="crm:employeeGradeApprove:view"><a href="${ctx}/crm/employeeGradeApprove/upgradeForm?id=${employeeGrade.id}">审批</a>
					</shiro:hasPermission>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
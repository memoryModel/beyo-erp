
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>


<html>
<head>
	<title>单表管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
            $("#searchForm").attr('action',"${ctx}/erp/packageDeposit/list");
			$("#searchForm").submit();
        	return false;
        }
        function getPackagesInfo(packages){
            $.jBox.info("物品清单:"+packages);

		}
        function submitForm(){
            $("#searchForm").attr('action',"${ctx}/erp/packageDeposit/list");
            $("#searchForm").submit();
        }
        function exportExcel(){
            $("#searchForm").attr('action',"${ctx}/erp/packageDeposit/exportList");
            $("#searchForm").submit();
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/erp/packageDeposit/list">寄取管理</a></li>
		<shiro:hasPermission name="erp:packageDeposit:form"><li><a href="${ctx}/erp/packageDeposit/form">新增寄件</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="packageDeposit" action="${ctx}/erp/packageDeposit/list" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>行李编号：</label>
				<form:input path="packageCode" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>所属人类型：</label>
				<form:select path="type" class="input-large ">
					<form:option value="">请选择</form:option>
					<form:options items="${erp:liveTypeList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>创建时间：</label>
				<input name="startTime" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   value="<fmt:formatDate value="${packageDeposit.startTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>-
				<input name="endTime" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   value="<fmt:formatDate value="${packageDeposit.endTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			</li>
			<li><label>状态：</label>
				<form:select path="packageDepositStatus" class="input-large ">
					<form:option value="">请选择</form:option>
					<form:options items="${erp:depositStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="button" value="查询" onclick="submitForm()"/>
				<input type="button" class="btn btn-primary" value="导出" onclick="exportExcel()">
			</li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>行李编号</th>
				<th>所属人类型</th>
				<th>所属人</th>
				<th>联系方式</th>
				<th>身份证号</th>
				<th>状态</th>
				<th>创建时间</th>
			    <th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="packageDeposit">
			<tr createUser="${packageDeposit.createUser}" id="${packageDeposit.id}">
				<td>
					${packageDeposit.packageCode}
				</td>
				<td>
						${erp:liveTypeName(packageDeposit.type)}
				</td>
				<td>
						${packageDeposit.erpStudentEnroll.id != null ? packageDeposit.erpStudentEnroll.name : packageDeposit.employee.name}
				</td>
				<td>
						${packageDeposit.erpStudentEnroll.id != null ? packageDeposit.erpStudentEnroll.phone : packageDeposit.employee.phone}
				</td>
				<td>
						${packageDeposit.erpStudentEnroll.id != null ? packageDeposit.erpStudentEnroll.stuNumber : packageDeposit.employee.idcard}
			    </td>
				<td>
						${erp:depositStatusName(packageDeposit.status)}
				</td>
				<td>
					<fmt:formatDate value="${packageDeposit.createTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>

				<td>
					<a onclick="getPackagesInfo('${packageDeposit.packages}')" href="javascript:; ">查看物品清单</a>
					<c:if test="${packageDeposit.status == 0}">
						<shiro:hasPermission name="erp:packageDeposit:getPackages"><a href="${ctx}/erp/packageDeposit/getPackages?id=${packageDeposit.id}" onclick="return confirmx('确认要取件吗？', this.href)">取件</a></shiro:hasPermission>
					</c:if>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
<script src="${ctxStatic}/officeNames/officeNames.js" type="text/javascript"></script>
</body>
</html>


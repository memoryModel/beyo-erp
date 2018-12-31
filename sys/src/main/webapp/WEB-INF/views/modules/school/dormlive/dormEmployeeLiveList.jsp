<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>入住管理管理</title>
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
	<li class="active"><a href="${ctx}/erp/dormEmployeeLive/list">待入住员工</a></li>
	<li ><a href="${ctx}/erp/dormStudentLive/list">待入住学员</a></li>
	<li><a href="${ctx}/erp/dormLiveHistory/list">入住申请记录</a></li>
</ul><br/>
<form:form id="searchForm" modelAttribute="dormEmployeeLive" action="${ctx}/erp/dormEmployeeLive/list" method="post" class="breadcrumb form-search">
	<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	<ul class="ul-form">
		<li><label>员工编号：</label>
			<form:input path="erpEmployee.code" htmlEscape="false" maxlength="20" class="input-medium"/>
		</li>
		<li><label>员工姓名：</label>
			<form:input path="erpEmployee.name" htmlEscape="false" maxlength="20" class="input-medium"/>
		</li>
		<li><label>创建时间：</label>
			<input name="startTime" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
				   value="<fmt:formatDate value="${dormEmployeeLive.startTime}" pattern="yyyy-MM-dd"/>"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>-
			<input name="endTime" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
				   value="<fmt:formatDate value="${dormEmployeeLive.endTime}" pattern="yyyy-MM-dd"/>"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
		</li>
		</li>
		<li><label>状态：</label>
			<form:select path="status" class="input-large ">
				<form:option value="">请选择</form:option>
				<form:options items="${erp:liveStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
			</form:select>
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
		<th>籍贯</th>
		<th>专业</th>
		<th>联系方式</th>
		<th>员工管理老师</th>
		<th>状态</th>
		<th>创建时间</th>
		<th>操作</th>
	</tr>
	</thead>
	<tbody>
	<c:forEach items="${page.list}" var="dormEmployeeLive">
		<tr createUser="${dormEmployeeLive.createUser}" id="${dormEmployeeLive.id}">
			<td>
					${dormEmployeeLive.erpEmployee.code}
			</td>
			<td>
					${dormEmployeeLive.erpEmployee.name}
			</td>
			<td>
					${dormEmployeeLive.erpEmployee.originalArea.name}
			</td>
			<td>
					<c:forEach items="${dormEmployeeLive.erpEmployee.professionList}" var="profession" varStatus="length">

						<c:if test="${length.index != 0}">
							,
						</c:if>
						${erp:getCommonsTypeName(profession)}
					</c:forEach>
			</td>
			<td>
					${dormEmployeeLive.erpEmployee.phone}
			</td>
			<td>
					${dormEmployeeLive.handleName.name}
			</td>
			<td>
					${erp:liveStatusName(dormEmployeeLive.status)}
			</td>
			<td>
				<fmt:formatDate value="${dormEmployeeLive.createTime}" pattern="yyyy-MM-dd HH:mm"/><%--创建时间--%>
			</td>
			<td>
				<shiro:hasPermission name="erp:dormRoomBed:handleEmployeeLive"><a class="btn btn-primary" href="${ctx}/erp/dormRoomBed/handleEmployeeLive?dormEmployeeLiveId=${dormEmployeeLive.id}">办理入住</a></shiro:hasPermission>
			</td>

		</tr>
	</c:forEach>
	</tbody>
</table>
<div class="pagination">${page}</div>
<script src="${ctxStatic}/officeNames/officeNames.js" type="text/javascript"></script>
</body>
</html>
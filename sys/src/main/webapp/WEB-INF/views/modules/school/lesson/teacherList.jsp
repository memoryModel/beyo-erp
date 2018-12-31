<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用户管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {

		});
		function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			$("#searchForm").attr("action","${ctx}/school/lesson/findTeacher");
			$("#searchForm").submit();
	    	return false;
	    }

        function selectTeacher(userId,userName,userLoginName,companyName,officeName,userPhone,userMobile){
            console.log("#btnSelect"+userId+"--"+userName+"--"+userLoginName+"--"+companyName+"--"+officeName+"--"+userPhone+"--"+userMobile);
            var chked = $("#checkbox"+userId).attr("checked");
            parent.window.frames["mainFrame"].selectTeacherCallback(userId,userName,userLoginName,companyName,officeName,userPhone,userMobile,chked);
        }
	</script>
</head>
<body>

	<form:form id="searchForm" modelAttribute="user" action="${ctx}/school/lesson/findTeacher" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<%--<sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>--%>
		<%--<ul class="ul-form">
			<li><label>归属公司：</label><sys:treeselect id="company" name="company.id" value="${user.company.id}" labelName="company.name" labelValue="${user.company.name}" 
				title="公司" url="/sys/office/treeData?type=1" cssClass="input-small" allowClear="true"/></li>
			<li><label>登录名：</label><form:input path="loginName" htmlEscape="false" maxlength="50" class="input-medium"/></li>
			<li class="clearfix"></li>
			<li><label>归属部门：</label><sys:treeselect id="office" name="office.id" value="${user.office.id}" labelName="office.name" labelValue="${user.office.name}" 
				title="部门" url="/sys/office/treeData?type=2" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/></li>
			<li><label>姓&nbsp;&nbsp;&nbsp;名：</label><form:input path="name" htmlEscape="false" maxlength="50" class="input-medium"/></li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
				&lt;%&ndash;<input id="btnExport" class="btn btn-primary" type="button" value="导出"/>
				<input id="btnImport" class="btn btn-primary" type="button" value="导入"/>&ndash;%&gt;</li>
			<li class="clearfix"></li>
		</ul>--%>
	</form:form>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>选择</th>
				<th>姓名</th>
				<th>登录名</th>
				<th>归属公司</th>
				<th>归属部门</th>
				<th>电话</th>
				<th>手机</th>
				<%--<th>角色</th> --%>
				<%--<shiro:hasPermission name="sys:user:edit">
					<th>操作</th>
				</shiro:hasPermission></tr></thead>--%>
		<tbody>
		<c:forEach items="${page.list}" var="user">
			<tr>
				<td>
					<input type="checkbox" id="checkbox${user.id}" onclick="selectTeacher(
							'${user.id}','${user.name}',
							'${user.loginName}','${user.company.name}',
							'${user.office.name}','${user.phone}','${user.mobile}')"/>
				</td>
				<td>${user.name}</td>
				<td><%--<a href="${ctx}/sys/user/form?id=${user.id}">${user.loginName}</a>--%>
						${user.loginName}
				</td>
				<td>${user.company.name}</td>
				<td>${user.office.name}</td>
				<td>${user.phone}</td>
				<td>${user.mobile}</td><%--
				<td>${user.roleNames}</td> --%>
				<%--<shiro:hasPermission name="sys:user:edit"><td>

				</td></shiro:hasPermission>--%>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
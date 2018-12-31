<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用户管理</title>
	<meta name="decorator" content="default"/>
		<script type="text/javascript">
		function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			$("#searchForm").attr("action","${ctx}/sys/user/list");
			$("#searchForm").submit();
	    	return false;
	    }

        function selectUser(userId,name){
            console.log("#btnSelect"+userId+name);
            top.$.jBox.confirm('确认要选择添加该员工吗？','系统提示',function(v,h,f) {
                if (v == 'ok') {
                    parent.window.frames["mainFrame"].selectUserCallback(userId,name);
                    top.$.jBox.close(true);
                }
            },{buttonsFocus:1, closed:function(){
                if (typeof closed == 'function') {
                    closed();
                }
            }});
        }
		</script>
</head>
<body>
	<form:form id="searchForm" modelAttribute="user" action="${ctx}/erp/employee/selectUser" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>员工姓名：</label>
				<form:input path="name" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>

			<li><label>手机号码：</label>
				<form:input path="mobile" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr><th class="sort-column name">员工姓名</th><th>手机号码</th><th>部门</th><th>操作</th></thead>
		<tbody>
		<c:forEach items="${page.list}" var="user">
			<tr>
				<td>${user.name}</td>
				<td>${user.mobile}</td>
				<td>${user.office.name}</td>
				<td>
					<shiro:hasPermission name="erp:employee:list"><a id="btnSelect" class="btn btn-primary" onclick="selectUser('${user.id}'
							,'${user.name}')" href="javascript:; ">选择员工</a></shiro:hasPermission>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
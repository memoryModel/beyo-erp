<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
<html>
<head>
	<title>学员报名管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>

	<c:if test="${tagFlag != 0}">
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/erp/studentApply/selectErpEmployee">员工列表</a></li>
	</ul>
	</c:if>

<br>
<form:form id="searchForm" modelAttribute="employee" action="${ctx}/erp/studentApply/selectErpEmployee" method="post" class="breadcrumb form-search">
	<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	<input id="tagFlag" name="tagFlag" type="hidden" value="${tagFlag}"/>
	<ul class="ul-form">
		<li><label>员工姓名：</label>
			<form:input path="name" htmlEscape="false" maxlength="20" class="input-medium"/>
		</li>
		<li><label>性别：</label>
			<form:select path="sex" class="input-large ">
				<form:option value="" label="------请选择------"/>
				<form:options items="${erp:sexStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
			</form:select>
		</li>
		<li><label>手机号码：</label>
			<form:input path="phone" htmlEscape="false" maxlength="20" class="input-medium"/>
		</li>
		<li><label>专业：</label>
			<form:select path="profession" class="input-medium">
				<form:option value="" label="------请选择------"/>
				<form:options items="${erp:getCommonsTypeList(21)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
			</form:select>
		</li>
		<li>
			<label>来源：</label>
			<sys:treeselect id="customerResource" name="customerResource.id" value="${employee.customerResource.id}"
							labelName="customerResource.customerName" labelValue="${employee.customerResource.customerName}"
							title="来源名称" url="/erp/customerResource/treeData" cssClass="required" />
		</li>
		<li><label>签约状态：</label>
			<form:select path="signStatus" class="input-large ">
				<form:option value="" label="------请选择------"/>
				<form:options items="${erp:contractSignStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
			</form:select>
		</li>
		<li><label>创建时间：</label>
			<input name="startTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
				   value="<fmt:formatDate value="${employee.startTime}" pattern="yyyy-MM-dd"/>"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>至
			<input name="endTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
				   value="<fmt:formatDate value="${employee.endTime}" pattern="yyyy-MM-dd"/>"
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
		<th>姓名</th>
		<th>性别</th>
		<th>手机号码</th>
		<th>专业</th>
		<th>来源</th>
		<th>签约状态</th>
		<th>添加人</th>
		<th>添加时间</th>
		<th>操作</th>
	</tr>
	</thead>
	<tbody>
	<c:forEach items="${page.list}" var="employee">
		<tr>
			<td>
					${employee.name}
			</td>
			<td>
					${erp:sexStatusName(employee.sex)}
			</td>
			<td>
					${employee.phone}
			</td>
			<td>
					<c:forEach items="${employee.getProfessionList()}" var="occId" varStatus="length">
						<c:if test="${length.index!=0}">
							,
						</c:if>
						${erp:getCommonsTypeName(occId)}
					</c:forEach>
			</td>
			<td>
					${employee.customerResource.customerName}
			</td>
			<td>
					${erp:commonsStatusName(employee.status)}
			</td>
			<td>
					${employee.user.name}
			</td>
			<td>
				<fmt:formatDate value="${employee.createTime}" pattern="yyyy-MM-dd"/>
			</td>
			<td>
				<a id="btnSelect" class="btn btn-primary" onclick="StudentEmployee('${employee.id}')"
				   href="javascript:; ">添加生源</a>
			</td>
		</tr>
	</c:forEach>
	</tbody>
</table>
<div class="pagination">${page}</div>
<script type="text/javascript">
    function page(n,s){
        $("#pageNo").val(n);
        $("#pageSize").val(s);
        $("#searchForm").submit();
        return false;
    }

    function StudentEmployee(employeeId){

        top.$.jBox.confirm('确认要选择添加员工吗？','系统提示',function(v,h,f) {

            if (v == 'ok') {
                parent.window.frames["mainFrame"].selectErpEmployeeCallback(employeeId);
                top.$.jBox.close(true);
            }
        },{buttonsFocus:1, closed:function(){
            if (typeof closed == 'function') {
                closed();
            }
        }});
    }
</script>
</body>
</html>
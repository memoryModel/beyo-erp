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
			$("#searchForm").submit();
        	return false;
        }
        function selectEmployee(employeeId,name,code,phone,profession){
            console.log("#btnSelect"+employeeId,name,code,phone,profession);
            top.$.jBox.confirm('确认要选择添加该员工吗？','系统提示',function(v,h,f) {
                if (v == 'ok') {
                    parent.window.frames["mainFrame"].selectEmployeeCallback(employeeId,name,code,phone,profession);
                    top.$.jBox.close(true);
                }
            },{buttonsFocus:1, closed:function(){
                if (typeof closed == 'function') {
                    closed();
                }
            }});
            //close
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/crm/employeeLeave/selectEmployee/">单表列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="employee" action="${ctx}/crm/employeeLeave/selectEmployee" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>员工姓名：</label>
				<form:input path="name" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>员工工号：</label>
				<form:input path="code" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>

			<li><label>创建时间：</label>
				<input name="createTimeStart" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>-
				<input name="createTimeEnd" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			</li>
			<li><label>员工状态：</label>
				<form:select path="signStatus" class="input-medium">
					<form:option value="" label="------请选择------"/>
					<form:options items="${fns:getDictList('emp_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
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
				<th>员工姓名</th>
				<th>员工性别</th>
				<th>工号</th>
				<th>工种</th>
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
					${employee.code}
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
					<a id="btnSelect" class="btn btn-primary" onclick="selectEmployee('${employee.id}','${employee.name}','${employee.code}','${employee.phone}','${erp:getCommonsTypeName(occId)}')" href="javascript:; ">添加员工</a>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>考核权重管理</title>
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
        function selectCustomer(customerId,name,phone,customerName){
            console.log("#btnSelect"+customerId,name,phone,customerName);
            top.$.jBox.confirm('确认要选择添加该客户吗？','系统提示',function(v,h,f) {
                if (v == 'ok') {
                    parent.window.frames["mainFrame"].selectCustomerCallback(customerId,name,phone,customerName);
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
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/crm/sale/selectCustomer">客户管理列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="customer" action="${ctx}/crm/sale/selectCustomer" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>客户姓名：</label>
				<form:input path="name" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>

			<li><label>手机号码：</label>
				<form:input path="phone" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>成单状态：</label>
				<form:select path="status" class="input-medium">
					<form:option value="" label="------请选择------"/>
					<form:options items="${erp:customerSaleStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>客户类型：</label>
				<form:select path="type" class="input-medium">
					<form:option value="" label="------请选择------"/>
					<form:options items="${erp:customerStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>创建时间：</label>
				<input name="startTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${customer.startTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>至
				<input name="endTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${customer.endTime}" pattern="yyyy-MM-dd"/>"
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
			<th>客户姓名</th>
			<th>手机号码</th>
			<th>客户类型</th>
			<th>成单状态</th>
			<th>创建人</th>
			<th>发布时间</th>
			<th>操作</th>
			<shiro:hasPermission name="crm:customer:edit"><th>操作</th></shiro:hasPermission>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="customer">
			<tr>
				<td><a href="${ctx}/crm/customer/form?id=${customer.id}">
						${customer.name}
				</a></td>
				<td>
						${customer.phone}
				</td>
				<td>
						${erp:customerStatusName(customer.type)}
				</td>
				<td>
						${erp:customerSaleStatusName(customer.status)}
				</td>
				<td>
						${customer.createUser}
				</td>
				<td>
					<fmt:formatDate value="${customer.createTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
			    <td>
					<a id="btnSelect" class="btn btn-primary" onclick="selectCustomer('${customer.id}','${customer.name}','${customer.phone}','${customer.customerResource.customerName}')" href="javascript:; ">添加客户</a>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
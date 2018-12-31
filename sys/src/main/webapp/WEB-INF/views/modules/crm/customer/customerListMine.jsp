<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>客户管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
            $(document).find("a[name='customerView']").each(function () {
                var customerId = $(this).attr("customerId");
                $(this).click(function () {
                    top.$.jBox("iframe:/crm/customer/info?id="+customerId+"&&tagFlag="+1,{
                        title:"客户信息 ",
                        width:1100,
                        height:768,
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
		<li class="active"><a href="${ctx}/crm/customer/listMine">客户管理列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="customer" action="${ctx}/crm/customer/listMine" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>客户姓名：</label>
				<form:input path="names" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>手机号码：</label>
				<form:input path="phone" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>性别：</label>
				<form:select path="sex" class="input-medium">
					<form:option value="" label="------请选择------"/>
					<form:options items="${erp:sexStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>成单状态：</label>
				<form:select path="status" class="input-medium">
					<form:option value="" label="------请选择------"/>
					<form:options items="${erp:changeStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
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
				<th>性别</th>
				<th>手机号码</th>
				<th>客户类型</th>
				<th>成单状态</th>
				<th>发布时间</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="customer">
			<tr>
				<td>
					<a name="customerView" customerId="${customer.id}" href="javascript:;" >${customer.name}</a>
				</td>
				<td>
						${erp:sexStatusName(customer.sex)}
				</td>
				<td>
						${customer.phone}
				</td>
				<td>
						${erp:customerStatusName(customer.type)}
				</td>
				<td>
						${erp:changeStatusName(customer.status)}
				</td>
				<td>
					<fmt:formatDate value="${customer.createTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
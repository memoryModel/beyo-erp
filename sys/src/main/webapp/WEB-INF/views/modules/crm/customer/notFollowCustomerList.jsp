<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>待跟进客户列表</title>
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

        function selectDelegatesCallback(){
            window.location.reload(true);
        }

	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/crm/customer/mineClient?flag=1">待跟进客户</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="customer" action="${ctx}/crm/customer/mineClient?flag=1" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>客户姓名：</label>
				<form:input path="name" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>

			<li><label>手机号码：</label>
				<form:input path="phone" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>客户类别：</label>
				<form:select path="type" class="input-large " style="width:180px;">
					<form:option value="">请选择</form:option>
					<form:options items="${erp:customerTypeList()}"  itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li>
				<label>性别：</label>
				<form:select path="sex"  class="input-large">
					<form:option value="" label="------请选择------"/>
					<form:options items="${erp:sexStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>客户来源：</label>
				<sys:treeselect id="customerResource" name="customerResource.id" value="${customer.customerResource.id}"
								labelName="customerResource.customerName" labelValue="${customer.customerResource.customerName}"
								title="来源名称" url="/erp/customerResource/treeData" allowClear="true"/>
			</li>
			<li><label>添加时间：</label>
				<input name="startTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${customer.startTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/> -
				<input name="endTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${customer.endTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			</li>
			<li><label>委派时间：</label>
				<input name="delegateStartTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${customer.delegateStartTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/> -
				<input name="delegateEndTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${customer.delegateEndTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			</li>
			<li>&nbsp;&nbsp;&nbsp;我获取的客户：
				<form:select path="meClientFlagValue"  class="input-large">
					<form:option value="" label="------请选择------"/>
					<form:options items="${erp:findVipFlagList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<%--todo:批量导出--%>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>客户编号</th>
				<th>客户姓名</th>
				<th>性别</th>
				<th>手机号码</th>
				<th>客户类别</th>
				<th>客户来源</th>
				<th>是否为我获取的客户</th>
				<th>委派时间</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="customer">
			<tr>
				<td>
						${customer.code}
				</td>
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
						${erp:customerTypeName(customer.type)}
				</td>
				<td>
						${customer.customerResource.customerName}
				</td>
				<td>
						${customer.meClientFlagName}
				</td>
				<td>
						<fmt:formatDate value="${customer.delegateTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>

				<td>
					<shiro:hasPermission name="crm:customer:form">
						<a href="${ctx}/crm/followRecord/form?customerId=${customer.id}">添加跟进记录</a><br/>
						<a href="${ctx}/crm/customer/editClientInfo?id=${customer.id}">编辑客户信息</a><br/>
						<a name="customerForm" customerId="${customer.id}" href="javascript:;">放弃跟进</a>
					</shiro:hasPermission>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	<script type="text/javascript">
        $(document).find("a[name='customerView']").each(function () {
            var customerId = $(this).attr("customerId");
            $(this).click(function () {
                top.$.jBox("iframe:/crm/customer/info?id="+customerId+"&&tagFlag="+1,{
                    title:"客户信息 ",
                    width:1300,
                    height:768,
                    buttons:{}
                });
            });
        });

        $(document).find("a[name='customerForm']").each(function(){
            var customerId=$(this).attr("customerId");
            $(this).click(function(){
                top.$.jBox("iframe:/crm/customer/renounceFollow?id="+customerId+"&&flag="+1, {
                    title:"放弃客户跟进",
                    width:600,
                    height:251,
                    buttons:{}
                });
			});
		});
	</script>
</body>
</html>
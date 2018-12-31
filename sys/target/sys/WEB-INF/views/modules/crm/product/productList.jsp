<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>商品管理</title>
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
		<li class="active"><a href="${ctx}/crm/product/list">商品管理列表</a></li>
		<shiro:hasPermission name="crm:product:form"><li><a href="${ctx}/crm/product/form">商品添加</a></li></shiro:hasPermission>
		<shiro:hasPermission name="crm:product:group"><li><a href="${ctx}/crm/product/group">商品套餐添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="product" action="${ctx}/crm/product/list" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>商品名称：</label>
				<form:input path="title" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>关联技能项：</label>
				<form:select path="skill.id"  class="input-large " >
					<form:option value="">请选择</form:option>
					<form:options items="${crmSkillList}" itemLabel="skillName" itemValue="id" htmlEscape="false" />
				</form:select>
			</li>

			<li><label>商品状态：</label>
				<form:select path="status"  class="required" id="status" style="width:180px">
					<form:option value="-1">请选择</form:option>
					<form:options items="${erp:productStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false" />
				</form:select>
			</li>
			<li><label>商品类型：</label>
				<form:select path="type" class="input-large" style="width: 180px">
					<form:option value="">请选择</form:option>
					<form:options items="${erp:productTypeList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>创建时间：</label>
				<input name="startTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${product.startTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>至
				<input name="endTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${product.endTime}" pattern="yyyy-MM-dd"/>"
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
				<th>LOGO</th>
				<th>商品名称/编码</th>
				<th>商品类型</th>
				<th>单独售卖</th>
				<th>计价方式</th>
				<th>服务项目</th>
				<th>价格</th>
				<th>总库存</th>
				<th>状态</th>
				<th>计划上架时间</th>
				<th>创建时间</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="product">
			<tr>
				<td>
					<c:if test="${!empty product.url}">
						<a href="${product.url}" target="_blank"><img src='${product.url}&iopcmd=thumbnail&type=4&width=100'/></a>
					</c:if>

				</td>
				<td>
					${product.title}<br>${product.code}
				</td>
				<td>
					${erp:productTypeName(product.type)}
				</td>
				<td>
					${erp:productSaleTypeName(product.saleType)}
				</td>
				<td>
					<c:if test="${product.measureWay==1}">单独</c:if>
					<c:if test="${product.measureWay==2}">打包</c:if>
				</td>
				<td>
					${product.skill.skillName}
				</td>
				<td>
					${product.price}
				</td>
				<td>
					${product.stock}
				</td>

				<td>
					${erp:productStatusName(product.status)}   <!--枚举形式-->
				</td>
				<td>
					<fmt:formatDate value="${product.planTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
					<fmt:formatDate value="${product.createTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>

					<td>
						<c:if test="${product.status == 0}">
							<c:if test="${product.type == 1}">
								<shiro:hasPermission name="crm:product:form"><a href="${ctx}/crm/product/form?id=${product.id}">修改</a></shiro:hasPermission>
									</c:if>
							<c:if test="${product.type == 2}">
								<shiro:hasPermission name="crm:product:group"><a href="${ctx}/crm/product/group?id=${product.id}">修改</a></shiro:hasPermission>
							</c:if>
							<c:if test="${product.saleType == 1}">
								<shiro:hasPermission name="crm:product:form"><a href="${ctx}/crm/product/publish?id=${product.id}" onclick="return confirmx('确认要上架该商品吗？', this.href)">上架</a></shiro:hasPermission>
							</c:if>
							<shiro:hasPermission name="crm:product:delete"><a href="${ctx}/crm/product/delete?id=${product.id}" onclick="return confirmx('确认要删除该商品吗？', this.href)">删除</a></shiro:hasPermission>
						</c:if>
						<c:if test="${product.status == 1 && product.saleType == 1}">
							<shiro:hasPermission name="crm:product:form"><a href="${ctx}/crm/product/cancel?id=${product.id}" onclick="return confirmx('确认要下架该商品吗？', this.href)">下架</a></shiro:hasPermission>
						</c:if>
						<c:if test="${product.status == 2}">
							<c:if test="${product.saleType == 1}">
								<shiro:hasPermission name="crm:product:form"><a href="${ctx}/crm/product/publish?id=${product.id}" onclick="return confirmx('确认要上架该商品吗？', this.href)">上架</a></shiro:hasPermission>
							</c:if>
							<shiro:hasPermission name="crm:product:delete"><a href="${ctx}/crm/product/delete?id=${product.id}" onclick="return confirmx('确认要删除该商品吗？', this.href)">删除</a></shiro:hasPermission>
						</c:if>
						<c:if test="${product.status == 3 && product.saleType == 1}">
							<shiro:hasPermission name="crm:product:form"><a href="${ctx}/crm/product/cancel?id=${product.id}" onclick="return confirmx('确认要下架该商品吗？', this.href)">下架</a></shiro:hasPermission>
						</c:if>
						<c:if test="${product.status == 4}">
							<shiro:hasPermission name="crm:product:form"><a href="${ctx}/crm/product/reset?id=${product.id}" onclick="return confirmx('确认要还原商品到仓库吗？', this.href)">还原</a></shiro:hasPermission>
						</c:if>
					</td>

			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
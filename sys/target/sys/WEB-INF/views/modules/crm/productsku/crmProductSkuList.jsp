<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>商品SKU管理</title>
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
		<li class="active"><a href="${ctx}/crm/productsku/crmProductSku/">商品SKU列表</a></li>
		<shiro:hasPermission name="crm:productsku:crmProductSku:edit"><li><a href="${ctx}/crm/productsku/crmProductSku/form">商品SKU添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="crmProductSku" action="${ctx}/crm/productsku/crmProductSku/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>商品id：</label>
				<form:input path="productId" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>技能id：</label>
				<form:input path="skillId" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>星级id：</label>
				<form:input path="levelId" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>单位：</label>
				<form:input path="unit" htmlEscape="false" maxlength="1" class="input-medium"/>
			</li>
			<li><label>最小售卖数量：</label>
				<form:input path="minStock" htmlEscape="false" maxlength="30" class="input-medium"/>
			</li>
			<li><label>最大售卖数量：</label>
				<form:input path="maxStock" htmlEscape="false" maxlength="30" class="input-medium"/>
			</li>
			<li><label>销售价格：</label>
				<form:input path="sellPrice" htmlEscape="false" class="input-medium"/>
			</li>
			<li><label>渠道结算单价：</label>
				<form:input path="channelPrice" htmlEscape="false" class="input-medium"/>
			</li>
			<li><label>服务人员结算价：</label>
				<form:input path="settlementPrice" htmlEscape="false" class="input-medium"/>
			</li>
			<li><label>库存：</label>
				<form:input path="stock" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>状态：</label>
				<form:input path="status" htmlEscape="false" maxlength="1" class="input-medium"/>
			</li>
			<li><label>创建时间：</label>
				<input name="createTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${crmProductSku.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>商品id</th>
				<th>技能id</th>
				<th>星级id</th>
				<th>单位</th>
				<th>最小售卖数量</th>
				<th>最大售卖数量</th>
				<th>销售价格</th>
				<th>渠道结算单价</th>
				<th>服务人员结算价</th>
				<th>库存</th>
				<th>状态</th>
				<th>创建时间</th>
				<shiro:hasPermission name="crm:productsku:crmProductSku:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="crmProductSku">
			<tr>
				<td><a href="${ctx}/crm/productsku/crmProductSku/form?id=${crmProductSku.id}">
					${crmProductSku.productId}
				</a></td>
				<td>
					${crmProductSku.skillId}
				</td>
				<td>
					${crmProductSku.levelId}
				</td>
				<td>
					${crmProductSku.unit}
				</td>
				<td>
					${crmProductSku.minStock}
				</td>
				<td>
					${crmProductSku.maxStock}
				</td>
				<td>
					${crmProductSku.sellPrice}
				</td>
				<td>
					${crmProductSku.channelPrice}
				</td>
				<td>
					${crmProductSku.settlementPrice}
				</td>
				<td>
					${crmProductSku.stock}
				</td>
				<td>
					${crmProductSku.status}
				</td>
				<td>
					<fmt:formatDate value="${crmProductSku.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="crm:productsku:crmProductSku:edit"><td>
    				<a href="${ctx}/crm/productsku/crmProductSku/form?id=${crmProductSku.id}">修改</a>
					<a href="${ctx}/crm/productsku/crmProductSku/delete?id=${crmProductSku.id}" onclick="return confirmx('确认要删除该商品SKU吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
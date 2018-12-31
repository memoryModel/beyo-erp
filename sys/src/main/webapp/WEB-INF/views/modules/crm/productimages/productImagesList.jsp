<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>商品图片管理</title>
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
		<li class="active"><a href="${ctx}/crm/productImages/">商品图片列表</a></li>
		<shiro:hasPermission name="productimages:productImages:edit"><li><a href="${ctx}/crm/productImages/form">商品图片添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="productImages" action="${ctx}/crm/productImages/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>商品id</th>
				<th>路径</th>
				<th>创建时间</th>
				<th>状态</th>
				<shiro:hasPermission name="productimages:productImages:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="productImages">
			<tr>
				<td><a href="${ctx}/crm/productImages/form?id=${productImages.id}">
					${productImages.productId}
				</a></td>
				<td>
					${productImages.url}
				</td>
				<td>
					<fmt:formatDate value="${productImages.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${productImages.status}
				</td>
				<shiro:hasPermission name="productimages:productImages:edit"><td>
    				<a href="${ctx}/crm/productImages/form?id=${productImages.id}">修改</a>
					<a href="${ctx}/crm/productImages/delete?id=${productImages.id}" onclick="return confirmx('确认要删除该商品图片吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
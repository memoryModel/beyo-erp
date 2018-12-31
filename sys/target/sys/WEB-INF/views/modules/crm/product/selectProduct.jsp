<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>销售线索管理</title>
	<meta name="decorator" content="default"/>

</head>
<body>
	<form:form id="searchForm" modelAttribute="product" action="${ctx}/crm/product/selectProduct" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input type="hidden" name="status" value="${product.status}">
		<input type="hidden" name="saleType" value="${product.saleType}">
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
			<th>计价方式</th>
			<th>服务项目</th>
			<th>价格</th>
			<th>总库存</th>
			<th>状态</th>
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
					<fmt:formatDate value="${product.createTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
					<shiro:hasPermission name="crm:product:productInfo"><input id="addButton${product.id}" type="button" class="btn btn-primary" value="添加" onclick="addSKU('${product.id}')"/></shiro:hasPermission>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>

	<script type="text/javascript">
        $(document).ready(function() {

        });

        function page(n,s){
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").submit();
            return false;
        }

        function addSKU(productId) {
            parent.window.frames["mainFrame"].addProductCallback(productId);

            $("#addButton"+productId).attr("disabled",true);
        }
	</script>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>销售线索管理</title>
	<meta name="decorator" content="default"/>

</head>
<body>
	<form:form id="searchForm" modelAttribute="productSku" action="${ctx}/crm/productsku/selectGroupProduct" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input iname="type" type="hidden" value="${productSku.product.type}"/>
		<input iname="product.status" type="hidden" value="${productSku.product.status}"/>
		<ul class="ul-form">
			<li><label>商品名称：</label>
				<form:input path="product.title" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>SKU编码：</label>
				<form:input path="code" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>关联技能项：</label>
				<form:select path="skill.id"  class="input-large " >
					<form:option value="">请选择</form:option>
					<form:options items="${crmSkillList}" itemLabel="skillName" itemValue="id" htmlEscape="false" />
				</form:select>
			</li>
			<li><label>商品分类：</label>
				<form:select path="categoryId"  class="input-large " >
					<form:option value="">请选择</form:option>
					<form:options items="${productCategoryList}" itemLabel="name" itemValue="id" htmlEscape="false" />
				</form:select>
			</li>
			<li><label>服务级别：</label>
				<form:select path="levelId"  class="input-large " >
					<form:option value="">请选择</form:option>
					<form:options items="${serviceLevelList}" itemLabel="name" itemValue="id" htmlEscape="false" />
				</form:select>
			</li>

			<li><label>时间：</label>
				<input name="startTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${product.startTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>至
				<input name="endTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${product.endTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			</li>
			<li><label>商品状态：</label>
				<form:select path="status"  class="required" id="status" style="width:180px">
					<form:option value="-1">请选择</form:option>
					<form:options items="${erp:productStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false" />
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
				<th>商品名称</th>
				<th>服务项目</th>
				<th>计价方式</th>
				<th>服务等级</th>
				<th>最小售卖</th>
				<th>最大售卖</th>
				<th>销售价格</th>
				<th>渠道结算</th>
				<th>服务人员</th>
				<th>库存</th>
				<th>状态</th>
				<th>创建时间</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="productSku">
			<c:set var="baseUnit"/>
			<c:if test="${productSku.unit == 1}">
				<c:set var="baseUnit" value="天"/>
			</c:if>
			<c:if test="${productSku.unit == 2}">
				<c:set var="baseUnit" value="次"/>
			</c:if>
			<tr>
				<td>
					${productSku.product.title}
				</td>
				<td>
						${productSku.skill.skillName}
				</td>
				<td>
					<c:if test="${productSku.product.measureWay==1}">按单</c:if>
					<c:if test="${productSku.product.measureWay==2}">打包</c:if>
				</td>
				<td>
						${productSku.serviceLevel.name}
				</td>
				<td>
						${productSku.minStock}&nbsp;${baseUnit}
				</td>
				<td>
						${productSku.maxStock}&nbsp;${baseUnit}
				</td>
				<td>
						${productSku.salePrice}&nbsp;元
				</td>
				<td>
						${productSku.channelPrice}&nbsp;元
				</td>
				<td>
						${productSku.servicePrice}&nbsp;元
				</td>
				<td>
						${productSku.stock}&nbsp;${baseUnit}
				</td>
				<td>
					${erp:productStatusName(productSku.product.status)}   <!--枚举形式-->
				</td>
				<td>
					<fmt:formatDate value="${productSku.createTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
					<input id="addButton${productSku.id}" type="button" class="btn btn-primary" value="添加" onclick="addSKU('${productSku.id}','${productSku.productId}','${productSku.code}','${productSku.product.measureWay}','${productSku.product.title}','${productSku.skill.skillName}','${productSku.levelId}','${productSku.serviceLevel.name}','${productSku.unit}','${productSku.minStock}','${productSku.maxStock}','${productSku.salePrice}','${productSku.channelPrice}','${productSku.servicePrice}','${productSku.stock}','${productSku.product.url}')"/>
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

        function addSKU(skuId,productId,code,measureWay,title,skillName,levelId,levelName,unit,minStock,maxStock,salePrice,channelPrice,servicePrice,stock,url) {
            parent.window.frames["mainFrame"].addSKUCallback(skuId,productId,code,measureWay,title,skillName,levelId,levelName,unit,minStock,maxStock,salePrice,channelPrice,servicePrice,stock,url);

            $("#addButton"+skuId).attr("disabled",true);
        }
	</script>
</body>
</html>
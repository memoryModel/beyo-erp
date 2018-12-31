<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>商品管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {


            var selectProductIds = '${selectProductIds}';
            var selectProductIdArray = selectProductIds.split(',');
            for(var i=0;i<selectProductIdArray.length;i++){
                $('a[name="productSelect"][id='+selectProductIdArray[i]+']').text('取消选择')
            }

			$('a[name="productSelect"]').click(function () {
			    var id = $(this).attr('id');
			    var selectFlag = $(this).text();
                parent.window.frames["mainFrame"].productSelectCallback(id,selectFlag);
            	if(selectFlag == '选择'){
            	    $(this).text('取消选择');
				}
				if(selectFlag == '取消选择'){
            	    $(this).text('选择')
				}
			})
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
	<form:form id="searchForm" modelAttribute="product" action="${ctx}/crm/product/saleProductlist" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input type="hidden" name="selectProductIds" value="${selectProductIds}">
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
				<th>商品名称</th>
				<th>商品类型</th>
				<th>商品编码</th>
				<th>服务项目</th>
				<th>价格</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="product">
			<tr>
				<td>
					${product.title}---${product.id}
				</td>
				<td>
					${erp:productTypeName(product.type)}
				</td>
				<td>${product.code}</td>
				<td>
					${product.skill.skillName}
				</td>
				<td>
					${product.price}
				</td>
				<td>
					<a name="productSelect" href="javascript:;" id="${product.id}">选择</a>
				</td>

			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
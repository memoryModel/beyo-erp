<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>上传图片管理</title>
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
		<li class="active"><a href="${ctx}/upload/">上传图片列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="uploadFiles" action="${ctx}/upload/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>名称：</label>
				<form:input path="name" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>创建时间：</label>
				<input name="startTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${uploadFiles.startTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>至
				<input name="endTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${uploadFiles.endTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			</li>
			<li><label>状态：</label>
				<form:select path="status" class="input-large ">
					<form:option value="">请选择</form:option>
					<form:options items="${erp:uploadStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
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
				<th>名称</th>
				<th>长度</th>
				<th>类型</th>
				<th>目录</th>
				<th>创建时间</th>
				<th>状态</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="uploadFiles">
			<tr>
				<td><a href="${ctx}/upload/form?id=${uploadFiles.id}">
					${uploadFiles.name}
				</a></td>
				<td>
					${uploadFiles.size}
				</td>
				<td>
					${uploadFiles.type}
				</td>
				<td>
					${uploadFiles.dir}
				</td>
				<td>
					<fmt:formatDate value="${uploadFiles.createTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
					${erp:uploadStatusName(uploadFiles.status)}
				</td>
				<td>
					<shiro:hasPermission name="upload:form"><a href="${ctx}/upload/form?id=${uploadFiles.id}">修改</a></shiro:hasPermission>
					<shiro:hasPermission name="upload:updateStatus"><a href="${ctx}/upload/updateStatus?id=${uploadFiles.id}" onclick="return confirmx('确认要删除该上传图片吗？', this.href)">删除</a></shiro:hasPermission>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
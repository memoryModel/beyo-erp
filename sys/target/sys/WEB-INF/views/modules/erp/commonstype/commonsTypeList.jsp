<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>基础类型管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {

		    $("#updateCache").click(function () {
				$.get("/erp/commonsType/updateCache",function (data) {
				    console.log(data);
					if (data == "success"){
					    $("#contentTable").before('<div id="messageBox" class="alert alert-success"><button data-dismiss="alert" class="close">×</button>缓存更新成功</div>');
					}else{
                        $("#contentTable").before('<div id="messageBox" class="alert alert-error"><button data-dismiss="alert" class="close">×</button>缓存更新失败</div>');
                    }
                }).error(function() {
                    $("#contentTable").before('<div id="messageBox" class="alert alert-error"><button data-dismiss="alert" class="close">×</button>缓存更新失败</div>');
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
		<li class="active"><a href="${ctx}/erp/commonsType/list">基础类型列表</a></li>
		<shiro:hasPermission name="erp:commonsType:list"><li><a href="${ctx}/erp/commonsType/form">基础类型添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="commonsType" action="${ctx}/erp/commonsType/list" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>名称：</label>
				<form:input path="commonsName" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>创建时间：</label>
				<input name="startTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${commonsType.startTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>至
				<input name="endTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${commonsType.endTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			</li>
			<li><label>分类：</label>
				<form:select path="category" class="input-large ">
					<form:option value="">请选择</form:option>
					<form:options items="${erp:commonsTypeList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="btns"><input id="updateCache" class="btn" type="button" value="更新缓存"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>名称</th>
				<th>描述</th>
				<th>分类</th>
				<%--<th>状态</th>--%>
				<th>创建时间</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="commonsType">
			<tr>
				<td>
					${commonsType.commonsName}
				</td>
				<td>
					${commonsType.description}
				</td>
				<td>
					${erp:commonsTypeName(commonsType.category)}
				</td>
				<%--<td>
					${erp:commonsStatusName(commonsType.status)}
				</td>--%>
				<td>
					<fmt:formatDate value="${commonsType.createTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
					<shiro:hasPermission name="erp:commonsType:form"><a href="${ctx}/erp/commonsType/form?id=${commonsType.id}">修改</a></shiro:hasPermission>
					<shiro:hasPermission name="erp:commonsType:delete"><a href="${ctx}/erp/commonsType/delete?id=${commonsType.id}" onclick="return confirmx('确认要删除该单表吗？', this.href)">删除</a></shiro:hasPermission>
			    </td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
	<title>技能项管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
	<script type="text/javascript">
        $(document).ready(function() {
            var tpl = $("#treeTableTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
            var data = ${fns:toJson(page)}, rootId = "0";

            var hasRoot = false;
            for(var i=0;i<data.length;i++){
                if(data[i].parentId == rootId){
                    hasRoot = true;
                    break;
                }
            }

            if(hasRoot == false){
                rootId = data[0].parentId;
            }


            addRow("#treeTableList", tpl, data, rootId, true);
            $("#treeTable").treeTable({expandLevel : 5});
        });
        function page(n,s){
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").submit();
            return false;
        }
        function addRow(list, tpl, data, pid, root){
            for (var i=0; i<data.length; i++){
                var row = data[i];
                if ((${fns:jsGetVal('row.parentId')}) == pid){
                    $(list).append(Mustache.render(tpl, {
                        dict: {
                            status: getDictLabel(${fns:toJson(fns:getDictList('sys_finaceType_status'))}, row.status)
                        }, pid: (root?0:pid), row: row
                    }));
                    addRow(list, tpl, data, row.id);
                }
            }
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/crm/productCategory/list">商品分类列表</a></li>
		<shiro:hasPermission name="crm:productCategory:form"><li><a href="${ctx}/crm/productCategory/form">商品分类添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="productCategory" action="${ctx}/crm/productCategory/list" method="post" class="breadcrumb form-search">
		<ul class="ul-form">
			<li><label>商品名称：</label>
				<form:input path="name" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>创建时间：</label>
				<input name="startTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${productCategory.startTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>至
				<input name="endTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${productCategory.endTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>商品名称</th>
				<th>排序</th>
				<th>创建时间</th>
				<th>备注</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody id="treeTableList"></tbody>
	</table>
	<script type="text/template" id="treeTableTpl">
		<tr id="{{row.id}}" pId="{{pid}}">
			<td><a href="${ctx}/crm/productCategory/form?id={{row.id}}">{{row.name}}</a></td>
			<td>{{row.sort}}</td>
			<td>{{row.createDateStr}}</td>
			<td>{{row.remark}}</td>
			<td>
				<shiro:hasPermission name="crm:productCategory:form"><a href="${ctx}/crm/productCategory/form?id={{row.id}}">修改</a></shiro:hasPermission>
				<shiro:hasPermission name="crm:productCategory:delete"><a href="${ctx}/crm/productCategory/delete?id={{row.id}}" onclick="return confirmx('要删除子目录吗？', this.href)">删除</a></shiro:hasPermission>
				<shiro:hasPermission name="crm:productCategory:form"><a href="${ctx}/crm/productCategory/form?parentId={{row.id}}">添加下级区域</a></shiro:hasPermission>
			</td>
		</tr>
	</script>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>财务科目设置管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
	<script type="text/javascript">
        $(document).ready(function() {
            var tpl = $("#treeTableTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
            var data = ${fns:toJson(list)}, rootId = "0";

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
        function addRow(list, tpl, data, pid, root){
            for (var i=0; i<data.length; i++){
                var row = data[i];
                if ((${fns:jsGetVal('row.parentId')}) == pid){
                    $(list).append(Mustache.render(tpl, {
                        dict: {
                            status: getDictLabel(${fns:toJson(fns:getDictList('sys_finaceType_status'))}, row.status),
                            paymentType: getDictLabel(${fns:toJson(fns:getDictList('sys_finaceType_paymentType'))}, row.paymentType)
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
	<li class="active"><a href="${ctx}/erp/finaceType/list">财务科目管理列表</a></li>
	<shiro:hasPermission name="erp:finaceType:form"><li><a href="${ctx}/erp/finaceType/form">财务科目管理添加</a></li></shiro:hasPermission>
</ul>
<form:form id="searchForm" modelAttribute="finaceType" action="${ctx}/erp/finaceType/list" method="post" class="breadcrumb form-search">
	<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	<ul class="ul-form">
		<li><label>名称：</label>
			<form:input path="subjectName" htmlEscape="false" maxlength="20" class="input-medium"/>
		</li>
		<li><label>创建时间：</label>
			<input name="startTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
				   value="<fmt:formatDate value="${finaceType.startTime}" pattern="yyyy-MM-dd"/>"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>至
			<input name="endTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
				   value="<fmt:formatDate value="${finaceType.endTime}" pattern="yyyy-MM-dd"/>"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
		</li>
		<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
		<li class="clearfix"></li>
	</ul>
</form:form>
<sys:message content="${message}"/>
<table id="treeTable" class="table table-striped table-bordered table-condensed">
	<thead><tr><th>财务科目管理名称</th><th>科目编码</th><th>备注</th><th>创建时间</th><th>操作</th></tr></thead>
	<tbody id="treeTableList"></tbody>
</table>
<script type="text/template" id="treeTableTpl">
	<tr id="{{row.id}}" pId="{{pid}}">
		<td><a href="${ctx}/erp/finaceType/form?id={{row.id}}">{{row.subjectName}}</a></td>
		<td>{{row.subjectCode}}</td>
		<td>{{row.remarks}}</td>
		<td>{{row.createDateStr}}</td>
		<td>
			<shiro:hasPermission name="erp:finaceType:form"><a href="${ctx}/erp/finaceType/form?id={{row.id}}">修改</a></shiro:hasPermission>.
			<shiro:hasPermission name="erp:finaceType:delete"><a href="${ctx}/erp/finaceType/delete?id={{row.id}}" onclick="return confirmx('要删除子目录吗？', this.href)">删除</a></shiro:hasPermission>
			<shiro:hasPermission name="erp:finaceType:form"><a href="${ctx}/erp/finaceType/form?parentId={{row.id}}">添加下级区域</a></shiro:hasPermission>
		</td>
	</tr>
</script>
</body>
</html>
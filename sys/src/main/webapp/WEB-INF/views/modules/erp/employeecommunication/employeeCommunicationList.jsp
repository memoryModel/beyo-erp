<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>招工沟通管理表管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
            jQueryCheckAll();

		    $('a[name="toAppointCommunicate"]').each(function(){
		        var id = $(this).attr("id");
                $(this).click(function () {
                    top.$.jBox("iframe:/erp/employeeCommunication/toAppointCommunicate?id="+id,{
                        title:"指派沟通人",
                        width:600,
                        height:300,
                        buttons:{},
                        closed:function () {
                            document.location.reload();
                        }
                    });
                });
			});

		    //批量指派沟通人
			$('#batchToAppointCommunicate').click(function () {
				var ids = checkedIds();
				    if(ids == null || ids == ""){
				        return;
                    }
                    top.$.jBox("iframe:/erp/employeeCommunication/batchToAppointCommunicate?ids="+ids,{
                        title:"批量指派沟通人",
                        width:600,
                        height:300,
                        buttons:{},
                        closed:function () {
                            document.location.reload();
                        }
                    });
            })
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }

        function checkedIds() {
            var ids = '';
            var elements = $("[name='checkbox']:checked");
            for (var  i = 0; i<elements.length;i++){
                if(i<elements.length-1){
                    ids = ids + $(elements[i]).val()+",";
                }else{
                    ids = ids + $(elements[i]).val();
                }

            }
            return ids;
        }

        function jQueryCheckAll(){
            var checkAll = $('[name="checkboxs"]');
            var items = $('[name="checkbox"]');
            checkAll.click(function () {
                if ($(this).attr('checked')) {
                    items.each(function () {
                        $(this).attr('checked', true);
                    })
                }else {
                    items.each(function () {
                        $(this).attr('checked', false);
                    })
                }
            });
            items.click(function () {
                checkAll.attr("checked", items.length == $('[name="checkbox"]:checked').length ? true : false);
            });
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/erp/employeeCommunication/list?employeeCommunication.appointStatus=1">待指派招工沟通管理表列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="employee" action="${ctx}/erp/employeeCommunication/list?employeeCommunication.appointStatus=1" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">

			<li><label>员工姓名：</label>
				<form:input path="name" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>手机号码：</label>
				<form:input path="phone" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>性别：</label>
				<form:select path="sex" class="input-large">
					<form:option value="" label="------请选择------"/>
					<form:options items="${erp:sexStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li class="clearfix"></li>
			<li><label>工种：</label>
				<form:select path="profession" class="input-large">
					<form:option value="" label="------请选择------"/>
					<form:options items="${erp:getCommonsTypeList(21)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
				</form:select>
			</li>

			<li>
				<label>来源：</label>
				<sys:treeselect id="customerResource" name="customerResource.id" value="${employee.customerResource.id}"
								labelName="customerResource.customerName" labelValue="${employee.customerResource.customerName}"
								title="来源名称" url="/erp/customerResource/treeData" allowClear="true"/>
			</li>

			<li class="clearfix"></li>
			<li><label>创建时间：</label>
				<input name="startTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${employee.startTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>至
				<input name="endTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${employee.endTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			</li>

			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
				<input id="batchToAppointCommunicate" class="btn btn-primary" type="button" value="批量指派沟通人"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>
					<input type="checkbox" name="checkboxs">
				</th>
				<th>姓名</th>
				<th>性别</th>
				<th>手机号码</th>
				<th>工种</th>
				<th>来源</th>
				<th>指派状态</th>
				<th>信息获取人</th>
				<th>添加人</th>
				<th>添加时间</th>
				<shiro:hasPermission name="employeecommunication:employeeCommunication:edit">
					<th>操作</th>
				</shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="erpEmployee">
			<tr>
				<td>
					<input type="checkbox" name="checkbox" value="${erpEmployee.id}">
				</td>
				<td>
						${erpEmployee.name}
				</td>
				<td>
						${erp:sexStatusName(erpEmployee.sex)}
				</td>
				<td>
						${erpEmployee.phone}
				</td>
				<td>
					<c:forEach items="${erpEmployee.getProfessionList()}" var="occId" varStatus="length">
						<c:if test="${length.index!=0}">
							,
						</c:if>
						${erp:getCommonsTypeName(occId)}
					</c:forEach>
				</td>
				<td>
						${erpEmployee.customerResource.customerName}
				</td>
				<td>
						${erp:appointStatusName(erpEmployee.employeeCommunication.appointStatus)}
				</td>
				<td>
						${erpEmployee.infoCollectId.name}
				</td>
				<td>
						${erpEmployee.creater.name}
				</td>
				<td>
					<fmt:formatDate value="${erpEmployee.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="employeecommunication:employeeCommunication:edit">
					<td>
						<a href="${ctx}/erp/employee/view?id=${erpEmployee.id}">查看</a>
    					<a name="toAppointCommunicate" href="javascript:;" id="${erpEmployee.id}">指派沟通人</a>
					</td>
				</shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
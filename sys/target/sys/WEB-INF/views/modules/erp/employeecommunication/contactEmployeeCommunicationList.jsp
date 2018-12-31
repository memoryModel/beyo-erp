<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>招工沟通管理表管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
            jQueryCheckAll();

            $('a[name="toAddCommunicationRecord"]').each(function(){
                var id = $(this).attr("id");
                $(this).click(function () {
                    top.$.jBox("iframe:/erp/employeeCommunication/toAddCommunicationRecord?id="+id,{
                        title:"添加沟通记录",
                        width:900,
                        height:500,
                        buttons:{},
                        closed:function () {
                            document.location.reload();
                        }
                    });
                });
            });

            $('a[name="toCancel"]').each(function(){
                var id = $(this).attr("id");
                $(this).click(function () {
                    top.$.jBox("iframe:/erp/employeeCommunication/toCancel?id="+id,{
                        title:"撤回到待指派",
                        width:900,
                        height:500,
                        buttons:{},
                        closed:function () {
                            document.location.reload();
                        }
                    });
                });
            });

            //批量撤回到待指派
            $('#batchToCancel').click(function () {
                var ids = checkedIds();
                if(ids == null || ids == ""){
                    return;
                }
                top.$.jBox("iframe:/erp/employeeCommunication/batchToCancel?ids="+ids,{
                    title:"批量指派沟通人",
                    width:600,
                    height:300,
                    buttons:{},
                    closed:function () {
                        document.location.reload();
                    }
                });
            });
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
                items.click(function () {
                    checkAll.attr("checked", items.length == $('[name="checkbox"]:checked').length ? true : false);
                });
            })
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/erp/employeeCommunication/list?employeeCommunication.appointStatus=0">已联系招工沟通管理表列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="employee" action="${ctx}/erp/employeeCommunication/list?employeeCommunication.appointStatus=0" method="post" class="breadcrumb form-search">
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
			<li><label>指派时间：</label>
				<input name="employeeCommunication.appointStartTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${employee.employeeCommunication.appointStartTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>至
				<input name="employeeCommunication.appointEndTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${employee.employeeCommunication.appointEndTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			</li>
			<li class="clearfix"></li>
			<li>最近沟通时间：
				<input name="employeeCommunication.communicationStartTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${employee.employeeCommunication.communicationStartTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>至
				<input name="employeeCommunication.communicationEndTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${employee.employeeCommunication.communicationEndTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			</li>
			<li><label>签约意向：</label>
				<form:select path="employeeCommunication.signingIntention" class="input-large">
					<form:option value="" label="------请选择------"/>
					<form:options items="${erp:signingIntentionStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li class="clearfix"></li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
				<input id="batchToCancel" class="btn btn-primary" type="button" value="批量撤回到待指派"/></li>
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
				<th>指派人</th>
				<th>指派时间</th>
				<th>沟通人</th>
				<th>最近沟通时间</th>
				<th>沟通次数</th>
				<th>签约意向</th>
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
				<td>
						${erpEmployee.employeeCommunication.appointName}
				</td>
				<td>
					<fmt:formatDate value="${erpEmployee.employeeCommunication.appointTime}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
						${erpEmployee.employeeCommunication.communicationPerson}
				</td>
				<td>
					<fmt:formatDate value="${erpEmployee.employeeCommunication.communicationTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
						${erpEmployee.employeeCommunication.communicationCount}
				</td>
				<td>
						${erp:signingIntentionStatusName(erpEmployee.employeeCommunication.signingIntention)}
				</td>
				<shiro:hasPermission name="employeecommunication:employeeCommunication:edit">
					<td>
						<a href="${ctx}/erp/employee/form?id=${erpEmployee.id}&flag=n">编辑</a>
						<a name="toAddCommunicationRecord" href="javascript:;" id="${erpEmployee.id}">添加沟通记录</a>
						<a name="communicationHistory" href="${ctx}/erp/employeeCommunicationHistory/list?employeeId=${erpEmployee.id}" id="${erpEmployee.id}">沟通历史记录</a>
						<a name="toCancel" href="javascript:;" id="${erpEmployee.id}">撤回到待指派</a>
					</td>
				</shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
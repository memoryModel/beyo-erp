<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>待通知面试列表</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
            jqueryCheckAll();

            $("#batchToInterviewRemind").click(function(){
                var ids = checkedIds();
                if (ids == null || ids == ''){
                    return;
				}

                var value= confirm('确认向选中的面试员工发送短信提醒？');
                if (value == true){
                    window.location.href="${ctx}/crm/interview/reminder?ids="+ids;
				}else if(value == false){
                   return false;
                }

			})
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }

        //复选框全选
        function jqueryCheckAll(){
		    var checkAll = $('[name="checkboxs"]');
		    var items = $('[name="checkbox"]');
            checkAll.click(function () {
				if ($(this).attr('checked')) {
				    items.each(function () {
						$(this).attr("checked",true);
                    })
				} else {
				    items.each(function () {
						$(this).attr("checked",false);
                    })
				}
            });
			items.click(function () {
                checkAll.attr("checked",items.length == $('[name="checkbox"]:checked').length ? true : false);
            })
		}

		//获取选中的待面试候选人的信息
		function checkedIds(){
            var ids = '';
            var elements = $('[name="checkbox"]:checked');
            for (var i = 0; i < elements.length; i++){
                if (i<elements.length - 1){
                    ids = ids + $(elements[i]).val() + ",";
				}else{
                    ids = ids + $(elements[i]).val();
				}
			}
			return ids;
		}


	</script>

</head>
<body>
<ul class="nav nav-tabs">
	<li class="active"><a href="${ctx}/crm/interview/toBeNotifiedList">待通知列表</a></li>
</ul><br/>
	<form:form id="searchForm" modelAttribute="interview" action="${ctx}/crm/interview/toBeNotifiedList" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>员工姓名：</label>
				<form:input path="employee.name" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>手机号码：</label>
				<form:input path="employee.phone" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li>
				<label>来源：</label>
				<sys:treeselect id="customerResource" name="customerResource.id" value="${employee.customerResource.id}"
								labelName="customerResource.customerName" labelValue="${employee.customerResource.customerName}"
								title="来源名称" url="/erp/customerResource/treeData"  allowClear="true"/>
			</li>
			<li><label>性别：</label>
				<form:select path="employee.sex" class="input-medium ">
					<form:option value="" label="------请选择------"/>
					<form:options items="${erp:sexStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;计划面试时间：
				<input name="startInterviewTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${interview.startInterviewTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/> --
				<input name="endInterviewTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${interview.endInterviewTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			</li>
			<li>&nbsp;&nbsp;&nbsp;&nbsp;计划添加时间：
				<input name="startTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${interview.startTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/> --
				<input name="endTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${interview.endTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			</li>
			<li class="clearfix"></li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
				<input id="batchToInterviewRemind" class="btn btn-primary" type="button" value="批量发送面试提醒"/></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th><input type="checkbox" name="checkboxs"></th>
				<th>姓名</th>
				<th>性别</th>
				<th>手机号码</th>
				<th>工种</th>
				<th>来源</th>
				<th>面试人</th>
				<th>计划面试时间</th>
				<th>提醒状态</th>
				<th>计划添加人</th>
				<th>计划添加时间</th>
				<th>操作</th>
			</tr>

		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="interview">
			<tr>
				<td><input type="checkbox" name="checkbox" value="${interview.id}"></td>
				<td>
					${interview.employee.name}
				</td>
				<td>
					${erp:sexStatusName(interview.employee.sex)}
				</td>
				<td>
					${interview.employee.phone}
				</td>
				<td>
					<c:forEach items="${interview.employee.getProfessionList()}" var="occId" varStatus="length">
						<c:if test="${length.index!=0}">
							,
						</c:if>
						${erp:getCommonsTypeName(occId)}
					</c:forEach>
				</td>
				<td>
					${interview.customerResource.customerName}
				</td>
				<td>
					${interview.interviewers.name}
				</td>
				<td>
					<fmt:formatDate value="${interview.planInterviewTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
					${erp:remindStatusName(interview.remindStatus)}
				</td>
				<td>
					${interview.addPlanUser.name}
				</td>
				<td>
					<fmt:formatDate value="${interview.createTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
					<a href="${ctx}/crm/interview/form?id=${interview.id}">修改面试计划</a>&nbsp;&nbsp;
					<a href="${ctx}/crm/interview/reminder?id=${interview.id}" onclick="return confirmx('确认向选中的面试员工发送短信提醒？', this.href)">发送面试提醒</a>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
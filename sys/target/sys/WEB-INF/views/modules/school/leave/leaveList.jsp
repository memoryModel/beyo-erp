<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>请假管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
            $(document).find("a[name='viewInfo']").each(function () {
                var rid = $(this).attr("rid");
                $(this).click(function () {
                    top.$.jBox("iframe:/school/leave/view?id="+rid,{
                        title:"预计延误课程",
                        width:976,
                        height:570,
                        buttons:{}
                    });
                });
            });
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }

        function selectDelegateCallback(){
            window.location.reload(true);
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/school/leave/list">请假列表</a></li>
		<shiro:hasPermission name="school:leave:form"><li><a href="${ctx}/school/leave/form">新增请假</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="leave" action="${ctx}/school/leave/list" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>请假时间：</label>
				<input name="startTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${leave.startTime}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>-
				<input name="endTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
				   value="<fmt:formatDate value="${leave.endTime}" pattern="yyyy-MM-dd"/>"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			</li>
			<li><label>请假原因：</label>
				<form:select path="leaveReason" class="input-large" style="width: 180px">
					<form:option value="">请选择</form:option>
					<form:options items="${erp:getCommonsTypeList(28)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>销假时间：</label>
				<input name="destroyTimeStart" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   value="<fmt:formatDate value="${leave.destroyTimeStart}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>-
				<input name="destroyTimeEnd" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   value="<fmt:formatDate value="${leave.destroyTimeEnd}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			</li>
			<li><label>创建时间：</label>
				<input name="createTimeStart" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   value="<fmt:formatDate value="${leave.createTimeStart}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>-
				<input name="createTimeEnd" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   value="<fmt:formatDate value="${leave.createTimeEnd}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			</li>
			<li><label>请假状态：</label>
				<form:select path="leaveStatus" class="input-large" style="width: 180px">
					<form:option value="">请选择</form:option>
					<form:options items="${erp:getCommonsTypeList(33)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
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
				<th>姓名</th>
				<th>学号</th>
				<th>手机号</th>
				<th>请假时间</th>
				<th>请假原因</th>
				<th>预计延误课程</th>
				<th>销假时间</th>
				<th>实际延误课程</th>
				<th>备注</th>
				<th>创建时间</th>
				<th>状态</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="schoolLeave">
			<tr createUser="${schoolLeave.createUser}" id="${schoolLeave.id}">
				<td>
					${schoolLeave.student.name}
				</td>
				<td>
					${schoolLeave.student.studentNumber}
				</td>
				<td>
					${schoolLeave.student.phone}
				</td>
				<td>
					<fmt:formatDate value="${schoolLeave.startTime}" pattern="yyyy-MM-dd HH:mm"/>~<br/>
					<fmt:formatDate value="${schoolLeave.endTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
					${erp:getCommonsTypeName(schoolLeave.leaveReason)}
				</td>
				<td>
					<a href="javascript:;" name="viewInfo" rid="${schoolLeave.id}">${schoolLeave.predictLesson}</a>
				</td>
				<td>
					<fmt:formatDate value="${schoolLeave.destroyTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
					${schoolLeave.practicalLesson}
				</td>
				<td>
					${schoolLeave.remark}
				</td>
				<td>
					<fmt:formatDate value="${schoolLeave.createTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
					${erp:leaveStatusName(schoolLeave.leaveStatus)}
				</td>
				<td>
					<c:if test="${schoolLeave.leaveStatus ==0}">
						<shiro:hasPermission name="school:leave:updateStatus"><a href="${ctx}/school/leave/updateStatus?id=${schoolLeave.id}&&leaveStatus=1" onclick="return confirmx('请假生效后，学员请假期间涉及到的课程将默认为缺勤.确定要将该请假设置为生效？', this.href)">生效</a></shiro:hasPermission>
						<shiro:hasPermission name="school:leave:updateStatus"><a href="${ctx}/school/leave/updateStatus?id=${schoolLeave.id}&&leaveStatus=3" onclick="return confirmx('确认将该请假设置为作废？', this.href)">作废</a></shiro:hasPermission>
					</c:if>
					<c:if test="${schoolLeave.leaveStatus == 1}">
						<shiro:hasPermission name="school:leave:updateStatus"><a name="leaveForm" leaveId="${schoolLeave.id}" href="javascript:;">销假</a></shiro:hasPermission>
					</c:if>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	<script type="text/javascript">
        $(document).find("a[name='leaveForm']").each(function () {
            var leaveId = $(this).attr("leaveId");
            $(this).click(function () {
                top.$.jBox("iframe:/school/leave/leaveDetailsForm?id="+leaveId,{
                    title:"销假",
                    width:500,
                    height:400,
                    buttons:{}
                });
            });
        });
	</script>
<script src="${ctxStatic}/officeNames/officeNames.js" type="text/javascript"></script>
</body>
</html>
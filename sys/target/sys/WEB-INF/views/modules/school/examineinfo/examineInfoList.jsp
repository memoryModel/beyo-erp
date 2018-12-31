<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>考试管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
            $(document).find("a[name='studentCount']").each(function () {
                var infoId = $(this).attr("infoId");
                $(this).click(function () {
                    top.$.jBox("iframe:/school/examineInfo/info?id="+infoId,{
                        title:"考试详情",
                        width:1024,
                        height:468,
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
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<shiro:hasPermission name="school:examineInfo:list">
			<li class="active"><a href="${ctx}/school/examineInfo/list">考试管理</a></li>
		</shiro:hasPermission>
		<shiro:hasPermission name="school:examineInfo:form"><li><a href="${ctx}/school/examineInfo/form">新增考试</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="examineInfo" action="${ctx}/school/examineInfo/list" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>考试名称：</label>
				<form:input path="examineName" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>考试类型：</label>
				<form:select path="examineType" class="input-medium" >
					<form:option value="">请选择</form:option>
					<form:options items="${erp:examTypeList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>考试方式：</label>
				<form:select path="examineMethod" class="input-medium" >
					<form:option value="">请选择</form:option>
					<form:options items="${erp:getCommonsTypeList(26)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
				</form:select>
			</li>
			<li class="clearfix"></li>

			<li><label>考试状态：</label>
				<form:select path="infoStatus" class="input-medium ">
					<form:option value="">请选择</form:option>
					<form:options items="${erp:infoStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li>
				<label>考试题库：</label>
				<form:select path="schoolExamineStore.id" class="input-medium">
					<form:option value="">请选择</form:option>
					<form:options items="${storeList}" itemLabel="name" itemValue="id" htmlEscape="false"/>
				</form:select>
			</li>
			<li class="clearfix"></li>
			<li><label>考试时间：</label>
				<input name="startTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${examineInfo.startTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>—
				<input name="endTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${examineInfo.endTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			</li>
			<li><label>创建时间：</label>
				<input name="createTimeStart" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   value="<fmt:formatDate value="${examineInfo.createTimeStart}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>—
				<input name="createTimeEnd" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   value="<fmt:formatDate value="${examineInfo.createTimeEnd}" pattern="yyyy-MM-dd"/>"
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
				<th>考试名称</th>
				<th>考试类型</th>
				<th>考试班级</th>
				<th>考试方式</th>
				<th>考试题库</th>
				<th>考试时段</th>
				<th>答题时长</th>
				<th>考试学员</th>
				<th>创建时间</th>
				<th>考试状态</th>
			    <th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="schoolExamineInfo">
			<tr createUser="${schoolExamineInfo.createUser}" id="${schoolExamineInfo.id}">
				<td>
					${schoolExamineInfo.examineName}
					<c:if test="${schoolExamineInfo.examineStatus==1}">
						-补考
					</c:if>
				</td>
				<td>
					${erp:examTypeName(schoolExamineInfo.examineType)}
				</td>
				<td>
					${schoolExamineInfo.schoolClass.className}
				</td>
				<td>
					${erp:getCommonsTypeName(schoolExamineInfo.examineMethod)}
				</td>
				<td>
					${schoolExamineInfo.schoolExamineStore.name}
				</td>
				<td>
					<fmt:formatDate value="${schoolExamineInfo.startTime}" pattern="yyyy-MM-dd HH:mm"/><br/>
					<fmt:formatDate value="${schoolExamineInfo.endTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
					${schoolExamineInfo.examineLength}分钟
				</td>
				<td>
					<a name="studentCount" infoId="${schoolExamineInfo.id}" href="javascript:;" >${schoolExamineInfo.studentCount}</a>
				</td>
				<td>
					<fmt:formatDate value="${schoolExamineInfo.createTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
					${erp:infoStatusName(schoolExamineInfo.infoStatus)}
				</td>
				<td>
					<c:if test="${schoolExamineInfo.infoStatus==0}">
						<shiro:hasPermission name="school:examineInfo:form"><a href="${ctx}/school/examineInfo/form?id=${schoolExamineInfo.id}">修改</a></shiro:hasPermission>
						<shiro:hasPermission name="school:examineInfo:delete"><a href="${ctx}/school/examineInfo/delete?id=${schoolExamineInfo.id}" onclick="return confirmx('确认要删除该考试吗？', this.href)">删除</a></shiro:hasPermission>
						<shiro:hasPermission name="school:examineInfo:form"><a href="${ctx}/school/examineInfo/gen?id=${schoolExamineInfo.id}" onclick="return confirmx('发放试卷后系统会根据设置的试卷规则生成每个学员的试卷<br>如果为在线考试则学员会在手机端收到考卷<br>确定发放试卷？', this.href)">发放考卷</a></shiro:hasPermission>
					</c:if>
					<c:if test="${schoolExamineInfo.infoStatus==1}">
						<shiro:hasPermission name="school:examineInfo:delete"><a href="${ctx}/school/examineInfo/stop?id=${schoolExamineInfo.id}" onclick="return confirmx('结束考试后系统会将该考试终止，老师可操作录入学员成绩<br>如果为在线考试则学员在手机端将不可再答题<br>确认提前结束考试？', this.href)">结束考试</a></shiro:hasPermission>
					</c:if>

					<c:if test="${schoolExamineInfo.infoStatus ==2 }">
						<shiro:hasPermission name="school:examineStudents:insertScore"><a href="${ctx}/school/examineInfo/studentScore?id=${schoolExamineInfo.id}">成绩录入</a></shiro:hasPermission>
					</c:if>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
<script src="${ctxStatic}/officeNames/officeNames.js" type="text/javascript"></script>
</body>
</html>
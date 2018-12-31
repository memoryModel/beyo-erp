<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>单表管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
        $(document).ready(function() {
            var tagflag = '${tagflag}'
            if(tagflag != '' && parseInt(tagflag) == 0){
                $("#li0").attr("class","active");
                $("#searchForm").attr("action","${ctx}/school/student/list");
            }
            if(tagflag != '' && parseInt(tagflag) == 1){
                $("#li1").attr("class","active");
                $("#searchForm").attr("action","${ctx}/school/student/followNoList");
            }
            if(tagflag != '' && parseInt(tagflag) == 2){
                $("#li2").attr("class","active");
                $("#searchForm").attr("action","${ctx}/school/student/followList");
            }
            if(tagflag != '' && parseInt(tagflag) == 3){
                $("#li3").attr("class","active");
                $("#searchForm").attr("action","${ctx}/school/student/mineStudentList");
            }

            var currentHref = window.location.pathname;


        });
        function page(n,s){
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").submit();
            return false;
        }
        function selectDelegatesCallback(){
            window.location.reload(true);
        }
	</script>
</head>
<body>
<ul class="nav nav-tabs">
	<shiro:hasPermission name="school:student:mineStudentList">
		<li id="li3"><a href="${ctx}/school/student/mineStudentList">我的生源</a></li>
	</shiro:hasPermission>
	<shiro:hasPermission name="school:student:followNoList">
		<li id="li1"><a href="${ctx}/school/student/followNoList">未分配生源</a></li>
	</shiro:hasPermission>
	<shiro:hasPermission name="school:student:followList">
		<li id="li2"><a href="${ctx}/school/student/followList">已分配生源</a></li>
	</shiro:hasPermission>
	<shiro:hasPermission name="school:student:list">
		<li id="li0"><a href="${ctx}/school/student/list">全部生源</a></li>
	</shiro:hasPermission>
	<shiro:hasPermission name="school:student:saveForm">
		<li><a href="${ctx}/school/student/saveForm">添加生源</a></li>
	</shiro:hasPermission>
</ul>
<form:form id="searchForm" modelAttribute="student" method="post" class="breadcrumb form-search">
	<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	<ul class="ul-form">
		<li><label>姓名/号码：</label>
			<form:input path="name" htmlEscape="false"  placeholder="搜索学员姓名/手机号" maxlength="20" class="input-medium"/>
		</li>
		<li><label>招聘老师：</label>
			<form:input path="teacher.name" htmlEscape="false" maxlength="20" class="input-medium"/>
		</li>
		<li><label>跟进人：</label>
			<form:input path="follow.name" htmlEscape="false" maxlength="20" class="input-medium"/>
		</li>
		<li><label>学员类型：</label>
			<form:select path="studentType" class="input-large " style="width:180px;">
				<form:option value="">请选择</form:option>
				<form:options items="${erp:StudentTypeList()}"  itemLabel="name" itemValue="value" htmlEscape="false"/>
			</form:select>
		</li>

		<br/><br/>
		<li><label>职业方向：</label>
			<form:select path="occupationId" class="input-large " style="width:180px;">
				<form:option value="">请选择</form:option>
				<form:options items="${erp:getCommonsTypeList(12)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
			</form:select>
		</li>

		<li><label>客户状态：</label>
			<form:select path="communication.status" class="input-large " style="width:180px;">
				<form:option value="-1">请选择</form:option>
				<form:options items="${erp:clientStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
			</form:select>
		</li>
		<li><label>创建时间：</label>
			<input name="createTimeStart" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
				   value="<fmt:formatDate value="${student.createTimeStart}" pattern="yyyy-MM-dd"/>"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>-
			<input name="createTimeEnd" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
				   value="<fmt:formatDate value="${student.createTimeEnd}" pattern="yyyy-MM-dd"/>"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
		</li>
		<li class="btns">
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" style="width:100px;"/>
		</li>
		<li class="clearfix"></li>
	</ul>
</form:form>
<sys:message content="${message}"/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

<table id="contentTable" class="table table-striped table-bordered table-condensed">
	<thead>
	<tr>
		<th>学生姓名</th>
		<th>学生性别</th>
		<th>手机号码</th>
		<th>职业方向</th>
		<th>招生来源</th>
		<th>招聘老师</th>
		<th>跟进人</th>
		<th>客户状态</th>
		<th>沟通记录</th>
		<th>学员类型</th>
		<th>创建时间</th>
		<th>操作</th>
	</tr>
	</thead>
	<tbody>
	<c:forEach items="${page.list}" var="student">
		<tr createUser="${student.createUser}" id="${student.id}">
			<td>
				<a name="studentView" studentName="${student.name}" studentId="${student.id}" href="javascript:;" >${student.name}</a>
			</td>
			<td>
					${erp:sexStatusName(student.sex)}
			</td>
			<td>
					${student.phone}
			</td>
			<td>
				<c:forEach items="${student.getOccupationList()}" var="occId" varStatus="length">
					<c:if test="${length.index!=0}">
						,
					</c:if>
					${erp:getCommonsTypeName(occId)}
				</c:forEach>
			</td>
			<td>
					${student.customerResource.customerName}
			</td>
			<td>
					${student.teacher.name}
			</td>
			<td>
					${student.follow.name}
			</td>
			<td>
					${erp:clientStatusName(student.communication.status)}
			</td>
			<td>
				<a studentId="${student.id}" href="${ctx}/school/communication/form?erpStudentEnrollId=${student.id}&currentHref">${student.countCommunication}</a>
			</td>
			<td>
					${erp:studentTypeName(student.studentType)}
			</td>
			<td>
				<fmt:formatDate value="${student.createTime}" pattern="yyyy-MM-dd HH:mm"/>
			</td>
			<td>
				<shiro:hasPermission name="school:student:form"><a href="${ctx}/school/student/form?id=${student.id}">修改</a>&nbsp;&nbsp;</shiro:hasPermission>
				<shiro:hasPermission name="school:communication:form"><a href="${ctx}/school/communication/form?erpStudentEnrollId=${student.id}">沟通记录</a>&nbsp;&nbsp;</shiro:hasPermission>
				<shiro:hasPermission name="school:student:delete"><a href="${ctx}/school/student/delete?id=${student.id}" onclick="return confirmx('确认要删除该生源吗？', this.href)">删除</a></shiro:hasPermission>
				<c:if test="${student.follow.id != null}">
					<shiro:hasPermission name="school:student:studentList"><a name="studentForm" studentId="${student.id}" href="javascript:;">重新指派</a></shiro:hasPermission>
				</c:if>
				<c:if test="${student.follow.id == null}">
					<shiro:hasPermission name="school:student:studentList"><a name="studentForm" studentId="${student.id}" href="javascript:;">指派跟进人</a></shiro:hasPermission>
				</c:if>
			</td>

		</tr>
	</c:forEach>
	</tbody>
</table>

<div class="pagination">${page}</div>

<script type="text/javascript">
    $(document).find("a[name='studentForm']").each(function () {
        var studentId = $(this).attr("studentId");
        $(this).click(function () {
            top.$.jBox("iframe:/school/student/studentList?id="+studentId,{
                title:"指派跟进人",
                width:500,
                height:400,
                buttons:{}
            });
        });
    });

    $(document).find("a[name='studentView']").each(function () {
        var studentId = $(this).attr("studentId");
        var studentName = $(this).attr("studentName")
        $(this).click(function () {
            top.$.jBox("iframe:/school/student/info?id="+studentId+"&&tagFlag="+1,{
                title:"学生信息:"+studentName,
                width:780,
                height:580,
                buttons:{}
            });
        });
    });
</script>
<script src="${ctxStatic}/officeNames/officeNames.js" type="text/javascript"></script>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>课表管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
        $(document).ready(function() {

            $(document).find("a[name='beginInfo']").each(function () {
                var scheduleId = $(this).attr("scheduleId");
                var classId = $(this).attr("classId");
                var lessonId = $(this).attr("lessonId");
                $(this).click(function () {
                    top.$.jBox("iframe:/school/classLessonSign/signInfo?id="+scheduleId+"&&classId="+classId+"&&lessonId="+lessonId,{
                        title:"开课详情",
                        width:768,
                        height:700,
                        buttons:{}
                    });
                });
            });

            var listSize = '${listSize}'
            if(listSize == '' || listSize == 0){
                $('#exprotButton').attr('disabled',true);
            }else{
                $('#exprotButton').attr('disabled',false);
            }
        });
        function page(n,s){
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").attr('action',"${ctx}/school/schedule/list");
            $("#searchForm").submit();
            return false;
        }
        function submitForm(){
            $("#searchForm").attr('action',"${ctx}/school/schedule/list");
            $("#searchForm").submit();
        }
        function exportExcel(){
            $("#searchForm").attr('action',"${ctx}/school/schedule/exportList");
            $("#searchForm").submit();
        }
	</script>
</head>
<body>
<ul class="nav nav-tabs">
	<shiro:hasPermission name="school:schedule:myList"><li><a href="${ctx}/school/schedule/myList">我的课表</a></li></shiro:hasPermission>
	<shiro:hasPermission name="school:schedule:list"><li class="active"><a href="${ctx}/school/schedule/list">全部课表</a></li></shiro:hasPermission>
	<li><a href="${ctx}/school/schedule/inClass">合班上课</a></li>
</ul>
<form:form id="searchForm" modelAttribute="classSchedule" action="${ctx}/school/schedule/list" method="post" class="breadcrumb form-search">
	<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	<ul class="ul-form">
			<%--<li><label>班级名称：</label>
				<form:select path="schoolClass.id" style="width:200px" class="input-medium">
					<form:option value="">请选择</form:option>
					<form:options items="${classList}" itemLabel="className" itemValue="id" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>课程：</label>
				<form:select path="schoolClassLesson.id"  class="input-medium">
					<form:option value="">请选择</form:option>
					<form:options items="${lessonList}" itemLabel="lessonName" itemValue="id" htmlEscape="false"/>
				</form:select>
			</li>
			<li>
				<label>授课老师：</label>
				<sys:employeeselect id="user" name="schoolClassLesson.teacher.id" value="${schoolClassLesson.teacher.id}"
									labelName="classSchedule.schoolClassLesson.teacher.name" labelValue="${classSchedule.schoolClassLesson.teacher.name}"
									title="用户" url="/sys/office/treeData?type=3" allowClear="true" />
			</li>
			<li><label>上课教室：</label>
				<form:select path="schoolClassroom.id"  class="input-medium">
					<form:option value="">请选择</form:option>
					<form:options items="${roomList}" itemLabel="classroomName" itemValue="id" htmlEscape="false"/>
				</form:select>
			</li>--%>
		<li><label>班级：</label>
			<form:input path="schoolClass.className" htmlEscape="false" maxlength="20" class="input-medium"/>
		</li>
		<li><label>课程名称：</label>
			<form:input path="schoolClassLesson.lessonName" htmlEscape="false" maxlength="20" class="input-medium"/>
		</li>
		<li><label>授课老师：</label>
			<form:input path="teacher.name" htmlEscape="false" maxlength="20" class="input-medium"/>
		</li>
		<li><label>上课教室：</label>
			<form:input path="schoolClassroom.classroomName" htmlEscape="false" maxlength="20" class="input-medium"/>
		</li>
		<li><label>创建时间：</label>
			<input name="createTimeStart" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
				   value="<fmt:formatDate value="${classSchedule.createTimeStart}" pattern="yyyy-MM-dd"/>"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>-
			<input name="createTimeEnd" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
				   value="<fmt:formatDate value="${classSchedule.createTimeStart}" pattern="yyyy-MM-dd"/>"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
		</li>
		<li><label>状态：</label>
			<form:select path="status" class="input-medium">
				<form:option value="" label="------请选择------"/>
				<form:options items="${erp:lessonsStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
			</form:select>
		</li>
		<li class="btns"><input id="btnSubmexprotButtonit" class="btn btn-primary" type="button" value="查询" onclick="submitForm()"/>
			<input type="button" id="exprotButton" class="btn btn-primary" value="导出" onclick="exportExcel()">
		</li>

		<li class="clearfix"></li>
	</ul>
</form:form>

<sys:message content="${message}"/>

<%--<div>

        <button id="fat-btn" data-loading-text="loading..." class="btn btn-primary">排课</button>

</div></br>--%>

<table id="contentTable" class="table table-striped table-bordered table-condensed">
	<thead>
	<tr>
		<th>班级</th>
		<th>课程</th>
		<th>授课老师</th>
		<th>上课时间</th>
		<th>上课时长</th>
		<th>教室</th>
		<th>实到人数</th>
		<th>创建时间</th>
		<th>状态</th>
		<th>操作</th>
	</tr>
	</thead>
	<tbody>
	<c:forEach items="${page.list}" var="schoolClassSchedule">
		<tr createUser="${schoolClassSchedule.createUser}" id="${schoolClassSchedule.id}">
			<td><a href="${ctx}/school/schedule/arrange?
							classId=${schoolClassSchedule.schoolClass.id}
							&&lessonId=${schoolClassSchedule.schoolClassLesson.id}
							&&scheduleId=${schoolClassSchedule.id}">
					${schoolClassSchedule.schoolClass.className}
							${schoolClassSchedule.id}
			</a></td>
			<td>
					${schoolClassSchedule.schoolClassLesson.lessonName}
			</td>
			<td>
					${schoolClassSchedule.teacher.name}
			</td>
			<td>
				<fmt:formatDate value="${schoolClassSchedule.beginTime}" pattern="yyyy-MM-dd HH:mm"/> ~~
				<fmt:formatDate value="${schoolClassSchedule.endTime}" pattern="HH:mm EE"/>
			</td>
			<td>
				<fmt:formatNumber value="${(schoolClassSchedule.endTime.getTime()-schoolClassSchedule.beginTime.getTime())/1000/60}" pattern="#0"/>分钟
			</td>
			<td>
					${schoolClassSchedule.schoolClassroom.classroomName}
			</td>
			<td>
				<a name="beginInfo" scheduleId="${schoolClassSchedule.id}" classId="${schoolClassSchedule.schoolClass.id}" lessonId="${schoolClassSchedule.schoolClassLesson.id}" href="javascript:;" >
						${schoolClassSchedule.signCount}&nbsp;/&nbsp;${schoolClassSchedule.studentCount}
				</a>
					<%--<c:if test="${schoolClassSchedule.noSignCount == 0}">
						0/${schoolClassSchedule.signCount}
					</c:if>
					<c:if test="${schoolClassSchedule.noSignCount >0}">
						${schoolClassSchedule.signCount-schoolClassSchedule.noSignCount}/${schoolClassSchedule.signCount}
					</c:if>--%>
			</td>
			<td>
				<fmt:formatDate value="${schoolClassSchedule.createTime}" pattern="yyyy-MM-dd HH:mm"/>
			</td>
			<td>
					${erp:lessonsStatusName(schoolClassSchedule.status)}
			</td>
			<td>
				<c:if test="${schoolClassSchedule.status==0}">
					<shiro:hasPermission name="school:schedule:arrange">
						<a href="${ctx}/school/schedule/arrange?
								classId=${schoolClassSchedule.schoolClass.id}&&lessonId=${schoolClassSchedule.schoolClassLesson.id}&&scheduleId=${schoolClassSchedule.id}">修改
						</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="school:schedule:delete">
						<a href="${ctx}/school/schedule/delete?id=${schoolClassSchedule.id}" onclick="return confirmx('确认要删除该课表吗？', this.href)">删除</a>
					</shiro:hasPermission>
				</c:if>
				<c:if test="${schoolClassSchedule.status==1}">
					<a href="${ctx}/school/classLessonSign/sign?id=${schoolClassSchedule.id}&&classId=${schoolClassSchedule.schoolClass.id}&&lessonId=${schoolClassSchedule.schoolClassLesson.id}&&modify=1">修改签到记录</a>
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
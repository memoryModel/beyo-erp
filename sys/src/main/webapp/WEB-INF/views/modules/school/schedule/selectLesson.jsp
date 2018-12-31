<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
<html>
<body>
<script type="text/javascript">
    var classScheduleList = ${fns:toJson(classScheduleList)};
    $(document).ready(function() {
        //alert(classScheduleList);
    });

    function page(n,s){
        $("#pageNo").val(n);
        $("#pageSize").val(s);
        $("#searchForm").submit();
        return false;
    }

    function selectLesson(lessonId,lessonName,teacherId,teacherName){
        // console.log("#btnSelect"+lessonId+"--"+lessonName+"--"+teacherId+"--"+teacherName+"--"+subjectId+"--"+subjectName);
        //var chked = $("#checkbox"+lessonId).attr("checked");
        top.$.jBox.confirm('确认要选择添加该课程吗？','系统提示',function(v,h,f) {
            if (v == 'ok') {
                parent.window.frames["mainFrame"].selectLessonCallback(lessonId,lessonName,teacherId,teacherName,${fns:toJson(classScheduleList)});
                top.$.jBox.close(true);
            }
        },{buttonsFocus:1, closed:function(){
            if (typeof closed == 'function') {
                closed();
            }
        }});
        //close
    }
</script>
<table id="scheduleTable" class="table table-striped table-bordered table-condensed">
</table>


<form:form id="searchForm" modelAttribute="classLesson" action="${ctx}/school/schedule/selectLesson?schoolClassId=${classLesson.schoolClassToLesson.schoolClass.id}" method="post" class="breadcrumb form-search">
	<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	<ul class="ul-form">
		<li><label>课程名称：</label>
			<form:input path="lessonName" htmlEscape="false" maxlength="512" class="input-medium"/>
		</li>
			<%--<li><label>科目：</label>
                <form:input path="schoolSubject.subjectName" htmlEscape="false" maxlength="512" class="input-medium"/>
            </li>--%>
		<li><label>创建时间：</label>
			<input name="createTimeStart" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>-
			<input name="createTimeEnd" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
		</li>
			<%--<li><label>状态：</label>
                <form:select path="status" class="input-medium">
                    <form:option value="" label="------请选择------"/>
                    <form:options items="${erp:commonsStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
                </form:select>
            </li>--%>
		</li>
		<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
		<li class="clearfix"></li>
	</ul>

</form:form>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
	<thead>
	<tr>
		<th>课程名称</th>
		<th>授课老师</th>
		<th>年份</th>
		<th>期段</th>
		<th>类型</th>
		<%--<th>科目</th>--%>
		<th>创建时间</th>
		<%--<th>状态</th>--%>
		<td>操作</td>
	</tr>
	</thead>
	<tbody>
	<c:forEach items="${page.list}" var="schoolClassLesson">
		<tr>
			<td>
					${schoolClassLesson.lessonName}
			</td>
			<td>
				<input type="hidden" value="${schoolClassLesson.teacherIds}">
					${schoolClassLesson.teacherNames}
			</td>
			<td>
				<fmt:formatDate value="${schoolClassLesson.createTime}" pattern="yyyy"/>
			</td>
			<td>
				<fmt:formatDate value="${schoolClassLesson.createTime}" pattern="MMMM"/>
			</td>
			<td>
					${schoolClassLesson.commonsType.commonsName}
			</td>
				<%--<td>
                        ${schoolClassLesson.schoolSubject.subjectName}
                </td>--%>
			<td>
				<fmt:formatDate value="${schoolClassLesson.createTime}" pattern="yyyy-MM-dd"/>
			</td>
				<%--<td>
                        ${erp:commonsStatusName(schoolClassLesson.status)}
                </td>--%>
			<td>
				<input type="button" id="button${schoolClassLesson.id}" value="选择" class="btn btn-primary" onclick="selectLesson(
						'${schoolClassLesson.id}','${schoolClassLesson.lessonName}',
						'${schoolClassLesson.teacherIds}','${schoolClassLesson.teacherNames}',
						'${schoolClassLesson.commonsType.commonsName}')"/>
			</td>
		</tr>
	</c:forEach>
	</tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>
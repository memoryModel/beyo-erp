<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
<html>
<head>
	<title>考试管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">

	</script>
</head>
<body>
<form:form id="searchForm" modelAttribute="schoolClass" action="${ctx}/school/class/selectClass" method="post" class="breadcrumb form-search">
	<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	<ul class="ul-form">
		<li><label>班级：</label>
			<form:input path="className" htmlEscape="false" maxlength="20" class="input-medium"/>
		</li>
		<li><label>班主任：</label>
			<form:input path="headteacher.name" htmlEscape="false" maxlength="20" class="input-medium"/>
		</li>
		<li><label>开班日期：</label>
			<input name="realBeginTime" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
				   value="<fmt:formatDate value="${schoolClass.realBeginTime}" pattern="yyyy-MM-dd"/>"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>-
			<input name="realEndTime" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
				   value="<fmt:formatDate value="${schoolClass.realEndTime}" pattern="yyyy-MM-dd"/>"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
		</li>
		<li><label>创建时间：</label>
			<input name="createTimeStart" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
				   value="<fmt:formatDate value="${schoolClass.createTimeStart}" pattern="yyyy-MM-dd"/>"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>-
			<input name="createTimeEnd" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
				   value="<fmt:formatDate value="${schoolClass.createTimeEnd}" pattern="yyyy-MM-dd"/>"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
		</li>
		<li><label>状态：</label>
			<form:select path="status" class="input-medium">
				<form:option value="" label="------请选择------"/>
				<form:options items="${erp:classStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
			</form:select>
				<%--<form:select path="status" class="input-medium">
					<form:option value="" label="------请选择------"/>
					<form:options items="${fns:getDictList('class_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>--%>
		</li>
		<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
		<li class="clearfix"></li>
	</ul>
</form:form>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
	<thead>
	<tr>
		<th>班级名称</th>
		<%--<th>课程</th>--%>
		<th>价格</th>
		<th>班主任</th>
		<th>报班学员</th>
		<th>入班率</th>
		<th>开班日期</th>
		<th>创建时间</th>
		<th>班级状态</th>
		<th>操作</th>
	</tr>
	</thead>
	<tbody>
	<c:forEach items="${page.list}" var="schoolClass">
		<tr>
			<td>
				<shiro:hasPermission name="school:class:info">
					<a href="${ctx}/school/class/info?id=${schoolClass.id}">${schoolClass.className}</a>
				</shiro:hasPermission>

					<%--<c:if test="${schoolClass.status == 4}">
						${schoolClass.className}
					</c:if>--%>

					<%--<a href="${ctx}/school/class/form?id=${schoolClass.id}&&lessonId=${schoolClass.schoolClassToLesson.schoolClassLesson.id}">
						${schoolClass.className}--%>
			</td>
			<!--17-8-21 测试提bug要求去除-->
				<%--<td>
						${schoolClass.schoolClassToLesson.schoolClassLesson.lessonName}
				</td>--%>
			<td>
					${schoolClass.tuitionAmount}
			</td>
			<td>
					${schoolClass.headteacher.name}
			</td>
			<td>
					${empty schoolClass.classRealNum ? '':schoolClass.classRealNum}
					${empty schoolClass.classRealNum ? '':'/'}
					${empty schoolClass.classRealNum ? '':schoolClass.classMaxNum}
			</td>
			<td>
				<fmt:formatNumber type="number" value="${schoolClass.classRealNum*100/schoolClass.classMaxNum}" maxFractionDigits="0"/>%
			</td>
			<td>
				<fmt:formatDate value="${schoolClass.realBeginTime}" pattern="yyyy-MM-dd"/>
			</td>
			<td>
				<fmt:formatDate value="${schoolClass.createTime}" pattern="yyyy-MM-dd HH:mm"/>
			</td>
			<td>
					${erp:classStatusName(schoolClass.status)}
					<%--${fns:getDictLabel(schoolClass.status, 'schoolclass_status', '')}--%>
			</td>
			<c:if test="${btnFlag == 1}">
				<td>
					<input id="selectClass${schoolClass.id}" name="chkClass" class="btn btn-primary" type="button" value="选择"
						   onclick="selectClass(
								   '${schoolClass.id}','${schoolClass.className}','${btnFlag}')" />
				</td>
			</c:if>
		</tr>
	</c:forEach>
	</tbody>
</table>
<div class="pagination">${page}</div>
<script type="text/javascript">

    var btnFlag = ${btnFlag};//按钮标记  0：按钮隐藏  1：按钮展示
    function page(n,s){
        $("#pageNo").val(n);
        $("#pageSize").val(s);
        $("#searchForm").submit();
        return false;
    }
    function selectClass(classId,className,btnFlag){
        if(btnFlag == 1){
            top.$.jBox.confirm('确认要选择该班级吗？','系统提示',function(v,h,f) {
                if (v == 'ok') {
                    parent.window.frames["mainFrame"].selectClassCallback(classId, className);
                    top.$.jBox.close(true);
                }
            },{buttonsFocus:1, closed:function(){
                if (typeof closed == 'function') {
                    closed();
                }
            }});
        }
    }


</script>
</body>
</html>
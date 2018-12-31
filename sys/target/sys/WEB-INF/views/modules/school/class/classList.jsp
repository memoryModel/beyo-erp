<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>班级管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
        $(document).ready(function() {

            if (${mineClass == true}){
                $('#liTwo').attr("class","active");
            }else if(${mineClass == false}){
                $('#liOne').attr("class","active");
            }
            
            $('a[name="studentGraduat"]').each(function () {
                var schoolClassId = $(this).attr('schoolClassId');
				$(this).click(function () {
                    top.$.jBox("iframe:/school/class/selectStudentGraduat?id="+schoolClassId,{
                        title:"学员结业",
                        width:900,
                        height:500,
                        buttons:{},
                        closed:function () {
                            document.location.reload();
                        }
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
	<shiro:hasPermission name="school:class:mineList">
		<li id="liTwo"><a href="${ctx}/school/class/mineList">我的班级</a></li>
	</shiro:hasPermission>
	<shiro:hasPermission name="school:class:list">
		<li id="liOne"><a href="${ctx}/school/class/list">全部班级</a></li>
	</shiro:hasPermission>
		<li><a href="${ctx}/school/class/pastStudent">往期学员在读</a></li>
</ul>
<form:form id="searchForm" modelAttribute="schoolClass" action="${ctx}/school/class/list" method="post" class="breadcrumb form-search">
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
		<tr createUser="${schoolClass.createUser}" id="${schoolClass.id}">
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
			<td>
				<c:if test="${schoolClass.status == 5 && schoolClass.status != 4}">
					<shiro:hasPermission name="school:class:info"><a href="${ctx}/school/classPlan/info?id=${schoolClass.id}">详情</a></shiro:hasPermission>
				</c:if>
				<c:if test="${schoolClass.status != 5 && schoolClass.status != 4}">
					<shiro:hasPermission name="school:class:info"><a href="${ctx}/school/class/info?id=${schoolClass.id}">详情</a></shiro:hasPermission>
					<shiro:hasPermission name="school:class:form"><a href="${ctx}/school/class/form?id=${schoolClass.id}">修改</a></shiro:hasPermission>
					<%--<shiro:hasPermission name="school:class:classInstall"><a href="${ctx}/school/class/classInstall?id=${schoolClass.id}">班级设置</a></shiro:hasPermission>--%>
				</c:if>
				<c:if test="${schoolClass.status == 0 && schoolClass.schoolClassToLesson.schoolClassLesson.id != null}">
					<%--<shiro:hasPermission name="school:schedule:arrange"><a href="${ctx}/school/schedule/arrange?classId=${schoolClass.id}&&lessonId=${schoolClass.schoolClassToLesson.schoolClassLesson.id}">排课</a></shiro:hasPermission>--%>
					<shiro:hasPermission name="school:schedule:arrange">
						<a href="${ctx}/school/schedule/arrange?classId=${schoolClass.id}&&tagFlag=0">排课</a>
					</shiro:hasPermission>
				</c:if>
				<c:if test="${schoolClass.status != 1 && schoolClass.status != 0 && schoolClass.status != 5 && schoolClass.status != 4}">
					<shiro:hasPermission name="school:schedule:arrange">
						<a href="${ctx}/school/schedule/arrange?classId=${schoolClass.id}&&tagFlag=0">修改排课</a>
					</shiro:hasPermission>
				</c:if>
				<c:if test="${schoolClass.status != 1 && schoolClass.status != 5 && schoolClass.status != 4 }">
					<shiro:hasPermission name="school:class:graduat"><a href="${ctx}/school/class/graduat?id=${schoolClass.id}"
																		onclick="return confirmx('确认要该班级结业吗？', this.href)">结业</a></shiro:hasPermission>
				</c:if>
				<c:if test="${schoolClass.status != 1 && schoolClass.status != 5 && schoolClass.status != 4 }">
					<a name="studentGraduat" href="javascript:void(0)" schoolClassId="${schoolClass.id}">学员结业</a>
				</c:if>
				<c:if test="${schoolClass.status == 4}">
					<shiro:hasPermission name="school:class:updateStatus"><a href="${ctx}/school/class/updateStatus?id=${schoolClass.id}"
																			 onclick="return confirmx('确认撤销结业该班级吗？', this.href)">撤销结业</a></shiro:hasPermission>
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
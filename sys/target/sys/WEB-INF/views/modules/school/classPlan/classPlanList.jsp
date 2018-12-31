<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>开班计划</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
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
		<shiro:hasPermission name="school:classPlan:list">
		<li class="active"><a href="${ctx}/school/classPlan/list">开班计划列表</a></li>
		</shiro:hasPermission>
		<shiro:hasPermission name="school:classPlan:form"><li><a href="${ctx}/school/classPlan/form">开班计划添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="schoolClass" action="${ctx}/school/classPlan/list" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">

			<li><label>计划开班：</label>
				<input name="beginTime" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   value="<fmt:formatDate value="${schoolClass.beginTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>-
				<input name="endTime" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   value="<fmt:formatDate value="${schoolClass.endTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			</li>
			<li><label>班级：</label>
				<form:input path="className" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>课程：</label>
				<form:input path="schoolClassToLesson.schoolClassLesson.lessonName" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li><br/><br/>
			<li><label>创建时间：</label>
				<input name="createTimeStart" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   value="<fmt:formatDate value="${schoolClass.createTimeStart}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>-
				<input name="createTimeEnd" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   value="<fmt:formatDate value="${schoolClass.createTimeEnd}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			</li>
			<%--<li><label>状态：</label>
				<form:select path="status" class="input-medium">
					<form:option value="" label="------请选择------"/>
					<form:options items="${erp:classPlanStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>--%>
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
				<th>学费</th>
				<th>班主任</th>
				<th>报班学员</th>
				<th>入班率</th>
				<th>计划开班日期</th>
				<th>创建日期</th>
				<th>班级状态</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="schoolClass">
			<tr createUser="${schoolClass.createUser}" id="${schoolClass.id}">
				<td>
					<shiro:hasPermission name="school:classPlan:info">
						<a href="${ctx}/school/classPlan/info?id=${schoolClass.id}">${schoolClass.className}</a>
					</shiro:hasPermission>
					<%--<a href="${ctx}/school/classPlan/form?id=${schoolClass.id}">${schoolClass.className}</a>--%>

					<%--<c:if test="${schoolClass.status == 5}">
						<a href="${ctx}/school/classPlan/form?id=${schoolClass.id}">${schoolClass.className}</a>
					</c:if>
					<c:if test="${schoolClass.status != 5}">
						<a href="${ctx}/school/class/form?id=${schoolClass.id}">${schoolClass.className}</a>
					</c:if>--%>
				</td>
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
						${0 == schoolClass.classRealNum ? '':schoolClass.classRealNum}
						${0 == schoolClass.classRealNum ? '':'/'}
						${0 == schoolClass.classRealNum ? '':schoolClass.classMaxNum}
				</td>
				<td>
						<fmt:formatNumber type="number" value="${schoolClass.classRealNum*100/schoolClass.classMaxNum}" maxFractionDigits="0"/>%
						<%--${empty schoolClass.classRealNum ? ' ':Integer(Math.rint(schoolClass.classRealNum*100/schoolClass.classMinNum))}
						${empty schoolClass.classRealNum ? ' ':'%'}--%>
				</td>
				<td>
						<fmt:formatDate value="${schoolClass.planBeginTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
						<fmt:formatDate value="${schoolClass.createTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
						${schoolClass.status==5 ? "待开班":"删除"}
				</td>
				<td>
					<shiro:hasPermission name="school:classPlan:info"><a href="${ctx}/school/classPlan/info?id=${schoolClass.id}">详情</a></shiro:hasPermission>
					<c:if test="${schoolClass.status == 5}">
						<shiro:hasPermission name="school:classPlan:form"><a href="${ctx}/school/classPlan/form?id=${schoolClass.id}">修改</a></shiro:hasPermission>
					</c:if>
					<c:if test="${schoolClass.status == 5}">
						<c:if test="${0 != schoolClass.classRealNum}">
							<c:if test="${schoolClass.headteacher.id != null || schoolClass.schoolClassToLesson.schoolClassLesson.id != null}">
								<shiro:hasPermission name="school:classPlan:updateStatus">
									<a href="${ctx}/school/classPlan/updateStatus?id=${schoolClass.id}"
										onclick="return confirmx('确认该班级开班吗？', this.href)">开班
									</a>
								</shiro:hasPermission>
							</c:if>
						</c:if>
						<c:if test="${0 == schoolClass.classRealNum && schoolClass.headteacher.id != null && schoolClass.schoolClassToLesson.schoolClassLesson.id != null}">
							<a href="javascript:;"
								onclick="return confirmx('无班级学员,不可执行开班操作！', this.href)">开班
							</a>
						</c:if>
						<c:if test="${0 != schoolClass.classRealNum && (schoolClass.headteacher.id == null || schoolClass.schoolClassToLesson.schoolClassLesson.id == null)}">
							<a href="javascript:;"
							   onclick="return confirmx('请先设置班级信息,再执行开班操作！', this.href)">开班
							</a>
						</c:if>
					</c:if>


					<%--<c:if test="${schoolClass.status != 1 && schoolClass.status == 5}">
						<c:if test="${schoolClass.headteacher.id == null || schoolClass.schoolClassToLesson.schoolClassLesson.id == null}">
							<shiro:hasPermission name="school:classPlan:classInstall">
								<a href="${ctx}/school/classPlan/classInstall?id=${schoolClass.id}">班级设置</a>
							</shiro:hasPermission>
						</c:if>
					</c:if>--%>

					<shiro:hasPermission name="school:classPlan:classInstall">
						<a href="${ctx}/school/classPlan/classInstall?id=${schoolClass.id}">班级设置</a>
					</shiro:hasPermission>

					<shiro:hasPermission name="school:classPlan:classStudentInfo">
						<a href="${ctx}/school/classPlan/classStudentInfo?id=${schoolClass.id}">学员转班</a>
					</shiro:hasPermission>

					<shiro:hasPermission name="school:classPlan:classStudentReturn">
					<a href="${ctx}/school/classPlan/classStudentInfo?id=${schoolClass.id}">学员退班</a>
					</shiro:hasPermission>

					<c:if test="${schoolClass.status != 1 && schoolClass.status == 5}">
						<c:if test="${0 == schoolClass.classRealNum}">
							<shiro:hasPermission name="school:classPlan:delete"><a href="${ctx}/school/classPlan/delete?id=${schoolClass.id}"
									onclick="return confirmx('确认要删除该班级吗？', this.href)">删除
							</a></shiro:hasPermission>
						</c:if>
						<c:if test="${0 != schoolClass.classRealNum}">
								<a href="javascript:;"
									onclick="return confirmx('请确认该班级学员退班完成！', this.href)">删除
							</a>
						</c:if>
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
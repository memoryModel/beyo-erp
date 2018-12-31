<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/head.jsp"%>

<html>
<head>
	<title>学员报名管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<c:if test="${tagFlag != 0}">
	<ul class="nav nav-tabs">
			<li class="active"><a href="${ctx}/erp/studentApply/selectStudentApply">班级列表</a></li>
	</ul>
	</c:if>

<form:form id="searchForm" modelAttribute="schoolClass" action="${ctx}/erp/studentApply/selectStudentApply" method="post" class="breadcrumb form-search">
	<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	<input id="studentId" name="studentId" type="hidden" value="${studentId}"/>
	<input id="employeeId" name="employeeId" type="hidden" value="${employeeId}"/>
	<input id="classJson" name="classJson" type="hidden" value="${classJson}"/>
	<input id="tagFlag" name="tagFlag" type="hidden" value="${tagFlag}"/>
	<ul class="ul-form">
		<li><label>班级名称：</label>
			<form:input path="className" htmlEscape="false" maxlength="20" class="input-medium"/>
		</li>
		<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
		<li class="clearfix"></li>
	</ul>
</form:form>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
	<thead>
	<tr>
		<c:if test="${tagFlag!=0}"><th>选择</th></c:if>
		<th>班级名称</th>
		<th>学费</th>
		<th>班主任</th>
		<th>预计招收学员</th>
		<th>当前报名学员</th>
		<th>最大招收学员</th>
		<th>计划开班日期</th>
		<th>计划结业日期</th>
		<c:if test="${tagFlag==0}"><th>操作</th></c:if>
	</tr>
	</thead>
	<tbody>
	<c:forEach items="${page.list}" var="schoolClass">
		<tr>
			<c:if test="${tagFlag!=0}">
				<td>
					<input type="checkbox" id="checkbox${schoolClass.id}" onclick="selectClass(
							'${schoolClass.id}','${schoolClass.className}',
							'${schoolClass.schoolClassToLesson.schoolClassLesson.lessonName}','${schoolClass.tuitionAmount}',
							'${schoolClass.headteacher.name}','${schoolClass.classRealNum}','${schoolClass.classMinNum}',
							'${schoolClass.classMaxNum}','${schoolClass.planBeginTime}','${schoolClass.planEndTime}',
							'${schoolClass.headteacher.id}','${schoolClass.prepaidAmount}',
							'${schoolClass.miscellaneousAmount}')"/>
				</td>
			</c:if>
			<td>
					${schoolClass.className}
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
					${schoolClass.classMinNum}  <!--预计招收学员-->
			</td>
			<td>
					${schoolClass.classRealNum}  <!--当前报名学员-->
			</td>
			<td>
					${schoolClass.classMaxNum}  <!--最大招收学员-->
			</td>
			<td>
					<fmt:formatDate value="${schoolClass.planBeginTime}" pattern="yyyy-MM-dd"/><!--计划开班日期-->
			</td>
			<td>
				    <fmt:formatDate value="${schoolClass.planEndTime}" pattern="yyyy-MM-dd"/><!--计划结业日期-->
			</td>
			<c:if test="${tagFlag==0}">
				<td>
					<a id="btnSelect" class="btn btn-primary" onclick="selectClass(
							'${schoolClass.id}','${schoolClass.className}',
							'${schoolClass.schoolClassToLesson.schoolClassLesson.lessonName}','${schoolClass.tuitionAmount}',
							'${schoolClass.headteacher.name}','${schoolClass.classRealNum}','${schoolClass.classMinNum}',
							'${schoolClass.classMaxNum}','${schoolClass.planBeginTime}','${schoolClass.planEndTime}',
							'${schoolClass.headteacher.id}','${schoolClass.prepaidAmount}',
							'${schoolClass.miscellaneousAmount}')"
					   href="javascript:; ">选择</a>
				</td>
			</c:if>
		</tr>
	</c:forEach>
	</tbody>
	<div class="pagination">${page}</div>
</table>
	<script type="text/javascript">

        var classJson = "${classJson}";
        var classDataArray = JSON.parse(decodeURIComponent(classJson));
        for(var i=0;i<classDataArray.length;i++) {
            var obj = classDataArray[i];
            var classId = obj.classId;
            var key = classId;
            classDataArray[i].key = key;
        }

        $(document).ready(function() {
            //旧数据
            for(var k=0;k<classDataArray.length;k++) {
                var obj = classDataArray[k];
                console.log(obj);
                $("#checkbox"+obj.key).attr("checked",true);
            }
        });
        function page(n,s){
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").submit();
            return false;
        }

        function selectClass(classId,className,lessonName,tuitionAmount,name,classRealNum,classMinNum,classMaxNum,planBeginTime,planEndTime,emplyoeeId,prepaidAmount,miscellaneousAmount){

            var chked = $("#checkbox"+classId).attr("checked");
            if(${tagFlag==0}) {
                top.$.jBox.confirm('确认要选择该班级吗？', '系统提示', function (v, h, f) {
                    if (v == 'ok') {
                        parent.window.frames["mainFrame"].selectclassCallback(classId, className, lessonName, tuitionAmount, name,
                            classRealNum, classMinNum, classMaxNum, planBeginTime,
                            planEndTime, emplyoeeId, prepaidAmount, miscellaneousAmount, chked);
                        top.$.jBox.close(true);
                    }
                }, {
                    buttonsFocus: 1, closed: function () {
                        if (typeof closed == 'function') {
                            closed();
                        }
                    }
                });
            }
            if(${tagFlag!=0}){
                parent.window.frames["mainFrame"].selectclassCallback(classId,className,lessonName,tuitionAmount,name,
                    classRealNum,classMinNum,classMaxNum,planBeginTime,
                    planEndTime,emplyoeeId,prepaidAmount,miscellaneousAmount,chked);
            }
            //close
        }
	</script>
</body>
</html>
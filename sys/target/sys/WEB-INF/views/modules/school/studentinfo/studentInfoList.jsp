<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>单表管理</title>
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

        function selectDelegatesCallback(){
            window.location.reload(true);
        }

        function selByLearningTeacherId(id){
            $.ajax({
                url:"${ctx}/studentenroll/erpStudentInfo/selByLearningTeacherId",
                data:{"learningTeacher.id":id},
                async:false,
                dataType:"json",
                success:function (data) {
                    $("input[name='empid']").each(function(){
                        this.checked=false;

                    });
                    for(var i=0;i<data.length;i++){

                        $("input[name='empid']").each(function(){

                            if($(this).val()==data[i])
                            {
                                this.checked=true;
                            }
                        });
                    }
                },
                error:function(){

                }
            })


        }



	</script>
</head>
<body>
<ul class="nav nav-tabs">
	<li class="active"><a href="${ctx}/school/studentInfo/list">学员信息管理</a></li>
</ul>
<form:form id="searchForm" modelAttribute="student" action="${ctx}/school/studentInfo/list" method="post" class="breadcrumb form-search">
	<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	<ul class="ul-form">

		<li><label>姓名：</label>
			<form:input path="name" htmlEscape="false" maxlength="20" class="input-medium"/>
		</li>
        <li><label>班级：</label>
			<form:input path="schoolClassStudents.schoolClass.className" htmlEscape="false" maxlength="20" class="input-medium"/>
        </li>
		<li><label>学管师：</label>
			<form:input path="learningTeacher.name" htmlEscape="false" maxlength="20" class="input-medium"/>
		 </li>
		<li><label>学号：</label>
			<form:input path="studentNumber" htmlEscape="false" maxlength="20" class="input-medium"/>
		</li>
		<br/><br/>


		<li><label>性别：</label>
			<form:select path="sex" class="input-large " style="width:180px;">
				<form:option value="">请选择</form:option>
				<form:options items="${erp:sexStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
			</form:select>
		</li>

		 <li><label>状态：</label>
				 <form:select path="status" class="input-large " style="width:180px;">
					 <form:option value="">请选择</form:option>
					 <form:options items="${erp:studentStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				 </form:select>
		 </li>

		<li><label>报名时间：</label>
			<input name="schoolClassStudents.applyTimeStart" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
				   value="<fmt:formatDate value="${student.schoolClassStudents.applyTimeStart}" pattern="yyyy-MM-dd"/>"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>-
			<input name="schoolClassStudents.applyTimeEnd" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
				   value="<fmt:formatDate value="${student.schoolClassStudents.applyTimeEnd}" pattern="yyyy-MM-dd"/>"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
		</li>
		 <li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" style="width:100px;"/></li>
		 <li class="clearfix"></li>
     </ul>
</form:form>


<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
	<thead>
	<tr>
		<th>姓名</th>
		<th>性别</th>
		<th>学号</th>
		<th>手机号</th>
		<th>身份证号</th>
		<th>出生日期</th>
		<th>报名时间</th>
		<th>学管师</th>
		<th>学员状态</th>
		<th>操作</th>
	</tr>
	</thead>
	<tbody>
	<c:forEach items="${page.list}" var="student">
		<tr createUser="${student.createUser}" id="${student.id}">
			<td>
				<a name="studentView" studentId="${student.id}"  studentName="${student.name}" href="javascript:;" >${student.name}</a>
			</td>
			<td>
					${erp:sexStatusName(student.sex)}
			</td>
			<td>
					${student.studentNumber}
			</td>

			<td>
					${student.phone}
			</td>
			<td>
					${student.stuNumber}
			</td>
			<td>
				<fmt:formatDate value="${student.dateBirth}" pattern="yyyy-MM-dd "/>
			</td>
			<td>
				<fmt:formatDate value="${student.schoolClassStudents.applyTime}" pattern="yyyy-MM-dd "/>
			</td>
			<td>
					${student.learningTeacher.name}
			</td>
			<td>
					${erp:studentStatusName(student.studentStatus)}
			</td>
			<td>
				<c:if test="${student.status == 2}">
					<shiro:hasPermission name="school:studentInfo:form"><a href="${ctx}/school/studentInfo/form?id=${student.id}">修改</a></shiro:hasPermission>
					<shiro:hasPermission name="school:studentInfo:info"><a href="${ctx}/school/studentInfo/info?id=${student.id}">转班</a></shiro:hasPermission>
					<shiro:hasPermission name="school:communication:form"><a href="${ctx}/school/communication/form?erpStudentEnrollId=${student.id}">沟通记录</a></shiro:hasPermission>
				</c:if>
				<c:if test="${student.learningTeacher == null}">
					<shiro:hasPermission name="school:studentInfo:studentInfoList"><a name="studentForm" studentId="${student.id}" href="javascript:;">指派学管师</a></shiro:hasPermission>
				</c:if>
				<c:if test="${student.learningTeacher != null}">
					<shiro:hasPermission name="school:studentInfo:studentInfoList"><a name="studentForm" studentId="${student.id}" href="javascript:;">重新指派</a></shiro:hasPermission>
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
            top.$.jBox("iframe:/school/studentInfo/studentInfoList?id="+studentId, {
                title:"指定学管师",
                width:500,
                height:550,
                buttons:{}
            });
        });
    });

    $(document).find("a[name='studentView']").each(function () {
        var studentId = $(this).attr("studentId");
        var studentName = $(this).attr("studentName");
        $(this).click(function () {
            top.$.jBox("iframe:/school/studentInfo/studentDetails?id="+studentId,{
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
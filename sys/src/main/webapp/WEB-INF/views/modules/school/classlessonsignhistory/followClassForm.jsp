<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>课表管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">

        var studentArray = new Array();
        var studentTableTemplate;
        $(document).ready(function() {
            var lessonId = $("#lessonId").val();
            studentTableTemplate = $("#studentTableTemplate").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
            $("#selectLesson,#selectLessonHref").click(function () {
                top.$.jBox("iframe:/school/class/selectLesson?btnFlag=1", {
                    title:"选择课程",
                    width:1024,
                    height:520,
                    buttons:{}
                });
            });
            if(lessonId != null && lessonId !=''){
                selectClass(lessonId);
            }


            //点击添加学员
            $("#selectStudent,#selectStudentHref").click(function () {
                var lessonId = $("#lessonId").val();
                if (lessonId == ""){
                    $("#lessonId").focus();
                    //return;
                }
                var str = $("#classStudentJson").val();

                top.$.jBox("iframe:/school/classLessonSignHistory/selectEnroll", {
                    title:"选择学员",
                    width:1024,
                    height:520,
                    buttons:{},
                    ajaxData:{"classStudentJson":encodeURIComponent(str),
                        "lessonId":lessonId},
                    closed:function () {
                        showStudents()
                    }
                });
            });

        });
        function page(n,s){
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").submit();
            return false;
        }

        function selectClass(lessonId){

            $("#selectClass").empty();
            $("#selectClass").append("<option value = ''>"+ "请选择" + "</option>");
            $.ajax({
                type : 'post',
                url : '${ctx}/school/classLessonSignHistory/selectClass',
                data : {"lessonId":lessonId},
                success : function(data){
                    classList = data.classList;
                    var json =  JSON.stringify(classList);
                    var obj = eval('(' + json + ')');
                    //console.log("classList:"+obj);
                    $.each(obj, function(idx, objj) {
                        //console.log(objj.schoolClass.className);

                        $("#selectClass").append('<option value="' + objj.schoolClass.id + '">' + objj.schoolClass.className + '</option>');
                    });
                    $("#selectClass option:first").prop("selected", 'selected');
                }
            })
        }

        function pushStudentArray(key,studentId,studentName){
            studentArray.push({
                "key":key,
                "studentId":studentId,
                "studentName":studentName
            });
        }

        function appendTable(){
            $("#studentTable").empty();
            $("#studentTable").append(Mustache.render(studentTableTemplate, {"studentArray":studentArray}));
            $("#studentJson").val(JSON.stringify(studentArray));
        }

        function classSchedule(scheduleId,classId,className,lessonName,name,beginTime,endTime){
            top.$.jBox.confirm('确认要选择该班级吗？','系统提示',function(v,h,f) {

                if (v == 'ok') {
                    $("#scheduleId").html(scheduleId);
                    $("#classId").html(classId);
                    $("#className").html(className);
                    $("#lesson").html(lessonName);
                    $("#teacher").html(name);
                    $("#beginTime").html(beginTime+"~"+endTime);

                    top.$.jBox.close(true);
                }
            },{buttonsFocus:1, closed:function(){
                if (typeof closed == 'function') {
                    closed();
                }
            }});
        }

        function saveFollowClass(){

            var scheduleId = $('#scheduleId').text();
            var classId = $('#classId').text();
            $.ajax({
                type: 'post',
                url : '${ctx}/school/classLessonSignHistory/saveFollowClass',
                data: {"studentJson":encodeURIComponent(JSON.stringify(studentArray)),"scheduleId":scheduleId,"classId":classId},
                success : function(data) {
                    if (data && data.result == "success") {
                        location.href = '${ctx}/school/classLessonSignHistory/list/';
                    } else {
                        window.location.reload();
                    }
                }
            })
        }

        //选择课程回调函数
        function selectLessonCallback(lessonId,lessonName,teacherId,teacherName,lessonTypeId,lessonTypeName,subjectId,subjectName,chked) {
            $("#selectLesson").val(lessonName);
            $("input[name='schoolClassLesson.id']").val(lessonId);
            selectClass(lessonId);
        }


        function selectStudentCallback(classId,className,studentId,studentName,studentNumber,chked){

            for(var i=0;i<studentArray.length;i++){
                if (studentId == studentArray[i].studentId){
                    if (chked){
                        return;
                    }else{
                        studentArray.remove(i);
                        return;
                    }
                }
            }

            studentArray.push({
                "classId":classId,
                "className":className,
                "studentId":studentId,
                "studentName":studentName,
                "studentNumber":studentNumber
            });
        }


        function showStudents(){
            $("#studentTable").empty();
            $("#studentTable").append(Mustache.render(studentTableTemplate, {"studentArray":studentArray}));
            $("#classStudentJson").val(JSON.stringify(studentArray));

            if (studentArray.length>0){
                $("#selectStudent").val("共"+studentArray.length+"名学员");
            }else{
                $("#selectStudent").val("");
            }
        }

        function removeClassStudents(studentId){

            for(var i=0;i<studentArray.length;i++){
                if (studentId == studentArray[i].studentId){
                    studentArray.remove(i);
                    break;
                }
            }
            showStudents();
        }
	</script>
</head>
<body>
<ul class="nav nav-tabs">
	<li><a href="${ctx}/school/classLessonSignHistory/list">补课管理列表</a></li>
	<li><a href="${ctx}/school/classLessonSignHistory/classNew">新开班补课</a></li>
	<li class="active"><a href="${ctx}/school/classLessonSignHistory/followClass">跟班补课</a></li>
</ul>

<form:form id="searchForm" modelAttribute="classSchedule" action="${ctx}/school/classLessonSignHistory/followClass" method="post" class="breadcrumb form-search">
	<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	<input type="hidden" name="studentJson" id="studentJson" style="width:1230px;"/>

	<ul class="ul-form">
		<li><label>课程：</label>
			<input id="lessonId" type="hidden" name="schoolClassLesson.id" value="${classSchedule.schoolClassLesson.id}">
			<input id="selectLesson" name="schoolClassLesson.lessonName" type="text" readonly="readonly" class="required" value="${classSchedule.schoolClassLesson.lessonName}"/>
			<a id="selectLessonHref" href="javascript:" class="btn">&nbsp;
				<i class="icon-search"></i>&nbsp;
			</a>
		</li>

		<li><label>班级：</label>
			<form:select path="schoolClass.id" id="selectClass"  style="width: 210px"  class="input-medium">

				<form:option value="">请选择</form:option>

			</form:select>
		</li>
		<li class="clearfix"></li>
		<li><label>上课时间：</label>
			<input name="beginTime" type="text" maxlength="20" class="input-medium Wdate" readonly="readonly"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>-
			<input name="endTime" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>
		</li>
		<li><label>创建时间：</label>
			<input name="createTimeStart" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>-
			<input name="createTimeEnd" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
		</li>
		<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
		<li class="clearfix"></li>
	</ul>

	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
		<tr>
			<th>班级</th>
			<th>课程</th>
			<th>授课老师</th>
			<th>上课时间</th>
			<th>上课时长</th>
			<th>教室</th>
			<th>创建时间</th>
			<th>状态</th>
			<th>操作</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="schoolClassSchedule">
			<tr createUser="${schoolClassSchedule.createUser}" id="${schoolClassSchedule.id}">
				<td>
						${schoolClassSchedule.schoolClass.className}
				</td>
				<td>
						${schoolClassSchedule.schoolClassLesson.lessonName}
				</td>
				<td>
						${schoolClassSchedule.teacher.name}
				</td>
				<td>
					<fmt:formatDate value="${schoolClassSchedule.beginTime}" pattern="yyyy-MM-dd HH:mm"/> ~~
					<fmt:formatDate value="${schoolClassSchedule.endTime}" pattern="HH:mm"/>
				</td>
				<td>
					<fmt:formatNumber value="${(schoolClassSchedule.endTime.getTime()-schoolClassSchedule.beginTime.getTime())/1000/60}" pattern="#0"/>分钟
				</td>
				<td>
						${schoolClassSchedule.schoolClassroom.classroomName}
				</td>
				<td>
					<fmt:formatDate value="${schoolClassSchedule.createTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
						${erp:lessonSignName(schoolClassSchedule.status)}
				</td>
				<td>
					<a id="btnSelect" onclick="classSchedule('${schoolClassSchedule.id}','${schoolClassSchedule.schoolClass.id}','${schoolClassSchedule.schoolClass.className}',
							'${schoolClassSchedule.schoolClassLesson.lessonName}','${schoolClassSchedule.teacher.name}'
							,'<fmt:formatDate value="${schoolClassSchedule.beginTime}" pattern="yyyy-MM-dd HH:mm"/>'
							,'<fmt:formatDate value="${schoolClassSchedule.endTime}" pattern="HH:mm"/>')"
					   href="javascript:; " class="btn btn-primary">选择班级</a>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</form:form>

<div class="control-group">
	补课学员：<input id="selectStudent" type="text" readonly="readonly" class="required"  value=""/>
	<a id="selectStudentHref" href="javascript:" class="btn" >&nbsp;
		<i class="icon-search"></i>&nbsp;
	</a>

	<span class="help-inline">
				<font color="red">*</font>
			</span>

</div>

<div class="control-group">
	<label class="control-label">补课学员：</label>
	<div class="controls">
		<table id="contentTables" style="width: 70%" class="table table-striped table-bordered table-condensed">
			<thead>
			<tr>
				<th>学生编号</th>
				<th>学生名称</th>
				<th>班级名称</th>
				<th>操作</th>
			</tr>
			</thead>
			<tbody id="studentTable">
			<script type="text/template" id="studentTableTemplate">
				{{#studentArray}}
				<tr>
					<td>{{studentNumber}}<input type="hidden" name="classId" value="{{classId}}"></td>
					<td>{{studentName}}<input type="hidden" name="studentId" value="{{studentId}}"></td>
					<td>{{className}}</td>
					<td>
						<input id="removeClassStudents{{studentId}}" class="btn btn-danger" type="button" value="删 除" onclick="removeClassStudents('{{studentId}}')"/>
					</td>
				</tr>
				{{/studentArray}}
			</script>
			</tbody>
		</table>
	</div>
</div>




<div class="control-group">
	<label class="control-label"><b>已选择</b></label>
</div>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
	<thead>
	<tr>
		<th>班级名称</th>
		<th>课程</th>
		<th>授课老师</th>
		<th>上课时间</th>
	</tr>
	</thead>
	<tbody id="scheduleTable">
	<tr>
		<input type="hidden" id="scheduleId">
		<input type="hidden" id="classId">
		<td id="className"></td>
		<td id="lesson"></td>
		<td id="teacher"></td>
		<td id="beginTime"></td>
	</tr>
	</tbody>

</table>
<div class="form-actions" style="text-align: center">
	<shiro:hasPermission name="school:classLessonSignHistory:saveFollowClass"><input id="btnSubmits" class="btn btn-primary" onclick="saveFollowClass()" type="button"  value="保 存"/>&nbsp;</shiro:hasPermission>
	<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
</div>
<script src="${ctxStatic}/officeNames/officeNames.js" type="text/javascript"></script>
</body>
</html>
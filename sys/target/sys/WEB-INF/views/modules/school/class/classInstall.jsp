<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
<html>
<head>
	<title>班级设置</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">

        //全局参数
        var classLessonList = ${fns:toJson(lessonList)};  //scheduleList后台查询已有课程信息

        var lessonTableTemplate;
        var lessonArray = new Array();
        $(document).ready(function() {
            lessonTableTemplate = $("#lessonTableTemplate").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");


            //$("#name").focus();
            //alert("classId:"+$("#id").val());
            $("#inputForm").validate({
                submitHandler: function(form){
                    loading('正在提交，请稍等...');
                    form.submit();
                },
                errorContainer: "#messageBox",
                errorPlacement: function(error, element) {
                    $("#messageBox").text("输入有误，请先更正。");
                    if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
                        error.appendTo(element.parent().parent());
                    } else {
                        error.insertAfter(element);
                    }
                }
            });

            //返回主页面
            $("#btnCancel").click(function () {
                window.location.href="${ctx}/school/class/list";
            });


            //点击添加课程
            $("#selectLesson").click(function () {
                var str = $("#lessonJson").val();
                var btnFlag = 0;  //按钮标记  0：按钮隐藏  1：按钮展示
                //console.log(str);
                top.$.jBox.open("iframe:/school/class/selectLesson",
                    "选择课程",
                    1024,
                    520,
                    {ajaxData:{"lessonJson":encodeURIComponent(str),"classId":$("#id").val(),"btnFlag":btnFlag}}

                );
            });

            appendTable();

        });




        //lessonArray追加数据
        function pushlessonArray(key,lessonId,lessonName,teacherName,lessonTypeName){
            lessonArray.push({
                "key":key,
                "lessonId":lessonId,
                "lessonName":lessonName,
				/*"teacherId":teacherId,*/
                "teacherName":teacherName,
				/*"lessonTypeId":lessonTypeId,*/
                "lessonTypeName":lessonTypeName,
				/*"subjectId":subjectId,
				 "subjectName":subjectName,*/

                "classId":$("#id").val()
            });
        }

        //读取后台传递的已有课程列表
        for(var i=0;i<classLessonList.length;i++){
            var obj = classLessonList[i];
            var lessonId = obj.schoolClassLesson.id;
            var lessonName = obj.schoolClassLesson.lessonName;
            var teacherName = obj.schoolClassLesson.teacherNames;
            //var teacherId = obj.schoolClassLesson.teacher.id;
            //var lessonTypeId = obj.schoolClassLesson.schoolLessonType.id;
            var lessonTypeName = obj.commonsType.commonsName;
            //var subjectId = obj.schoolClassLesson.schoolSubject.id;
            //var subjectName = obj.schoolClassLesson.schoolSubject.subjectName;

            var key = lessonId+lessonName;
            //console.log("lessonTypeId:"+lessonTypeId+"lessonTypeName:"+lessonTypeName);

            pushlessonArray(key,lessonId,lessonName,/*teacherId,*/teacherName,lessonTypeName/*subjectId,subjectName*/);

        }

        function appendTable(){
            $("#lessonTable").empty();
            $("#lessonTable").append(Mustache.render(lessonTableTemplate, {"lessonArray":lessonArray}));
            $("#lessonJson").val(JSON.stringify(lessonArray));
        }

        function selectLessonCallback(lessonId,lessonName,teacherId,teacherName,lessonTypeName,chked) {

            var key = lessonId + lessonName;
            $("#lessonId").val(lessonId);
            $("#lessonName").val(lessonName);

            for (var i = 0; i < lessonArray.length; i++) {
                if (key == lessonArray[i].key) {
                    if (chked) {
                        return;
                    } else {
                        lessonArray.remove(i);
                        appendTable();
                        return;
                    }
                }
            }

            pushlessonArray(key, lessonId, lessonName/*, teacherId*/, teacherName, lessonTypeName,chked/*, subjectId, subjectName*/);
            appendTable();

        }



        //移除元素
        Array.prototype.remove=function(dx){
            if(isNaN(dx)||dx>this.length){return false;}
            for(var i=0,n=0;i<this.length;i++)
            {
                if(this[i]!=this[dx])
                {
                    this[n++]=this[i]
                }
            }
            this.length-=1
        };


        //提交from表单
        function submitSave() {

            $.ajax({
                type : 'post',
                url : '${ctx}/school/classPlan/saveClassAndLessonList',
                data:{"lessonJson":encodeURIComponent(JSON.stringify(lessonArray)),"classId":$("#id").val(),"headteacherId":$("#headteacherId").val(),"instructorId":$("#instructorId").val(),"managerId":$("#managerId").val(),"supervisorId":$("#supervisorId").val()},
                success : function(data) {
                    if (data && data.result == "success") {
                        location.href = '${ctx}/school/class/list/';
                    } else {
                        window.location.reload();
                    }
                }
            })

        }


	</script>
</head>
<body>
<c:if test="${tagFlag != 1}">
	<div>
		<ul class="nav nav-tabs">
			<li><a href="${ctx}/school/class/list">班级列表</a></li>
			<c:if test="${tagFlag != 2}">
				<li class="active"><a href="${ctx}/school/class/info?id=${schoolClass.id}">班级详情</a></li>
			</c:if>
			<c:if test="${tagFlag == 2}">
				<li class="active"><a href="${ctx}/school/class/form?id=${schoolClass.id}">班级
					<shiro:hasPermission name="school:class:form">${not empty schoolClass.id?'修改':'添加'}</shiro:hasPermission>
					<shiro:lacksPermission name="school:class:form">查看</shiro:lacksPermission></a>
				</li>
			</c:if>
		</ul>
	</div><br/>
</c:if>
<c:if test="${tagFlag != 2}">
	<div>
		<ul class="nav nav-tabs">
			<li><a href="${ctx}/school/class/info?id=${schoolClass.id}&&tagFlag=${tagFlag}">基本信息</a></li>
			<li><a href="${ctx}/school/class/studentInfo?id=${schoolClass.id}&&tagFlag=${tagFlag}">学员信息</a></li>
			<li><a href="${ctx}/school/class/lessonInfo?id=${schoolClass.id}&&tagFlag=${tagFlag}">上课信息</a></li>
			<li class="active"><a href="${ctx}/school/class/classInstall?id=${schoolClass.id}&&tagFlag=${tagFlag}">班级设置</a></li>
		</ul>
	</div>
</c:if>
<c:if test="${tagFlag == 2}">
	<div>
		<ul class="nav nav-tabs">
			<li><a href="/school/class/form?id=${schoolClass.id}">基本信息</a></li>
			<li class="active"><a href="${ctx}/school/class/classInstall?id=${schoolClass.id}&&tagFlag=2">班级设置</a></li>
		</ul>
	</div>
</c:if>

<br/>

<form:form id="inputForm" modelAttribute="schoolClass" method="post" class="form-horizontal">
	<form:hidden path="id"/>
	<input type="hidden" name="lessonJson" id="lessonJson" style="width:1230px;"/>
	<sys:message content="${message}"/>

	<div class="control-group">
		<label class="control-label">班主任：</label>
		<div class="controls">
			<sys:treeselect id="headteacher" name="headteacher.id" value="${schoolClass.headteacher.id}"
							labelName="schoolClass.headteacher.name" labelValue="${schoolClass.headteacher.name}"
							title="选择用户" url="/sys/office/treeData?type=3" allowClear="true" notAllowSelectParent="true" cssClass="required"/>

			<span class="help-inline"><font color="red">*</font> </span>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">副班主任：</label>
		<div class="controls">
			<sys:treeselect id="instructor" name="instructor.id" value="${schoolClass.instructor.id}"
							labelName="schoolClass.instructor.name" labelValue="${schoolClass.instructor.name}"
							title="选择用户" url="/sys/office/treeData?type=3" allowClear="true" notAllowSelectParent="true"/>
		</div>
	</div>

	<%--<div class="control-group">
        <label class="control-label">管理老师：</label>
        <div class="controls">
            <sys:treeselect id="manager" name="manager.id" value="${schoolClass.manager.id}"
                            labelName="schoolClass.manager.name" labelValue="${schoolClass.manager.name}"
                            title="选择用户" url="/sys/office/treeData?type=3" allowClear="true" notAllowSelectParent="true" cssClass="required"/>
            <span class="help-inline"><font color="red">*</font> </span>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">督导老师：</label>
        <div class="controls">
            <sys:treeselect id="supervisor" name="supervisor.id" value="${schoolClass.supervisor.id}"
                            labelName="schoolClass.manager.name" labelValue="${schoolClass.supervisor.name}"
                            title="选择用户" url="/sys/office/treeData?type=3" allowClear="true" notAllowSelectParent="true" cssClass="required"/>
            <span class="help-inline"><font color="red">*</font> </span>
        </div>
    </div>--%>

	<div class="control-group" hidden="hidden">
		<label class="control-label">原课程：</label>
		<div class="controls">
			//<input  name="oldlessonId" id="oldlessonId" value="${schoolClass.schoolClassToLesson.schoolClassLesson.id}">
			<input type="text"  name="oldlessonName" id="oldlessonName" value="${schoolClass.schoolClassToLesson.schoolLessonType}"
				   style="width:392px;" readonly=readonly/>
		</div>
	</div>

	<div class="control-group">
		<label class="control-label">课程名称：</label>
		<div class="controls">
			<input type="hidden" name="schoolClassToLesson.schoolClassLesson.id" id="lessonId" value="${schoolClass.schoolClassToLesson.schoolClassLesson.id}">
			<input type="hidden"  name="schoolClassToLesson.schoolClassLesson.lessonName" id="lessonName" value="${schoolClass.schoolClassToLesson.schoolClassLesson.lessonName}"
				   style="width:392px;" placeholder="点击选择添加课程" readonly=readonly/>&nbsp;&nbsp;
			<c:if test="${tagFlag!=1}">
				<input id="selectLesson" class="btn btn-primary" type="button" value="选择课程"/>
			</c:if>
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
	</div><br/>

	<table id="contentTable" class="table table-striped table-bordered table-condensed" style="width: 75%;">
		<thead>
		<tr>
				<%--<th>LessonId</th>--%>
			<th>课程名称</th>
			<th>授课老师</th>
				<%--<th>科目</th>--%>
			<th>类型</th>
			<th>操作</th>
		</tr>
		</thead>
		<tbody id="lessonTable">
		<script type="text/template" id="lessonTableTemplate">
			{{#lessonArray}}
			<tr>
					<%--<td>{{lessonId}}</td>--%>
				<td>{{lessonName}}</td>
				<td>{{teacherName}}</td>
					<%--<td>{{subjectName}}</td>--%>
				<td>{{lessonTypeName}}</td>
				<td>
					<input id="removeLessons{{lessonId}}" class="btn btn-primary" type="button" value="删 除" onclick="removeLessons('{{lessonId}}')"/>
				</td>
			</tr>
			{{/lessonArray}}
		</script>
		</tbody>

	</table>


	<div class="form-actions">
		<c:if test="${tagFlag !=1 && schoolClass.status !=4 }">
			<shiro:hasPermission name="school:classPlan:saveClassAndLessonList">
				<button type="button" class="btn btn-primary" onclick="submitSave()">保存</button>&nbsp;
			</shiro:hasPermission>
		</c:if>
		<input id="btnCancel" class="btn" type="button" value="返 回"/>
	</div>
</form:form>
<script type="text/javascript">
    function removeLessons(lessonId){
        for(var i=0;i<lessonArray.length;i++){
            if (lessonId == lessonArray[i].lessonId){
                lessonArray.remove(i);
                appendTable();
                return;
            }
        }
        //appendTable();
    }
</script>
</body>
</html>
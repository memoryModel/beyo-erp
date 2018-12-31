<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
<html>
<head>
	<title>班级设置</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
        function validform() {
            return $("#inputForm").validate();
        }

        //全局参数
        var classLessonList = ${fns:toJson(lessonList)};  //scheduleList后台查询已有课程信息

        var lessonTableTemplate;
        var lessonArray = new Array();
        $(document).ready(function() {
            $(validform());

            $("#submit").click(function () {
                //if(lessonValidate())
                var lv = lessonValidate();
                var hv = headteacherValidate();
                //var iv = instructorValidate();
                //var mv = managerValidate();
                //var sv = supervisorValidate();
                if(lv && hv && validform().form()){
                    submitSave();
                }else{
                    return;
                }
            });

            //返回主页面
            $("#btnCancel").click(function () {
                window.location.href="${ctx}/school/classPlan/list";
            });

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



            //点击添加课程
            $("#selectLesson").click(function () {
                //if(!headteacherValidate()) return;
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
        function pushlessonArray(key,lessonId,lessonName,teacherId,teacherName,/*lessonTypeId,*/lessonTypeName){
            lessonArray.push({
                "key":key,
                "lessonId":lessonId,
                "lessonName":lessonName,
                "teacherId":teacherId,
                "teacherName":teacherName,
				/*"lessonTypeId":lessonTypeId,*/
                "lessonTypeName":lessonTypeName,
                "classId":$("#id").val()
            });
        }

        //读取后台传递的已有课程列表
        for(var i=0;i<classLessonList.length;i++){
            var obj = classLessonList[i];
            var lessonId = obj.schoolClassLesson.id;
            var lessonName = obj.schoolClassLesson.lessonName;
            //var teacherName = obj.schoolClassLesson.teacher.name;
            var teacherName = obj.schoolClassLesson.teacherNames;
            //var teacherId = obj.schoolClassLesson.teacher.id;
            var teacherId = obj.schoolClassLesson.teacherIds;
            //var lessonTypeId = obj.schoolClassLesson.schoolLessonType.id;
            var lessonTypeName = obj.schoolClassLesson.schoolLessonType;

            var key = lessonId+lessonName;
            //console.log("lessonTypeId:"+lessonTypeId+"lessonTypeName:"+lessonTypeName);

            pushlessonArray(key,lessonId,lessonName,teacherId,teacherName/*,lessonTypeId*/,lessonTypeName);

        }

        function appendTable(){
            $("#lessonTable").empty();
            $("#lessonTable").append(Mustache.render(lessonTableTemplate, {"lessonArray":lessonArray}));
            $("#lessonJson").val(JSON.stringify(lessonArray));
        }

        function selectLessonCallback(lessonId,lessonName,teacherId,teacherName/*,lessonTypeId*/,lessonTypeName,chked){

            var key = lessonId+lessonName;
            $("#lessonId").val(lessonId);
            $("#lessonName").val(lessonName);

            for(var i=0;i<lessonArray.length;i++){
                if (key == lessonArray[i].key){
                    if (chked){
                        return;
                    }else{
                        lessonArray.remove(i);
                        appendTable();
                        return;
                    }
                }
            }

            pushlessonArray(key,lessonId,lessonName,teacherId,teacherName/*,lessonTypeId*/,lessonTypeName);
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
                        location.href = '${ctx}/school/classPlan/list/';
                    } else {
                        window.location.reload();
                    }
                }
            })

        }

        //验证报名班级的数据是否为空
        function lessonValidate(){
            var count = lessonArray.length;
            //alert(count);
            if(count==0){
                $("#lessonError").html("请选择课程！");
                return false;
            }else{
                $("#lessonError").html("");
                return true;
            }
        }

        //班主任老师校验
        function headteacherValidate(){
            var teacher = $("#headteacherId").val();
            //alert(headteacher);
            if(teacher==null || teacher==undefined || teacher==''){
                $("#headteacherError").html("请选择班主任！");
                return false;
            }else{
                $("#headteacherError").html("");
                return true;
            }
        }
        //指导老师校验
		/*function instructorValidate(){
		 var teacher = $("#instructorId").val();
		 //alert(headteacher);
		 if(teacher==null || teacher==undefined || teacher==''){
		 $("#instructorError").html("请选择副班主任！");
		 return false;
		 }else{
		 $("#instructorError").html("");
		 return true;
		 }
		 }*/
        //管理老师校验
		/*function managerValidate(){
		 var teacher = $("#managerId").val();
		 //alert(headteacher);
		 if(teacher==null || teacher==undefined || teacher==''){
		 $("#managerError").html("请选择管理老师！");
		 return false;
		 }else{
		 $("#managerError").html("");
		 return true;
		 }
		 }
		 //督导老师校验
		 function supervisorValidate(){
		 var teacher = $("#supervisorId").val();
		 //alert(headteacher);
		 if(teacher==null || teacher==undefined || teacher==''){
		 $("#supervisorError").html("请选择督导老师！");
		 return false;
		 }else{
		 $("#supervisorError").html("");
		 return true;
		 }
		 }*/

	</script>
</head>
<body>
<div>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/school/classPlan/list">开班计划列表</a></li>
		<li class="active"><a href="${ctx}/school/classPlan/info?id=${schoolClass.id}">开班计划详情</a></li>
	</ul></div><br/><div>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/school/classPlan/info?id=${schoolClass.id}">基本信息</a></li>
		<li><a href="${ctx}/school/classPlan/classStudentInfo?id=${schoolClass.id}">班级学员</a></li>
		<li class="active"><a href="${ctx}/school/classPlan/classInstall?id=${schoolClass.id}">班级设置</a></li>
	</ul>
</div><br/>
<form:form id="inputForm" modelAttribute="aClass" method="post" class="form-horizontal">
	<form:hidden path="id"/>
	<input type="hidden" name="lessonJson" id="lessonJson" style="width:1230px;"/>
	<sys:message content="${message}"/>

	<div class="control-group">
		<label class="control-label">班主任：</label>
		<div class="controls">
			<sys:treeselect id="headteacher" name="headteacher.id" value="${schoolClass.headteacher.id}"
							labelName="headteacher.name" labelValue="${schoolClass.headteacher.name}"
							title="选择用户" url="/sys/office/treeData?type=3" cssClass="required" notAllowSelectParent="true" allowClear="true"/>
				<%--<sys:employeeselect id="headteacher" name="headteacher.id" value="${schoolClass.headteacher.id}"
									labelName="schoolClass.headteacher.name" labelValue="${schoolClass.headteacher.name}"
									title="员工" url="/erp/employee/officeTreeData?type=3" allowClear="true" notAllowSelectParent="true"/>--%>
			<font color="red">*</font>
			<label class="error" id="headteacherError"></label>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">副班主任：</label>
		<div class="controls">
			<sys:treeselect id="instructor" name="instructor.id" value="${schoolClass.instructor.id}"
							labelName="instructor.name" labelValue="${schoolClass.instructor.name}"
							title="选择用户" url="/sys/office/treeData?type=3" allowClear="true" notAllowSelectParent="true"/>
				<%--<sys:employeeselect id="instructor" name="instructor.id" value="${schoolClass.instructor.id}"
									labelName="schoolClass.instructor.name" labelValue="${schoolClass.instructor.name}"
									title="员工" url="/erp/employee/officeTreeData?type=3" allowClear="true" notAllowSelectParent="true"/>--%>
				<%--<label class="error" id="instructorError"></label>--%>
		</div>
	</div>

	<%--<div class="control-group">
        <label class="control-label">管理老师：</label>
        <div class="controls">
            <sys:treeselect id="manager" name="manager.id" value="${schoolClass.manager.id}"
                            labelName="manager.name" labelValue="${schoolClass.manager.name}"
                            title="选择用户" url="/sys/office/treeData?type=3" allowClear="true" notAllowSelectParent="true" cssClass="required"/>

            &lt;%&ndash;<sys:employeeselect id="manager" name="manager.id" value="${schoolClass.manager.id}"
                                labelName="schoolClass.manager.name" labelValue="${schoolClass.manager.name}"
                                title="员工" url="/erp/employee/officeTreeData?type=3" allowClear="true" notAllowSelectParent="true"/>&ndash;%&gt;
            <font color="red">*</font>
            <label class="error" id="managerError"></label>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">督导老师：</label>
        <div class="controls">
            <sys:treeselect id="supervisor" name="supervisor.id" value="${schoolClass.supervisor.id}"
                            labelName="supervisor.name" labelValue="${schoolClass.supervisor.name}"
                            title="选择用户" url="/sys/office/treeData?type=3" allowClear="true" notAllowSelectParent="true" cssClass="required"/>

            &lt;%&ndash;<sys:employeeselect id="supervisor" name="supervisor.id" value="${schoolClass.supervisor.id}"
                                labelName="schoolClass.supervisor.name" labelValue="${schoolClass.supervisor.name}"
                                title="员工" url="/erp/employee/officeTreeData?type=3" allowClear="true" notAllowSelectParent="true"/>&ndash;%&gt;
            <font color="red">*</font>
            <label class="error" id="supervisorError"></label>
        </div>
    </div>--%>

	<div class="control-group" hidden="hidden">
		<label class="control-label">原课程：</label>
		<div class="controls">
			<input  name="oldlessonId" id="oldlessonId" value="${schoolClass.schoolClassToLesson.schoolClassLesson.id}">
			<input type="text"  name="oldlessonName" id="oldlessonName" value="${schoolClass.schoolClassToLesson.schoolClassLesson.lessonName}"
				   style="width:392px;" readonly=readonly/>
		</div>
	</div>

	<div class="control-group">
		<label class="control-label">课程名称：</label>
		<div class="controls">
			<input type="hidden" name="schoolClassToLesson.schoolClassLesson.id" id="lessonId" value="${schoolClass.schoolClassToLesson.schoolClassLesson.id}">
			<input id="selectLesson" class="btn btn-primary" type="button" value="选择课程"/>
			<font color="red">*</font>
			<label class="error" id="lessonError"></label>
				<%--<span class="help-inline"><font color="red">*</font> </span>--%>
				<%--<input type="text"  name="schoolClassToLesson.schoolClassLesson.lessonName" id="lessonName" value="${schoolClass.schoolClassToLesson.schoolClassLesson.lessonName}"
					   style="width:392px;" placeholder="点击选择添加课程" readonly=readonly/>&nbsp;&nbsp;--%>


		</div>
	</div><br/>

	<table id="contentTable" class="table table-striped table-bordered table-condensed" style="width: 70%">
		<thead>
		<tr>
				<%--<th>LessonId</th>--%>
			<th>课程名称</th>
			<th>授课老师</th>
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
		<shiro:hasPermission name="school:classPlan:saveClassAndLessonList">
			<input id="submit" type="button" class="btn btn-primary"  value="保 存"/>&nbsp;
			<%--<button type="button" class="btn btn-primary" onclick="submitSave()">保存</button>&nbsp;--%>
		</shiro:hasPermission>
		<input id="btnCancel" class="btn" type="button" value="返 回"/>
	</div>
</form:form>

<script type="text/javascript">
    function removeLessons(lessonId){
        //console.log(lessonId);
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
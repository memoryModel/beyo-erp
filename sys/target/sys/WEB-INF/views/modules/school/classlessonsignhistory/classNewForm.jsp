<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>班级管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
        function validform() {
            return $("#inputForm").validate();
        }

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


        var studentTableTemplate;
        var studentArray = new Array();

		$(document).ready(function() {
		    var id = '${classTimeId}';
		    classTime(id);
            studentTableTemplate = $("#studentTableTemplate").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");

            $("#selectLesson,#selectLessonHref").click(function () {
                top.$.jBox("iframe:/school/class/selectLesson?btnFlag=1", {
                    title:"选择课程",
                    width:1024,
                    height:520,
                    buttons:{}
                });
            });


            $(validform());
            $("#btnSubmit").click(function () {
                if(validform().form()){
                    submitSave();
                }else{
                    return;
                }
            });

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

        function submitSave() {
            var ttDate = $("#attendClassTime").val();
            ttDate = ttDate.match(/\d{4}.\d{1,2}.\d{1,2}/mg).toString();
            ttDate = ttDate.replace(/[^0-9]/mg, '-');
            console.log("studentJson:"+encodeURIComponent(JSON.stringify(studentArray)),"lessonId:"+$("#lessonId").val(),"lessonName:"+$("#lessonId").find("option:selected").text(),"className:"+$("#className").val(),
                "headteacher:"+$("#headteacher").val(),"attendClassTime:"+ttDate,"startTime:"+$("#startTime").val(),"endTime:"+$("#endTime").val(),"timeLength:"+$("#timeLength").val(),"classRoomId:"+$("#classRoomId").val(),
                "remark:"+$("#remark").val());
            $.ajax({
                type: 'post',
                url : '${ctx}/school/classLessonSignHistory/saveClass',
                data: {"studentJson":encodeURIComponent(JSON.stringify(studentArray)),"lessonId":$("#lessonId").val(),"lessonName":$("#lessonId").find("option:selected").text(),"className":$("#className").val(),
                    "headteacher":$("#headteacherId").val(),"attendClassTime":ttDate,"startTime":$("#startTime").val(),"endTime":$("#endTime").val(),"timeLength":$("#timeLength").val(),"classRoomId":$("#classRoomId").val(),
                    "remark":$("#remark").val()},
                success : function(data) {
                    if (data && data.result == "success") {
                        location.href = '${ctx}/school/classLessonSignHistory/list/';
                    } else {
                        window.location.reload();
                    }
                }
            })
        }


        function classTime(id){
		    $.ajax({
				type : 'post',
				url : '${ctx}/school/classLessonSignHistory/selectTime',
				data : {'id':id},
				success : function (data) {
                    document.getElementById("startTime").value=data.data.startTime;
                    document.getElementById("endTime").value=data.data.endTime;
                  	a = $("#startTime").val();
                  	b = $("#endTime").val();
                  	var d1 = new Date("1111/1/1"+" "+a);
                    var d2 = new Date("1111/1/1"+" "+b);
                    var gap = Math.abs(d1-d2)/1000/60;
                    $("#timeLength").val(gap);
                }
			})
		}


        //选择课程回调函数
        function selectLessonCallback(lessonId,lessonName,teacherId,teacherName,lessonTypeId,lessonTypeName,subjectId,subjectName,chked) {
            $("#selectLesson").val(lessonName);
            $("input[name='schoolClassLesson.id']").val(lessonId);
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
                $("#studentNum").val(studentArray.length);
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
		<li class="active"><a href="${ctx}/school/classLessonSignHistory/classNew">新开班补课<shiro:hasPermission name="school:classLessonSignHistory:classNew">${not empty schoolClass.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="school:classLessonSignHistory:classNew">查看</shiro:lacksPermission></a></li>
		<li><a href="/school/classLessonSignHistory/followClass">跟班补课</a> </li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="classLessonSignHistory"  method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="status"/>
		<input type="hidden" id="classStudentJson"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">课程：</label>
			<div class="controls">
				<div class="input-append">
					<input id="lessonId" type="hidden" name="schoolClassLesson.id" value="${examineInfo.schoolClassLesson.id}">
					<input id="selectLesson" name="schoolClassLesson.name" type="text" readonly="readonly" class="required" value="${examineInfo.schoolClassLesson.lessonName}"/>
					<a id="selectLessonHref" href="javascript:" class="btn">&nbsp;
						<i class="icon-search"></i>&nbsp;
					</a>
				</div>
				<span class="help-inline">
						<font color="red">*</font>
				</span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">班级名称：</label>
			<div class="controls">
				<form:input id="className" style="width:190px" path="" name="className" htmlEscape="false" maxlength="512" class="required input-xlarge " />
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">授课老师：</label>
			<div class="controls">
				<sys:treeselect id="headteacher" name="classLessonSign.teacher.id" value="${classLessonSign.teacher.id}"
								labelName="classLessonSign.teacher.name" labelValue="${classLessonSign.teacher.name}"
								title="选择用户" url="/sys/office/treeData?type=3" notAllowSelectParent="true"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">上课日期：</label>
			<div class="controls">
				<input id="attendClassTime" type="text" name="attendClassTime" readonly="readonly" maxlength="20" class="required input-medium Wdate " style="width:190px"
					   value="<fmt:formatDate value="${schoolClass.realBeginTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">上课时间：</label>
			<div class="controls">
				<form:select id="schoolTime" path="" name="schoolTime" onchange="classTime(this.options[this.options.selectedIndex].value)" class="required" style="width:207px">
					<form:options items="${classTimeList}" itemLabel="lessonName" itemValue="id" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">开始时间：</label>
			<div class="controls">
				<form:input id="startTime" path="" style="width:190px"  htmlEscape="false" maxlength="512" readonly="true" class="input-xlarge required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">结束时间：</label>
			<div class="controls">
				<form:input id="endTime" style="width:190px" path="" htmlEscape="false" maxlength="512" readonly="true" class="input-xlarge required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">上课时长：</label>
			<div class="controls">
				<form:input id="timeLength" style="width:100px" path="" htmlEscape="false" maxlength="512" readonly="true" class="input-xlarge"/>分钟
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">上课教室：</label>
			<div class="controls">
				<form:select id="classRoomId" path="" style="width:200px" class="required">
					<form:options items="${classRoomList}" itemLabel="classroomName" itemValue="id" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<form:textarea path="" name="remark" id="remark"  rows="4" style="width:709px;" maxlength="1000"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">补课学员：</label>
			<div class="controls">
				<div class="input-append">
					<input id="studentNum" name="studentNum" type="hidden"/>
					<input id="selectStudent" type="text" readonly="readonly" class="required" value=""/>
					<a id="selectStudentHref" href="javascript:" class="btn">&nbsp;
						<i class="icon-search"></i>&nbsp;
					</a>
				</div>
				<span class="help-inline">
						<font color="red">*</font>
				</span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">补课学员：</label>
			<div class="controls">
				<table id="contentTable" style="width: 70%" class="table table-striped table-bordered table-condensed">
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

		<div class="form-actions">
			<shiro:hasPermission name="school:classLessonSignHistory:saveClass"><input id="btnSubmit" class="btn btn-primary" type="button"  value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>
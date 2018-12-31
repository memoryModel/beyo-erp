<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>考试管理详情页面</title>
	<meta name="decorator" content="default"/>

</head>
<body>
	<form:form id="inputForm" modelAttribute="examineInfo"  class="form-horizontal" action="/school/examineInfo/save">
		<form:hidden path="id"/>
		<form:hidden path="status"/>
		<input type="hidden" id="classStudentJson"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">考试名称：</label>
			<div class="controls">
				<form:input id="examineName" readonly="true" style="width:210px" path="examineName" htmlEscape="false" maxlength="215" class="required input-xlarge " />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">考试类型：</label>
			<div class="controls">
				<form:select id="examineType" disabled="true" path="examineType" class="required input-large" style="width: 210px">
					<form:options items="${erp:getCommonsTypeList(25)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">考试课程：</label>
			<div class="controls">
				<div class="input-append">
					<input id="lessonId" type="hidden" name="schoolClassLesson.id" value="${examineInfo.schoolClassLesson.id}">
					<input id="selectLesson" name="schoolClassLesson.name" type="text" readonly="readonly" class="required" value="${examineInfo.schoolClassLesson.lessonName}"/>
				</div>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">考试题库：</label>
			<div class="controls">
				<form:select id="examineStore" disabled="true" path="schoolExamineStore.id" class="required input-medium" style="width: 210px">
					<form:option value="">请选择</form:option>
					<form:options items="${storeList}" itemLabel="name" itemValue="id" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">考试方式：</label>
			<div class="controls">
				<form:select id="examineMethod" disabled="true" path="examineMethod" class="required input-large" style="width: 210px">
					<form:options items="${erp:getCommonsTypeList(26)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">考试时段：</label>
			<div class="controls">
				<input name="startTime" id="startTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate " style="width: 210px"
					   value="<fmt:formatDate value="${schoolExamineInfo.startTime}" pattern="yyyy-MM-dd HH:mm"/>"/>—
				<input name="endTime" id="endTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate " style="width: 210px"
					   value="<fmt:formatDate value="${schoolExamineInfo.endTime}" pattern="yyyy-MM-dd HH:mm"/>"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">答题时长：</label>
			<div class="controls">
				<form:input style="width: 210px" readonly="true" id="examineLength" path="examineLength" htmlEscape="false" maxlength="10" class="input-xlarge required digits" cssStyle="width: 50px;text-align: right;"/>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<form:textarea path="remark" readonly="true" id="remark" htmlEscape="false" rows="4" maxlength="580" style="width: 500px" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">随机试卷生成规则：</label>
			<div class="controls">
				<table style="width: 50%" class="table table-striped table-bordered table-condensed">
					<thead>
					<th>
						题型
					</th>
					<th>
						单选题
					</th>
					<th>
						多选题
					</th>
					</thead>
					<tbody>
					<tr>
						<td>
							题数
						</td>
						<td>
							<form:input style="width: 210px" path="singleChoiceNum" readonly="true" id="singleChoiceNum" htmlEscape="false" maxlength="10" class="input-xlarge required digits" cssStyle="width: 50px;text-align: right;"/>
						</td>
						<td>
							<form:input style="width: 210px"  path="multiChoiceNum" readonly="true" id="multiChoiceNum" htmlEscape="false" maxlength="10" class="input-xlarge required digits" cssStyle="width: 50px;text-align: right;"/>
						</td>
					</tr>
					<tr>
						<td>
							分值
						</td>
						<td>
							<form:input style="width: 210px" readonly="true" path="singleChoiceGrade" id="singleChoiceGrade" htmlEscape="false" maxlength="10" class="input-xlarge required digits" cssStyle="width: 50px;text-align: right;"/>
						</td>
						<td>
							<form:input  style="width: 210px" readonly="true" path="multiChoiceGrade" id="multiChoiceGrade" htmlEscape="false" maxlength="10" class="input-xlarge required digits" cssStyle="width: 50px;text-align: right;"/>
						</td>
					</tr>
					<tr>
						<td>合计
						</td>
						<td colspan="2" style="text-align: right">
							卷面总分：100分
						</td>
					</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">发放试卷规则：</label>
			<div class="controls">
				<form:select path="disbursementType" disabled="true" id="disbursementType" class="required input-large" style="width: 210px">
					<form:options items="${erp:getCommonsTypeList(20)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">及格分数：</label>
			<div class="controls">
				<form:input style="width: 210px" readonly="true" path="passingGrade" id="passingGrade" htmlEscape="false" maxlength="10" class="input-xlarge required digits" cssStyle="width: 50px;text-align: right;"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">考试学员：</label>
			<div class="controls">
				<div class="input-append">
					<input id="selectStudent" type="text" readonly="readonly" class="required" value=""/>
				</div>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">考试学员：</label>
			<div class="controls">
				<table id="contentTable" style="width: 70%" class="table table-striped table-bordered table-condensed">
					<thead>
					<tr>
						<th>班级</th>
						<th>姓名</th>
						<th>学号</th>
						<th>性别</th>
						<th>手机号</th>
					</tr>
					</thead>
					<tbody id="studentTable">
					<script type="text/template" id="studentTableTemplate">
						{{#studentArray}}
						<tr>
							<td>{{className}}<input type="hidden" name="classId" value="{{classId}}"></td>
							<td>{{studentName}}<input type="hidden" name="studentId" value="{{studentId}}"></td>
							<td>{{studentNumber}}</td>
							<td>{{studentSex}}</td>
							<td>{{studentPhone}}</td>
						</tr>
						{{/studentArray}}
					</script>
					</tbody>
				</table>
			</div>
		</div>
	</form:form>
	<script type="text/javascript">
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

        //全局参数
        var studentList = ${fns:toJson(studentsList)};  //后台查询已有学员信息
        var studentTableTemplate;
        var studentArray = new Array();



        $(document).ready(function() {

            studentTableTemplate = $("#studentTableTemplate").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");


            if (studentList && studentList.length>0){
                for(var i=0;i<studentList.length;i++){
                    var sex="";
                    if(studentList[i].student.sex == 1){sex = '男'}else{sex = '女'}
                    studentArray.push({
						"classId":studentList[i].schoolClass.id,
                        "className":studentList[i].schoolClass.className,
                        "studentId":studentList[i].student.id,
                        "studentName":studentList[i].student.name,
                        "studentNumber":studentList[i].student.studentNumber,
						"studentSex":sex,
						"studentPhone":studentList[i].student.phone})
				}

				showStudents();
			}
            
            $("#selectLesson,#selectLessonHref").click(function () {
                top.$.jBox("iframe:/school/class/selectLesson?btnFlag=1", {
                    title:"选择课程",
					width:1024,
					height:520,
                    buttons:{}
				});
            });


            //$("#name").focus();
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

            //点击添加学员
            $("#selectStudent,#selectStudentHref").click(function () {
                var lessonId = $("#lessonId").val();
                if (lessonId == ""){
                    $("#lessonId").focus();
                    //return;
                }
                var str = $("#classStudentJson").val();

                top.$.jBox("iframe:/school/examineInfo/selectEnroll", {
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
			}else{
                $("#selectStudent").val("");
			}
		}

        /*function removeClassStudents(studentId){

            for(var i=0;i<studentArray.length;i++){
                if (studentId == studentArray[i].studentId){
                    studentArray.remove(i);
                    break;
                }
            }
            showStudents();
        }*/


	</script>
</body>
</html>
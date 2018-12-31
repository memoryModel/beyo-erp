<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>单表管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
            //$("#name").focus();
            $("#inputForm").validate({
                submitHandler: function (form) {
                    loading('正在提交，请稍等...');
                    form.submit();
                },
                errorContainer: "#messageBox",
                errorPlacement: function (error, element) {
                    $("#messageBox").text("输入有误，请先更正。");
                    if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-append")) {
                        error.appendTo(element.parent().parent());
                    } else {
                        error.insertAfter(element);
                    }
                }
            });


        });

	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><shiro:hasPermission name="school:classStudents:quitList">
			<c:if test="${tagFlag==1}">
				<a href="${ctx}/school/classStudents/quitList">退班管理</a>
			</c:if>
			<c:if test="${tagFlag==0}">
				<a href="${ctx}/school/classStudents/quitList?studentId=${quitStudent.student.id}&&classId=${quitStudent.schoolClass.id}&&tagFlag=0">退班管理</a>
			</c:if>
		</shiro:hasPermission></li>
	</ul><br/>
	<!--弹框选择退班的学生信息-->

	<table style="border-collapse:separate; border-spacing:5px;">
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">姓名：<input id="name" readonly="readonly" style="border: 0px;outline:none;cursor: pointer;"></label>

				</div>

			</td>
			<td>
				<div class="control-group">
					<label class="control-label">学号：<input id="studentNumber" readonly="readonly" style="border: 0px;outline:none;cursor: pointer;"></label>
				</div>
			</td>
			<td>
				<div class="control-group">
					<label class="control-label">性别：<input id="sex" readonly="readonly" style="border: 0px;outline:none;cursor: pointer;"></label>
				</div>
			</td>
			<td>
				<div class="control-group">
					<label class="control-label">手机号：<input id="phone" readonly="readonly" style="border: 0px;outline:none;cursor: pointer;"></label>

				</div>
			</td>

			<td>
				<div class="control-group">
					<div class="controls">
						<input type="hidden" name="student.id" id="studentId" value="${classStudents.student.id}">
						<c:if test="${tagFlag==1}">
							<input id="selectStudent" class="btn btn-primary" type="button" value="选择退班学员" style="height:33px;width:110px;"/>
						</c:if>
					</div>
				</div>
			</td>
		</tr>
	</table>

	<table id="contentTable" style="margin: 20px 0;" class="table table-striped table-bordered table-condensed">
		<%--展示学员报读的班级信息--%>
		<thead>
		<tr>
			<th>班级名称</th>
			<th>课程</th>
			<th>班主任</th>
			<th>学费</th>
			<th>付款类型</th>
			<th>学费优惠</th>
			<th>开班日期</th>
			<th>报名日期</th>
		</tr>
		</thead>
		<tbody>
		<tr>
			<td><div id="className"></div></td>
			<td><div id="lessonName"></div></td>
			<td><div id="teacherName"></div></td>
			<td><span id="tuitionAmount"></span></td>
			<td><span id="paymentType"></span></td>
			<td><span id="tuitionFavorable"></span></td>
			<td><span id="realBeginTime"></span></td>
			<td><span id="applyTime"></span></td>
		</tr>
		</tbody>
	</table>
	<table id="contentTable" style="margin: 20px 0;" class="table table-striped table-bordered table-condensed">
		<%--展示课程详细信息--%>
		<thead>
		<tr>
			<th>课程名称</th>
			<th>科目</th>
			<th>类型</th>
			<th>总课次</th>
			<th>已上课次</th>
			<th>剩余课次</th>
		</tr>
		</thead>
		<tbody id="studentTable">
		<script type="text/template" id="studentTableTemplate">
			{{#studentArray}}
			<tr>
				<td>{{lessonName}}</td>
				<td>{{subjectName}}</td>
				<td>{{lessonTypeName}}</td>
				<td>{{tuitionAmount}}</td>
				<td>{{paymentType}}</td>
				<td>{{tuitionFavorable}}</td>
			</tr>
			{{/studentArray}}
		</script>
		</tbody>
	</table>
	<hr style="height:1px;border:none;border-top:1px solid #000000;" />
		<font size="4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;退班</font>
	<hr style="height:1px;border:none;border-top:1px solid #000000;" />
	<form:form id="inputForm"  modelAttribute="classStudents" action="${ctx}/school/classStudents/save" method="post" class="form-horizontal">
		<input type="hidden" name="id" id="classStudentsId">
		<input type="hidden" name="tagFlag" id="tagFlag" value="${tagFlag}">
		<sys:message content="${message}"/>

		<div class="control-group">
			<label class="control-label">退班原因：</label>
			<div class="controls">
				<form:select path="cause" id="cause" class="required" style="width: 180px">
					<form:option value="0" label="请选择"/>
					<form:options items="${erp:getCommonsTypeList(3)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
			<div class="control-group">
			<label class="control-label">退班日期：</label>
			<div class="controls">
				<input name="quitTime" type="text" maxlength="20" class="input-medium Wdate required"
					   value="<fmt:formatDate value="${classStudents.quitTime}" pattern="yyyy-MM-dd HH:mm"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});" class="required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<textarea  name="description" maxlength="1024" class="input-xxlarge" rows="4"></textarea>
			</div>
		</div>
		<hr style="height:1px;border:none;border-top:1px solid #000000;" />
		<div class="form-actions">
			<shiro:hasPermission name="school:classStudents:save">
				<input id="btnSubmit" class="btn btn-danger" type="submit" value="退班" style="height:40px;width:100px;"/>&nbsp;&nbsp;&nbsp;&nbsp;
			</shiro:hasPermission>
			<input type="button" id="resets" class="btn btn-warning" onclick="reset()" value="重置" style="height:40px;width:100px;"/>&nbsp;
		</div>
	</form:form>

	<script>
        //选择退班
        var jbox;
        $("#selectStudent").click(function () {

            if(studentArray.length>=1){
                studentArray.splice(0,studentArray.length);
            }
            var tb = document.getElementById('studentTable');
            var rowNum=tb.rows.length;
            for (i=0;i<rowNum;i++)
            {
                tb.deleteRow(i);
                rowNum=rowNum-1;
                i=i-1;
            }

            jbox = top.$.jBox("iframe:/school/classStudents/selectStudent", {
                title:"学员退班",
                width:900,
                height:550,
                buttons:{}
            });
        });


        //重置功能
        function reset(){
            /*var inputs = document.getElementsByTagName('input');
            for(var i=0;i<inputs.length;i++){
                if(inputs[i].type == 'textbox'){
                    inputs[i].value = '';
                }
            }*/
            console.info("123123");
            window.location.reload(true);
        };

        var studentList;var quitStudent;
        if(${not empty studentList}) studentList = ${fns:toJson(studentList)};
        var studentTableTemplate = $("#studentTableTemplate").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
        var studentArray = new Array();
        console.info("tagFlag:"+${tagFlag});

        if(${not empty quitStudent}) {
            quitStudent = ${fns:toJson(quitStudent)};
            console.info(quitStudent);

            $("#classStudentsId").val(quitStudent.id);
            $("#name").val(quitStudent.student.name);
            $("#studentNumber").val(quitStudent.student.studentNumber);
            $("#sex").val(quitStudent.student.sex == 1 ? "男":"女");
            $("#phone").val(quitStudent.student.phone);

            $("#className").text(quitStudent.schoolClass.className);// 设置文本内容
            $("#lessonName").text(quitStudent.schoolClass.schoolClassToLesson == undefined ? " " : quitStudent.schoolClass.schoolClassToLesson.schoolClassLesson.lessonName);
            $("#teacherName").text(quitStudent.schoolClass.headteacher == undefined ? " " : quitStudent.schoolClass.headteacher.name);
            $("#tuitionAmount").text(quitStudent.schoolClass.tuitionAmount == undefined ? " " :quitStudent.schoolClass.tuitionAmount);
            $("#paymentType").text(quitStudent.order.payType == undefined ? " ":quitStudent.order.payType);
            $("#tuitionFavorable").text(quitStudent.order.tuitionFavorable);

            if(quitStudent.schoolClass.realBeginTime == undefined || quitStudent.schoolClass.realBeginTime == null) {
                var realBeginTime = " ";
			}else {
                var dayTime = new Date(quitStudent.schoolClass.realBeginTime);
                var realBeginTime = dayTime.Format("yyyy-MM-dd");
            }
            var time = new Date(quitStudent.applyTime);
            var applyTime = time.Format("yyyy-MM-dd");

            $("#realBeginTime").text(realBeginTime);
            $("#applyTime").text(applyTime);
        }

        //展示表格数组
        function studentList(){
            $("#studentTable").append(Mustache.render(studentTableTemplate, {"studentArray":studentArray}));
        }



        //回显数据
        function selectStudentback(id,stuId,name,studentNumber,sex,phone,className,lessonName,teacherName,tuitionAmount,paymentType,tuitionFavorable,realBeginTime,applyTime,subjectName,lessonTypeName) {

            if(realBeginTime != null && realBeginTime != ""){
                var dayTime = new Date(realBeginTime);
                realBeginTime = dayTime.Format("yyyy-MM-dd");
            } else{

            }

            var dayTime = new Date(applyTime);
            applyTime = dayTime.Format("yyyy-MM-dd");


            $("#classStudentsId").val(id);
            $("#name").val(name);
			$("#studentNumber").val(studentNumber);
			$("#sex").val(sex);
			$("#phone").val(phone);
			$("#className").text(className);// 设置文本内容
			$("#lessonName").text(lessonName);
			$("#teacherName").text(teacherName);
			$("#tuitionAmount").text(tuitionAmount);
			$("#paymentType").text(paymentType);
			$("#tuitionFavorable").text(tuitionFavorable);
			$("#realBeginTime").text(realBeginTime);
			$("#applyTime").text(applyTime);

            //表格数据追加


            studentArray.push({
                "lessonName":lessonName,
                "subjectName":subjectName,
                "lessonTypeName":lessonTypeName

            });
            studentList();
        }
	</script>
</body>
</html>
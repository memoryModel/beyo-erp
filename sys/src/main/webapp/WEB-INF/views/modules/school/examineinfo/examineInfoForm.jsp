<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>考试管理</title>
    <meta name="decorator" content="default"/>

</head>
<body>
<ul class="nav nav-tabs">
    <li>
        <c:if test="${examineInfo.examineStatus == 0}">
            <a href="${ctx}/school/examineInfo/list">考试管理</a>
        </c:if>
        <c:if test="${examineInfo.examineStatus == 1}">
            <a href="${ctx}/school/examineStudents/makeupList">补考管理</a>
        </c:if>

    </li>
    <li class="active">
        <a href="/school/examineInfo/form?id=${examineInfo.id}&examineStatus=${examineInfo.examineStatus}">
            <shiro:hasPermission name="school:examineInfo:form">${not empty schoolExamineInfo.id?'修改':'新增'}</shiro:hasPermission>
            <shiro:lacksPermission name="school:examineInfo:form">查看</shiro:lacksPermission>
            <c:if test="${examineInfo.examineStatus == 0}">
                考试
            </c:if>
            <c:if test="${examineInfo.examineStatus == 1}">
                补考
            </c:if>
        </a></li>
</ul><br/>
<form:form id="inputForm" modelAttribute="examineInfo"  class="form-horizontal" action="/school/examineInfo/save">
    <form:hidden path="id"/>
    <form:hidden path="examineStatus" id="examineStatus"/>
    <input type="hidden" id="classStudentJson"/>
    <sys:message content="${message}"/>
    <div class="control-group">
        <label class="control-label">
            <c:if test="${examineInfo.examineStatus == 0}">
                考试名称：
            </c:if>
            <c:if test="${examineInfo.examineStatus == 1}">
                补考名称：
            </c:if>
        </label>
        <div class="controls">
            <form:input id="examineName" path="examineName" htmlEscape="false" maxlength="215" class="required input-xlarge " />
            <span class="help-inline"><font color="red">*</font> </span>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">考试类型：</label>
        <div class="controls">
            <form:select id="examineType" path="examineType" class="required input-large" >
                <form:option value="">---请选择---</form:option>
                <form:options items="${erp:examTypeList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
            </form:select>
            <span class="help-inline"><font color="red">*</font> </span>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">考试班级：</label>
        <div class="controls">
            <div class="input-append">
                <input id="classId" type="hidden" name="schoolClass.id" value="${examineInfo.schoolClass.id}">
                <input id="selectClass" name="schoolClass.className" type="text" readonly="readonly" class="input-xlarge" value="${examineInfo.schoolClass.className}"/>
                <a id="selectClassHref" href="javascript:" class="btn">&nbsp;
                    <i class="icon-search"></i>&nbsp;
                </a>
            </div>
        </div>
    </div>
    <div class="control-group" id="examStoreDiv">
        <label class="control-label">考试题库：</label>
        <div class="controls">
            <form:select id="examineStore" path="schoolExamineStore.id" class="required input-large" >
                <form:options items="${storeList}" itemLabel="name" itemValue="id" htmlEscape="false"/>
            </form:select>
            <span class="help-inline"><font color="red">*</font> </span>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">考试方式：</label>
        <div class="controls">
            <form:select id="examineMethod" path="examineMethod" class="required input-large">
                <form:option value="">---请选择---</form:option>
                <form:options items="${erp:getCommonsTypeList(26)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
            </form:select>
            <span class="help-inline"><font color="red">*</font> </span>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">考试时段：</label>
        <div class="controls">
            <input name="startTime" id="startTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
                   value="<fmt:formatDate value="${schoolExamineInfo.startTime}" pattern="yyyy-MM-dd HH:mm"/>"
                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true,onpicked:function(dp){examTime()}});"/>—
            <input name="endTime" id="endTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
                   value="<fmt:formatDate value="${schoolExamineInfo.endTime}" pattern="yyyy-MM-dd HH:mm"/>"
                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true,onpicked:function(dp){examTime()}});"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">考试时长：</label>
        <div class="controls">
            <input type="hidden" id="examineLength">
            <form:input style="width: 210px"  path="examineLength" htmlEscape="false" class="input-xlarge required digits examineLengthCheck" cssStyle="width: 50px;text-align: right;"/>
            <span class="help-inline"><font color="red">*</font> 分钟</span>
        </div>
    </div>
    <div class="control-group" id="teacher" style="display: none;">
        <label class="control-label">监考老师：</label>
        <div class="controls">
            <sys:treeselect id="teacherId" name="teacher.id" value="${examineInfo.teacher.id}"
                            labelName="teacher.name" labelValue="${examineInfo.teacher.name}"
                            title="选择用户" url="/sys/office/treeData?type=3"  notAllowSelectParent="true"/>

        </div>
    </div>
    <div class="control-group">
        <label class="control-label">备注：</label>
        <div class="controls">
            <form:textarea path="remark" id="remark" htmlEscape="false" rows="3" cssClass="input-xxlarge" maxlength="580" />
        </div>
    </div>
    <div id="theoryExam" class="control-group">
        <label class="control-label">随机试卷生成规则：</label>
        <div class="controls">
            <table style="width: 50%" class="table table-striped table-bordered table-condensed">
                <thead>
                <th>
                    题型
                </th>
                <th>
                    单选题&nbsp;<span id="singleNum"></span>
                </th>
                <th>
                    多选题&nbsp;<span id="multiNum"></span>
                </th>
                </thead>
                <tbody>
                <tr>
                    <td>
                        题数
                    </td>
                    <td>
                        <form:input style="width: 210px" path="singleChoiceNum" id="singleChoiceNum" htmlEscape="false" maxlength="10" class="input-xlarge required digits singleNum checkPoints" cssStyle="width: 50px;text-align: right;"/>&nbsp;<span id="singleTip"></span>
                    </td>
                    <td>
                        <form:input style="width: 210px"  path="multiChoiceNum" id="multiChoiceNum" htmlEscape="false" maxlength="10" class="input-xlarge required digits multiNum checkPoints" cssStyle="width: 50px;text-align: right;"/>&nbsp;<span id="multiTip"></span>
                    </td>
                </tr>
                <tr>
                    <td>
                        分值
                    </td>
                    <td>
                        <form:input style="width: 210px"  path="singleChoiceGrade" id="singleChoiceGrade" htmlEscape="false" maxlength="10" class="input-xlarge required digits points checkPoints" cssStyle="width: 50px;text-align: right;"/>&nbsp;分/每题
                    </td>
                    <td>
                        <form:input  style="width: 210px" path="multiChoiceGrade" id="multiChoiceGrade" htmlEscape="false" maxlength="10" class="input-xlarge required digits points checkPoints" cssStyle="width: 50px;text-align: right;"/>&nbsp;分/每题
                    </td>
                </tr>
                <tr>
                    <td>合计
                    </td>
                    <td colspan="2" style="text-align: right">
                        卷面总分：<span id="paperGrade"></span>&nbsp;分
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div id="actualExam" class="control-group" style="display: none;">
        <label class="control-label">考试试卷：</label>
        <div class="controls" >

            <div id="actualExamTable"></div>
            <br>
            <div>
                卷面总分：<span id="paperGrade2"></span>&nbsp;分
            </div>
            <br>
            <input id="addExam" type="button" class="btn btn-primary" value="添加试题"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">发放试卷规则：</label>
        <div class="controls">
            <form:select path="disbursementType" id="disbursementType" class="required input-large" style="width: 210px">
                <form:option value="">---请选择---</form:option>
                <form:options items="${erp:examRuleTypeList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
            </form:select>
            <span class="help-inline"><font color="red">*</font> </span>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">及格分数：</label>
        <div class="controls">
            <form:input style="width: 210px"  path="passingGrade" id="passingGrade" htmlEscape="false" class="input-xlarge required digits checkPoints" cssStyle="width: 50px;text-align: right;"/>
            <span class="help-inline"><font color="red">*</font> </span>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">考试学员：</label>
        <div class="controls">
            <div class="input-append">
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
        <label class="control-label">考试学员：</label>
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
                            <input id="removeClassStudents{{studentId}}{{classId}}" class="btn btn-danger" type="button" value="删 除" onclick="removeClassStudents('{{studentId}}','{{classId}}')"/>
                        </td>
                    </tr>
                    {{/studentArray}}
                </script>
                </tbody>
            </table>
        </div>
    </div>

    <div class="form-actions">
        <shiro:hasPermission name="school:examineInfo:save"><input id="button" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>
</form:form>
<script id="actualExamTemplate" type="text/template">
    <table class="table table-striped table-bordered table-condensed" style="width: 60%">
        <tbody>
        <tr>
            <td title="index">
                题目{{index}}
            </td>
            <td style="text-align: left;padding-left: 20px">
                <input type="text" value="{{title}}" name="actualTitle" class="required input-xxlarge"/>
            </td>
            <td rowspan="2">
                <input type="button"  class="btn btn-danger" index="{{index}}" value="删除" onclick="deleteActualExam(this)"/>
            </td>
        </tr>
        <tr>
            <td>
                分值:
            </td>
            <td style="text-align: left;padding-left: 20px">
                <input type="text" value="{{point}}" id="aid{{index}}" name="actualPoints"  class="required digits points checkActualPoints" style="width: 50px;text-align: right;">&nbsp;分
            </td>
        </tr>
        </tbody>
    </table>
</script>
<script type="text/javascript">
    $.validator.addClassRules("points", {range:[0,100]});
    $.validator.addMethod("checkPoints",function (value, element) {

        var singleChoiceNum = $("#singleChoiceNum").val();
        var multiChoiceNum = $("#multiChoiceNum").val();
        var singleChoiceGrade = $("#singleChoiceGrade").val();
        var multiChoiceGrade = $("#multiChoiceGrade").val();

        singleChoiceNum = parseInt(singleChoiceNum);
        if(!singleChoiceNum || isNaN(singleChoiceNum)) singleChoiceNum = 0;

        multiChoiceNum = parseInt(multiChoiceNum);
        if(!multiChoiceNum  || isNaN(multiChoiceNum)) multiChoiceNum = 0;

        singleChoiceGrade = parseInt(singleChoiceGrade);
        if(!singleChoiceGrade || isNaN(singleChoiceGrade))singleChoiceGrade = 0;

        multiChoiceGrade = parseInt(multiChoiceGrade);
        if(!multiChoiceGrade || isNaN(multiChoiceGrade))multiChoiceGrade = 0;




        var point = singleChoiceNum*singleChoiceGrade+multiChoiceNum*multiChoiceGrade;

        $("#paperGrade").text(point);

        var passingGrade = $("#passingGrade").val();
        if (passingGrade == "" )return true;

        passingGrade = parseInt(passingGrade);
        if(!passingGrade || isNaN(passingGrade))passingGrade = 0;



        if(point <= passingGrade)return false;

        return true;
    },"及格分数低于题数和分数合计！");

    $.validator.addMethod("checkActualPoints",function (value, element) {

        var point = 0;
        $("input[name='actualPoints']").each(function () {
            var val = $(this).val();
            if (!val || val=="")return;

            point += parseInt(val);
        });
        $("#paperGrade2").text(point);


        var passingGrade = $("#passingGrade").val();
        if (passingGrade == "")return true;

        passingGrade = parseInt(passingGrade);
        if(!passingGrade || isNaN(passingGrade))passingGrade = 0;

        if(point<=passingGrade)return false;

        return true;
    },"及格分数低于分值合计！");

    $.validator.addMethod("examineLengthCheck",function (value, element) {
        var len = $("#examineLength").val();

        if (value > parseInt(len)){
            return false;
        }

        return true;
    },"考试时长不能大于考试时段时长！");


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

    var actualExamTemplate;
    var actualExamList = ${fns:toJson(questionList)};
    var actualExamArray = new Array();

    $(document).ready(function() {

        studentTableTemplate = $("#studentTableTemplate").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");

        actualExamTemplate = $("#actualExamTemplate").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");

        if (studentList && studentList.length>0){
            for(var i=0;i<studentList.length;i++){
                studentArray.push({
                    "classId":studentList[i].schoolClass.id,
                    "className":studentList[i].schoolClass.className,
                    "studentId":studentList[i].student.id,
                    "studentName":studentList[i].student.name,
                    "studentNumber":studentList[i].student.studentNumber})
            }

            showStudents();
        }

        if(actualExamList && actualExamList.length>0){
            for(var i=0;i<actualExamList.length;i++){
                console.log(actualExamList[i]);
                actualExamArray.push({
                    "index":i+1,
                    "title":actualExamList[i].title,
                    "point":actualExamList[i].point
                });
            }

            showActualExam();
        }else{
            actualExamArray.push({"index":1,
                "title":" ",
                "point":""});
            showActualExam();
        }

        $("#selectClass,#selectClassHref").click(function () {
            top.$.jBox("iframe:/school/class/selectClass?btnFlag=1", {
                title:"选择班级",
                width:1024,
                height:520,
                buttons:{}
            });
        });


        $("#examineStore").change(function () {
            if ($(this).val()=="")return;

            $.get("/school/examineStore/examineStoreInfo",{"id":$(this).val()},function (data) {

                if (data || data.status=="success"){
                    $("#singleNum").empty();
                    $("#multiNum").empty();
                    $("#singleNum").html("("+data.single+" 道)");
                    $("#multiNum").html("("+data.multi+" 道)");

                    $("#singleTip").empty();
                    $("#multiTip").empty();
                    $("#singleTip").html("<= "+data.single);
                    $("#multiTip").html("<= "+data.multi);

                    $.validator.addClassRules("singleNum", {range:[0,data.single]});
                    $.validator.addClassRules("multiNum", {range:[0,data.multi]});


                }else{
                    showMessage("error","请求失败");
                }
            },"json").error(function() {
                showMessage("error","请求失败");
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
            var examineStatus = $("#examineStatus").val();
            var str = $("#classStudentJson").val();
            var title = "选择学员";
            if (examineStatus == 1){
                title = "选择补考学员";
            }


            top.$.jBox("iframe:/school/examineInfo/selectStudent", {
                title:title,
                width:1024,
                height:520,
                buttons:{},
                ajaxData:{"classStudentJson":encodeURIComponent(str),
                    "examineStatus":examineStatus},
                closed:function () {
                    showStudents()
                }
            });
        });

        $("#examineType").change(function () {
            if($(this).val() == 2){
                $("#disbursementType").find("option").each(function (i,n) {
                    if($(n).val()== "1"){
                        $(n).attr("selected",true);
                        $("#s2id_disbursementType").find(".select2-chosen").text($(n).text());

                        $("#examineMethod option:last").attr("selected",true);
                        $("#s2id_examineMethod").find(".select2-chosen").text($("#examineMethod option:last").text());

                        $("#teacher").show();
                        $("#theoryExam").hide();
                        $("#actualExam").show();
                        $("#examStoreDiv").hide();
                        $("#disbursementType").attr("readonly",true);
                        $("#examineMethod").attr("readonly",true);
                        $("#passingGrade").removeClass("checkPoints");
                        $("#passingGrade").addClass("checkActualPoints");
                        showActualExam();
                        return;
                    }
                });

            }else{
                $("#theoryExam").show();
                $("#actualExam").hide();
                $("#teacher").hide();
                $("#examStoreDiv").show();
                $("#disbursementType").attr("readonly",false);

                $("#examineMethod option:first").attr("selected",true);
                $("#s2id_examineMethod").find(".select2-chosen").text($("#examineMethod option:first").text());

                $("#examineMethod").attr("readonly",false);
                $("#passingGrade").removeClass("checkActualPoints");
                $("#passingGrade").addClass("checkPoints");
            }
        });


        $("#addExam").click(function () {
            var exam = {"index":actualExamArray.length+1,
                "title":" ",
                "point":""};

            $("#actualExamTable").append(Mustache.render(actualExamTemplate,exam));
            actualExamArray.push(exam);

        });

        $("#examineType").trigger("change");
        $("#examineStore").trigger("change");

    });

    function selectClassCallback(classId,className) {
        $("#classId").val(classId);
        $("input[name='schoolClass.className']").val(className);
        findStudent(classId);
    }

    function findStudent(id){
        $.ajax({
            type:"POST",
            dataType: "json",
            async:false,
            url:"/school/class/findStudent",
            data:"id="+id,
            success:function(data){
                console.log(data);
                for(var i=0; i<data.length;i++){
                    var classId = data[i].schoolClass.id
                    var className = data[i].schoolClass.className
                    var studentId = data[i].student.id
                    var studentName = data[i].student.name
                    var studentNumber = data[i].student.studentNumber
                    if(studentArray.length<=0){
                        studentArray.push({
                            "classId":classId,
                            "className":className,
                            "studentId":studentId,
                            "studentName":studentName,
                            "studentNumber":studentNumber})
                    }else{
                        for(var i=0;i<studentArray.length;i++){
                            if(studentArray[i].classId == classId && studentArray[i].studentId == studentId){
                                break;
                            }else{
                                studentArray.push({
                                    "classId":classId,
                                    "className":className,
                                    "studentId":studentId,
                                    "studentName":studentName,
                                    "studentNumber":studentNumber})
                            }
                        }

                    }

                }
                showStudents();

            }
        });

    }


    function selectStudentCallback(classId,className,studentId,studentName,studentNumber,chked){
        for(var i=0;i<studentArray.length;i++){
            if (studentId == studentArray[i].studentId && classId == studentArray[i].classId){
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

        showStudents();
    }


    function showStudents(){
        $("#studentTable").html("");
        $("#studentTable").append(Mustache.render(studentTableTemplate, {"studentArray":studentArray}));
        $("#classStudentJson").val(JSON.stringify(studentArray));

        if (studentArray.length>0){
            $("#selectStudent").val("共"+studentArray.length+"名学员");
        }else{
            $("#selectStudent").val("");
        }
    }

    function showActualExam() {
        $("#actualExamTable").empty();
        for(var i=0;i<actualExamArray.length;i++){
            $("#actualExamTable").append(Mustache.render(actualExamTemplate,actualExamArray[i]));
        }
    }

    function removeClassStudents(studentId,classId){

        for(var i=0;i<studentArray.length;i++){
            if (studentId == studentArray[i].studentId && classId == studentArray[i].classId){
                studentArray.remove(i);
                break;
            }
        }
        showStudents();
    }

    function deleteActualExam(obj) {
        var index = $(obj).attr("index");

        $(obj).parents("table").remove();


        for(var i=0;i<actualExamArray.length;i++){
            if (index == actualExamArray[i].index){
                actualExamArray.remove(i);
                break;
            }
        }

        var i=1;
        $("#actualExamTable").find("td[title='index']").each(function () {
            $(this).text("题目"+i);
            i++;
        });
    }

    function showMessage(status,message) {
        $("#messageBox").remove();
        $("form").before('<div id="messageBox" class="alert alert-'+status+'"><button data-dismiss="alert" class="close">×</button>'+message+'</div>');
    }

    function examTime(dp) {

        var startTime = $("#startTime").val();
        var endTime = $("#endTime").val();

        if (startTime == "" || endTime=="")return;

        var sdate = new Date(startTime);
        var edate = new Date(endTime);



        var time = edate.getTime()-sdate.getTime();

        if (time <= 0){
            $("#examineLength").val(0);
            return;
        }
        $("#examineLength").val(time/1000/60);



    }

</script>
</body>
</html>
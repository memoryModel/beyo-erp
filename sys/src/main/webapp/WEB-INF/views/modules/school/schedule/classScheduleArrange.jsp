<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>排课管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>
<ul class="nav nav-tabs">
	<c:if test="${not empty schoolClassSchedule.id}">
		<li><a href="${ctx}/school/schedule/list">课表列表</a></li>
	</c:if>
	<c:if test="${empty schoolClassSchedule.id}">
		<li><a href="${ctx}/school/class/list">班级列表</a></li>
	</c:if>
	<li class="active">
		<a href="${ctx}/school/schedule/arrange?
					scheduleId=${schoolClassSchedule.id}&&classId=${schoolClassSchedule.schoolClass.id}&&lessonId=${schoolClassLesson.id}">
			<shiro:hasPermission name="school:schedule:arrange">
				${not empty schoolClassSchedule.id?'课表修改':'排课管理'}
			</shiro:hasPermission>
		</a>
	</li>
</ul><br/>
<form:form id="inputForm" modelAttribute="classSchedule" method="post" class="form-horizontal">
	<form:hidden path="id"/>
	<input type="hidden" name="scheduleJson" id="scheduleJson" style="width:1230px;"/>
	<input type="hidden" name="scheduleId" id="scheduleId" style="width:1230px;"/>
	<sys:message content="${message}"/>

	<div class="control-group">
		<label class="control-label">班级：</label>
		<div class="controls">
			<input type="hidden" id="schoolClassId" value="${schoolClassSchedule.schoolClass.id}">
			<input type="text" value="${schoolClassSchedule.schoolClass.className}" readonly="readonly">
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
	</div>

	<div class="control-group">
		<label class="control-label">课程：</label>
		<div class="controls">
			<input type="hidden" id="schoolClassLessonId" value="${schoolClassLesson.id}">
			<input type="text" id="lessonName" value="${schoolClassLesson.lessonName}" readonly="readonly">
			<c:if test="${schoolClassLesson.id == null}">
				<shiro:hasPermission name="school:schedule:selectLesson">
					<input id="selectLesson" class="btn btn-primary" type="button" value="选择课程"/>
				</shiro:hasPermission>
			</c:if>
			<font color="red">*</font>
			<label class="error" id="lessonNameError"></label>
		</div>
	</div>

	<div class="control-group">
		<label class="control-label">授课老师：</label>
		<div class="controls" teacher>
			<input type="hidden" id="teacherId"/>
			<input type="text" id="teacherName" class="input-large" readonly="readonly"/>
			<a href="javascript:;" name="selectTeacher">选择</a>
		</div>
	</div>
	<%--<div class="control-group">
        <label class="control-label">开始日期：</label>
        <div class="controls">
            <input name="beginTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
                value="<fmt:formatDate value="${schoolClassSchedule.beginTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
                onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">结束日期：</label>
        <div class="controls">
            <input name="endTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
                value="<fmt:formatDate value="${schoolClassSchedule.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
                onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
        </div>
    </div>--%>

	<%--<div class="control-group">
        <label class="control-label">上课教室：</label>
        <div class="controls">
            <form:select path="schoolClassroom.id" class="input-medium">
                <c:if test="${empty schoolClassSchedule.id}">
                    <form:option value="" label="--请选择--"/>
                </c:if>
                <form:options items="${classroomList}" itemLabel="classroomName" itemValue="id" htmlEscape="false"/>
            </form:select>
            <span class="help-inline"><font color="red">*</font> </span>
        </div>
    </div>--%>

	<div class="control-group">
		<label class="control-label">上课时间：</label>
		<div class="controls">
			<shiro:hasPermission name="school:schedule:selectSchedule">
				<input id="selectSchedule" class="btn btn-primary" type="button" value="添加上课时间"/>
			</shiro:hasPermission>
			<span class="help-inline"><font color="red">*</font> </span>&nbsp;&nbsp;
			<input type="checkbox" id="jumpHoliday" checked="checked"/>&nbsp;跳过节假日
		</div>

	</div><br/><br/>


	<table id="contentTable" class="table table-striped table-bordered table-condensed" style="width:75%;">
		<thead>
		<tr>
				<%--<th>课程Id</th>--%>
			<th>课程名称</th>
			<th>授课老师</th>
			<th>日期</th>
			<th>上课时间</th>
			<th>教室</th>
			<th>操作</th>
		</tr>
		</thead>
		<tbody id="scheduleTable">
		<script type="text/template" id="scheduleTableTemplate">
			{{#scheduleArray}}
			<tr>
					<%--<td>{{lessonId}}</td>--%>
				<td>{{lessonName}}</td>
				<td>{{teacherName}}</td>
				<td>{{day}}</td>
				<td>{{startTime}}-{{endTime}}</td>
				<td>{{roomName}}</td>
				<td>
					<input id="removeSchedules{{key}}" class="btn btn-primary" type="button" value="删 除"
						   onclick="removeSchedules('{{key}}')"/>
				</td>
			</tr>
			{{/scheduleArray}}

		</script>
		</tbody>
	</table>


	<div class="form-actions">
		<c:if test="${scheduleList != null}">
			<shiro:hasPermission name="school:schedule:saveScheduleList">
				<button type="button" class="btn btn-primary" onclick="submitSave()">保存</button>&nbsp;
			</shiro:hasPermission>
		</c:if>
			<%--<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>--%>
		<input id="btnCancel" class="btn" type="button" value="返 回"/>
	</div>
</form:form>
<script type="text/javascript">

    Date.prototype.Format = function(fmt){
        var o = {
            "M+" : this.getMonth()+1,                 //月份
            "d+" : this.getDate(),                    //日
            "h+" : this.getHours(),                   //小时
            "m+" : this.getMinutes(),                 //分
            "s+" : this.getSeconds(),                 //秒
            "q+" : Math.floor((this.getMonth()+3)/3), //季度
            "S"  : this.getMilliseconds()             //毫秒
        };
        if(/(y+)/.test(fmt))
            fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));
        for(var k in o)
            if(new RegExp("("+ k +")").test(fmt))
                fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));
        return fmt;
    };

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
    var classScheduleList = ${fns:toJson(scheduleList)};  //scheduleList后台查询已有课表信息
    var scheduleTableTemplate = $("#scheduleTableTemplate").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
    var scheduleArray = new Array();
    var lessonId;

    //scheduleArray追加数据
    function pushscheduleArray(key,lessonId,lessonName,teacherId,teacherName,roomId,startTime,endTime,roomName,day){
        scheduleArray.push({
            "key":key,
            "lessonId":lessonId,
            "lessonName":lessonName,
            "teacherId":teacherId,
            "teacherName":teacherName,
            "roomId":roomId,
            "startTime":startTime,
            "endTime":endTime,
            "roomName":roomName,
            "day":day,
        });
    }

    //读取后台传递的已有课表列表
    for(var i=0;i<classScheduleList.length;i++){
        var obj = classScheduleList[i];
        var dayTime = new Date(obj.beginTime);

        var day = dayTime.Format("yyyy-MM-dd");
        var lessonId = obj.schoolClassLesson.id;
        var lessonName = obj.schoolClassLesson.lessonName;
        var roomId = obj.schoolClassroom.id;
        var teacherId = obj.teacher.id;
        var teacherName = obj.teacher.name;
        var roomName = obj.schoolClassroom.classroomName;
        var startTime = dayTime.Format("hh:mm");
        var endTime = (new Date(obj.endTime)).Format("hh:mm");

        var key = roomId+day+startTime+endTime;

        pushscheduleArray(key,lessonId,lessonName,teacherId,teacherName,roomId,startTime,endTime,roomName,day);

    }
    $(function () {
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

            if(${not empty schoolClassSchedule.id}) window.location.href="${ctx}/school/schedule/list";
            if(${empty schoolClassSchedule.id}) window.location.href="${ctx}/school/class/list";
        });

        //点击添加排课
        $("#selectSchedule").click(function () {
            var lv = lessonValidate();
            if(!lv) return;

            var jumpHoliday = $("#jumpHoliday").attr("checked");
            if(jumpHoliday == "checked"){
                jumpHoliday = 0;//跳过节假日
            }else{
                jumpHoliday = 1;//不跳过节假日
            }
            var str = $("#scheduleJson").val();

            top.$.jBox.open("iframe:/school/schedule/selectSchedule",
                "选择上课时间",
                1024,
                520,
                {ajaxData:{"jumpHoliday":jumpHoliday,"scheduleJson":encodeURIComponent(str),"schoolClassId":$("#schoolClassId").val(),"schoolClassLessonId":$("#schoolClassLessonId").val()}}
            );
        });

        //点击选择课程
        $("#selectLesson").click(function () {
            lessonId = $("#schoolClassLessonId").val();
            console.log(lessonId);
            top.$.jBox.open("iframe:/school/schedule/selectLesson",
                "选择课程",
                1024,
                520,
                {ajaxData:{"schoolClassId":$("#schoolClassId").val()}}
            );
        });

        //选择授课老师
        $('a[name="selectTeacher"]').click(function () {
            top.$.jBox("iframe:/school/schedule/selectTeacher", {
                title:"选择授课老师",
                width:500,
                height:400,
                buttons:{}
            });
        })

        showScheduleList();
    })


    function showScheduleList(){
        $("#scheduleTable").empty();
        scheduleArray.sort(function (x, y){
            if (x.day > y.day){
                return 1;
            }else if(x.startTime > y.startTime){
                return 1;
            }else {
                return 0;
            }
        });
        $("#scheduleTable").append(Mustache.render(scheduleTableTemplate, {"scheduleArray":scheduleArray}));
        $("#scheduleJson").val(JSON.stringify(scheduleArray));
    }

    //jbox回显选择班级的课程数据
    function selectLessonCallback(lessonId,lessonName,teacherId,teacherName,subjectId,subjectName,scheduleList) {
        $("#schoolClassLessonId").val(lessonId);
        $("#lessonName").val(lessonName);
        //$("#teacherId").val(teacherId);
        //$("#teacherName").val(teacherName);
        var teacherIdArray = teacherId.split(',');
        var teacherNameArray = teacherName.split(',');
        $('span[radio]').remove();
        for(var i=0;i<teacherIdArray.length;i++){
            var radioHTML = '<span radio><input type="radio" name="radioTeacherName" id="radioTeacherId" teacherName='+teacherNameArray[i]+' value='+teacherIdArray[i]+'>'+teacherNameArray[i]+'</span>';
            $('div[teacher]').prepend(radioHTML);
        }
        $('span[radio]:first').find('input[type="radio"]').attr("checked",true);

        $('input[type="radio"]').click(function () {
            $('input[type="radio"]').each(function () {
                if($(this).attr('checked')){
                    $("#teacherId").val('');
                    $("#teacherName").val('');
                }
            })
        })

        //var schArray = new Array();
        //scheduleArray 重置为该班级指定课程的课表数据
        /*for(var i=0;i<scheduleArray.length;i++){
            var a = lessonId;
            var b = scheduleArray[i].lessonId;
            //alert(a != b);
            if (lessonId == scheduleArray[i].lessonId){
                schArray.push({
                    "key":scheduleArray[i].key,
                    "lessonId":scheduleArray[i].lessonId,
                    "lessonName":scheduleArray[i].lessonName,
                    "teacherId":scheduleArray[i].teacherId,
                    "teacherName":scheduleArray[i].teacherName,
                    "roomId":scheduleArray[i].roomId,
                    "startTime":scheduleArray[i].startTime,
                    "endTime":scheduleArray[i].endTime,
                    "roomName":scheduleArray[i].roomName,
                    "day":scheduleArray[i].day,
                    "classId":$("#schoolClassId").val()
                });
            }
        }*/
        //scheduleArray = schArray;

        /*for(var i=0;i<scheduleList.length;i++){
            var obj = scheduleList[i];

            var dayTime = new Date(obj.beginTime);

            var day = dayTime.Format("yyyy-MM-dd");
            var teacherId = obj.teacher.id;
            var teacherName = obj.teacher.name;
            var roomId = obj.schoolClassroom.id;
            var roomName = obj.schoolClassroom.classroomName;
            var startTime = dayTime.Format("hh:mm");
            var endTime = (new Date(obj.endTime)).Format("hh:mm");

            var key = roomId+day+startTime+endTime;


            pushscheduleArray(key,lessonId,lessonName,teacherId,teacherName,roomId,startTime,endTime,roomName,day);
            //pushscheduleArray(key,lessonName,teacherId,teacherName,roomId,startTime,endTime,roomName,day);
        }*/
        /*$("#scheduleTable").empty();
        $("#scheduleTable").append(Mustache.render(scheduleTableTemplate, {"scheduleArray":scheduleArray}));
        $("#scheduleJson").val(JSON.stringify(scheduleArray));*/

        lessonValidate();
    }


    //jbox回显排课数据
    function selectScheduleCallback(roomId,startTime,endTime,dayTime,roomName,chked) {
        var daytime = new Date();
        daytime.setTime(dayTime);
        var day = daytime.Format("yyyy-MM-dd");
        var key = roomId+day+startTime+endTime;

        for(var i=0;i<scheduleArray.length;i++){
            if (key == scheduleArray[i].key){
                if (chked == "checked"){
                    return;
                }else{
                    scheduleArray.remove(i);
                    showScheduleList();
                    return;
                }
            }
        }
        var teacher = getTeacherIdAndName();
        pushscheduleArray(key,$("#schoolClassLessonId").val(),$("#lessonName").val(),teacher.teacherId,teacher.teacherName,roomId,startTime,endTime,roomName,day);
        //pushscheduleArray(key,roomId,startTime,endTime,roomName,day);
        showScheduleList();

    }

    function removeSchedules(key){
        console.log(key);
        for(var i=0;i<scheduleArray.length;i++){
            if (key == scheduleArray[i].key){
                scheduleArray.remove(i);
                showScheduleList();
                return;
            }
        }
    }

    //验证课程是否为空
    function lessonValidate(){
        var lessonName = $("#lessonName").val();
        if(null == lessonName || "" == lessonName){
            $("#lessonNameError").html("请选择课程！");
            return false;
        }else{
            $("#lessonNameError").html("");
            return true;
        }
    }


    //提交from表单
    function submitSave() {
        var schedule = $("#scheduleJson");
        var schoolSchedule = new Array();
        var classId = $("#schoolClassId").val();
        lessonId = $("#schoolClassLessonId").val();

        //console.log(id+"----"+lessonId+"----"+classId);
        for(var i=0;i<scheduleArray.length;i++){
            schoolSchedule.push({
                "lessonId":scheduleArray[i].lessonId,
                "teacherId":scheduleArray[i].teacherId,
                "roomId":scheduleArray[i].roomId,
                "beginTime":scheduleArray[i].day + " "+ scheduleArray[i].startTime,
                "endTime":scheduleArray[i].day + " "+ scheduleArray[i].endTime,
            });
            console.log("classId:"+schoolSchedule[i].classId+",startTime:"+ schoolSchedule[i].beginTime + ",endTime:"+ schoolSchedule[i].endTime);
        }

        var lv = lessonValidate();
        if(!lv) return;
        $.ajax({
            type : 'post',
            url : '${ctx}/school/schedule/saveScheduleList',
            data:{"scheduleJson":encodeURIComponent(JSON.stringify(schoolSchedule)),"classIdStr":classId},
            success : function(data) {
                if (data && data.result == "success") {
                    if(${tagFlag==0}) location.href = '${ctx}/school/class/list';
                    if(${tagFlag!=0}) location.href = '${ctx}/school/schedule/list';
                } else {
                    window.location.reload();
                }
            }
        })

    }

    //选择授课老师后回调
    function selectTeacherCallback(teacherId,teacherName) {
        $('#teacherId').val(teacherId);
        $('#teacherName').val(teacherName);
        $('input[type="radio"]').attr("checked",false);
    }

    //获得授课老师和名字
    function getTeacherIdAndName() {
        var teacher = new Object();
        var radioHTML = $('input[type="radio"]')
        for(var i=0;i<radioHTML.length;i++){
            if($(radioHTML[i]).attr('checked')){
                var teacherId = $(radioHTML[i]).val();
                var teacherName = $(radioHTML[i]).attr('teacherName');
                teacher.teacherId = teacherId;
                teacher.teacherName = teacherName;
                return teacher;
            }
        }
        var teacherId = $('#teacherId').val();
        var teacherName = $('#teacherName').val();
        teacher.teacherId = teacherId;
        teacher.teacherName = teacherName;
        return teacher;
    }

</script>
</body>
</html>
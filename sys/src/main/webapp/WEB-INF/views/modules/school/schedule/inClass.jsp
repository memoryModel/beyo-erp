<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>合班上课</title>
	<meta name="decorator" content="default"/>
</head>
<body>
<form:form id="inputForm" modelAttribute="classSchedule" method="post" class="form-horizontal">
        <input type="hidden" name="scheduleJson" id="scheduleJson"/>
        <input type="hidden" name="scheduleId" id="scheduleId"/>
        <input type="hidden" id="schoolClassIds">
		<sys:message content="${message}"/>		

		<div class="control-group">
			<label class="control-label">选择课程：</label>
			<div class="controls">
                <input type="hidden" id="schoolClassLessonId">
                <input type="text" id="lessonName" readonly="readonly">
                <input id="selectLesson" class="btn btn-primary" type="button" value="选择课程"/>
				<span class="help-inline"><font color="red">*</font> </span>
                <label class="error" id="lessonNameError"></label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">选择授课老师：</label>
			<div class="controls" teacher>
				<input type="hidden" id="teacherId"/>
				<input type="text" id="teacherName" class="input-large" readonly="readonly"/>
				<a href="javascript:;" name="selectTeacher">选择</a>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">选择上课时间和教室：</label>
			<div class="controls">
                <input id="selectSchedule" class="btn btn-primary" type="button" value="添加上课时间"/>
                <span class="help-inline"><font color="red">*</font> </span>&nbsp;&nbsp;
                <input type="checkbox" id="jumpHoliday" checked="checked"/>&nbsp;跳过节假日
                <label class="error" id="scheduleArrayError"></label>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">选择排课班级：</label>
			<div class="controls">
                <input id="selectClass" class="btn btn-primary" type="button" value="选择班级"/>
                <span class="help-inline"><font color="red">*</font></span>
                <label class="error" id="schoolClassIdsError"></label>
			</div>
		</div>
        <br/><br/>

        <table id="contentTable" class="table table-striped table-bordered table-condensed" style="width:75%;">
            <thead>
            <tr schedule="thead">
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
                <tr schedule="tbody">
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
</form:form>
		<div class="form-actions">
            <button type="button" class="btn btn-primary" onclick="submitSave()">保存</button>&nbsp;
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
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
                "day":day
            });
        }

        $(document).ready(function() {
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

            //点击选择课程
            $("#selectLesson").click(function () {
                top.$.jBox("iframe:/school/schedule/selectAllLesson",{
                        title:"选择课程",
                        width:1024,
                        height:520,
                        buttons:{},
                        closed:function(){
                        }
                    }
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
                    {ajaxData:{"jumpHoliday":jumpHoliday,"scheduleJson":encodeURIComponent(str),"allScheduleFlag":"y"}}
                );
            });

            //选择班级
            $('#selectClass').click(function(){
                top.$.jBox.open("iframe:/school/schedule/selectClass",
                    "选择班级",
                    1024,
                    520,
                    {ajaxData:{"scheduleJson":encodeURIComponent(JSON.stringify(scheduleArray))}}
                );
            });
        });
        //选择课程回调
        function selectAllLessonCallback(lessonId,lessonName,teacherId,teacherName,subjectId,subjectName){
            $("#schoolClassLessonId").val(lessonId);
            $("#lessonName").val(lessonName);
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
        }

        //选择授课老师后回调
        function selectTeacherCallback(teacherId,teacherName) {
            $('#teacherId').val(teacherId);
            $('#teacherName').val(teacherName);
            $('input[type="radio"]').attr("checked",false);
        }

        //回显排课数据
        function selectScheduleCallback(roomId,startTime,endTime,dayTime,roomName,chked){
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
            showScheduleList();
        }

        //回显选择班级
        function selectClassallback(classIds,classNames){
            var classTheadHtml = '<th className>班级</th>';
            $('tr[schedule="thead"]').find('th[className]').remove();
            $('tr[schedule="thead"]').prepend(classTheadHtml);

            var classNamesHtml = '<td classNames>'+classNames+'</td>';
            $('tr[schedule="tbody"]').find('td[classNames]').remove();
            $('tr[schedule="tbody"]').prepend(classNamesHtml);

            $('#schoolClassIds').val(classIds);
        }


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

        function removeSchedules(key){
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

        //验证上课时间是否为空
        function scheduleValidate(){
            if(!scheduleArray || scheduleArray.length == 0){
                $("#scheduleArrayError").html("请选择上课时间！");
                return false;
            }else{
                $("#scheduleArrayError").html("");
                return true;
            }
        }

        //验证班级
        function classValidate(){
            var schoolClassIds = $('#schoolClassIds').val()
            if(!schoolClassIds){
                $("#schoolClassIdsError").html("请选择班级！");
                return false;
            }else{
                $("#schoolClassIdsError").html("");
                return true;
            }
        }

        function submitSave(){
            var schoolSchedule = new Array();
            var lv = lessonValidate();
            var sv = scheduleValidate();
            var cv = classValidate();
            if(!lv || !sv || !cv) return;
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

            $.ajax({
                type : 'post',
                url : '${ctx}/school/schedule/saveScheduleList',
                data:{"scheduleJson":encodeURIComponent(JSON.stringify(schoolSchedule)),"classIdStr":$('#schoolClassIds').val()},
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
    </script>
</body>
</html>
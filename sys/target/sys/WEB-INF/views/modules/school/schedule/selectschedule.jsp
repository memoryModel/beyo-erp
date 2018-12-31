<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
<html>
<body>
<script type="text/javascript">

    var dayNames = ["周日", "周一", "周二", "周三", "周四", "周五", "周六"];

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
    }
    function getNewDay(dateTemp, days) {
        var dateTemp = dateTemp.split("-");
        var nDate = new Date(dateTemp[1] + '-' + dateTemp[2] + '-' + dateTemp[0]); //转换为MM-DD-YYYY格式
        var millSeconds = Math.abs(nDate) + (days * 24 * 60 * 60 * 1000);
        var rDate = new Date(millSeconds);
        var year = rDate.getFullYear();
        var month = rDate.getMonth() + 1;
        if (month < 10) month = "0" + month;
        var date = rDate.getDate();
        if (date < 10) date = "0" + date;
        return new Date(year + "-" + month + "-" + date);
    }


    //
    var currentDay = new Date();
    var currentClassId = "${schoolClassId}";
    var currentClassLessonId = "${schoolClassLessonId}";
    var classroomList = ${fns:toJson(classroomList)};
    var classTimeList = ${fns:toJson(classTimeList)};
    var holidayList = ${fns:toJson(holidayList)};
    var classScheduleList = ${fns:toJson(classScheduleList)};

    var scheduleJson = "${scheduleJson}";
    var classTime = {"am":new Array(),"pm":new Array()};

    for(i=0;i<classTimeList.length;i++){
        var obj = classTimeList[i];
        obj.startTime = currentDay.Format("yyyy-MM-dd")+" "+obj.startTime;
        obj.endTime = currentDay.Format("yyyy-MM-dd")+" "+obj.endTime;
        var starthour = new Date(obj.startTime).Format("hh:mm");
        var endhour = new Date(obj.endTime).Format("hh:mm");
        if (starthour>"12:00"){
            classTime.pm.push({"lessonName":obj.lessonName,"startTime":starthour,"endTime":endhour,"id":obj.id,"dayTime":obj.startTime});
        }else{
            classTime.am.push({"lessonName":obj.lessonName,"startTime":starthour,"endTime":endhour,"id":obj.id,"dayTime":obj.startTime});
        }

    }

    var scheduleDataArray = JSON.parse(decodeURIComponent(scheduleJson));


    for(var i=0;i<scheduleDataArray.length;i++) {
        var obj = scheduleDataArray[i];
        var dt = new Date(obj.day);
        var key = dt.Format("MMdd") + obj.startTime.replace(":", "") + obj.endTime.replace(":", "");
        scheduleDataArray[i].key = key;
    }


    var timesTemplate;
    var scheduleTemplate;
    var weekdayArray;

    var holidayArray = new Array();
    for(i=0;i<holidayList.length;i++){
        holidayArray.push((new Date(holidayList[i].holidayTime)).Format("MM-dd"));
    }
    var today = currentDay.Format("MM-dd");

    $(function () {
        timesTemplate = $("#timesTemplate").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
        scheduleTemplate = $("#scheduleTemplate").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");

        showWeek(currentDay);
        showSchedule();
        //检查下拉框选择的之前有没有排过课的教室
        checkselectClass();
    })

    function showWeek(currentDay) {
        //重置为周一
        if (currentDay.getDay()!=1){
            var d = 1 - currentDay.getDay();
            currentDay = getNewDay(currentDay.Format("yyyy-MM-dd"),d);
        }

        weekdayArray = new Array();

        for(var i=0;i<7;i++){

            var weekday = new Object();
            weekday.day = getNewDay(currentDay.Format("yyyy-MM-dd"),i);

            weekday.times = weekday.day.getTime();
            weekday.mmdd = weekday.day.Format("MMdd");
            weekday.hhdd = weekday.day.Format("MM-dd");
            if ( weekday.hhdd == today){
                weekday.title = "今天  "+dayNames[weekday.day.getDay()];
            }else{
                weekday.title = weekday.hhdd+"  "+dayNames[weekday.day.getDay()];
            }

            if (i==0){
                weekday.left = 1;
            }else  if(i == 6){
                weekday.right = 1;
            }


            for(var j=0;j<holidayArray.length;j++){
                if(holidayArray[j] == weekday.hhdd){
                    weekday.holiday = 1;
                    weekday.busy = 1;
                }
            }
            weekday.scheduleTime = weekday.day.Format("yyyy-MM-dd");
            weekdayArray.push(weekday);
        }

        $("#scheduleTable").append(Mustache.render(timesTemplate, {"weekdayArray":weekdayArray}));

        $("#leftPage").click(function () {
            $("#scheduleTable").fadeToggle(300,"linear",function () {
                currentDay = getNewDay(currentDay.Format("yyyy-MM-dd"),-7);

                $("#scheduleTable").html("");
                showWeek(currentDay);
                showSchedule();
                $("#scheduleTable").show();
                checkselectClass();
            });



        });
        $("#rightPage").click(function () {
            $("#scheduleTable").fadeToggle(300,"linear",function () {
                currentDay = getNewDay(currentDay.Format("yyyy-MM-dd"),7);

                $("#scheduleTable").html("");
                showWeek(currentDay);
                showSchedule();
                $("#scheduleTable").show();
                checkselectClass();
            });



        });
    }

    function showSchedule(){
        var content;
        for(i=0;i<classTime.am.length;i++){
            content = new Object();
            var ct = classTime.am[i];
            if(i==0){
                content.len = classTime.am.length;
                content.area = '上午';
                //content.title = '第'+(i+1)+"节课";
                content.time = ct.startTime+"-"+ct.endTime;
            }else{
                //content.title = '第'+(i+1)+"节课";
                content.time = ct.startTime+"-"+ct.endTime;
            }
            content.title = ct.lessonName;
            content.dayTime = ct.dayTime;
            content.ct = ct;
            content.timeId = ct.startTime.replace(":","")+ct.endTime.replace(":","");
            content.schedule = weekdayArray;



            content.roomList = classroomList;
            $("#scheduleTable").append(Mustache.render(scheduleTemplate, {"content":content}));
        }


        for(i=0;i<classTime.pm.length;i++){
            content = new Object();
            var ct = classTime.pm[i];
            if(i==0){
                content.len = classTime.pm.length;
                content.area = '下午';
                //content.title = '第'+(i+1+classTime.am.length)+"节课";
                content.time = ct.startTime+"-"+ct.endTime;
            }else{
                //content.title = '第'+(i+1+classTime.am.length)+"节课";
                content.time = ct.startTime+"-"+ct.endTime;
            }
            content.title = ct.lessonName;
            content.dayTime = ct.dayTime;
            content.ct = ct;
            content.timeId = ct.startTime.replace(":","")+ct.endTime.replace(":","");
            content.schedule = weekdayArray;
            content.roomList =  classroomList;

            $("#scheduleTable").append(Mustache.render(scheduleTemplate, {"content":content}));
        }


        //旧数据
        for(var k=0;k<scheduleDataArray.length;k++) {
            var obj = scheduleDataArray[k];
            $("#checkbox"+obj.key).attr("checked",true);
            $("#classRoom"+obj.key).find("option[value="+obj.roomId+"]").attr("selected",true);
            if (obj.lessonId != currentClassLessonId || obj.classId != currentClassId){
                $("#checkbox"+obj.key).attr("disabled",true);
                //$("#classRoom"+obj.key).attr("disabled",true);
                $("#schedule"+obj.key).text("已占用");
            }
        }

        //教室占用
        for(var i=0;i<classScheduleList.length;i++){
            var obj = classScheduleList[i];

            var dayTime = new Date(obj.beginTime);
            var day = dayTime.Format("MMdd");
            var roomId = obj.schoolClassroom.id;
            var startTime = dayTime.Format("hhmm");
            var endTime = (new Date(obj.endTime)).Format("hhmm");
            var key = day+startTime+endTime;
            var lessonId = obj.schoolClassLesson.id;
            var classId = obj.schoolClass.id;
            var roomName = obj.schoolClassroom.classroomName;
            var lessonName = obj.schoolClassLesson.lessonName;
            var teacherName = obj.teacher.name;
            var className = obj.schoolClass.className;
            $("#checkbox"+key).attr("checked",true);
            $("#classRoom"+key).find("option[value="+roomId+"]").attr("selected",true);
            var content = $("#schedule"+key).html();
            $("#schedule"+key).html(content+className+lessonName+teacherName+roomName+"已占用"+'<br/>');
            if (lessonId != currentClassLessonId ){
                $("#checkbox"+key).attr("disabled",true);
                //$("#classRoom"+key).attr("disabled",true);
                $("#checkbox"+key).attr("checked",true);

            }
            if(lessonId == currentClassLessonId){
                $("#checkbox"+key).attr("checked",false);
                $("#checkbox"+key).attr("disabled",false);
            }
//			var scheduleTime = (new Date(classScheduleList[n].beginTime)).Format("yyyy-MM-dd hh:mm");
//			$("select[scheduleTime='"+scheduleTime+"'] option[value='"+classScheduleList[n].schoolClassroom.id+"']").remove();

        }


        //-----------------------------------

    }


    function selectSchedule(time,timeId,startTime,endTime,times){

        var roomId = $("#classRoom"+time+timeId).val();
        var roomName =  $("#classRoom"+time+timeId+"  option:selected").text();
        var chked = $("#checkbox"+time+timeId).attr("checked");
        if (chked == "checked"){
            $("#classRoom"+time+timeId).attr("disabled",true);
        }else{
            $("#classRoom"+time+timeId).attr("disabled",false);
        }

        parent.window.frames["mainFrame"].selectScheduleCallback(roomId,startTime,endTime,times,roomName,chked);
    }


    function checkselectClass() {
        $('select').change(function () {
            var selectHTML = $(this);
            var selectFlag = $(this).attr('selectFlag');
            var selectHTMLRoomId = $(this).find('option:selected').val();
            //旧数据
            /*for(var k=0;k<scheduleDataArray.length;k++) {
                var obj = scheduleDataArray[k];
                var roomId = obj.roomId;
                $("#checkbox"+obj.key).attr("checked",false);
                var selectRoomId = $('#classRoom'+obj.key+' option:selected').val();
                if(selectRoomId == roomId){
                    $("#checkbox"+obj.key).attr("checked",true);
                }
            }*/
            var flag = false;

            //教室占用
            for(var i=0;i<classScheduleList.length;i++){
                var obj = classScheduleList[i];

                var dayTime = new Date(obj.beginTime);
                var day = dayTime.Format("MMdd");
                var roomId = obj.schoolClassroom.id;
                var startTime = dayTime.Format("hhmm");
                var endTime = (new Date(obj.endTime)).Format("hhmm");
                var key = day+startTime+endTime;
                var lessonId = obj.schoolClassLesson.id;
                var classId = obj.schoolClass.id;
                var roomName = obj.schoolClassroom.classroomName;
                var lessonName = obj.schoolClassLesson.lessonName;
                var teacherName = obj.teacher.name;
                var className = obj.schoolClass.className;
                if(key == selectFlag){
                    if(flag){
                        $("#checkbox"+selectFlag).attr("disabled",true);
                    }
                    if(selectHTMLRoomId != roomId){
                        $("#checkbox"+selectFlag).attr("checked",false);
                        $("#checkbox"+selectFlag).attr("disabled",false);
                    }else{
                        if(classId != currentClassId){
                            if(lessonId == currentClassLessonId){
                                $("#checkbox"+selectFlag).attr("checked",false);
                                $("#checkbox"+selectFlag).attr("disabled",false);
                            }else{
                                $("#checkbox"+selectFlag).attr("disabled",true);
                                flag = true;
                            }
                        }else{
                            $("#checkbox"+selectFlag).attr("disabled",true);
                        }
                    }
                    if(flag == true && i == (classScheduleList.length-1)){
                        $("#checkbox"+selectFlag).attr("disabled",true);
                    }
                }
                flag = false;

            }
        })
    }


</script>
<table id="scheduleTable" class="table table-striped table-bordered table-condensed">
</table>
<script type="text/template" id="timesTemplate">
	<thead>
	<th colspan="2">
		课时/日期
	</th>
	{{#weekdayArray}}
	<th>
		{{#left}}
		<a href="javascript:void(0)" id="leftPage">向左</a>&nbsp;&nbsp;
		{{/left}}

		{{title}}

		{{#right}}
		&nbsp;&nbsp;<a href="javascript:void(0)" id="rightPage">向右</a>
		{{/right}}
	</th>
	{{/weekdayArray}}
	</thead>
</script>
<script type="text/template" id="scheduleTemplate">
	<tr>
		{{#content.len}}
		<td rowspan="{{content.len}}">{{content.area}}</td>
		{{/content.len}}
		<td>
			<p>{{content.title}}</p>
			<p>{{content.time}}</p>
		</td>
		{{#content.schedule}}
		<td>
			{{#holiday}}
			假日
			{{/holiday}}

			{{^busy}}
			<p><span id="schedule{{mmdd}}{{content.timeId}}"></span></p>
			<p><input type="checkbox" id="checkbox{{mmdd}}{{content.timeId}}" onclick="selectSchedule('{{mmdd}}','{{content.timeId}}','{{content.ct.startTime}}','{{content.ct.endTime}}','{{times}}')"/><span>排课{{mmdd}}{{content.timeId}}</span></p>
			<p><select id="classRoom{{mmdd}}{{content.timeId}}" selectFlag="{{mmdd}}{{content.timeId}}" scheduleTime="{{scheduleTime}} {{content.ct.startTime}}">
				{{#content.roomList}}
				<option value="{{id}}">{{classroomName}}</option>
				{{/content.roomList}}
			</select>
			</p>
			{{/busy}}

		</td>
		{{/content.schedule}}
	</tr>
</script>
</body>
</html>
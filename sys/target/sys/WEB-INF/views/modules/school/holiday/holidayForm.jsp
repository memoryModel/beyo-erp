<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<!-- Long live the font Ubuntu ! -->

	<script src="/static/tools/bic_calendar.js"></script>
	<link href="/static/bootstrap/css/bootstrap.css" rel="stylesheet">
	<script src="/static/bootstrap/2.3.1/js/bootstrap.min.js"></script>
	<link href="/static/tools/bic_calendar.css" rel="stylesheet">
	<style>
		body{
			background: #f0f0f0;
			padding-top: 20px;
			background-image: url(/static/tools/grid-18px-masked.png);
			background-position: top;
			background-repeat: repeat-x;
			background-attachment: fixed;
		}
		footer{
			padding-top: 100px;
		}
		.pintam{
			box-shadow: rgba(0,0,0,0.3) 0 1px 3px;
			background: #f7f7f7;
			border-radius: 5px;
		}
		.jumbotron{
			box-shadow: 0 0 10px #ccc;
			margin-top: 10px;
			margin-bottom: 10px;
		}
		.atzucac{
			padding: 20px;
		}
		.container{
			max-width: 1200px;
			margin-right: 100px;
		}
		.selectedDate{
			background-color:rgba(141,200,230,0.5);
		}
	</style>
	<title>节假日管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
        $(document).ready(function() {

        });
        function page(n,s){
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").submit();
            return false;
        }
        //格式化日期
        Date.prototype.Format = function(format){
            var o = {
                "M+" : this.getMonth()+1, //month
                "d+" : this.getDate(), //day
                "h+" : this.getHours(), //hour
                "m+" : this.getMinutes(), //minute
                "s+" : this.getSeconds(), //second
                "q+" : Math.floor((this.getMonth()+3)/3), //quarter
                "S" : this.getMilliseconds() //millisecond
            }
            if(/(y+)/.test(format)) {
                format = format.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));
            }
            for(var k in o) {
                if(new RegExp("("+ k +")").test(format)) {
                    format = format.replace(RegExp.$1, RegExp.$1.length==1 ? o[k] : ("00"+ o[k]).substr((""+ o[k]).length));
                }
            }
            return format;
        }

	</script>
</head>
<body>
<c:if test="${!empty result}">
	<div class="form-actions">
		<c:choose>
			<c:when test="${result == 'success'}">
				<div id="messageBox" class="alert alert-success"><button data-dismiss="alert" class="close">×</button>节假日保存成功</div>
			</c:when>
			<c:otherwise>
				<div id="messageBox" class="alert alert-success"><button data-dismiss="alert" class="close">×</button>节假日保存失败</div>
			</c:otherwise>
		</c:choose>
	</div>
</c:if>
<div style="float: right; margin-top: 20px">
	<table id="mytable">
		<form:form id="inputForm" modelAttribute="holiday" action="${ctx}/erp/holiday/save" method="post" class="form-horizontal">
			<input type="hidden" id="times" name="times"/>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<div class="form-actions">
						<shiro:hasPermission name="erp:holiday:save"><input id="btnSubmit" class="btn btn-primary" type="submit" value="确 定"/>&nbsp;</shiro:hasPermission>
						<input id="btnCancel" class="btn" type="button" value="取 消" onclick="history.go(1)"/>					</div>
				</td>
			</tr>
		</form:form>
	</table>
</div>
<div class="container" style="float: left;">
	<div id="row">
		<div class="col-md-12" >
			<br>
			<script>

                Array.prototype.remove=function(dx)
                {
                    if(isNaN(dx)||dx>this.length){return false;}
                    for(var i=0,n=0;i<this.length;i++)
                    {
                        if(this[i]!=this[dx])
                        {
                            this[n++]=this[i]
                        }
                    }
                    this.length-=1
                }
                var holidayDateArray = new Array();
                var holidaySelectDateArray = new Array();
                <c:forEach items="${erpHolidayList}" var="holiday">
				holidayDateArray.push('<fmt:formatDate value="${holiday.holidayTime}" pattern="d/M/yyyy"/>');
                holidaySelectDateArray.push('<fmt:formatDate value="${holiday.holidayTime}" pattern="M/d/yyyy"/>');
                </c:forEach>
                $("#times").val(holidaySelectDateArray.toString());


                $(document).ready(function() {

                    var monthNames = ["1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月"];

                    var dayNames = ["周一", "周二", "周三", "周四", "周五", "周六", "周日"];
                    var date = new Date();
                    var today = date.Format("d/M/yyyy");
                    var events = [
                        {
                            date: today,
                            title: '今天',
                            link: '#',
                            color: 'green',
                            content: '',
                            class: '',
                        }
                    ];
                    for(i=0;i<holidayDateArray.length;i++){
                        events.push({
                            date: holidayDateArray[i],
                            title: holidayDateArray[i],
                            link: '#',
                            color: '',
                            content: '',
                            class: 'selectedDate event',
                        });
                    }


                    var bicCalendar = $('#calendari_lateral1').bic_calendar({
                        //list of events in array
                        events: events,
                        //enable select
                        enableSelect: true,
                        //enable multi-select
                        multiSelect: false,
                        //set day names
                        dayNames: dayNames,
                        //set month names
                        monthNames: monthNames,
                        //show dayNames
                        showDays: true,
                        //set ajax call
                        //reqAjax: {
                        //    type: 'get',
                        //    url: 'http://bic.cat/bic_calendar/index.php'
                        //}
                        //set popover options
                        //popoverOptions: {}
                        //set tooltip options
                        //tooltipOptions: {}
                    });
                    document.addEventListener('bicCalendarSelect', function(e) {
						console.log(holidaySelectDateArray);

                        $('#calendari_lateral1').find("td").each(function(){
                            if($(this).attr("data-date")==e.detail.date){
                                if($(this).hasClass("selectedDate")){
                                    $(this).removeClass("selectedDate");
                                    $(this).removeClass("event");

                                    //$(this).addClass("cancelDate");


                                    //定义数组
                                    for(i=0;i<holidaySelectDateArray.length;i++){
                                        if(e.detail.date == holidaySelectDateArray[i]){
                                            holidaySelectDateArray.remove(i);
                                            $(this).removeClass("week-day-"+(i+2));
                                            break;
                                        }
                                    }


                                }else{
                                    //$(this).removeClass("cancelDate");
                                    $(this).addClass("selectedDate event");

                                    holidaySelectDateArray.push(e.detail.date);
                                }

                            }
                        });


                        $("#times").val(holidaySelectDateArray.toString());
                    });
                });
			</script>
			<div id="calendari_lateral1"></div>
		</div>
	</div>
</div>
</body>
</html>
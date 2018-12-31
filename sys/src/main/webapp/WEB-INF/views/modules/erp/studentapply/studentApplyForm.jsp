<%@ taglib prefix="s" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
<html>
<head>
	<title>学员报名管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>
<ul class="nav nav-tabs">
</ul>
<br/>
<form:form id="inputForm" modelAttribute="student" action="${ctx}/erp/studentApply/save" method="post" class="form-horizontal" >
	<form:hidden path="id" id="studentId"/>
	<form:hidden path="studentNumber"/>
	<form:hidden path="studentType"/>
	<form:hidden path="status"/>
	<input type="hidden" id="oldPhone"/>
	<input type="hidden" id="oldStudentNumber"/>
	<input type="hidden" name="classJson" id="classJson"/>
	<div class="control-group">
		<label class="control-label">选择生源：</label>
		<div class="controls">
			<!--从学生选择-->
			<input id="selectErpStudent" class="btn btn-primary" type="button" value="选择学员"/>
			&nbsp;&nbsp;
			<!--从员工选择-->
			<input type="hidden" name="employee.id" id="employeeId" value="${student.employee.id}">
			<%--<input id="selectErpEmployee" class="btn btn-primary" type="button" value="选择员工"/>--%>
		</div>
	</div>
	<table>
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label" >姓名：</label>
					<div class="controls">
						<form:input path="name" id="name"  htmlEscape="false" maxlength="50" class="required input-large " />
						<font color="red">*</font>
						<label class="error" id="jobGroupError"></label>
					</div>
				</div>
			</td>

			<td>
				<div class="control-group">
					<label class="control-label">性别：</label>
					<div class="controls">
						<form:select path="sex" id="sex" class="required" style="width: 180px" >
							<form:options items="${erp:sexStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
						</form:select>
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">出生日期：</label>
					<div class="controls">
							<%--<form:input path="dateBirth" id="dateBirth" htmlEscape="false" maxlength="20" class="input-large "/>--%>
						<input name="dateBirth" id="dateBirth" type="text"  maxlength="20" class="input-large Wdate"
							   value="<fmt:formatDate value="${student.dateBirth}" pattern="yyyy-MM-dd"/>"
							   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"  readonly="readonly"/>
					</div>
				</div>
			</td>
			<td>
				<div class="control-group">
					<label class="control-label">所属校区：</label>
					<div class="controls">
						<form:select path="areas.id" id="areas"  class="required" style="width:180px" >
							<form:options items="${areasList}" itemLabel="areaName" itemValue="id" htmlEscape="false" />
						</form:select>
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">身份证号：</label>
					<div class="controls">
						<form:input path="stuNumber" id="stuNumber"  htmlEscape="false" maxlength="64" class="required card stuNumberExist valid "  />
						<span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>
			</td>
			<td>
				<div class="control-group">
					<label class="control-label">身份证号地址：</label>
					<div class="controls">
						<form:input path="stuNumberAddress" id="stuNumberAddress"  htmlEscape="false" maxlength="64" class=""  />
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">手机号码：</label>
					<div class="controls">
						<form:input path="phone" id="phone"  htmlEscape="false" maxlength="64" class="required mobile phoneExist valid " />
						<span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>
			</td>
			<td>
				<div class="control-group">
					<label class="control-label">职业方向：</label>
					<div class="controls">
						<form:checkboxes path="occupationId" items="${erp:getCommonsTypeList(12)}" itemLabel="commonsName" itemValue="id" htmlEscape="false" class="required valid"/>
						<font color="red">*</font>
						<label class="error" id="occupationIdError"></label>
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">学历：</label>
					<div class="controls">
						<form:select path="education" id="education" class="input-large" style="width: 180px" >
							<form:options items="${erp:getCommonsTypeList(7)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
						</form:select>
					</div>
				</div>
			</td>
			<td>
				<div class="control-group">
					<label class="control-label">QQ号码：</label>
					<div class="controls">
						<form:input path="qqNumber" id="qqNumber"  htmlEscape="false" maxlength="64" class="qq valid " />
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">籍贯：</label>
					<div class="controls">
						<%--<sys:treeselect id="nativePlace" name="nativePlace.id"  value="${student.nativePlace.id}"
										labelName="nativePlace.name" labelValue="${student.nativePlace.name}"
										title="区域" url="/sys/area/treeData" allowClear="true" notAllowSelectParent="true"/>--%>

							<div class="input-append">
								<input id="nativePlaceId" name="nativePlace.id" type="hidden" value=""/>
								<input id="nativePlaceName" name="nativePlace.name" readonly="readonly" type="text" value="" data-msg-required=""  class="" style="" maxlength="255"/>
								<a id="nativePlaceButton" href="javascript:" class="btn  " style="">
									&nbsp;<i class="icon-search"></i>&nbsp;
								</a>&nbsp;&nbsp;
							</div>
					</div>
				</div>
			</td>
			<td>
				<div class="control-group">
					<label class="control-label">报名时间：</label>
					<div class="controls">
						<input name="applyTime" id="applyTime" type="text" readonly="readonly" maxlength="20" class="input-large Wdate"
							   value="<fmt:formatDate value="${student.dateBirth}" pattern="yyyy-MM-dd HH:mm"/>"
							   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"  readonly="readonly"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">招聘老师：</label>
					<div class="controls">
						<%--<sys:treeselect id="teacher" name="teacher.id" value="${student.teacher.id}"
										labelName="teacher.name" labelValue="${student.teacher.name}"
										title="选择用户" url="/sys/office/treeData?type=3" allowClear="true" notAllowSelectParent="true" cssClass="required"/>--%>
							<div class="input-append">
								<input id="teacherId" name="teacher.id" type="hidden" value=""/>
								<input id="teacherName" name="teacher.name" readonly="readonly" type="text" value="" data-msg-required=""  class="required" style="" maxlength="255"/>
								<a id="teacherButton" href="javascript:" class="btn  " style="">
									&nbsp;<i class="icon-search"></i>&nbsp;
								</a>&nbsp;&nbsp;
							</div>
							<span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>
			</td>
			<td>
				<div class="control-group">
					<label class="control-label">推荐人：</label>
					<div class="controls">
						<%--<sys:treeselect id="referrer" name="referrer.id" value="${student.referrer.id}"
										labelName="referrer.name" labelValue="${student.referrer.name}"
										title="推荐人" url="/sys/office/treeData?type=3"
										allowClear="true" notAllowSelectParent="true" />--%>
							<div class="input-append">
								<input id="referrerId" name="referrer.id" type="hidden" value=""/>
								<input id="referrerName" name="referrer.name" readonly="readonly" type="text" value="" data-msg-required=""  class="" style="" maxlength="255"/>
								<a id="referrerButton" href="javascript:" class="btn  " style="">
									&nbsp;<i class="icon-search"></i>&nbsp;
								</a>&nbsp;&nbsp;
							</div>
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">招生来源：</label>
					<div class="controls">
						<%--<sys:treeselect id="customerResource"  name="customerResource.id" value="${student.customerResource.id}"
										labelName="customerResource.customerName" labelValue="${student.customerResource.customerName}"
										title="来源名称" url="/erp/customerResource/treeData" cssClass="required" allowClear="true" notAllowSelectParent="true"/>--%>
							<div class="input-append">
								<input id="customerResourceId" name="customerResource.id" type="hidden" value=""/>
								<input id="customerResourceName" name="customerResource.customerName" readonly="readonly" type="text" value="" data-msg-required=""  class="required" style="" maxlength="255"/>
								<a id="customerResourceButton" href="javascript:" class="btn  " style="">
									&nbsp;<i class="icon-search"></i>&nbsp;
								</a>&nbsp;&nbsp;
							</div>
							<span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>
			</td>
			<td>
				<div class="control-group">
					<label class="control-label">紧急联络人：</label>
					<div class="controls">
						<form:input path="emergencyContact" id="emergencyContact"  htmlEscape="false" maxlength="64" class="input-large"  />
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">生活城市：</label>
					<div class="controls">
						<%--<sys:treeselect id="stuCity" name="stuCity.id" value="${student.stuCity.id}"
										labelName="stuCity.name" labelValue="${student.stuCity.name}"
										title="区域" url="/sys/area/treeData" cssClass="required" allowClear="true" notAllowSelectParent="true"/>--%>
							<div class="input-append">
								<input id="stuCityId" name="stuCity.id" type="hidden" value=""/>
								<input id="stuCityName" name="stuCity.name" readonly="readonly" type="text" value="" data-msg-required=""  class="required" style="" maxlength="255"/>
								<a id="stuCityButton" href="javascript:" class="btn  " style="">
									&nbsp;<i class="icon-search"></i>&nbsp;
								</a>&nbsp;&nbsp;
							</div>
							<span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>
			</td>
			<td>
				<div class="control-group">
					<label class="control-label">紧急联络电话：</label>
					<div class="controls">
						<form:input path="urgencyPhone" id="urgencyPhone"  htmlEscape="false" maxlength="64" class="mobile valid "  />
					</div>
				</div>
			</td>
		</tr>
	</table>


	<div class="control-group">
		<label class="control-label">是否住宿：</label>
		<div class="controls">
			<input type="radio"  name="dormitory"  value="1" />住宿
			<input type="radio"  name="dormitory"  value="0"  checked="checked"/>不住宿
			<font color="red">*</font>
			<label class="error" id="dormitoryError"></label>
		</div>
	</div>
	<!--弹框选择班级-->
	<div class="control-group">
		<label class="control-label">选择班级：</label>
		<div class="controls">
			<input type="text" id="classSum" class="input-large required" readonly="readonly"/>
			<input id="selectClass" class="btn btn-primary" type="button" value="选择班级"/>
			<font color="red">*</font>
			<label class="error" id="classError"></label>
		</div>
	</div>
	<br/>


	<table id="contentTable" class="table table-striped table-bordered table-condensed" style="width: 80%">
		<thead>
		<tr>
			<th>班级名称</th>
			<th>课程</th>
			<th>学费</th>
			<th>班主任</th>
			<th>预计招收学员</th>
			<th>当前报名学员</th>
			<th>最大招收学员</th>
			<th>计划开班日期</th>
			<th>计划结业日期</th>
			<th>操作</th>
		</tr>
		</thead>
		<tbody id="classTable">
		<script type="text/template" id="classTableTemplate">
			{{#classArray}}
			<tr>
				<td>{{className}}</td>
				<td>{{lessonName}}</td>
				<td>{{tuitionAmount}}</td>
				<td>{{name}}</td>
				<td>{{classMinNum}}</td>
				<td>{{classRealNum}}</td>
				<td>{{classMaxNum}}</td>
				<td>{{planBeginTime}}</td>
				<td>{{planEndTime}}</td>
				<td>
					<input type="hidden" name="classId" value="{{classId}}">
					<input id="removeLessons{{classId}}" class="btn btn-danger" type="button" value="删 除"
						   onclick="removeclasses('{{classId}}')"/>
				</td>
			</tr>
			{{/classArray}}
		</script>
		</tbody>
	</table>
	<br>
	<table  id="contentTables" class="table table-striped table-bordered table-condensed" style="width:50%">
		<tr>
			<th colspan ="2" >学费</th>
		</tr>
		<tr>
			<td>预定金</td>
			<td><input type="text" name="prepaidAmount" id="prepaidAmount" readonly="readonly"  value="" style="width: 50px;text-align: right;"/>&nbsp;&nbsp;元</td>
		</tr>
		<tr>
			<td>学费</td>
			<td><input type="text" name="tuitionAmount" id="tuitionAmount" readonly="readonly"  value="" style="width: 50px;text-align: right;"/>&nbsp;&nbsp;元</td>
		</tr>
		<tr>
			<td >学杂费</td>
			<td><input type="text" name="miscellaneousAmount"  id="miscellaneousAmount" readonly="readonly"   value="" style="width: 50px;text-align: right;"/>&nbsp;&nbsp;元</td>
			<td colspan="2"></td>
		</tr>
		<tr>
			<td >学费优惠</td>
			<td>
				<input type="text" name="tuitionFavorable"  id="tuitionFavorable" value="" class="money" style="width: 50px;text-align: right;"/>&nbsp;&nbsp;元
			</td>
			<td colspan="2"></td>
		</tr>

		<tr>
			<td >应付学费</td>
			<td><input type="text" name="shouldTuitionAmount" id="shouldTuitionAmount"   readonly="readonly" value="" style="width: 50px;text-align: right;"/>&nbsp;&nbsp;元</td>
			<td colspan="2"></td>
		</tr>
		<tr>
			<td>付款类型</td>
			<td>
				<form:select path="schoolClassStudents.order.payType" id="paymentType" class="required" style="width: 200px">
					<form:options items="${erp:getCommonsTypeList(22)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
				</form:select>
			</td>
			<td colspan="2"></td>
		</tr>
	</table>
	<div class="form-actions">
		<input  type="submit" class="btn btn-primary"  value="保 存"/>&nbsp;
		<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
	</div>
</form:form>
<script>
    var classTableTemplate;
    var classArray = new Array();

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

    $(document).ready(function() {
        $("#inputForm").validate({
            submitHandler: function(form){
                form.submit();
            },
            errorContainer: "#messageBox",
            errorPlacement: function(error, element) {

                $("#messageBox").text("输入有误，请先更正。");
                if (element.is(":checkbox")  || element.is(":radio")){
                    error.appendTo(element.parent().parent());
                }else if( element.parent().is(".input-append")){
                    $(error).text("必填信息");
                    element.parents(".controls").append(error);
                }else {
                    error.insertAfter(element);
                }
            }
        });

        jQuery.validator.addMethod("employeeExist", function(value, element) {
            var flag = false;
            $.ajax({
                type:"POST",
                async:false,
                url:"/school/student/employeeApplyExist",
                data:"id="+$("#employeeId").val(),
                success: function(data){
                    console.log(data);
                    if(data=="success"){
                        flag = true;
                    }else{
                        flag = false;
                    }
                }
            });
            return flag;
        }, "该员工已报过名");

        //验证手机号是否存在
        jQuery.validator.addMethod("phoneExist", function (value, element) {

            //修改时若手机号没改变则跳过验证
            if(value == $("#oldPhone").val()){
                return true;
            }
            var flag = false;
            $.ajax({
                type: "POST",
                async: false,
                url: "/school/student/ifPhone",
                data: "graphone=" + value,
                success: function (data) {
                    console.log(data);
                    if (data == "success") {
                        flag = true;
                    } else {
                        flag = false;
                    }
                }
            });
            return flag;
        }, "手机号码已存在");

        //验证身份证号码是否存在
        jQuery.validator.addMethod("stuNumberExist", function (value, element) {

            //修改时若身份证号码未改动，跳过验证
            if(value == $("#oldStudentNumber").val()){
                return true;
            }
            var flag = false;
            $.ajax({
                type: "POST",
                async: false,
                url: "/school/student/ifStuNumber",
                data: "grastuNumber=" + value,
                success: function (data) {
                    console.log(data);
                    if (data == "success") {
                        flag = true;
                    } else {
                        flag = false;
                    }
                }
            });
            return flag;
        }, "身份证号码已存在");

        $("#tuitionFavorable").keyup(function () {
            var reg = $(this).val().match(/\d+\.?\d{0,2}/);
            var txt = '';
            if(reg != null) {
                txt = reg[0];
            }
            $(this).val(txt);
            var tuitionAmount = parseFloat($("#tuitionAmount").val());
            if(tuitionAmount > 0.00) {
                if ($(this).val() != null && $(this).val() <= tuitionAmount) {
                    var tuitionFavorable = parseFloat($(this).val());
                }else{//如果优惠额度大于总金额,则退一格
                    $(this).val($(this).val().substr(0, $(this).val().length - 1));
                    return;
                }
                if ($(this).val() == null || $(this).val() == '') var tuitionFavorable = parseFloat(0.00);
				/*if(tuitionAmount > tuitionFavorable) $(this).val(0.00);*/
                var shouldTuitionAmount = tuitionAmount - tuitionFavorable;
                $("#shouldTuitionAmount").val(shouldTuitionAmount);
                var amountFlag = true;
                console.log("amountFlag:" + amountFlag);
            }
        }).change(function () {
            $(this).keypress();
            var v = $(this).val();
            if (/\.$/.test(v)){
                $(this).val(v.substr(0, v.length - 1));
            }
        });


        classTableTemplate = $("#classTableTemplate").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");


        var currentTime = new Date();
        var applyTime = currentTime.Format("yyyy-MM-dd hh:mm");
        $("#applyTime").val(applyTime);

        //选择生源表
        $("#selectErpStudent").click(function () {
            $("#name").removeClass("employeeExist");
            top.$.jBox("iframe:/erp/studentApply/studentTable?tagFlag=0",
                {"title": "学生列表",
                    "width":1024,
                    "height":520,
                    buttons:{}});
        });

        //选择员工表
        $("#selectErpEmployee").click(function () {
            $("#name").addClass("employeeExist");
            top.$.jBox("iframe:/erp/studentApply/selectErpEmployee?tagFlag=0",
                {"title": "员工列表",
                    "width":1024,
                    "height":520,
                    buttons:{}});
        });


        //点击添加报读班级
        $("#selectClass").click(function () {
            var str = $("#classJson").val();
            //console.log(str);
            top.$.jBox.open("iframe:/erp/studentApply/selectStudentApply?tagFlag=0",
                "选择班级",
                1024,
                520,
                {ajaxData:{"classJson":encodeURIComponent(str),"studentId":$("#studentId").val(),"employeeId":$("#employeeId").val()}}
            );
        });
        appendTable();


    });


    var flag = 0;

    function selectStudentCallback(id){
        loading('正在加载，请稍等...');
        $.get("/school/student/studentInfo",{"id":id},function (data) {
            console.log(data);
            if (data.status == "success"){
                showStudent(data.student);

            }else{
                loading('加载失败');
                setTimeout("closeLoading()",2000);
            }
        }).error(function() {
            loading('加载失败');
            setTimeout("closeLoading()",2000);
        });

        flag = 0;

    }

    function showStudent(student) {
        $("#studentId").val(student.id);
        $("#name").val(student.name);
        $("#sex").val(student.sex);
        $("#s2id_sex").find(".select2-chosen").text(student.sex==1?"男":"女");
        $("#dateBirth").val(student.dateBirth);
        if(student.areas){
            $("#areas").val(student.areas.id);
            $("#s2id_areas").find(".select2-chosen").text($("#areas option[value="+student.areas.id+"]").text());
        }

        $("#stuNumber").val(student.stuNumber);
        $("#oldStudentNumber").val(student.stuNumber);
        $("#stuNumberAddress").val(student.stuNumberAddress);
        if(student.occupationId && student.occupationId!=""){
            var array = student.occupationId.split(",");
            for(var i=0;i<array.length;i++){
                $("input[name='occupationId'][value='"+array[i]+"']").attr("checked",true);
            }
        }

        $("#phone").val(student.phone);
        $("#oldPhone").val(student.phone);

        $("#education").val(student.education);
        $("#s2id_education").find(".select2-chosen").text($("#education option[value="+student.education+"]").text());

        $("#qqNumber").val(student.qqNumber);
        if(student.nativePlace){

            $("#nativePlaceId").val(student.nativePlace.id);
            $("#nativePlaceName").val(student.nativePlace.name);
        }
        if(student.stuCity){

            $("#stuCityId").val(student.stuCity.id);
            $("#stuCityName").val(student.stuCity.name);
        }
        if(student.teacher){
            $("#teacherId").val(student.teacher.id);
            $("#teacherName").val(student.teacher.name);
        }
        if(student.referrer){

            $("#referrerId").val(student.referrer.id);
            $("#referrerName").val(student.referrer.name);
        }
        if(student.customerResource){
            $("#customerResourceId").val(student.customerResource.id);
            $("#customerResourceName").val(student.customerResource.customerName);
        }

        $("#emergencyContact").val(student.emergencyContact);
        $("#urgencyPhone").val(student.urgencyPhone);
        closeLoading();
    }


    //员工表回显数据
    function selectErpEmployeeCallback(id){
        loading('正在加载，请稍等...');
        $.get("/school/student/employeeInfo",{"id":id},function (data) {
            console.log(data);
            if (data.status == "success"){
                showEmployee(data.employee);
            }else{
                loading('加载失败');
                setTimeout("closeLoading()",2000);
            }
        }).error(function() {
            loading('加载失败');
            setTimeout("closeLoading()",2000);
        });
        flag = 1;

    }
    function showEmployee(employee) {
        $("#studentId").val("");
        $("#employeeId").val(employee.id);
        $("#name").val(employee.name);
        $("#sex").val(employee.sex);
        $("#s2id_sex").find(".select2-chosen").text(employee.sex==1?"男":"女");

        $("#dateBirth").val(employee.birthTime);


        if(employee.originalArea){

            $("#nativePlaceId").val(employee.originalArea.id);
            $("#nativePlaceName").val(employee.originalArea.name);
        }
        if(employee.currentArea){

            $("#stuCityId").val(employee.currentArea.id);
            $("#stuCityName").val(employee.currentArea.name);
        }
        $("#stuNumber").val(employee.idcard);
        $("#oldStudentNumber").val(employee.idcard);
        if(employee.specialityId && employee.specialityId!=""){
            var array = employee.specialityId.split(",");
            for(var i=0;i<array.length;i++){
                $("input[name='occupationId'][value='"+array[i]+"']").attr("checked",true);
            }
        }

        $("#phone").val(employee.phone);
        $("#oldPhone").val(employee.phone);

        $("#education").val(employee.education);
        $("#s2id_education").find(".select2-chosen").text($("#education option[value="+employee.education+"]").text());

        $("#emergencyContact").val(employee.emergencyContact);
        $("#urgencyPhone").val(employee.emergencyContactPhone);

        closeLoading();

        $("#inputForm").validate().element($("#name"))
    }

    //classArray追加数据
    function pushclassArray(key,classId,className,lessonName,tuitionAmount,name,classRealNum,classMinNum,classMaxNum,planBeginTime,
                            planEndTime,emplyoeeId,shouldTuitionAmount,prepaidAmount,miscellaneousAmount){
        classArray.push({
            "key":key,
            "classId":classId,
            "className":className,
            "lessonName":lessonName,
            "tuitionAmount":tuitionAmount,
            "name":name,
            "classRealNum":classRealNum,
            "classMinNum":classMinNum,
            "classMaxNum":classMaxNum,
            "planBeginTime":planBeginTime,
            "planEndTime":planEndTime,
            "emplyoeeId":emplyoeeId,
            "shouldTuitionAmount":shouldTuitionAmount,
            "prepaidAmount":prepaidAmount,
            "miscellaneousAmount":miscellaneousAmount,
            "studentId":$("#id").val()
        });
    }

    function appendTable(){
        $("#classTable").empty();
        $("#classTable").append(Mustache.render(classTableTemplate, {"classArray":classArray}));
        $("#classJson").val(JSON.stringify(classArray));
        if(classArray.length>0){
            $("#classSum").val("共 "+classArray.length+" 个班级");
        }else{
            $("#classSum").val("");
        }

    }
    //报读班级数据回显
    function selectclassCallback(classId,className,lessonName,tuitionAmount,name,classRealNum,classMinNum,classMaxNum,planBeginTime,
                                 planEndTime,emplyoeeId,prepaidAmount,miscellaneousAmount,chked){


        var key = classId+className;
        var dayTime = new Date(planBeginTime);
        planBeginTime = dayTime.Format("yyyy-MM-dd");
        var dayTime = new Date(planEndTime);
        planEndTime = dayTime.Format("yyyy-MM-dd");
        for(var i=0;i<classArray.length;i++){
            if (key == classArray[i].key){
                if (chked){
                    return;
                }else{
                    classArray.remove(i);
                    //去除移除班级所需费用
                    subtractAmount(tuitionAmount,prepaidAmount,miscellaneousAmount);
                    appendTable();
                    return;
                }
            }
        }
        //学费累加
        addAmount(tuitionAmount,prepaidAmount,miscellaneousAmount);

        pushclassArray(key,classId,className,lessonName,tuitionAmount,name,classRealNum,classMinNum,classMaxNum,planBeginTime,
            planEndTime,emplyoeeId,shouldTuitionAmount,prepaidAmount,miscellaneousAmount);

        appendTable();


    }

    var payAmount = 0;//学费
    var paymiscellaneousAmount = 0;//学杂费
    var payprepaidAmount = 0;//预定金
    var shouldTuitionAmount = 0;//应付学费

    //学费累加
    function addAmount(tuitionAmount,prepaidAmount,miscellaneousAmount){
        payAmount += parseFloat(tuitionAmount);
        if (!isNaN(payAmount))$("#tuitionAmount").val(payAmount);

        //console.log("payAmount:"+payAmount);

        payprepaidAmount += parseFloat(prepaidAmount);
        if(!isNaN(payprepaidAmount))$("#prepaidAmount").val(payprepaidAmount);
        //console.log("payprepaidAmount:"+payprepaidAmount);

        paymiscellaneousAmount += parseFloat(miscellaneousAmount);
        if(!isNaN(paymiscellaneousAmount))$("#miscellaneousAmount").val(paymiscellaneousAmount);
        //console.log("paymiscellaneousAmount:"+paymiscellaneousAmount);

        //应收学费
        shouldTuitionAmount = $("#tuitionAmount").val() - $("#tuitionFavorable").val();
        if(!isNaN(shouldTuitionAmount))$("#shouldTuitionAmount").val(shouldTuitionAmount);
    }

    //去除移除班级所需费用
    function subtractAmount(tuitionAmount,prepaidAmount,miscellaneousAmount) {
        payAmount -= parseFloat(tuitionAmount);
        if(!isNaN(payAmount)) $("#tuitionAmount").val(payAmount);
        //console.log("payAmount:"+payAmount);

        payprepaidAmount -= parseFloat(prepaidAmount);
        if(!isNaN(payprepaidAmount)) $("#prepaidAmount").val(payprepaidAmount);
        //console.log("payprepaidAmount:"+payprepaidAmount);

        paymiscellaneousAmount -= parseFloat(miscellaneousAmount);
        if(!isNaN(paymiscellaneousAmount)) $("#miscellaneousAmount").val(paymiscellaneousAmount);
        //console.log("paymiscellaneousAmount:"+paymiscellaneousAmount);


        //应收学费
        shouldTuitionAmount = $("#tuitionAmount").val() - $("#tuitionFavorable").val();
        shouldTuitionAmount = parseFloat(shouldTuitionAmount);
        if(shouldTuitionAmount<=0)shouldTuitionAmount = 0;
        $("#shouldTuitionAmount").val(shouldTuitionAmount);
    }




    function removeclasses(classId){
        //console.log(classId);
        for(var i=0;i<classArray.length;i++){
            if (classId == classArray[i].classId){
                //去除移除班级所需费用
                var tuitionAmount =classArray[i].tuitionAmount;
                var prepaidAmount =classArray[i].prepaidAmount;
                var miscellaneousAmount =classArray[i].miscellaneousAmount;
                subtractAmount(tuitionAmount,prepaidAmount,miscellaneousAmount);
                classArray.remove(i);
                appendTable();

                return;
            }
        }
    }
</script>
</body>
</html>
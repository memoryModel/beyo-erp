<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<body>
<br/>
<form:form id="inputForm" modelAttribute="serviceLevel" action="#" method="post" class="form-horizontal">
	<input type="hidden" name="employeeId" value="${employee.id}"/>
	<input type="hidden" name="skillId" id="skillId" value="${skill.id}"/>
	<input type="hidden" name="skill.skillName" id="skillName" value="${skill.skillName}"/>
	<input type="hidden" name="levelId" id="levelId" value=""/>
	<input type="hidden" name="unit" id="unit" value="${skill.unit}">
	<input type="hidden" name="category" id="category" value="${skill.category}">
	<sys:message content="${message}"/>
	<c:if test="${empty result}">
		<div class="control-group">
			<label class="control-label">基础服务技能：</label>
			<div class="controls" >
					${skill.skillName}
			</div>
		</div>
		<div class="control-group">
			<div class="controls" >
				<c:forEach items="${weightList}" var="weight" varStatus="index">
					${weight.checkName}(满分100):
					<input id="points${index.index}" name="points" rate="${weight.percentage}" value="100" maxlength="3" class="required points valid" style="width: 50px;text-align: right;margin: 2%">
					<c:if test="${(index.index+1)%2 == 0}">
						<br>
					</c:if>
				</c:forEach>
				<br>
				<shiro:hasPermission name="crm:serviceLevel:findScore"><input id="skillTest" class="btn btn-warning" type="button" value="系统测评" />&nbsp;&nbsp;</shiro:hasPermission>

			</div>

		</div>


		<div class="control-group">
			<span style="margin-left: 17%">综合得分：</span>
			<span name="score"style="width: 2%;text-align: center;">

			</span>
			<span style="margin-left: 20%">系统测评定级：</span>
			<span name="result" style="width: 2%;text-align: center;">

			</span>
		</div>
		<div class="control-group">
			<label class="control-label">等级对应服务结算单价：</label>
			<span name="servicePrice" style="width: 2%;text-align: center;"></span>
		</div>
		<div class="control-group">
			<label class="control-label">人工定级：</label>
			<div class="controls">
				<form:select path="id" id="employeeSkillSelect" class="input-large">
					<form:options selectId="id" items="${serviceLevelList}" itemLabel="name" itemValue="id" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">当前员工服务结算单价：</label>
			<div class="controls">
				<input name="costomServicePrice" type="text" class="input-large">
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="crm:employeeGrade:edit">	<input id="btnSubmit" class="btn btn-primary" name="save"  type="button" value="保 存"/>&nbsp;&nbsp;
			</shiro:hasPermission>
			<input name="closeWindows" class="btn" type="button" value="关 闭" />
		</div>
	</c:if>
	<c:if test="${!empty result}">
		<div class="form-actions">
			<c:choose>
				<c:when test="${result == 'success'}">
					<div id="messageBox" class="alert alert-success"><button data-dismiss="alert" class="close">×</button>技能等级评测保存成功</div>
				</c:when>
				<c:otherwise>
					<div id="messageBox" class="alert alert-success"><button data-dismiss="alert" class="close">×</button>技能等级评测保存失败</div>
				</c:otherwise>
			</c:choose>

			<input name="closeWindows" class="btn" type="button" value="关 闭"/>
		</div>
	</c:if>
</form:form>
<script type="text/javascript">
    var level = ${fns:toJson(serviceLevel)};

    $(document).ready(function() {
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
        jQuery.validator.addClassRules("points", {range:[1,100]});

        $("#skillTest").click(function () {
            if(!$("#inputForm").valid())return;
            var score = 0;
            var pointArray = $("input[name='points']");
            for(i=0;i<pointArray.length;i++){
                p = parseInt($(pointArray[i]).val());
                r = parseInt($(pointArray[i]).attr("rate"));
                score += parseFloat(p*(r/100));
            }
            //渲染等级
            $.ajax({
                url:'/crm/serviceLevel/findScore',
                data:{"score":score},
                type:'post',
                async:false,
                dataType:'json',
                success:function (data) {
                    if (data || data.status=="success"){
                        if (!data.serviceLevel){
                            showMessage("error","评测失败，分数错误或过低无法计算等级");
                            return;
                        }
                        level = data.serviceLevel;
                        $('[name="result"]').text(level.name);
                        $("#levelId").val(level.id);
                    }else{
                        showMessage("error","请求失败");
                    }
                },
                error:function () {
                    showMessage("error","请求失败");
                }
            });

            //渲染得分
            $('[name="score"]').text(score);

            //渲染结算单价
            var skillId = $("#skillId").val();
            $.ajax({
                url:'/crm/skill/skillInfo',
                data:{"id":skillId},
                type:'post',
                dataType:'json',
                async:false,
                success:function (data) {
                    if (data || data.status=="success"){
                        showSkillPrice(data);
                    }else{
                        showMessage("error","请求失败");
                    }
                },
                error:function () {
                    showMessage("error","请求失败");
                }

            })

            //渲染人工定级
            $('#employeeSkillSelect').find('option[selectLevelId='+level.id+']').attr("selected",true);
        });

        $('input[name="save"]').click(function () {
                var skillId = $("#skillId").val();
                if(!level)return;
                var pointsValueArray = new Array();
                $('input[name="points"]').each(function () {
                    pointsValueArray.push($(this).val())
                })
                var skillName = $('#skillName').val();
                var score = $('span[name="score"]').text();
                var levelId = $('#levelId').val();
                var levelName = $('span[name="result"]').text();
                var servicePrice = $('span[name="servicePrice"]').text();
                var appraisalLevelId = $('#employeeSkillSelect').find('option:selected').val();
                var appraisalLevelName = $('#employeeSkillSelect').find('option:selected').text();
                var costomServicePrice = $('input[name="costomServicePrice"]').val();
                var unit = $('#unit').val();

                parent.window.frames["mainFrame"].employeeSkillCallback(skillId,skillName,pointsValueArray,score,levelId,levelName,
                    servicePrice,appraisalLevelId,appraisalLevelName,costomServicePrice,unit);
                top.$.jBox.close(true);
        });
        $("input[name='closeWindows']").each(function () {
            $(this).click(function () {
                top.$.jBox.close(true);
            })
        })


        var unit = $("#unit").val();
        var unitName = '';
        if(unit == "1"){
            unitName = "元/天";
        }else{
            unitName = "元/次";
        }
        $('[name="costomServicePrice"]').after(unitName);
    });

    function showSkillPrice(data) {
        var skill = data.skill;
        if(!skill){
            showMessage("error","请求失败");
            return;
        }
        var skillId = $("#skillId").val();
        var servicePrice = 0;
        var levelId = 0;
        if (skill.category == 1){
            servicePrice = skill.settlementPrice;
        }else{
            var levelArray = data.levelList;
            for(var k=0;k<levelArray.length;k++){
                if(levelArray[k].id == $('#levelId').val()){
                    levelId = levelArray[k].id;
                    servicePrice = levelArray[k].levelAmount;
                    break;
                }
            }
        }

        var category = $("#unit").val();

        $('[name="servicePrice"]').text(servicePrice);
        $('[name="costomServicePrice"]').val(servicePrice)

    }


    function showMessage(status,message) {
        $("#messageBox").remove();
        $('[name="servicePrice"]').parent().parent().after('<div id="messageBox" class="alert alert-'+status+'"><button data-dismiss="alert" class="close">×</button>'+message+'</div>');
    }
</script>
</body>
<head>
	<title>单表管理</title>
	<meta name="decorator" content="default"/>
</head>
</html>
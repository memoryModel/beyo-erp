<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<body>
<br/>
<form:form id="inputForm" modelAttribute="serviceLevel" action="#" method="post" class="form-horizontal">
	<input type="hidden" name="employeeId" value="${employee.id}"/>
	<input type="hidden" name="skillId" id="skillId" value="${skill.id}"/>
	<input type="hidden" name="levelId" id="levelId" value="${employeeSkill.systemServiceLevel.id}"/>
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
					<input id="points${weight.id}" name="points" rate="${weight.percentage}" value="100" maxlength="3" class="required points valid" style="width: 50px;text-align: right;margin: 2%">
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
                ${employeeSkill.score}
			</span>
			<span style="margin-left: 20%">系统测评定级：</span>
			<span name="result" style="width: 2%;text-align: center;">
                ${employeeSkill.systemServiceLevel.name}
			</span>
		</div>
		<div class="control-group">
			<label class="control-label">等级对应服务结算单价：</label>
			<span name="servicePrice" style="width: 2%;text-align: center;">
                ${employeeSkill.skillToLevel.levelAmount}
            </span>
		</div>
		<div class="control-group">
			<label class="control-label">人工定级：</label>
			<div class="controls">
                    <form:select path="id" id="employeeSkillSelect" class="input-large">
                        <form:options selectLevelId="levelId" items="${skillToLevelList}" itemLabel="serviceLevel.name" itemValue="levelId" htmlEscape="false"/>
                    </form:select>
			</div>
		</div>
        <div class="control-group">
            <label class="control-label">当前员工服务结算单价：</label>
            <div class="controls">
                <input name="costomServicePrice" type="text" class="input-large number" value="${employeeSkill.servicePrice}">
            </div>
        </div>
		<div class="form-actions">
				<input id="btnSubmit" class="btn btn-primary" name="save"  type="button" value="保 存"/>&nbsp;&nbsp;

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
    <!-- 点击修改定级后权重的id和得分的回显-->
    <c:forEach items="${employeeSkill.skillWeightList}" var="skillWeight">
        <input type="hidden" name="hdSkillWeight" hdId="${skillWeight.weightId}" value="${skillWeight.weightScore}">
    </c:forEach>
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

        //点击修改定级后权重的id和得分的回显
        $('input[type="hidden"][name="hdSkillWeight"]').each(function () {
            var weightId = $(this).attr('hdId');
            var weightScore = $(this).val();
            $('#points'+weightId).val(weightScore);
        })

        $("#skillTest").click(function () {
            $('input[name="costomServicePrice"]').removeClass('required');
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

        //将权重分数和测评的结果保存到父页面
            $('input[name="save"]').click(function () {
                $('input[name="costomServicePrice"]').addClass('required');
                if(!$("#inputForm").valid())return;
                var skillId = $("#skillId").val();
                if(!level)return;
                var pointsValueArray = new Array();
                $('input[name="points"]').each(function () {
                    pointsValueArray.push($(this).val())
                })
                var score = $('span[name="score"]').text().replace(/[\r\n\t]/g,"").replace(/\s+/g, "");
                var levelId = $('#levelId').val();
                var levelName = $('span[name="result"]').text().replace(/[\r\n\t]/g,"").replace(/\s+/g, "");
                var servicePrice = $('span[name="servicePrice"]').text().replace(/[\r\n\t]/g,"").replace(/\s+/g, "");
                var appraisalLevelId = $('#employeeSkillSelect').find('option:selected').val();
                var appraisalLevelName = $('#employeeSkillSelect').find('option:selected').text();
                var costomServicePrice = $('input[name="costomServicePrice"]').val();
                var unit = $('#unit').val();

                parent.window.frames["mainFrame"].employeeSkillCallback(skillId,pointsValueArray,score,levelId,levelName,
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
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>题库管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/school/examineStore/list">题库管理列表</a></li>
		<li class="active"><a href="${ctx}/school/examineStore/form?id=${examineStore.id}">题库管理${not empty examineStore.id?'修改':'添加'}</a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="examineStore" action="${ctx}/school/examineStore/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<input type="hidden" name="examJson" id="examJson"/>
		<div class="control-group">
			<label class="control-label">题库名称：</label>
			<div class="controls">
				<form:input path="name" id="examineStoreName" htmlEscape="false" maxlength="20" class="required input-xlarge"/>
				<span class="help-inline"><font color="red">*</font> </span>

			</div>
		</div>
		<div class="control-group">
			<label class="control-label">题库类型：</label>
			<div class="controls">
				<form:hidden path="type" id="examType"/>
				<input type="text"  value="${erp:examTypeName(examineStore.type)}" class="required input-xlarge" readonly="readonly"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">科目：</label>
			<div class="controls">
				<form:select path="subject" class="required input-xlarge" id="subjectId" >
					<form:options items="${erp:getCommonsTypeList(50)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">状态：</label>
			<div class="controls">
				<form:select path="status" class="required" >
					<form:options items="${erp:commonsStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<form:textarea path="remark" id="remark" htmlEscape="false" maxlength="1000" class="input-xxlarge"/>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">试题：</label>
			<div class="controls">
				<input type="text" id="itemSum" class="input-large required" readonly="readonly">
				<span class="help-inline"><font color="red">*</font> </span>&nbsp;&nbsp;
				<input id="selectItems" class="btn btn-primary" type="button" value="添加试题"/>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label"></label>
			<div class="controls">
				<table style="width: 80%" class="table table-striped table-bordered table-condensed">
					<thead>
					<tr>
						<th>类型</th>
						<th>题目</th>
						<th>选项</th>
						<th>答案</th>
						<th width="20%">操作</th>
					</tr>
					</thead>
					<tbody id="examItemsTable">

					</tbody>
				</table>
			</div>
		</div>


		<div class="form-actions">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
	<script type="text/template" id="itemsTemplate">
		<tr>
			<td>{{optionType}}</td>
			<td>{{title}}</td>
			<td>
				{{#optionsArray}}

				{{option}}<br>

				{{/optionsArray}}
			</td>
			<td>
				{{#answerArray}}
				{{answer}}<br>
				{{/answerArray}}
			</td>
			<td>
				<input class="btn btn-danger" type="button" value="删 除" onclick="deleteItem('{{title}}',this)"/>
			</td>
		</tr>
	</script>
	<script type="text/javascript">
        var questionList = ${fns:toJson(questionList)};
        var itemsArray = new Array();
        var template;

        $(document).ready(function() {
            $('form').each(function() {
                $(this).validate({
                    ignore: ".ignore",
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


            template = $("#itemsTemplate").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");



            $("#selectItems").click(function () {
                var str = $("#itemsJson").val();
                top.$.jBox.open("iframe:/school/examineStore/selectItems",
                    "添加试题",
                    768,
                    650,
					{
                        buttons:{},
                        ajaxData:{}
					});
            });


            showQuestionList();

        });

		function showQuestionList() {
            for(var i=0;i<questionList.length;i++){

                var optionsArray = new Array();
                var answerArray = new Array();

                var optionType = "";
                if (questionList[i].type == 1){
                    optionType = "单选";
                }else{
                    optionType = "多选";
                }

                if (!questionList[i].answerList || questionList[i].answerList.length<=0)continue;

                for(var j=0;j<questionList[i].answerList.length;j++){
					var answerList = questionList[i].answerList[j];

                    optionsArray.push({
                        "answerOption":answerList.reference,
                        "optionContent":answerList.title,
                        "option":answerList.reference+"."+answerList.title,
                        "chckFlag":answerList.solution+""
                    });
                    if(answerList.solution == 1){
                        answerArray.push({
                            "answer":answerList.reference
                        });
                    }

                }

                var exam = {
                    "title":questionList[i].title,
                    "optionType":optionType,
                    "type":questionList[i].type+"",
                    "optionsArray":optionsArray,
                    "answerArray":answerArray
                };

                $("#examItemsTable").append(Mustache.render(template, exam));

                itemsArray.push(exam);


            }
            if(itemsArray.length>0){
                $("#itemSum").val("共 "+itemsArray.length+" 道试题");

                $("#examJson").val(encodeURIComponent(JSON.stringify(itemsArray)));
            }


        }
        function selectAnswerCallback(title,type,examIteamsArray) {

            for(var i=0;i<itemsArray.length;i++){
                if (title == itemsArray[i].title){
                    return;
                }
            }

            var optionsArray = new Array();
			var answerArray = new Array();

			var optionType = "";
            if (type == 1){
                optionType = "单选";
            }else{
                optionType = "多选";
            }
			if($("#examType").val() == 1 && examIteamsArray.length<=0){
				showMessage("error","只有[实操考试]类型才允许试题无选项");
				return;
			}


            for(var i=0;i<examIteamsArray.length;i++){


                optionsArray.push({
					"answerOption":examIteamsArray[i].answerOption,
					"optionContent":examIteamsArray[i].optionContent,
					"option":examIteamsArray[i].answerOption+"."+examIteamsArray[i].optionContent,
					"chckFlag":examIteamsArray[i].chckFlag+""
                });
				if(examIteamsArray[i].chckFlag == 1){
                    answerArray.push({"answer":examIteamsArray[i].answerOption});
				}

			}

			var exam = {
                "title":title,
                "optionType":optionType,
				"type":type+"",
                "optionsArray":optionsArray,
                "answerArray":answerArray
            };


            $("#examItemsTable").append(Mustache.render(template, exam));

            itemsArray.push(exam);

            $("#itemSum").val("共 "+itemsArray.length+" 道试题");

            $("#examJson").val(encodeURIComponent(JSON.stringify(itemsArray)));

            $("#showJson").val(JSON.stringify(itemsArray));
        }

        function deleteItem(title,obj) {
            for(var i=0;i<itemsArray.length;i++){

                if (title == itemsArray[i].title){
                    itemsArray.remove(i);
                    $(obj).parents("tr").remove();
                    if (itemsArray.length>0){
                        $("#itemSum").val("共 "+itemsArray.length+" 道试题");
                        $("#examJson").val(encodeURIComponent(JSON.stringify(itemsArray)));
					}else{
                        $("#itemSum").val("");
                        $("#examJson").val("");
					}

                    return;
                }
            }
        }

        function showMessage(status,message) {
            $("#messageBox").remove();
            $("form").before('<div id="messageBox" class="alert alert-'+status+'"><button data-dismiss="alert" class="close">×</button>'+message+'</div>');
        }
        //移除元素
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

	</script>
</body>
</html>
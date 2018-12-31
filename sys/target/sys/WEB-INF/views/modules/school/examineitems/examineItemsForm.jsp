<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>考试试题管理</title>
	<meta name="decorator" content="default"/>

</head>
<body>
<br>
	<form:form id="inputForm" modelAttribute="examQuestion" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">试题题目：</label>
			<div class="controls">
				<form:input path="title" id="questionTitle" htmlEscape="false" maxlength="50" class="required input-xxlarge"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">试题类型：</label>
			<div class="controls">
				<form:select id="itemsType" path="type" class="input-xlarge">
					<form:options items="${erp:examQuestionTypeList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">答案选项：</label>
			<div class="controls">

				<input name="add_option" id="addOption" class="btn btn-primary" type="button" value="添加答案选项"/>
			</div>
		</div>
		<div class="control-group">
			<table id="optioniteamsTable" class="table table-striped table-bordered table-condensed" width="width:50%">
				<thead>
				<tr>
					<th>选项</th>
					<th>选项内容</th>
					<th>答案</th>
					<th>操作</th>
				</tr>
				</thead>
				<tbody id="answerTable">

				</tbody>
			</table>
		</div>



		<div class="form-actions">
			<input id="btnSubmit"  type="button" class="btn btn-primary"  value="保 存"/>
		</div>
	</form:form>
	<script type="text/template" id="answerOptionTemplate">
			<tr id="tr{{index}}">
				<td>
					<input type="text" name= "answerOption" value="{{answerOption}}" style="width:50px;text-align:center;" readonly="readonly" />
				</td>
				<td>
					<textarea name="optionContent" class="input-xlarge">{{optionContent}}</textarea>
				</td>
				<td>

					{{#radio}}
						<input type="radio" name="defaultAnswer" onchange="checkAnswer('{{index}}')" value="0"/>
					{{/radio}}
					{{#chkbox}}
						<input type="checkbox" id="checkbox{{index}}" name="defaultAnswer" onchange="checkAnswer('{{index}}')" value="0"/>
					{{/chkbox}}
					设为答案
				</td>
				<td><input type="button" onclick="removeanswers('{{index}}')" class="btn btn-danger" value="移除" /></td>
			</tr>

	</script>
	<script type="text/javascript">
        var outcha = 1;       //超出字母范围 重赋选项值

        var chckFlag = 0;     //试题答案标记 0：不是答案 1：是答案
		var examIteamsArray = new Array();
        var answer;
        var template;
        $(document).ready(function() {
			
            template = $("#answerOptionTemplate").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
            
            $("#itemsType").change(function () {
                $("#answerTable").empty();
                examIteamsArray = new Array();
            });
            
            $("#btnSubmit").click(function () {
                $("#messageBox").remove();

                var k = 0;
                $("textarea[name='optionContent']").each(function () {
                    if(examIteamsArray[k]){
                        examIteamsArray[k].optionContent = this.value;
                        k++;
					}

                });

                if($("#questionTitle").val() == ""){
                    showMessage("error","试题题目不能为空");
                    return;
                }

                var chk = 0;
                for(var i=0;i<examIteamsArray.length;i++){

                    if (examIteamsArray[i].optionContent == "" || examIteamsArray[i].optionContent == " " ){
                        showMessage("error","选项内容不能为空");
                        return;
                    }
                    chk += examIteamsArray[i].chckFlag;
                }
                if (chk == 0 && examIteamsArray.length>0){
                    examIteamsArray[0].chckFlag = 1;
				}

                parent.window.frames["mainFrame"].selectAnswerCallback( $("#questionTitle").val(),$("#itemsType").val(),examIteamsArray);
                top.$.jBox.close(true);

            });

            //点击添加一行答案
            $("#addOption").click(function () {
                addAnswer();
            });

		});


		function addAnswer() {

            var alphabet;  //字母选项
            //模板字母计数--试题选项
            if (examIteamsArray.length < 25) {
                alphabet = String.fromCharCode((65 + examIteamsArray.length));

            } else {//超出字母范围
                outcha--;
                alphabet = outcha;
            }

            answer = {"answerOption":alphabet,
				"optionContent":" ",
				"index":examIteamsArray.length+1

			};


            var value = $("#itemsType").val();
            if(value == 2){
                answer.chkbox = 1;
                answer.radio = 0;
                answer.chckFlag= 0;
            }else{
                answer.chkbox = 0;
                answer.radio = 1;
                answer.chckFlag= 0;
            }

            examIteamsArray.push(answer);

            var html= Mustache.render(template, answer); //添加模板

            $("#answerTable").append(html);
        }

        function checkAnswer(index){
		    var value = $("#itemsType").val();

            for(var i=0;i<examIteamsArray.length;i++){
                if(value == 2){
                    if (index == examIteamsArray[i].index){
                        examIteamsArray[i].chckFlag =1;
                    }
                }else{
                    if (index == examIteamsArray[i].index){
                        examIteamsArray[i].chckFlag =1;
                    }else{
                        examIteamsArray[i].chckFlag =0;
					}
                }

            }
		}

        function removeanswers(index){
            for(var i=0;i<examIteamsArray.length;i++){
                if (index == examIteamsArray[i].index){
                    examIteamsArray.remove(i);
					$("#tr"+index).remove();
                }
            }
            for(var i=0;i<examIteamsArray.length;i++){

                var alphabet;  //字母选项
                //模板字母计数--试题选项
                if (i < 26) {
                    alphabet = String.fromCharCode((65 + i));
                    //alert(alphabet);
                } else {//超出字母范围
                    outcha--;
                    alphabet = outcha;
                }
				console.log(alphabet);
                $("#answerTable").find("tr").each(function (k) {
                    console.log(i+" "+k);
					if (i == k){
                        $(this).find("input[name='answerOption']").val(alphabet);
					}
                })

            }


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




        function showMessage(status,message) {
            $("#messageBox").remove();
            $("form").before('<div id="messageBox" class="alert alert-'+status+'"><button data-dismiss="alert" class="close">×</button>'+message+'</div>');
        }

	</script>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>商品管理</title>
	<meta name="decorator" content="default"/>
	<link href="/static/upload/uploadfile.css?v=1" type="text/css" rel="stylesheet" />
	<script type="text/javascript" src="/static/ckeditor/ckeditor.js"></script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/crm/product/list">商品管理列表</a></li>
		<li class="active"><a href="${ctx}/crm/product/form?id=${product.id}">商品<shiro:hasPermission name="crm:product:form">${not empty product.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="crm:product:form">查看</shiro:lacksPermission></a>
		</li>
	</ul><br/>
	<form:form id="productForm" modelAttribute="product" action="${ctx}/crm/product/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="unit"/>
		<sys:message content="${message}"/>

		<div class="control-group">
			<label class="control-label">商品分类：</label>
			<div class="controls">
				<sys:treeselect id="productCategory" name="productCategory.id" value="${product.productCategory.id}"
								labelName="productCategory.name" labelValue="${product.productCategory.name}"
								title="商品名称" url="/crm/productCategory/treeData" cssClass="required" allowClear="true"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">关联技能项：</label>
			<div class="controls">
				<form:select path="skill.id"  class="required" id="productSkill" style="width:268px">
					<form:option value="" label="请选择"/>
					<form:options items="${crmSkillList}" itemLabel="skillName" itemValue="id" htmlEscape="false" />
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">商品名称：</label>
			<div class="controls">
				<form:input path="title" htmlEscape="false" maxlength="215" class="required input-xlarge " style="width:255px"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">商品编码：</label>
			<div class="controls">
				<form:input path="code" htmlEscape="false" maxlength="64" class="required input-xlarge " style="width:255px"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">商品简介：</label>
			<div class="controls">
				<form:textarea path="description" htmlEscape="false" rows="4" maxlength="215" class="input-xxlarge " style="width:350px"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">计价单位：</label>
			<div class="controls">
				<input type="text" class="input-xlarge " id="basicUnit" style="width:80px" readonly="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">计价方式：</label>
			<div class="controls">
				<c:if test="${empty product.id}">
					<input type="radio"  name="measureWay" value="1" <c:if test="${empty product.measureWay || product.measureWay == 1}">checked</c:if>/>按单价计价
					<input type="radio"  name="measureWay" value="2" <c:if test="${product.measureWay == 2}">checked</c:if>/>按包价计价
				</c:if>
				<c:if test="${!empty product.id}">
					<form:hidden path="measureWay"/>
					<c:if test="${empty product.measureWay || product.measureWay == 1}">按单</c:if>
					<c:if test="${product.measureWay == 2}">打包</c:if>
				</c:if>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">SKU：</label>
			<div class="controls">
				<div id="skuContent">
					请选择服务项目
				</div>
				<div id="addPackageSkuDiv" style="display: none;">
					<input id="addPackageSku" type="button" value="新增SKU" class="btn primary" />
				</div>
			</div>

		</div>
		<div class="control-group">
			<label class="control-label">销售起价：</label>
			<div class="controls">
				<form:input path="price" class="required money valid" id="price" style="width: 50px;text-align: right;" />&nbsp;元
				<span class="help-inline"><font color="red">*</font> </span>

			</div>
		</div>
		<div class="control-group">
			<label class="control-label">商品封面：</label>
			<div class="controls">
				<form:hidden path="url" id="url"/>
				<span id="coverShow">
					<c:if test="${!empty product.url}">
						<div><img src='${product.url}&iopcmd=thumbnail&type=4&width=200'/></div>
					</c:if>
				</span>
				<span id="uploadCover"></span>
				<div type="button" class="btn" id="deleteCover">删除封面</div>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">商品详情：</label>
			<div class="controls">
				<form:textarea path="details" htmlEscape="false" rows="4" class="required input-xxlarge " style="width:360px"/>
				<script type="text/javascript">CKEDITOR.replace('details');</script>
				<span class="help-inline"><font color="red">*</font> </span>

			</div>
		</div>
		<div class="control-group">
			<label class="control-label">是否需要线下签约：</label>
			<div class="controls">
				<input type="radio"  name="sign" value="1" <c:if test="${product.sign == 1}">checked</c:if>/>是
				<input type="radio"  name="sign" value="0" <c:if test="${empty product.sign || product.sign == 0}">checked</c:if>/>否
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">是否单独售卖：</label>
			<div class="controls">
				<form:radiobuttons id="saleType" path="saleType" items="${erp:productSaleTypeList()}" itemLabel="name" itemValue="value"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">是否上架：</label>
			<div class="controls">
				<form:select path="status"  class="required" id="status" style="width:180px">
					<form:options items="${erp:productStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false" />
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
				&nbsp;
				<input id="planTime" name="planTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate" value="<fmt:formatDate value="${product.planTime}" pattern="yyyy-MM-dd HH:mm:ss"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});" <c:if test="${product.status !=4 }">style="display: none;"</c:if>/>
			</div>
		</div>

		<div class="form-actions">
			<shiro:hasPermission name="crm:product:save"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/></shiro:hasPermission>&nbsp;
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
	<script type="text/template" id="singleTemplate" >
		<table class="table table-striped table-bordered table-condensed" style="max-width: 70%">
			<thead>
			<th>
				项目/星级
			</th>
			<th>
				最小购买数量
			</th>
			<th>
				最大购买数量
			</th>
			<th>
				销售单价
			</th>
			<th>
				渠道结算单价
			</th>
			<th>
				服务人员结算价
			</th>
			<th>
				库存
			</th>
			<th>
				操作
			</th>
			</thead>
			<tbody>
			{{#skillArray}}

				<tr id="count{{count}}">
					<td>
						{{#skillName}}
						{{skillName}}
						{{/skillName}}

						{{#level}}
						<select name="levelId" style="width: 100px" onchange="changeLevel(this)">
							{{#levelList}}
							<option value="{{id}}">{{name}}</option>
							{{/levelList}}
						</select>
						{{/level}}
						<input type="hidden" name="skillId" value="{{skillId}}">
						<input type="hidden" name="skuCode" value="{{skuCode}}">
						<input type="hidden" name="skuPrice" value="{{price}}">
					</td>
					<td>
						<input name="minStock" type="text" style="width: 50px;text-align: right;" value="{{minStock}}" class="required digits valid startPrice"/>&nbsp;{{basicUnit}}
					</td>
					<td>
						<input name="maxStock" type="text" style="width: 50px;text-align: right;" value="{{maxStock}}" class="required digits valid"/>&nbsp;{{basicUnit}}
					</td>
					<td>
						<input name="salePrice" type="text" style="width: 50px;text-align: right;" value="{{salePrice}}" class="required digits valid startPrice"/>&nbsp;元
					</td>
					<td>
						<input name="channelPrice" type="text" style="width: 50px;text-align: right;" value="{{channelPrice}}" class="required digits valid"/>&nbsp;元
					</td>
					<td>
						<input name="servicePrice" type="text" style="width: 50px;text-align: right;" value="{{servicePrice}}" class="required digits valid" readonly="readonly"/>&nbsp;元
					</td>
					<td>
						<input name="skuStock" type="text" style="width: 50px;text-align: right;" value="{{skuStock}}" class="required digits valid"/>&nbsp;{{basicUnit}}
					</td>
					<td>
						<input type="button" class="btn btn-danger" value="删除" onclick="removeSku(this,'{{skuId}}')"/>
					</td>
				</tr>
			{{/skillArray}}
			</tbody>

		</table>
	</script>
	<script type="text/template" id="groupTemplate">
		<table class="table table-striped table-bordered table-condensed" style="max-width: 70%">
			<thead>
			<th>
				项目/星级
			</th>
			<th>
				销售数量
			</th>
			<th>
				销售单价
			</th>
			<th>
				销售总价
			</th>
			<th>
				渠道结算单价
			</th>
			<th>
				服务人员结算价
			</th>
			<th>
				库存
			</th>
			<th>
				操作
			</th>
			</thead>
			<tbody>
			{{#skillArray}}
			<tr id="count{{count}}">
				<td>
					{{#skillName}}
					{{skillName}}
					{{/skillName}}

					{{#level}}
					<select name="levelId" style="width: 100px" onchange="changeLevel(this)">
						{{#levelList}}
						<option value="{{id}}">{{name}}</option>
						{{/levelList}}
					</select>
					{{/level}}
					<input type="hidden" name="skillId" value="{{skillId}}">
					<input type="hidden" name="skuCode" value="{{skuCode}}">
				</td>
				<td>
					<input name="minStock" type="text" style="width: 50px;text-align: right;" value="{{minStock}}" class="required digits valid startPrice"/>&nbsp;{{basicUnit}}
					<input name="maxStock" type="hidden" value="{{maxStock}}"/>
				</td>
				<td>
					<input name="salePrice" type="text" style="width: 50px;text-align: right;" value="{{salePrice}}" class="required digits valid startPrice"/>&nbsp;元
				</td>
				<td>
					<input name="skuPrice" myProperty="myGroupTemplate" type="text" style="width: 50px;text-align: right;" value="{{price}}" class="required digits valid"/>&nbsp;元
				</td>
				<td>
					<input name="channelPrice" type="text" style="width: 50px;text-align: right;" value="{{channelPrice}}" class="required digits valid"/>&nbsp;元
				</td>
				<td>
					<input name="servicePrice" type="text"  style="width: 50px;text-align: right;" value="{{servicePrice}}" class="required digits valid" readonly="readonly"/>&nbsp;元
				</td>
				<td>
					<input name="skuStock" type="text" style="width: 50px;text-align: right;" value="{{skuStock}}" class="required digits valid"/>&nbsp;{{basicUnit}}
				</td>
				<td>
					<input type="button" class="btn btn-danger" value="删除" onclick="removeSku(this,'{{skuId}}')"/>
				</td>
			</tr>
			{{/skillArray}}
			</tbody>
		</table>
	</script>

	<script type="text/javascript" src="/static/upload/jquery.form.js"></script>
	<script type="text/javascript" src="/static/upload/jquery.uploadfile.min.js?v=1"></script>
	<script type="text/javascript">
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

		var skillId = "${product.skill.id}";
		var skuArray = ${fns:toJson(skuList)};
		var count = 0;

		var skillData;
		var levelList;
        $(document).ready(function(){

            $.validator.addMethod("startPrice",function (value, element) {

                var minStock = $("input[name='minStock']").val();
                var salePrice = $("input[name='salePrice']").val();
				if(!minStock || !salePrice)return true;
                minStock = parseInt(minStock);
                salePrice = parseInt(salePrice);
                if(isNaN(minStock) || isNaN(salePrice))return true;

                $("input[name='price']").val(minStock*salePrice);

                return true;
            },"");


            if (skillId!=""){
                loadSKU(skillId);
			}

            $("#productSkill").change(function () {
				if($(this).val() == ""){
				    console.log("empty");
				}else{

					loadSKU($(this).val())
				}
            });

            //计价方式切换SKU模板
            $("input[name='measureWay']").click(function () {
                count = 0;
				showSKU(skillData,true);
            });

            //单独售卖默认状态
            //if($("input[name='type']:checked").length<=0){
            //    $($("input[name='type']")[0]).attr("checked",true);
			//}

            $("#uploadCover").uploadFile({
                url:"/upload/files",
                fileName:"content",
                uploadStr:"上传封面",
                formData: {"dir":"product","isPrivate":false},
                multiple:false,
                dragDrop:false,
                uploadButtonClass:"ajax-file-upload-green btn btn-primary ignore",
                showStatusAfterSuccess:false,
                showAbort:false,
                showDone:false,
                acceptFiles:"image/*",
                allowedTypes:"png,gif,jpg,jpeg",
                returnType:"json",
                showPreview:true,
                previewHeight: "100px",
                previewWidth: "100px",
                onSuccess:function(files,data,xhr,pd) {

                    var url = data.urls[0];

                    $("#coverShow").empty();
                    $("#coverShow").html("<div><img src='"+url+"&iopcmd=thumbnail&type=4&width=200'/></div>");
                    $("input[name='url']").val(url);

                },
                onError:function(files,data,xhr,pd) {
                    showMessage("error","上传失败");
                }
            });


            $("#deleteCover").click(function () {
                $("#coverShow").empty();
                $("input[name='url']").val("");
            });

			//页面有多个form的情况下 !!!
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
		
			$("#status").change(function () {

				if($(this).val() == 3){
					$("#planTime").show();
                    $("#planTime").addClass("required");
				}else{
                    $("#planTime").hide();
                    $("#planTime").removeClass("required");
					$("label[for=planTime]").remove();
				}
            });

            $("#addPackageSku").click(function () {

                showSKU(skillData,false);
            });

            $("input[name='saleType']").click(function () {

                if($(this).val() == 2){

                    $("#status option:first").attr("selected",true);
                    $("#s2id_status").find(".select2-chosen").text($("#status option:first").text());
                    $("#status").attr("readonly",true);
					return;
                }else{

                    $("#status").attr("readonly",false);
                    return;
                }

            });
        });

        function showMessage(status,message) {
            $("#contentTable").before('<div id="messageBox" class="alert alert-'+status+'"><button data-dismiss="alert" class="close">×</button>'+message+'</div>');
        }

        function loadSKU(id) {
            $.get("/crm/skill/skillInfo",{"id":id},function (data) {

                skillData = data;
                if (data || data.status=="success"){
                    count = 0;
                    showSKU(data,true);
                }else{
                    showMessage("error","请求失败");
                }
            },"json").error(function() {
                showMessage("error","请求失败");
            });
        }
        //
        function showSKU(data,flush){
            if (!data)return;

            count++;

            var skillObj = data.skill;
            levelList = data.levelList;

            if(flush==true)$("#skuContent").empty();


            $("#unit").val(skillObj.unit);
            if (skillObj.unit == 1){
                skillObj.basicUnit = "天";
            }else{
                skillObj.basicUnit = "次";
            }
            $("#basicUnit").val(skillObj.basicUnit);


            var skillArray = new Array();

            var template;


            skillObj.count = count;
            skillObj.skillId = skillObj.id;
            skillObj.levelId = 0;
            skillObj.skuCode = codeFormat(1,3);
            skillObj.servicePrice = skillObj.settlementPrice;
            skillObj.price = 0;

            if(skillObj.category == 2){
                skillObj.skillName = null;
                skillObj.level = true;

			}

            skillArray.push(skillObj);


            var measureWay = $("input[name='measureWay']:checked").val();
            if (!measureWay) measureWay = $("input[name='measureWay']").val();

			if (measureWay == 1){

                template = $("#singleTemplate").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
                if (skillObj.category == 1){
                    $("#addPackageSkuDiv").hide();
				}else{
                    $("#addPackageSkuDiv").show();
				}

			}else if(measureWay == 2){
                template = $("#groupTemplate").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
                $("#addPackageSkuDiv").show();
                for(var j=0;j<skillArray.length;j++){
                    skillArray[j].price = parseInt(skillArray[j].minStock)*parseInt(skillArray[j].salePrice);
                    if(!skillArray[j].price){
                        skillArray[j].price = 0;
					}
                    //如果是组合，maxstock默认为0，不然提交会影响其他项
                    if( !skillArray[j].maxStock !== undefined ){
                        skillArray[j].maxStock = 0;
                    }

                }
			}



			if(flush==false || skuArray.length <=0){
                $("#skuContent").append(Mustache.render(template, {"skillArray":skillArray,"levelList":data.levelList}));

                if(skillObj.category == 2){
                    changeLevel($("#count"+count).find("select")[0]);
                }
                return;
			}

			//修改:旧数据匹配
			for(var i=0;i<skuArray.length;i++){
                for(var j=0;j<skillArray.length;j++){
                    if(skuArray[i].skillId == skillArray[j].skillId){
                        count++;
                        skillArray[j].count = i+1;
                        skillArray[j].skuId = skuArray[i].id;
                        skillArray[j].minStock = skuArray[i].minStock;
                        skillArray[j].maxStock = skuArray[i].maxStock;
                        if( skuArray[i].maxStock == undefined ){
                            skillArray[j].maxStock = 0;
                        }
                        skillArray[j].price = skuArray[i].price;
                        skillArray[j].salePrice = skuArray[i].salePrice;
                        skillArray[j].channelPrice = skuArray[i].channelPrice;
                        skillArray[j].servicePrice = skuArray[i].servicePrice;
                        skillArray[j].skuStock = skuArray[i].stock;

                        if (skuArray[i].unit == 1){
                            skillArray[j].basicUnit = "天";
                        }else{
                            skillArray[j].basicUnit = "次";
                        }
                        $("#skuContent").append(Mustache.render(template, {"skillArray":skillArray,"levelList":data.levelList}));
					}

				}

                if(skillObj.category == 2){
                    $("#count"+(i+1)).find("select").val(skuArray[i].levelId)
                }

			}
		}

		function removeSku(btn,skuId){
            if (count <=1)return;

            for(var i=0;i<skuArray.length;i++){
				if(skuArray[i].id == skuId){
                    skuArray.remove(i);
				}
            }
            count--;
			$(btn).parents("table").remove();
		}

		function changeLevel(levelObj) {
			var levelId = $(levelObj).val();

			for(i=0;i<levelList.length;i++){
			    if(levelList[i].id == levelId){
                    $(levelObj).parents("tr").find("input[name='servicePrice']").val(levelList[i].levelAmount);
                    $(levelObj).parents("tr").find("input[name='skuPrice']").val(levelList[i].levelAmount);
				}
			}

        }

		function codeFormat(num,length) {
            var numstr = num.toString();
            var l=numstr.length;
            if (numstr.length>=length) {return numstr;}

            for(var  i = 0 ;i<length - l;i++){
                numstr = "0" + numstr;
            }
            var prefix = $("input[name='code']").val();
            return prefix+numstr;
        }
		
	</script>
</body>
</html>
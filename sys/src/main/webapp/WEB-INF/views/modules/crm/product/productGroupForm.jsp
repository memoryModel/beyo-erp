<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>商品管理</title>
	<meta name="decorator" content="default"/>
	<link href="/static/upload/uploadfile.css?v=1" type="text/css" rel="stylesheet" />
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/crm/product/list">商品管理列表</a></li>
		<li class="active"><a href="${ctx}/crm/product/group?id=${product.id}">商品套餐<shiro:hasPermission name="crm:product:form">${not empty product.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="crm:product:form">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="productForm" name="productForm" modelAttribute="product" action="${ctx}/crm/product/saveGroup" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="unit"/>
		<form:hidden path="type"/>
		<form:hidden path="sign"/>
		<sys:message content="${message}"/>

		<div class="control-group">
			<label class="control-label">商品分类：</label>
			<div class="controls">
				<sys:treeselect id="productCategory" name="productCategory.id" value="${product.productCategory.id}"
								labelName="productCategory.name" labelValue="${product.productCategory.name}"
								title="商品名称" url="/crm/productCategory/treeData" cssClass="required" allowClear="true" notAllowSelectParent="true"/>
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
			<label class="control-label">选择商品：</label>
			<div class="controls">
				<div class="input-append">
					<shiro:hasPermission name="crm:productsku:selectGroupProduct"><input id="selectProduct" type="text" readonly="readonly" class="required input-xlarge" style="${cssStyle}" maxlength="255"/></shiro:hasPermission>
					<shiro:hasPermission name="crm:productsku:selectGroupProduct"><a id="selectProductHref" href="javascript:" class="btn">&nbsp;
						<i class="icon-search"></i>&nbsp;
					</a></shiro:hasPermission>
				</div>
				<span class="help-inline">
						<font color="red">*</font>
				</span>

				<div id="skuContent">

				</div>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">商品库存：</label>
			<div class="controls">
				<form:input id="stock" path="stock" htmlEscape="false" rows="4" maxlength="10" class="required digits valid" style="width:50px"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">商品封面：</label>
			<div class="controls">
				<form:hidden path="url"/>
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
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">是否上架：</label>
			<div class="controls">
				<form:select path="status"  class="required" id="status" style="width:180px">
					<form:options items="${erp:productStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false" />
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>

		<div class="form-actions">
			<shiro:hasPermission name="crm:product:saveGroup"><input id="btnSubmit" class="btn btn-primary" type="submit"  value="保 存"/></shiro:hasPermission>&nbsp;
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
	<script type="text/template" id="skuTemplate" >
		<table class="table table-striped table-bordered table-condensed" style="max-width: 80%;">
			<thead>
			<th>
				编码
			</th>
			<th>
				LOGO
			</th>
			<th>
				商品名称
			</th>
			<th>
				服务项目
			</th>
			<th>
				星级
			</th>
			<th>
				计价方式
			</th>
			<th>
				最小购买数量
			</th>
			<th>
				最大购买数量
			</th>
			<th>购买数量</th>
			<th>
				购买
			</th>
			<th>
				销售单价
			</th>
			<th>
				渠道结算价
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
			{{#skuArray}}
			<tr id="skuItem{{skuId}}">
				<td>
					{{code}}
					{{#error}}
					<div style="color: red">SKU已失效！</div>
					{{/error}}
				</td>
				<td>
					<input type="hidden" name="skuIds" value="{{skuId}}">
					<input type="hidden" name="productItemIds" value="{{productItemId}}">
					{{#url}}
					<img src="{{url}}" width="50px" height="50px"/>
					{{/url}}
				</td>
				<td>
					{{title}}
				</td>
				<td>
					{{skillName}}
				</td>
				<td>
					{{levelName}}
				</td>
				<td>
					{{measureWayName}}
				</td>
				<td>
					{{minStock}}&nbsp;{{baseUnit}}
				</td>
				<td>
					{{maxStock}}&nbsp;{{baseUnit}}
				</td>
                <td>
                    <span class="btn" onclick="changeCart(this,-1,'{{productItemId}}')">-</span>
                    <input name="saleStockNumber" id="saleStockNumber{{productItemId}}" minStock="{{minStock}}" maxStock="{{maxStock}}" type="text" style="width: 50px;text-align: right;" value="{{minStock}}" class="required number digits valid" readonly="readonly"/>
                    <span class="btn" onclick="changeCart(this,1,'{{productItemId}}')">+</span>
                </td>
				<td>
					{{salePrice}}&nbsp;元
				</td>
				<td>
					{{channelPrice}}&nbsp;元
				</td>
				<td>
					{{servicePrice}}&nbsp;元
				</td>
				<td>
					{{stock}}&nbsp;{{baseUnit}}
				</td>
				<td>
					<input type="button" class="btn" value="删除" onclick="removeSku('{{skuId}}')"/>
				</td>
			</tr>
			{{/skuArray}}
			</tbody>
		</table>
		<div>
			<div class="control-group">
				<label class="control-label" style="text-align: left">套餐总价:</label>
				<div class="controls">
					<input name="salePrice" type="text" style="width: 50px;text-align: right;" value="{{salePrice}}" class="required digits valid"/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" style="text-align: left">渠道结算总价:</label>
				<div class="controls">
					<input name="channelPrice" type="text" style="width: 50px;text-align: right;" value="{{channelPrice}}" class="required digits valid"/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" style="text-align: left">服务人员结算总价:</label>
				<div class="controls">
					<input name="servicePrice" type="text" style="width: 50px;text-align: right;" value="{{servicePrice}}" class="required digits valid"/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" style="text-align: left">套餐销售价格:</label>
				<div class="controls">
					<input name="price" type="text" style="width: 50px;text-align: right;" value="{{price}}" class="required digits valid"/>
				</div>
			</div>
		</div>


	</script>
	<script src="/static/upload/jquery.form.js"></script>
	<script src="/static/upload/jquery.uploadfile.min.js?v=1"></script>
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

        var skuArray = ${fns:toJson(skuList)};
        if (!skuArray)skuArray = new Array();

        var salePrice = parseFloat("${product.salePrice}");
        if(!salePrice)salePrice = 0;

        var channelPrice = parseFloat("${product.channelPrice}");
        if(!channelPrice)channelPrice = 0;

        var servicePrice = parseFloat("${product.servicePrice}");
        if(!servicePrice)servicePrice = 0;

        var price = parseFloat("${product.price}");
        if(!price)price = 0;

        var stock = parseFloat("${product.stock}");
        if(!stock)price = 0;

        var skuIdsArray = new Array();
        //var skuArray = new Array();
        var template = $("#skuTemplate").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");


        $(document).ready(function(){


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
                    $("#coverShow").html("<div><img src='"+url+"&iopcmd=thumbnail&type=4&width=100'/></div>");
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

            $("#selectProduct,#selectProductHref").click(function () {
                top.$.jBox.open("iframe:/crm/productsku/selectGroupProduct",
                    "选择商品",
                    1024,
                    768,
                    {
                        closed:function () {showSku()},
						ajaxData:{"product.type":"1","product.saleType":"2","product.status":"0","status":"0","skuIds":skuIdsArray.join(",")}
					}
                );
            });

            for(var i=0;i<skuArray.length;i++){
                skuIdsArray.push(skuArray[i].id);
                skuArray[i].productItemId = skuArray[i].product.id;
                skuArray[i].skuId = skuArray[i].id;
                skuArray[i].title = skuArray[i].product.title;
                skuArray[i].url = skuArray[i].product.url;
                skuArray[i].skillName = skuArray[i].skill.skillName;
                if(skuArray[i].serviceLevel){
                    skuArray[i].levelName = skuArray[i].serviceLevel.name;
                }

            }

            showSku();

        });


        function showMessage(status,message) {
            $("#contentTable").before('<div id="messageBox" class="alert alert-'+status+'"><button data-dismiss="alert" class="close">×</button>'+message+'</div>');
        }


        function addSKUCallback(skuId,productId,code,measureWay,title,skillName,levelId,levelName,unit,minStock,maxStock,salePrice,channelPrice,servicePrice,stock,url){
			//console.log(productId);
            //console.log(skuId+" "+title+" "+skillName+" "+levelId+" "+levelName+" "+unit+" "+minStock+" "+maxStock+" "+salePrice+" "+channelPrice+" "+servicePrice+" "+stock+" "+url);

            skuIdsArray.push(skuId);

            var baseUnit = "";
            if(unit == "1")baseUnit = "天";
            if(unit == "2")baseUnit = "次";

            var measureWayName = "";
            if(measureWay == "1")measureWayName = "单独";
            if(measureWay == "2")measureWayName = "打包";

            skuArray.push({
                "skuId":skuId,
                "productItemId":productId,
				"code":code,
				"title":title,
				"skillName":skillName,
				"levelId":levelId,
				"levelName":levelName,
				"unit":unit,
				"minStock":minStock,
				"maxStock":maxStock,
				"salePrice":salePrice,
				"channelPrice":channelPrice,
				"servicePrice":servicePrice,
				"stock":stock,
				"url":url,
				"baseUnit":baseUnit,
				"measureWayName":measureWayName,
				"measureWay":measureWay
			});
		}
		
		function showSku() {
            if(null==skuArray || skuArray.length <=0 ){
                return;
			}
			var stock = 0;
			if (price <= 0){
                for(var i=0;i<skuArray.length;i++){
                    salePrice +=  parseFloat(skuArray[i].salePrice)*parseFloat(skuArray[i].minStock);
                    channelPrice +=  parseFloat(skuArray[i].channelPrice)*parseFloat(skuArray[i].minStock);
                    servicePrice +=  parseFloat(skuArray[i].servicePrice)*parseFloat(skuArray[i].minStock);

                    stock += parseInt(skuArray[i].stock);


                    if (skuArray[i].status == 1){
                        skuArray[i].error = true;
					}
                }
                price = salePrice;
				//$("#stock").val(stock);
			}else {
                for(var i=0;i<skuArray.length;i++){
                    var baseUnit = "";
                    if(skuArray[i].unit == 1)baseUnit = "天";
                    if(skuArray[i].unit == 2)baseUnit = "次";
                    skuArray[i].baseUnit = baseUnit;

                    if(!skuArray[i].measureWayName){
                        var measureWayName = "";
                        if(skuArray[i].product.measureWay == 1)measureWayName = "单独";
                        if(skuArray[i].product.measureWay == 2)measureWayName = "打包";
                        skuArray[i].measureWayName = measureWayName;
					}

                    if (skuArray[i].status == 1){
                        skuArray[i].error = true;
                    }

                }
			}


            $("#skuContent").empty();
            $("#skuContent").append("<br>");
            $("#skuContent").append(Mustache.render(template, {
                "skuArray":skuArray,
				"salePrice":salePrice,
				"channelPrice":channelPrice,
				"servicePrice":servicePrice,
				"price":price
            }));

            $("#selectProduct").val("共"+skuArray.length+"件商品");
        }

        function removeSku(id) {

            for(var i=0;i<skuArray.length;i++){
                if( id == skuArray[i].skuId){
                    skuArray.remove(i);
                    $("#skuItem"+id).remove();
                    break;
				}
			}
            for(var i=0;i<skuIdsArray.length;i++){
                if( id == skuIdsArray[i]){
                    skuIdsArray.remove(i);
                    break;
                }
            }
            $("#selectProduct").val("共"+skuArray.length+"件商品");
            if (skuArray.length <=0 ){
                $("#skuContent").empty();
                $("#selectProduct").val("");
			}
        }

        function changeCart(button,num,pid) {
            var saleStockNumber = $('#saleStockNumber'+pid).val();
            var minStock = $('#saleStockNumber'+pid).attr('minStock');
            var maxStock = $('#saleStockNumber'+pid).attr('maxStock');
            saleStockNumber = parseInt(saleStockNumber)+num;
            if(saleStockNumber >= parseInt(minStock) && saleStockNumber<= parseInt(maxStock)){
                $('#saleStockNumber'+pid).val(saleStockNumber);
            }
        }
	</script>
</body>
</html>
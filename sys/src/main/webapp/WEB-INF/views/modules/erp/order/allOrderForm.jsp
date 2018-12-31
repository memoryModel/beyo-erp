<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>订单信息</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<c:if test="${tagFlag == 0}">
		<ul class="nav nav-tabs">
			<li  class="active"><a href="${ctx}/erp/allOrder/list">全部订单列表</a></li>
		</ul><br/>
		<ul class="nav nav-tabs">
			<li class="active"><a href="${ctx}/erp/allOrder/form?id=${order.id}&&studentId=${order.student.id}&&tagFlag=${tagFlag}">订单信息</a></li>
			<li><a href="${ctx}/erp/allOrder/customerInfo?id=${order.id}&&studentId=${order.student.id}&&tagFlag=${tagFlag}">
				<c:if test="${order.orderType == 1}">
					学生信息
				</c:if>
				<c:if test="${order.orderType == 2}">
					客户信息
				</c:if>
			</a></li>
			<li><a href="${ctx}/erp/allOrder/contractInfo?id=${order.id}&&studentId=${order.student.id}&&tagFlag=${tagFlag}">合同信息</a></li>
			<li><a href="${ctx}/erp/allOrder/receivableBillsInfo?id=${order.id}&&studentId=${order.student.id}&&tagFlag=${tagFlag}">结算信息</a></li>
				<%--<li><a href="${ctx}/erp/allOrder/form?id=${order.id}">服务信息</a></li>--%>
		</ul>
	</c:if>

	<c:if test="${tagFlag == 1}">
		<ul class="nav nav-tabs">
			<li><a href="${ctx}/crm/customer/info?id=${order.customer.id}&&tagFlag=${tagFlag}">基本信息</a></li>
			<li><a href="${ctx}/crm/customer/saleInfo?id=${order.customer.id}&&tagFlag=${tagFlag}">销售线索</a></li>
			<li><a href="${ctx}/crm/customer/orderInfo?id=${order.customer.id}&&tagFlag=${tagFlag}">订单信息</a></li>
			<li class="active"><a href="${ctx}/crm/customer/contractInfo?id=${order.customer.id}&&tagFlag=${tagFlag}">合同信息</a></li>
		</ul><br/>
		<ul class="nav nav-tabs">
			<li class="active"><a href="${ctx}/erp/allOrder/contractInfo?id=${order.id}&&tagFlag=${tagFlag}">合同信息</a></li>
			<li><a href="${ctx}/erp/allOrder/receivableBillsInfo?id=${order.id}&&tagFlag=${tagFlag}">结算信息</a></li>
		</ul><br/>
	</c:if>

	<form:form id="inputForm" modelAttribute="order" action="${ctx}/erp/allOrder/form" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<c:if test="${order.orderType == 1}">
			<strong>学生信息</strong>
			<table>
				<tr>
					<td>
						<div class="control-group">
							<label class="control-label">学生名称：</label>
							<div class="controls">
								<div class="input-append">
									<form:input path="student.name" readonly="true" type="text" value="${stuName}" class="input-large" style="width:150px"/>
								</div>
								<span class="help-inline">
								<font color="red">*</font>
				            </span>
							</div>
						</div>
					</td>
					<td>
						<div class="control-group">
							<label class="control-label">手机号码：</label>
							<div class="controls">
								<form:input path="student.phone" readonly="true" type="text" value="${stuPhone}" class="input-large" style="width:150px"/>
							</div>
						</div>
					</td>
					<td>
						<div class="control-group">
							<label class="control-label">性别：</label>
							<div class="controls">
								<form:input path="student.sex" readonly="true" type="text" value="${erp:sexStatusName(sex)}" class="input-large" style="width:120px"/>
							</div>
						</div>
					</td>
					<td>
						<div class="control-group">
							<label class="control-label">出生日期：</label>
							<div class="controls">
								<input name="student.dateBirth" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate " style="width:120px"
									   value="<fmt:formatDate value="${dateBirth}" pattern="yyyy-MM-dd"/>"/>
							</div>
						</div>
					</td>
				</tr>
			</table>
			<strong>班级信息</strong>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
		<tr>
			<th>班级名称</th>
			<th>课程</th>
			<th>价格</th>
			<th>班主任</th>
			<th>报班学员</th>
			<th>入班率</th>
			<th>开班日期</th>
			<th>班级状态</th>
		</tr>
		</thead>
		<tbody>
			<c:forEach items="${classList}" var="schoolClass">
				<tr>
					<td>
						   ${schoolClass.className}
					</td>
					<td>
							${schoolClass.schoolClassToLesson.schoolClassLesson.lessonName}
					</td>
					<td>
							${schoolClass.tuitionAmount}
					</td>
					<td>
							${schoolClass.headteacher.name}
					</td>
					<td>
							${empty schoolClass.classRealNum ? '':schoolClass.classRealNum}
							${empty schoolClass.classRealNum ? '':'/'}
							${empty schoolClass.classRealNum ? '':schoolClass.classMaxNum}
					</td>
					<td>
						<fmt:formatNumber type="number" value="${schoolClass.classRealNum*100/schoolClass.classMaxNum}" maxFractionDigits="0"/>%
					</td>
					<td>
						<fmt:formatDate value="${schoolClass.realBeginTime}" pattern="yyyy-MM-dd"/>
					</td>
					<td>
							${erp:classStatusName(schoolClass.status)}
							<%--${fns:getDictLabel(schoolClass.status, 'schoolclass_status', '')}--%>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
		</c:if>
		<c:if test="${order.orderType == 2}">
			<table>
				<tr>
					<td>
						<div class="control-group">
							<label class="control-label">客户名称：</label>
							<div class="controls">
								<div class="input-append">
									<form:input path="customer.name" readonly="true" type="text" value="${order.customer.name}" class="input-large" style="width:150px"/>
								</div>
								<span class="help-inline">
								<font color="red">*</font>
				            </span>
							</div>
						</div>
					</td>
					<td>
						<div class="control-group">
							<label class="control-label">手机号码：</label>
							<div class="controls">

								<form:input path="customer.phone" readonly="true" type="text" value="${order.customer.phone}" class="input-large" style="width:150px"/>
							</div>
						</div>
					</td>
					<td>
						<div class="control-group">
							<label class="control-label">性别：</label>
							<div class="controls">
								<form:input path="customer.sex" htmlEscape="false" maxlength="200" class="required input-xlarge " style="width:150px" value="${erp:sexStatusName(order.customer.sex)}" readonly="true"/>
							</div>
						</div>
					</td>
					<td>
						<div class="control-group">
							<label class="control-label">出生日期：</label>
							<div class="controls">
								<input name="customer.birthTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate " style="width:120px"
									   value="<fmt:formatDate value="${order.customer.birthTime}" pattern="yyyy-MM-dd HH:mm"/>"/>
							</div>
						</div>
					</td>
				</tr>


			</table>

			<div class="control-group">
				<label class="control-label">商品信息：</label>
				<div class="controls">

					<div id="skuContent">

					</div>
				</div>
			</div>
			<table>
				<tr>
					<td>
						<div class="control-group">
							<label class="control-label" >订单金额合计:</label>
							<div class="controls">
								<form:input path="overallAmount" id="overallAmount" value="${order.overallAmount}"  class=" digits valid" readonly="true" style="width:150px;"/>&nbsp;元
							</div>
						</div>
					</td>
					<td>
						<div class="control-group">
							<label class="control-label" >优惠金额:</label>
							<div class="controls">
								<form:input path="favorableAmount" id="favorableAmount" value="${order.favorableAmount}" class="required money valid" readonly="true" style="width:150px;"/>&nbsp;元
								<span class="help-inline">
						<font color="red">*</font>
				</span>
							</div>
						</div>
					</td>
					<td>
						<div class="control-group">
							<label class="control-label">支付金额:</label>
							<div class="controls">
								<form:input path="paymentAmount" id="paymentAmount" value="${order.paymentAmount}" class=" money valid" readonly="true" style="width:150px;"/>&nbsp;元
							</div>
						</div>
					</td>
				</tr>
			</table>
			<table>
				<tr>
					<td>
						<div class="control-group">
							<label class="control-label">订单来源：</label>
							<div class="controls">
								<form:input path="customerResource.id" type="text" value="${order.customerResource.customerName}" class="input-large" style="width:200px" readonly="true" />
								<span class="help-inline">
						      <font color="red">*</font>
							</span>
							</div>
						</div>
					</td>
					<td>
						<div class="control-group">
							<label class="control-label">销售顾问：</label>
							<div class="controls">
								<form:input path="sale.id" type="text" value="${order.sale.name}" class="input-large" style="width:200px" readonly="true" />
							</div>
						</div>
					</td>
				</tr>
			</table>
		</c:if>
	</form:form>

	<!--商品信息-->
	<script type="text/template" id="skuTemplate" >
		<br id="br{{product.id}}">
		<table id="product{{product.id}}" class="table table-striped table-bordered table-condensed" style="max-width: 80%">
			<thead>
			<th colspan="2">
				商品名称
			</th>
			<th colspan="2">
				商品类型
			</th>
			<th colspan="2">
				商品编码
			</th>
			<th colspan="2">
				销售起价
			</th>
			<th>
				操作
			</th>
			</thead>
			<tbody>
			<tr>
				<td colspan="2">
					{{product.title}}
				</td>
				<td colspan="2">
					{{product.typeName}}
				</td>
				<td colspan="2">
					{{product.code}}
				</td>
				<td colspan="2">
					{{product.price}}&nbsp;元
				</td>
				<td>
					<input type="button" class="btn btn-danger" value="删除" onclick="removeProductSku('{{product.id}}')"/>
				</td>
			</tr>
			<tr>
				<td colspan="999" id="skuListContent{{product.id}}">

				</td>
			</tr>
			</tbody>
		</table>
	</script>
	<!--单项技能+单品-->
	<script id="singleTemplate" type="text/template">
		<table id="skuTable{{product.id}}" class="table table-striped table-bordered table-condensed index{{index}}">
		<thead>
		<th>
			服务项目
		</th>
		<th>
			销售单价
		</th>
		<th>
			最小购买数量
		</th>
		<th>
			最大购买数量
		</th>
		<th colspan="2">
			购买数量
		</th>
		<th colspan="2">
			销售总价
		</th>
		</thead>
		<tbody>
		{{#skuList}}
		<tr>
			<td>
				{{product.skill.skillName}}
				<input type="hidden" name="productId" value="{{product.id}}">
				<input type="hidden" name="skuId" value="{{id}}">
			</td>
			<td>
				{{salePrice}}&nbsp;元
				<input type="hidden" name="salePrice" value="{{salePrice}}">
			</td>
			<td>
				{{minStock}}&nbsp;{{basicUnit}}
				<input type="hidden" name="minStock" value="{{minStock}}">
			</td>
			<td>
				{{maxStock}}&nbsp;{{basicUnit}}
				<input type="hidden" name="maxStock" value="{{maxStock}}">
			</td>
			<td colspan="2">
				<span class="btn" onclick="changeCart(this,-1,'{{product.id}}')">-</span>
				<input name="sum" type="text" style="width: 50px;text-align: right;" value="{{sum}}" class="required digits valid" readonly="readonly"/>
				<span class="btn" onclick="changeCart(this,1,'{{product.id}}')">+</span>
			</td>
			<td colspan="2">
				<input name="itemPrice" type="text" style="width: 50px;text-align: right;" value="{{itemPrice}}" class="required digits valid" readonly="readonly"/>&nbsp;元
			</td>
		</tr>
		{{/skuList}}
		</tbody>
		</table>
	</script>
	<!--单项技能+打包-->
	<script id="singlePackageTemplate" type="text/template">
		<table id="skuTable{{product.id}}" class="table table-striped table-bordered table-condensed index{{index}}">
		<thead>
		<th>
			服务项目
		</th>
		<th>
			服务数量
		</th>
		<th>
			销售单价
		</th>
		<th colspan="2">
			购买数量
		</th>
		<th colspan="2">
			销售总价
		</th>
		</thead>
		<tbody>
		<tr>
			<td>
				{{product.skill.skillName}}
				<input type="hidden" name="productId" value="{{product.id}}">
			</td>
			<td>
				<select name="skuId" style="width: 100px">
					{{#skuList}}
					<option value="{{id}}">{{minStock}}&nbsp;{{basicUnit}}</option>
					{{/skuList}}
				</select>
			</td>
			<td>
				<span name="price"></span>&nbsp;元
				<input type="hidden" name="salePrice" value="">
			</td>
			<td colspan="2">
				<span class="btn" onclick="changeCart(this,-1,'{{product.id}}')">-</span>
				<input name="sum" type="text" style="width: 50px;text-align: right;" value="{{sum}}" class="required digits valid" readonly="readonly"/>
				<span class="btn" onclick="changeCart(this,1,'{{product.id}}')">+</span>
			</td>
			<td colspan="2">
				<input name="itemPrice" type="text" style="width: 50px;text-align: right;" value="{{itemPrice}}" class="required digits valid" readonly="readonly"/>&nbsp;元
			</td>
		</tr>
		</tbody>
		</table>
	</script>
	<!--基础技能+单品-->
	<script id="baseTemplate" type="text/template">
		<table id="skuTable{{product.id}}" class="table table-striped table-bordered table-condensed index{{index}}">
			<thead>
			<th>
				服务项目
			</th>
			<th>
				服务星级
			</th>
			<th>
				销售单价
			</th>
			<th>
				最小购买数量
			</th>
			<th>
				最大购买数量
			</th>
			<th colspan="2">
				购买数量
			</th>
			<th colspan="2">
				销售总价
			</th>
			</thead>
			<tbody>

			<tr>
				<td>
					{{product.skill.skillName}}
					<input type="hidden" name="productId" value="{{product.id}}">
				</td>
				<td>
					<select name="skuId" style="width: 100px">
						{{#skuList}}
						<option value="{{id}}">{{serviceLevel.name}}</option>
						{{/skuList}}
					</select>
				</td>
				<td>
					<span name="salePrice"></span>&nbsp;元
					<input type="hidden" name="salePrice" value="">
				</td>
				<td>
					<span name="minStock"></span>&nbsp;{{basicUnit}}
				</td>
				<td>
					<span name="maxStock"></span>&nbsp;{{basicUnit}}
				</td>
				<td colspan="2">
					<span class="btn" onclick="changeCart(this,-1,'{{product.id}}')">-</span>
					<input name="sum" type="text" style="width: 50px;text-align: right;" value="{{sum}}" class="required digits valid" readonly="readonly"/>
					<span class="btn" onclick="changeCart(this,1,'{{product.id}}')">+</span>
				</td>
				<td colspan="2">
					<input name="itemPrice" type="text" style="width: 50px;text-align: right;" value="{{itemPrice}}" class="required digits valid" readonly="readonly"/>&nbsp;元
				</td>
			</tr>
			</tbody>
		</table>
	</script>
	<!--基础技能+打包-->
	<script id="basePackageTemplate" type="text/template">
		<table id="skuTable{{product.id}}" class="table table-striped table-bordered table-condensed index{{index}}">
			<thead>
			<th>
				服务项目
			</th>
			<th>
				服务星级/服务数量
			</th>
			<th>
				销售单价
			</th>
			<th colspan="2">
				购买数量
			</th>
			<th colspan="2">
				销售总价
			</th>
			</thead>
			<tbody>
			<tr>
				<td>
					{{product.skill.skillName}}
					<input type="hidden" name="productId" value="{{product.id}}">
				</td>
				<td>
					<select name="skuId">
						{{#skuList}}
						<option value="{{id}}">{{serviceLevel.name}}&nbsp;&nbsp;{{minStock}}&nbsp;{{basicUnit}}</option>
						{{/skuList}}
					</select>
				</td>

				<td>
					<span name="price"></span>&nbsp;元
					<input type="hidden" name="salePrice" value="">
				</td>
				<td colspan="2">
					<span class="btn" onclick="changeCart(this,-1,'{{product.id}}')">-</span>
					<input name="sum" type="text" style="width: 50px;text-align: right;" value="{{sum}}" class="required digits valid" readonly="readonly"/>
					<span class="btn" onclick="changeCart(this,1,'{{product.id}}')">+</span>
				</td>
				<td colspan="2">
					<input name="itemPrice" type="text" style="width: 50px;text-align: right;" value="{{itemPrice}}" class="required digits valid" readonly="readonly"/>&nbsp;元
				</td>
			</tr>
			</tbody>
		</table>
	</script>
	<script type="text/javascript">

		<c:if test="${!empty readonly}">
        var readonly = ${readonly};
		</c:if>
        <c:if test="${empty readonly}">
        var readonly = false;
        </c:if>

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

        var data = ${fns:toJson(returnMap)};

        var productIdsArray = new Array();
        //var skuArray = new Array();
        var template = $("#skuTemplate").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
        var singleTemplate = $("#singleTemplate").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
        var singlePackageTemplate = $("#singlePackageTemplate").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
        var baseTemplate = $("#baseTemplate").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
        var basePackageTemplate = $("#basePackageTemplate").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");


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

            

            $("#customerButton").click(function () {
                if(readonly)return;

                top.$.jBox.open("iframe:/crm/customer/select", "选择客户", 1024, 520);
            });

            $("#selectProduct,#selectProductHref").click(function () {
                if(readonly)return;

                top.$.jBox.open("iframe:/crm/product/selectProduct",
                    "选择商品",
                    1024,
                    768,
                    {
                        closed:function () {},
                        ajaxData:{"productIds":productIdsArray.join(","),"status":1}
                    }
                );
            });
            
            $("#favorableAmount").change(function () {
                if(readonly)return;

                var favorableAmount  = $(this).val();
                if(isNaN(favorableAmount)){
                    $(this).val(0);
				}

				totalAmount();
            });

            if (data){
                showProductSku(data);
			}

        });

        function selectCustomerCallback(id,name){
            $("#customerId").val(id);
            $("#customerName").val(name);
        }

        function addProductCallback(productId){

            loading('正在加载，请稍等...');


            productIdsArray.push(productId);

            $.get("/crm/product/productInfo",{"id":productId},function (data) {

                if (data.status == "success"){
                    showProductSku(data);
                }else{
                    loading('加载失败');
                    setTimeout("closeLoading()",2000);
                }
            }).error(function() {
                loading('加载失败');
                setTimeout("closeLoading()",2000);
            });
        }

        var productList;
        var cacheProductList = new Array();

        function showProductSku(data) {

            if(!data || !data.productList)return;

            var type = data.type;

            productList = data.productList;


            if(productList.length<=0)return;


            for(var i=0;i<productList.length;i++){

                productIdsArray.push(productList[i].product.id);
                cacheProductList.push(productList[i]);

                if (productList[i].product.type == 1){
                    productList[i].product.typeName = "单品";
                }else if(productList[i].product.type ==2 ){
                    productList[i].product.typeName = "套餐";
                }

                for(var j=0;j<productList[i].skuList.length;j++){


                    if (productList[i].skuList[j].unit == 1){
                        productList[i].skuList[j].basicUnit = "天";
                    }else{
                        productList[i].skuList[j].basicUnit = "次";
                    }
                    if(productList[i].skuList[j].sum == undefined){
                        productList[i].skuList[j].sum = 1;
                    }

                    //if (productList[i].product.measureWay ==1){
                    //    productList[i].skuList[j].sum = productList[i].skuList[j].minStock;
                    //}

                    if(productList[i].skuList[j].itemPrice == undefined){
                        if (productList[i].product.measureWay == 1){
                            productList[i].skuList[j].itemPrice = parseInt(productList[i].skuList[j].sum)*parseFloat(productList[i].skuList[j].salePrice);
                        }else if(productList[i].product.measureWay == 2){
                            productList[i].skuList[j].itemPrice = parseInt(productList[i].skuList[j].sum)*parseFloat(productList[i].skuList[j].price);
						}
                    }


				}
				var skucontent = "";
                if (productList[i].product.skill.category == 1 && productList[i].product.measureWay == 1){//单项+单品
                    skucontent += Mustache.render(singleTemplate, {"product":productList[i].product,"skuList":productList[i].skuList,"index":productList[i].product.id});
                }else if(productList[i].product.skill.category == 1 && productList[i].product.measureWay == 2){//单项+打包
                    skucontent += Mustache.render(singlePackageTemplate, {"product":productList[i].product,"skuList":productList[i].skuList,"index":productList[i].product.id});
                }else if (productList[i].product.skill.category == 2 && productList[i].product.measureWay == 1){//基础+单品
                    skucontent += Mustache.render(baseTemplate, {"product":productList[i].product,"skuList":productList[i].skuList,"index":productList[i].product.id});
                }else if(productList[i].product.skill.category == 2 && productList[i].product.measureWay == 2){//基础+打包
                    skucontent += Mustache.render(basePackageTemplate, {"product":productList[i].product,"skuList":productList[i].skuList,"index":productList[i].product.id});
                }

                if(type == 1){
                    $("#skuContent").append(Mustache.render(template, {"product":productList[i].product}));
                    $("#skuListContent"+productList[i].product.id).html(skucontent);
				}else{

                    if (i==0){
                        if (data.parentProduct.type == 1){
                            data.parentProduct.typeName = "单品";
                        }else if(data.parentProduct.type ==2 ){
                            data.parentProduct.typeName = "套餐";
                        }

                        $("#skuContent").append(Mustache.render(template, {"product":data.parentProduct}));
					}

                    $("#skuListContent"+data.parentProduct.id).append(skucontent);
				}
                var pid = productList[i].product.id;

                if(productList[i].product.skill.category == 1 && productList[i].product.measureWay == 1){
                    totalAmount();
                }else if(productList[i].product.skill.category == 1 && productList[i].product.measureWay == 2){

                    $("#skuTable"+pid).find("select").each(function (index,item) {
                        $(item).change(function () {
                            for(var k=0;k<cacheProductList.length;k++){
                                for(var m=0;m<cacheProductList[k].skuList.length;m++){

                                    if ($(item).val() == cacheProductList[k].skuList[m].id){

                                        $(item).parents(".index"+cacheProductList[k].product.id).find("span[name='price']").text(cacheProductList[k].skuList[m].price);
                                        $(item).parents(".index"+cacheProductList[k].product.id).find("input[name='salePrice']").val(cacheProductList[k].skuList[m].price);
                                        $(item).parents(".index"+cacheProductList[k].product.id).find("input[name='sum']").val(cacheProductList[k].skuList[m].sum);
                                        $(item).parents(".index"+cacheProductList[k].product.id).find("input[name='itemPrice']").val(cacheProductList[k].skuList[m].itemPrice);

                                        totalAmount();
                                    }
                                }
							}
                        });

                        if(index==0)$(item).trigger("change");
                    });
				}else if(productList[i].product.skill.category == 2 && productList[i].product.measureWay == 1){

                    $("#skuTable"+pid).find("select").each(function (index,item) {
                        $(item).change(function () {
                            for(var k=0;k<cacheProductList.length;k++){
                                for(var m=0;m<cacheProductList[k].skuList.length;m++){

                                    if ($(item).val() == cacheProductList[k].skuList[m].id) {

                                        $(item).parents(".index"+cacheProductList[k].product.id).find("span[name='salePrice']").text(cacheProductList[k].skuList[m].salePrice);
                                        $(item).parents(".index"+cacheProductList[k].product.id).find("input[name='salePrice']").val(cacheProductList[k].skuList[m].salePrice);
                                        $(item).parents(".index"+cacheProductList[k].product.id).find("span[name='minStock']").text(cacheProductList[k].skuList[m].minStock);
                                        $(item).parents(".index"+cacheProductList[k].product.id).find("span[name='maxStock']").text(cacheProductList[k].skuList[m].maxStock);
                                        $(item).parents(".index"+cacheProductList[k].product.id).find("input[name='sum']").val(cacheProductList[k].skuList[m].sum);
                                        $(item).parents(".index"+cacheProductList[k].product.id).find("input[name='itemPrice']").val(cacheProductList[k].skuList[m].itemPrice);

                                        totalAmount();
                                    }
                                }
                            }
                        });

                        if(index==0)$(item).trigger("change");
                    });
				}else if(productList[i].product.skill.category == 2 && productList[i].product.measureWay == 2){


                    $("#skuTable"+pid).find("select").each(function (index,item) {
                        $(item).change(function () {
                            for(var k=0;k<cacheProductList.length;k++){
                                for(var m=0;m<cacheProductList[k].skuList.length;m++){

                                    if ($(item).val() == cacheProductList[k].skuList[m].id) {

                                        $(item).parents(".index"+cacheProductList[k].product.id).find("span[name='price']").text(cacheProductList[k].skuList[m].price);
                                        $(item).parents(".index"+cacheProductList[k].product.id).find("input[name='salePrice']").val(cacheProductList[k].skuList[m].price);
                                        $(item).parents(".index"+cacheProductList[k].product.id).find("input[name='sum']").val(cacheProductList[k].skuList[m].sum);
                                        $(item).parents(".index"+cacheProductList[k].product.id).find("input[name='itemPrice']").val(cacheProductList[k].skuList[m].itemPrice);

                                        totalAmount();
                                    }
                                }
                            }
                        });

                        if(index==0)$(item).trigger("change");
                    });
                }

            }


            closeLoading();
        }

        function removeProductSku(id) {
            if(readonly)return;

            for(var i=0;i<productIdsArray.length;i++){
                if( id == productIdsArray[i]){
                    productIdsArray.remove(i);
                    break;
                }
            }
            for(var i=0;i<cacheProductList.length;i++){
                if( id == cacheProductList[i].product.id){
                    cacheProductList.remove(i);
                    break;
                }
            }
            $("#product"+id).remove();
            $("#br"+id).remove();
			if (productIdsArray.length <=0 ){
                $("#selectProduct").val("");
			}else{
                $("#selectProduct").val("共"+productIdsArray.length+"件商品");
			}

			totalAmount();
        }


		function changeCart(button,num,pid) {
            if(readonly)return;

            for(var i=0;i<cacheProductList.length;i++){
                if( pid == cacheProductList[i].product.id){

                    if(cacheProductList[i].product.skill.category == 1 && cacheProductList[i].product.measureWay == 1){
                        var table = "#skuTable"+cacheProductList[i].product.id;
                        var sum = $(table).find("input[name='sum']").val();
                        var minStock = $(table).find("input[name='minStock']").val();
                        var maxStock = $(table).find("input[name='maxStock']").val();
                        var salePrice = $(table).find("input[name='salePrice']").val();

						var itemPrice = cartItemPrice(sum,num,minStock,maxStock,salePrice);

						if (itemPrice <=0 )return;

                        sum = parseInt(sum) + num;

                        $(table).find("input[name='sum']").val(sum);

                        $(table).find("input[name='itemPrice']").val(itemPrice);

                        totalAmount();

                        return;



                    }else if(cacheProductList[i].product.measureWay == 2  && (cacheProductList[i].product.skill.category == 1 || cacheProductList[i].product.skill.category == 2)){

                        var table = "#skuTable"+cacheProductList[i].product.id;
						var skuId = $(table).find("select").val();

						var minStock = 1;
						var maxStock = 0;
						for(k=0;k<cacheProductList[i].skuList.length;k++){
						    if (skuId == cacheProductList[i].skuList[k].id){
                                maxStock = cacheProductList[i].skuList[k].stock;
                                break;
							}
						}

                        var sum = $(table).find("input[name='sum']").val();
                        var salePrice = $(table).find("span[name='price']").text();



                        var itemPrice = cartItemPrice(sum,num,minStock,maxStock,salePrice);


                        if (itemPrice <=0 )return;

                        sum = parseInt(sum) + num;



                        $(table).find("input[name='sum']").val(sum);

                        $(table).find("input[name='itemPrice']").val(itemPrice);

                        totalAmount();

                        return;

                    }else if(cacheProductList[i].product.skill.category == 2 && cacheProductList[i].product.measureWay == 1){

                        var table = "#skuTable"+cacheProductList[i].product.id;
                        var sum = $(table).find("input[name='sum']").val();
                        var minStock = $(table).find("span[name='minStock']").text();
                        var maxStock = $(table).find("span[name='maxStock']").text();
                        var salePrice = $(table).find("span[name='salePrice']").text();

                        var itemPrice = cartItemPrice(sum,num,minStock,maxStock,salePrice);

                        if (itemPrice <=0 )return;

                        sum = parseInt(sum) + num;

                        $(table).find("input[name='sum']").val(sum);

                        $(table).find("input[name='itemPrice']").val(itemPrice);

                        totalAmount();

                        return;


                    }



                    break;
                }
            }
        }

        function cartItemPrice(sum,num,minStock,maxStock,price) {
            sum = parseInt(sum) + num;

            if (sum <= 0)return 0;

            minStock = parseInt(minStock);
            maxStock = parseInt(maxStock);

            if (sum < minStock)return 0;
            if (sum > maxStock)return 0;



            price = parseFloat(price);
            return sum * price;

        }


        function totalAmount(){
            var amount = 0;
            var num = 0;
            for(var i=0;i<cacheProductList.length;i++){
                num += parseInt($("#skuTable"+cacheProductList[i].product.id).find("input[name='sum']").val());
                var itemPrice = $("#skuTable"+cacheProductList[i].product.id).find("input[name='itemPrice']").val();
                amount += parseFloat(itemPrice);
            }

            $("#overallAmount").val(amount);

			var favorableAmount = $("#favorableAmount").val();
            favorableAmount = parseFloat(favorableAmount);
            if(isNaN(favorableAmount))favorableAmount = 0;
            if(favorableAmount>amount){
                favorableAmount = amount;
			}
            $("#paymentAmount").val(amount-favorableAmount);
            $("#selectProduct").val("共"+num+"件商品");

            if(readonly){
                $("#favorableAmount").attr("readonly","readonly");
                $("#paymentAmount").attr("readonly","readonly");
                $("#customerResourceId,#customerResourceName,#customerResourceButton").unbind("click");
                $("#saleIdId,#saleIdName,#saleIdButton").unbind("click");
			}
        }

	</script>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>添加预定订单</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$('#selectProduct').click(function(){
			    //获取已选择的产品id
				var productIdHTML = $('input[type="hidden"][name="productId"]');
                var selectProductIds = '';
				for(var i=0;i<productIdHTML.length;i++){
                    if(i<productIdHTML.length-1){
                        selectProductIds = selectProductIds + $(productIdHTML[i]).val()+",";
					}else{
                        selectProductIds = selectProductIds + $(productIdHTML[i]).val();
					}
				}
				top.$.jBox("iframe:/crm/product/saleProductlist?selectProductIds="+selectProductIds,{
                    title:"商品列表",
                    width:1000,
                    height:500,
                    buttons:{},
                    /* closed:function () {
                        document.location.reload();
                    }*/
                });

            })
		});
		//选择商品回调
        function productSelectCallback(id,selectFlag){
            if(selectFlag == '选择'){
                $.ajax({
					url:'${ctx}/crm/saleMyself/getProduct',
					type:'post',
					dataType:'json',
					async:false,
					data:{'productId':id},
					success:function (data) {
						var type = data.type //商品类型
						if(type == 1){
                            var productSinglePriceTemplate = $("#productSinglePriceTemplate").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
							var trHTML = Mustache.render(productSinglePriceTemplate,{
							    "id":data.id,
							   "title":data.title,
							   "code":data.code,
								"salePrice":data.salePrice,
								"productSkuList":data.productSkuList
							});
                            $('table[product]').append('<tr><td>'+trHTML+'</td></tr>');
						}else if(type == 2){
						    var productGroupPriceTemplate = $("#productGroupPriceTemplate").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
                            var trHTML = Mustache.render(productGroupPriceTemplate,{
                                "id":data.id,
                                "title":data.title,
                                "code":data.code,
                                "salePrice":data.salePrice,
                                "productGroupList":data.productGroupList
                            });
                            $('table[product]').append('<tr><td>'+trHTML+'</td></tr>');
						}
                    }
				})
			}else if(selectFlag == '取消选择'){
                $('input[type="hidden"][name="productId"][value='+id+']').parent().parent().parent().remove();
			}
        }

        function removeProduct(buttonHTML){
            $(buttonHTML).parent().parent().remove();
		}
	</script>
</head>
<body>
	<form:form id="searchForm" modelAttribute="sale" action="${ctx}/crm/saleMyself/doReservation" method="post" class="form-horizontal">
		<div class="alert alert-info">商品信息</div>
		<input id="selectProduct" class="btn btn-primary" type="button" value="选择商品"/>
		<table product class="table table-striped table-bordered table-condensed" style="max-width: 50%">

		</table>
		<table class="table table-striped table-bordered table-condensed" style="max-width: 50%">
			<tr>
				<td>订单金额合计（元）：<input type="text" name="amount" style="width:20%"></td>
				<td>*优惠金额（元）：<input type="text" style="width:20%"></td>
				<td>实际金额（元）：<input type="text" style="width:20%"></td>
			</tr>
		</table>

		<div class="alert alert-info">订单信息</div>
		<table class="table table-striped table-bordered table-condensed" style="max-width: 50%">
			<tr>
				<td>*订单来源：<input type="text" name="amount" style="width:20%"></td>
				<td>销售顾问：<input type="text" style="width:20%"></td>
			</tr>
		</table>
	</form:form>
	<script type="text/template" id="productSinglePriceTemplate" >
		<div>
			<table class="table table-striped table-bordered table-condensed">
				<input type="hidden" name="productId" value="{{id}}">
				<thead>
				<tr>
					<th colspan="3">商品名称</th>
					<th>商品类型</th>
					<th colspan="2">商品编码</th>
					<th colspan="2">销售起价</th>
				</tr>
				</thead>
				<tbody>
				<tr>
					<td colspan="3">{{title}}</td>
					<td>单品</td>
					<td colspan="2">{{code}}</td>
					<td colspan="2">{{salePrice}}</td>
				</tr>
				</tbody>
				<thead>
				<tr>
					<th>技能项</th>
					<th>计价方式</th>
					<th>星级</th>
					<th>销售单价</th>
					<th>最小购买数</th>
					<th>最大购买数</th>
					<th>购买数量</th>
					<th>销售总价</th>
				</tr>
				</thead>
				<tbody>
				{{#productSkuList}}
				<tr>
					<td>{{skillName}}</td>
					<td>{{measureWayName}}</td>
					<td>{{levelName}}</td>
					<td>{{salePrice}}</td>
					<td>{{minStock}}</td>
					<td>{{maxStock}}</td>
					<td><input type="text" style="width: 20%"></td>
					<td>5000</td>
				</tr>
				{{/productSkuList}}
				</tbody>
			</table>
			<input type="button" class="btn btn-primary" value="删除" onclick="removeProduct(this);">
		</div>

	</script>
	<script type="text/template" id="productGroupPriceTemplate" >
		<div>
			<table class="table table-striped table-bordered table-condensed">
				<input type="hidden" name="productId" value="{{id}}">
				<thead>
				<tr>
					<th colspan="2">商品名称</th>
					<th>商品类型</th>
					<th>商品编码</th>
					<th>销售起价</th>
				</tr>
				</thead>
				<tbody>
				<tr>
					<td colspan="2">{{title}}</td>
					<td>套餐</td>
					<td>{{code}}</td>
					<td>{{salePrice}}</td>
				</tr>
				</tbody>
				<thead>
				<tr>
					<th>技能项</th>
					<th>星级</th>
					<th>销售单价</th>
					<th>售卖数量</th>
					<th>价格合计</th>
				</tr>
				</thead>
				<tbody>
				{{#productGroupList}}
				<tr>
					<td>{{productSku.product.skill.skillName}}</td>
					<td>{{productSku.levelName}}</td>
					<td>{{productSku.salePrice}}</td>
					<td>售卖数量</td>
					<td>价格合计</td>
				</tr>
				{{/productGroupList}}
				</tbody>
			</table>
			<input type="button" class="btn btn-primary" value="删除" onclick="removeProduct(this);">
		</div>
	</script>
	<sys:message content="${message}"/>
</body>
</html>
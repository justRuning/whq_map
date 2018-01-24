<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<script src="http://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script>


<script type="text/javascript"
	src="http://api.map.baidu.com/api?v=2.0&ak=sA0bSnULTPEEtWYDd8AgSHWT"></script>

<div style="width: 100%; margin-left: auto; margin-right: auto;">
	<div id="weatherDiv" class="tab1 weatherDiv">
		<div id="weatherMap" style="width: 100%; height: 100%;"></div>
	</div>



	<script type="text/javascript">
			// 实况
			var myPointsGouKou = [];
			var opt = [];
			var labelGouKou = [];
		    var map121 = new BMap.Map("weatherMap", { mapType: BMAP_SATELLITE_MAP });
		    var poi = new BMap.Point(106.98, 41.45);
		    map121.centerAndZoom(poi, 10);
		    map121.enableScrollWheelZoom();
		    map121.addControl(new BMap.NavigationControl());               // 添加平移缩放控件
		    map121.addControl(new BMap.ScaleControl());                    // 添加比例尺控件
		    map121.addControl(new BMap.OverviewMapControl());              //添加缩略地图控件
		                       
			var opt ={offset: new BMap.Size(45, 50)};                
			map121.addControl(new BMap.MapTypeControl(opt));          //添加地图类型控件
			vv=getBoundary();
			vv=WriteBoundary();
			
			
			map121.addEventListener("zoomend", function(){
				var z=this.getZoom();
				if(z>11){
					for (i=1;i<=13;i++){
						labelGouKou[i].show();
					}
				}
				if (z<12){
					for (i=1;i<=13;i++){
						labelGouKou[i].hide();
					}
				}
			});
			
			//给地图添加边界
			function getBoundary(){       
		    var bdary = new BMap.Boundary();
		    var name = "乌拉特后旗";
		    
		    bdary.get(name, function(rs){       
		        var count = rs.boundaries.length; 
		        
		        for(var i = 0; i < count; i++){
		            var ply = new BMap.Polyline(rs.boundaries[i], {strokeWeight:2,strokeOpacity:0.8,strokeColor:"blue"}); //建立多边形覆盖物
		            map121.addOverlay(ply);  //添加覆盖物  
		        }
		    });   
			};
			
			
			function WriteBoundary(){
				var BoundData="107.262958,41.29498;107.26612,41.291944;107.26612,41.289126;107.263246,41.285873;107.266983,41.282837;107.264683,41.280452;107.262958,41.2785;107.264395,41.276549;107.260658,41.274597;107.257784,41.271777;107.258934,41.269392;107.263533,41.267873;107.26727,41.263752;107.271869,41.261583;107.273882,41.244661;*107.176146,41.24336;107.171834,41.237935;107.173559,41.231642;107.167235,41.227085;107.16781,41.224046;107.164648,41.22079;107.164935,41.218186;107.168385,41.217317;107.172984,41.215581;107.173559,41.21341;107.172984,41.206897;107.173846,41.204292;107.177008,41.201904;107.18477,41.203424;107.190806,41.19995;*107.129003,41.21862;107.139064,41.213193;107.137914,41.211022;107.142513,41.210154;107.147975,41.206246;107.149412,41.198864;107.151137,41.18931;107.154299,41.183664;107.162635,41.176931;*107.068637,41.189962;107.067774,41.18779;107.065475,41.185401;107.0649,41.182361;107.074961,41.178017;107.076111,41.17389;107.073811,41.171501;107.074673,41.168677;107.078123,41.167591;107.082147,41.169111;107.087322,41.166939;107.096233,41.164115;107.100832,41.15977;107.095658,41.156511;107.092496,41.150645;107.096233,41.146081;107.109743,41.141735;107.119229,41.142387;*107.049665,41.143908;107.053976,41.140649;107.054264,41.136519;107.058863,41.136085;107.062888,41.137171;107.068349,41.135433;107.070936,41.13239;107.069787,41.127608;107.069787,41.124565;107.074673,41.119348;107.082722,41.115;*107.050527,41.129999;107.050239,41.126739;107.049952,41.121739;107.049952,41.118696;107.054839,41.116304;107.056851,41.115217;107.057713,41.111956;107.058001,41.107608;107.058863,41.103911;*106.986711,41.133477;106.984987,41.130216;106.988149,41.126521;106.984699,41.123478;106.985849,41.121304;106.990161,41.122174;106.992748,41.116087;106.984987,41.116304;106.987574,41.112173;106.99591,41.106303;106.998497,41.100867;107.002521,41.101084;107.003671,41.103259;107.007121,41.100867;107.006833,41.097605;107.008558,41.094995;107.014595,41.094778;107.024943,41.085426;*106.927208,41.085643;106.928357,41.083686;106.928932,41.081293;106.931807,41.079988;106.928932,41.074332;106.93037,41.073027;106.934107,41.073462;106.936694,41.071722;106.938131,41.067806;106.942443,41.066718;106.945892,41.061496;106.949917,41.059973;106.959115,41.056926;*106.823435,41.026455;106.827172,41.025367;106.826885,41.022972;106.832059,41.024714;106.832921,41.019706;106.841258,41.017311;106.841833,41.014045;106.837233,41.012086;106.841545,41.011868;106.842982,41.009473;106.845857,41.00773;106.86253,41.004682;106.881502,40.99597;*106.786066,41.025585;106.79124,41.006642;106.801301,41.002722;106.799864,41.000108;106.801876,40.997495;106.799576,40.997059;106.799576,40.99597;106.802163,40.99401;106.8059,40.995099;106.80935,40.989871;106.835221,40.972661;*106.760769,41.010779;106.763069,41.010126;106.763644,41.008384;106.766231,41.008602;106.765369,41.005988;106.761919,41.005117;106.762782,41.003593;106.764794,41.002939;106.765656,40.999891;106.772843,41.000762;106.773993,40.993574;106.776005,40.991832;106.780604,40.990307;106.780604,40.987693;106.782616,40.981594;106.786641,40.974404;106.788078,40.969829;106.794402,40.96765;106.800726,40.956972;*106.735186,40.977019;106.737773,40.973968;106.736048,40.973315;106.735473,40.970918;106.739785,40.970482;106.738348,40.970047;106.738635,40.966996;106.740935,40.965689;106.737198,40.96242;106.737773,40.960023;106.745534,40.959587;106.746972,40.956536;106.746397,40.951523;106.750134,40.951959;106.751571,40.949562;106.751283,40.946946;106.752721,40.94542;106.748121,40.941933;106.746397,40.937355;*106.627677,40.950652;106.633426,40.944767;106.640037,40.939535;106.646361,40.933213;106.650673,40.932559;106.65441,40.92798;106.656135,40.921003;106.659872,40.915552;";
				var Bound=BoundData.split("*");
				var LineBound=[];
				for	(var i=0;i<Bound.length;i++){
					var boun=Bound[i].split(";");
					for (var j=0;j<boun.length-1;j++){
						LineBound[j]=new BMap.Point(boun[j].split(",")[0],boun[j].split(",")[1]);
					}
					var polyline1 = new BMap.Polyline(LineBound,
					{strokeColor:"red", strokeWeight:3, strokeOpacity:0.5}
					);
					map121.addOverlay(polyline1);
					LineBound.length=0;
				}
				
				myPointsGouKou[1]=new BMap.Point(107.274744,41.241841);
				opt[1] = {
							  position : myPointsGouKou[1],  
							  offset   : new BMap.Size(-15, -22) 
							};
				labelGouKou[1] = new BMap.Label("东乌盖沟",opt[1]); 
				
				myPointsGouKou[2]=new BMap.Point(107.192531,41.197996);
				opt[2] = {
							  position : myPointsGouKou[2],  
							  offset   : new BMap.Size(-15, -22) 
							};
				labelGouKou[2] = new BMap.Label("西乌盖沟",opt[2]); 
				
				myPointsGouKou[3]=new BMap.Point(107.163785,41.175845);
				opt[3] = {
							  position : myPointsGouKou[3],  
							  offset   : new BMap.Size(-15, -22) 
							};
				labelGouKou[3] = new BMap.Label("达拉盖沟",opt[3]); 
				
				myPointsGouKou[4]=new BMap.Point(107.097095,41.148906);
				opt[4] = {
							  position : myPointsGouKou[4],  
							  offset   : new BMap.Size(-15, -22) 
							};
				labelGouKou[4] = new BMap.Label("三贵沟",opt[4]); 
				
				myPointsGouKou[5]=new BMap.Point(107.071224,41.127173);
				opt[5] = {
							  position : myPointsGouKou[5],  
							  offset   : new BMap.Size(-15, -22) 
							};
				labelGouKou[5] = new BMap.Label("东升庙沟",opt[5]); 
				
				myPointsGouKou[6]=new BMap.Point(107.059438,41.102824);
				opt[6] = {
							  position : myPointsGouKou[6],  
							  offset   : new BMap.Size(-15, -22) 
							};
				labelGouKou[6] = new BMap.Label("善岱沟",opt[6]); 
				
				myPointsGouKou[7]=new BMap.Point(107.025231,41.084991);
				opt[7] = {
							  position : myPointsGouKou[7],  
							  offset   : new BMap.Size(-15, -22) 
							};
				labelGouKou[7] = new BMap.Label("大坝沟",opt[7]); 
				
				myPointsGouKou[8]=new BMap.Point(106.959403,41.055838);
				opt[8] = {
							  position : myPointsGouKou[8],  
							  offset   : new BMap.Size(-15, -22) 
							};
				labelGouKou[8] = new BMap.Label("毕力盖沟",opt[8]); 
				
				myPointsGouKou[9]=new BMap.Point(106.882939,40.994663);
				opt[9] = {
							  position : myPointsGouKou[9],  
							  offset   : new BMap.Size(-15, -22) 
							};
				labelGouKou[9] = new BMap.Label("红山沟",opt[9]); 
				
				myPointsGouKou[10]=new BMap.Point(106.835796,40.972443);
				opt[10] = {
							  position : myPointsGouKou[10],  
							  offset   : new BMap.Size(-15, -22) 
							};
				labelGouKou[10] = new BMap.Label("杨贵沟",opt[10]);
				
				myPointsGouKou[11]=new BMap.Point(106.800726,40.955446);
				opt[11] = {
							  position : myPointsGouKou[11],  
							  offset   : new BMap.Size(-15, -22) 
							};
				labelGouKou[11] = new BMap.Label("炭窑沟",opt[11]); 
				
				myPointsGouKou[12]=new BMap.Point(106.746109,40.936701);
				opt[12] = {
							  position : myPointsGouKou[12],  
							  offset   : new BMap.Size(-15, -22) 
							};
				labelGouKou[12] = new BMap.Label("玻璃庙沟",opt[12]); 
				
				myPointsGouKou[13]=new BMap.Point(106.660447,40.914679);
				opt[13] = {
							  position : myPointsGouKou[13],  
							  offset   : new BMap.Size(-15, -22) 
							};
				labelGouKou[13] = new BMap.Label("流沙沟",opt[13]);
				for (i=1;i<=13;i++){
					
					labelGouKou[i].setStyle({
						 color : "red",
						 backgroundColor:"none",
						 border: 0,
						 margin: 0, 
						 padding: 0,
						 fontSize : "13px",
						 height : "12px",
						 lineHeight : "12px",
						 fontFamily:"微软雅黑"
					 });
					map121.addOverlay(labelGouKou[i]);
					labelGouKou[i].hide();
				};
			};
			
			
    		</script>
	<c:forEach items="${qiyes}" var="weather" varStatus="s">

		<script>
	    		var point1${weather.name} = new BMap.Point(${weather.longitude},${weather.latitude});
	    		var opts1${weather.name} = {
	    				  position : point1${weather.name},    // 指定文本标注所在的地理位置
	    				  offset   : new BMap.Size(-15, -20)    //设置文本偏移量
	    				}
	    		
	    		var myIcon = new BMap.Icon("./style/img/qiye.png", new BMap.Size(20,20));
	    		var marker${weather.name} = new BMap.Marker(point1${weather.name},{icon:myIcon}); 
	    		map121.addOverlay(marker${weather.name});
	    		
				var label = new BMap.Label("${weather.name}", opts1${weather.name}); 
					label.setStyle({
						 fontSize : "13px",
						 color : "#1010DE",
						 height : "20px",
						 lineHeight : "20px",
						 fontFamily:"方正准圆",
			          	 borderStyle:"none",
			             backgroundColor:"none"
					 });
				marker${weather.name}.setLabel(label);
				var eventOpts1${weather.name} = {
						  width : 120,     // 信息窗口宽度
						  height: 140,     // 信息窗口高度
						}
				var infoWindow2${weather.name} =new BMap.InfoWindow("<h4 style='margin:0 0 5px 0;padding:0.2em 0'>${weather.name}</h4><div> 企业性质：${weather.group}</div><div> 地址:${weather.address}</div><div> 联系人:${weather.linkper}   ${weather.phone}</div>", eventOpts1${weather.name}); // 创建信息窗口对象 
				marker${weather.name}.addEventListener("click", function(){          
					map121.openInfoWindow(infoWindow2${weather.name}, point1${weather.name}); //开启信息窗口
				});
				
				
					
			</script>
	</c:forEach>
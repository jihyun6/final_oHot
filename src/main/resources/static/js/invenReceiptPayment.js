/**
 * <pre>
 * 
 * </pre>
 * @author 유선영
 * @since 2023. 11. 18.
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * 수정일        수정자       수정내용
 * --------     --------    ----------------------
 * 2023. 11. 18.      유선영       최초작성
 * Copyright (c) 2023 by DDIT All right reserved
 * </pre>
 */ 
$(document).ready(function() {
	let addCommas = function(num) {
	    return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	};	
	let itemWindowModal = new bootstrap.Modal($('#itemWindow')[0]);
	let wareWindowModal = new bootstrap.Modal($('#wareWindow')[0]);
	//모달이 화면이 남아있는경우 다시클릭시 화면에 바로 보여주기위한 변수
	//let isItemModalShown = false;
	
	
	/*$('#itemWindowModal').on('hidden.bs.modal', function () {
	 	$('.modal-backdrop').remove();   
	 	$('body').css('overflow', ''); 
	});*/
	
	//버튼 이벤트발생시 모달 show
	$('#itemSearchBtn').on('click', function () {
		itemWindowModal.show();
	});
	$('#itemSearch').on('click', function () {
		itemWindowModal.show();
		$('.modal-backdrop').remove();
	});
	//버튼 이벤트발생시 모달 show
	$('#wareSearchBtn').on('click', function () {
	    wareWindowModal.show();
	});
	$('#wareSearch').on('click', function () {
	    wareWindowModal.show();
	});
	
	
	/*	//Modal 제어
	$('#itemSearch').on('click', function () {
	    if (!isItemModalShown) {
			$('.modal-backdrop').remove();
	        itemWindowModal.show();
	        isItemModalShown = true;
	    } else {
			$('.modal-backdrop').remove();
	        itemWindowModal.hide();
	        isItemModalShown = false;
	    }
	});
	
	*/
	
	$('#wareTable').DataTable({
	        paging: true,
	        searching: true,
	        lengthChange: false,
	        info: false,
	        ordering: false
	});
	//modal이 닫히는 이벤트가 발생시 body의 css를 overflow hidden을 날려주기위해 사용
	
	$('#wareWindow').on('hidden.bs.modal', function () {
	    $('body').css('overflow', ''); 
	});
	
/*	$('#wareClose').on('click', function () {
		$('.modal-backdrop').remove();
        wareWindowModal.hide();
    });
	$('#itemClose').on('click', function () {
		$('.modal-backdrop').remove();
        wareWindowModal.hide();
    });*/
	let cPath = $('.pageConversion').data('contextPath');
	let baseUrl = `${cPath}/invenSituation`;
	
	let makeTrTag = function (result) {
	    let trTag = `
				<tr>
       	  			<td><input class="form-check-input checkData" type="checkbox" /></td>
           	  		<td style="text-align: center;">${result.itemCd}</td>
           	  		<td style="text-align: left;"><a href="javascript:;" class="selectItem" data-selected-value="${result.itemNm}">
           	  			${result.itemNm}
           	  		</a></td>
       	  		</tr>
		    `;
		
		    return trTag;
		};
	
	
	$(searchForm).on("submit", function(event) {
		event.preventDefault();
		let urls = this.action;
		let datas = $(this).serialize();
		$.ajax({
			url: urls,
			method: "GET",
			data : datas,
			success: function (resp) {
				console.log(resp);
				let itemList = resp.paging.dataList;
				let trTags = "";
		
				if (itemList?.length > 0) {
					$.each(itemList, function () {
						trTags += makeTrTag(this);
					});
					$(pagingArea).html(resp.paging.pagingHTML);
				} else {
					trTags += `
							<tr>
								<td class="text-nowrap" colspan='3'>등록된 품목이 없습니다.</td>
							</tr>
						`;
					$(pagingArea).empty();
				}
				$('.list').html(trTags);
			
			/*	$('#dataTable').DataTable({
			        paging: true,
			        searching: true,
			        lengthChange: false,
			        info: false,
			        ordering: false
			    });*/
				
			},
			error: function (xhr, status, error) {
				console.log(xhr);
				console.log(status);
				console.log(error);
			}
		});
	}).submit();
	
	$(searchUI).on("click", "#searchBtn", function(event) {
		let inputs = $(this).parents("#searchUI").find(":input[name]");
		$.each(inputs, function(idx, ipt) {
			let name = ipt.name;
			let value = $(ipt).val();
			console.log(name);
			console.log(value);
			$(searchForm).find(`:input[name=${name}]`).val(value);
		});
		$('#searchForm').submit();
	});
	
	
	
	 //품목코드 한개를 선택시 span태그에 저장
	$('.modal-body').on('click', '.selectItem', function (e) {
	  e.preventDefault();
 	  let row = $(this).closest('tr');
	  let itemCd = row.find('td:eq(1)').text();
	  let selectedValue = $(this).data('selected-value');
	  
	  appendSpanIfNotDuplicate(selectedValue,itemCd);
	  
	  $('.modal-backdrop').remove();
	  itemWindowModal.hide();
	});
	//모달에서  창고선택시 발생하는 이벤트
	$('.modal-body').on('click', '.selectWare', function (e) {
	  e.preventDefault();
	  let selectedValue = $(this).data('selected-value');
	  let selectedCd = $(this).closest('tr').find('td:first').text();

	  $('#wareSearch').val(selectedValue);
	  $('#wareCdValue').val(selectedCd);
	  let removeTag = `<button type="button" id='wareClean' class="btn searchBtn p-1 border-0 removeSpan">
								                <i class="fas fa-times-circle"></i>
								            </button>`;
	  $('#removeWare').html(removeTag);
	  wareWindowModal.hide();
	});
	
	
	$(document).on('click','#wareClean',function(){
		$('#wareSearch').val('');
		$('#wareCdValue').val('');
		$('#wareClean').empty();
	})
	// 품목 span 태그 생성
	function spanMaker(selectedValue,itemCd) {
	    return `
	        <span id =${itemCd} class ="customSpan" style="margin-left: 3px; margin-top: 10px; padding: 3px; background-color: #3498db; color: white; border-radius: 5px;">
	            ${selectedValue}
	            <button type="button" class="btn searchBtn p-1 border-0 removeSpan">
	                <i class="fas fa-times-circle"></i>
	            </button>
	        </span>
	    `;
	}
	
	// span 태그 삭제
	$(document).on('click', '.removeSpan', function() {
	    $(this).closest('.customSpan').remove();
	});

	//저장버튼을 클릭하면 생기는 이벤트
	$('#saveBtn').on('click',function(){
	    $('.checkData:checked').each(function() {
			let row = $(this).closest('tr');
	        let itemCd = row.find('td:eq(1)').text();
	        let itemNm = row.find('td:eq(2)').text(); 
	        let spanTag = appendSpanIfNotDuplicate(itemNm, itemCd);
			$('#spanSpace').append(spanTag);
			$(this).prop('checked', false);
	    });
	})
	
	
	//중복검사를 통해 중복된 값이 추가되려하면 막음.
	function appendSpanIfNotDuplicate(selectedValue, itemCd) {
	    let isDuplicate = false;
	
	    if (typeof selectedValue === 'string' && typeof selectedValue.trim === 'function') {
	        $('#spanSpace').find('.customSpan').each(function() {
	            if ($(this).text().trim() === selectedValue.trim()) {
	                isDuplicate = true;
	                return false;
	            }
	        });
	    }
	
	    if (!isDuplicate) {
	        let spanTag = spanMaker(selectedValue, itemCd);
	        $('#spanSpace').append(spanTag);
	    }
	}

	//폼이 submit될때의 이벤트를 잡음
 	$('#invenForm').on('submit',function(e){
		e.preventDefault();
		alert('너 왓니!');
		//span태그내에 있는 id의 값을 가져와 배열에 저장함
		let itemCd=[];
		$('.customSpan').each(function() {
           let datas = $(this).attr('id');
           itemCd.push(datas);
		});
		
		let jsonTrans = [];
        //저장된 배열을 for문돌려서 json형식으로 만들어줌
		itemCd.forEach(code => {
		     let itemCode = { 'itemCd': code };
   			 jsonTrans.push(itemCode);
		});
		
		let data = $(this).serializeJSON();
		
		let rmstSdate = data.rmstSdate;
		let rmstLdate = data.rmstLdate;
		
		
		let invenValue = 0 ; //전일재고를 계산하기 위한 전역변수 선언 
		data.itemList = jsonTrans;
		
		console.log("data 데이터입니다.",data);
		
		let jsonData = JSON.stringify(data);
		console.log(jsonData);
		let url = $(this).attr('action');
		let method = $(this).attr('method');

		/*
        Swal.fire({
            title: '로딩 중',
            html: '잠시만 기다려 주세요...',
            allowOutsideClick: false,
			allowEscapeKey: false,
			showConfirmButton: false,
            willOpen: () => {
		      swal.showLoading();
		    }
        });
		*/

		$.ajax({
			url: url,
			method: method,
			data : jsonData,
			contentType: 'application/json',
			success: function (resp) {
				
				let invenList = resp.invenList;
				let groupedData = {};
				let groupedItems = {};
				
				//그래프인 경우
				if(data.graph==='Y'){
					alert("그래프");
					$('#contentBody').html('');
					$('#graphBody').html('');
					let timelineData=[];
						
					let charts =`
						<div id="chart" class="echart-bar-timeline-chart-example" style="width: 1100px; height: 700px;" data-echart-responsive="true"></div>
						<ul class="nav nav-tabs" id="yearTabs"></ul>
						<div id="monthlyDataContainer"></div>
					`;
					//resp.invenList.length : 47
					console.log("resp.invenList.length : " + resp.invenList.length);
					if(resp.invenList.length===0){
						let spanData = `<span class="text-center" style="display: block; font-size: 20px;">검색된 조건의 데이터가 없습니다.</span>`;
						$('#itemSpace').html(spanData);
					}else{
						$('#itemSpace').html('');
						$('#graphBody').html(charts);
					
						var chart = echarts.init(document.getElementById('chart'));
						/*
						charts->invenList : [
							{"itemCd":"D001PH001","itemNm":"도현폰","itemUnit":null,"itemCate":null,"itemSafeQty":0,"itemYn":null,"itemNote":null,
							"itMaker":null,"itWght":null,"itColor":null,"itemInpr":0,"itemOutpr":0,"itemBoolean":false,"itemQty":0,"orderFrag":null
							,"itCateNm":null,"itemUprc":null,
							"itemDetailVOList":[
								{"itemCd":"D001PH001","itemNm":"도현폰","rmstDate":"2021-04-03","storCate":"B002","comNm":"[판매]-IT전자","rmstNote":null
								,"wareCd":"W003","storRsn":"C001","rmstInQty":0,"rmstOutQty":490,"rmstSelfQty":0,"rmstInitQty":0,"jaego":110},
						*/
						//console.log("charts->invenList : " + JSON.stringify(invenList));
						
						//******* 중첩된 자바빈리스트 꺼내는맵
						//const wareSecList = result.map(item => item.wareSecList).flat();
						const itemDetailVOList = invenList.map(item => item.itemDetailVOList).flat();
						
						console.log("itemDetailVOList : ", itemDetailVOList);
						
						itemDetailVOList.forEach(item => {
							//2차원배열로 date관리
						   	const date = moment(item.rmstDate);
					        const year = date.year();
					        const month = date.month() + 1; // month는 0부터 시작하므로 1을 더함
							//date : 1702382752071
							//console.log("date : ",  date);
							//year : 2023
							console.log("year : " + year);
							//month : 12
							//console.log("month : " + month);
					
				            // 그룹화된 데이터 객체에 추가
				            if (!groupedData[year]) {
				                groupedData[year] = {};
				            }
				            if (!groupedData[year][month]) {
				                groupedData[year][month] = [];
				            }
				            groupedData[year][month].push(item);
							
						}); //forEach 마지막
						
						/*
						groupedData : {"2023":{"12":[
							{"itemCd":"D001PH001","itemNm":"도현폰","itemUnit":null,"itemCate":null,"itemSafeQty":0,"itemYn":null,"itemNote":null,"itMaker":null,"itWght":null,"itColor":null
							,"itemInpr":0,"itemOutpr":0,"itemBoolean":false,"itemQty":0,"orderFrag":null,"itCateNm":null,"itemUprc":null,
							"itemDetailVOList":[
								{"itemCd":"D001PH001","itemNm":"도현폰","rmstDate":"2021-04-03","comNm":"[판매]-IT전자","rmstNote":null,"wareCd":"W003"
								,"storRsn":"C001","rmstInQty":0,"rmstOutQty":490,"rmstSelfQty":0,"rmstInitQty":0,"jaego":110},
						*/
						//console.log("groupedData : " + JSON.stringify(groupedData));				
						
						//ECharts를 위한 timelineData 넣기 
						timelineData=Object.keys(groupedData);
						console.log("이건 날짜 데이터]",groupedData);
						console.log("이건 타임라인 ",timelineData);
						
						var option = {
						    baseOption: {
						        timeline: {
						            data: timelineData,
						            axisType: 'category',
						            autoPlay: true,
						            playInterval: 3000,
						            loop: true,
						            controlStyle: {
						                position: 'left',
						            },
						        },
						        xAxis: {
						            type: 'category',
						            data: [], // 빈 배열로 초기화
						        },
						        yAxis: {
						            type: 'value',
						        },
						        series: [
						            {
						                name: 'Series 1',
						                type: 'line',
						                data: [], // 빈 배열로 초기화
						            },
						        ],
						    },
						    options: [], // 타임라인에 따른 각 날짜별 차트 옵션
						};
						var yAxisData = [];
	
						// 타임라인에 따른 각 날짜별 차트 옵션 설정
						timelineData.forEach(function (date) {
						    // xAxis와 series의 data에 해당하는 월별 데이터 추가
						    var xAxisData = Object.keys(groupedData[date]);
						    var seriesDataIn = []; // 입고 데이터
						    var seriesDataOut = []; // 출고 데이터
						    
						    // 월별로 입고 및 출고 수량을 분류
						    xAxisData.forEach(function (month) {
						        var totalQuantityIn = 0;
						        var totalQuantityOut = 0;
						
						        groupedData[date][month].forEach(function (item) {
						            if (item.storCate === 'B001') {
						                totalQuantityIn += item.rmstInQty;
						            } else if (item.storCate === 'B002') {
						                totalQuantityOut += item.rmstOutQty;
						            }
						        });
						
						        seriesDataIn.push(totalQuantityIn);
						        seriesDataOut.push(totalQuantityOut);
						    });
		
							console.log("seriesDataIn : ",seriesDataIn);
							console.log("seriesDataOut : ",seriesDataOut);
						
						   option.options.push({
							    title: {
							        text: 'Chart on ' + date,
							    },
							    xAxis: {
							        type: 'category', // x축 타입을 category로 변경
							        data: xAxisData,
							    },
							    yAxis: {
							        type: 'value',
							        axisLabel: {
							            formatter: '{value} pcs', // 수량에 따라 수정
							        },
							    },
							    legend: {
							        data: ['입고', '출고', '입고 선형 그래프', '출고 선형 그래프'], // 범례에 표시될 항목 설정
							        textStyle: {
							            fontSize: 12, // 범례의 폰트 크기 조절
							        },
							    },
							    series: [
							        {
							            type: 'bar', // 시리즈 타입을 bar로 변경
							            data: seriesDataIn,
							            name: '입고',
							            barWidth: '20%', // 바의 너비 조절
							            itemStyle: {
							                color: 'orange', // 입고 데이터의 색상 (주황색)
							            }
							        },
							        {
							            type: 'bar', // 시리즈 타입을 bar로 변경
							            data: seriesDataOut,
							            name: '출고',
							            barWidth: '20%', // 바의 너비 조절
							            itemStyle: {
							                color: 'skyblue', // 출고 데이터의 색상 (하늘색)
							            }
							        }
							    ],
								textStyle: {
							        fontFamily: 'Roboto, sans-serif' // 여기에 사용할 폰트 지정
							    }
												
							});
						    // yAxis 데이터에 현재 날짜에 해당하는 총 수량 추가
						    yAxisData.push({
						        name: date,
						        value: seriesDataIn.reduce(function (total, quantity) {
						            return total + quantity;
						        }, 0) + seriesDataOut.reduce(function (total, quantity) {
						            return total + quantity;
						        }, 0),
						    });
						});
						
						// yAxis 설정
						option.baseOption.yAxis = {
						    type: 'value',
						    axisLabel: {
						        formatter: function(params) {
							        // 세 자리마다 쉼표 추가하여 수량 포맷팅
							        return params.value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + ' pcs';
							    },
						    },
						    data: yAxisData,
						};
						
						// 차트에 옵션 적용
						chart.setOption(option);
	
						let yearTabsHTML = '<ul class="nav nav-tabs" id="yearTabs">';
						for (let year in groupedData) {
						    yearTabsHTML += `<li class="nav-item"><a class="nav-link" id="tab${year}" data-year="${year}" href="javascript:void(0);">${year}</a></li>`;
						}
						yearTabsHTML += '</ul>';
						$('#yearTabs').html(yearTabsHTML);
						
						// 탭 클릭 시 연도별 데이터를 표시하는 이벤트 핸들러
						$('#yearTabs').on('click', 'a[data-year]', function(e) {
						    e.preventDefault();
						
						    let selectedYear = $(this).data('year');
						
						    // 선택한 연도의 1월부터 12월까지의 데이터를 계산
						    let monthlyData = {};
							let totalInSum = 0; // 입고 총량 합산을 위한 변수
						    let totalOutSum = 0; // 출고 총량 합산을 위한 변수
						    for (let month = 1; month <= 12; month++) {
						        let totalIn = 0;
						        let totalOut = 0;
						
						        if (groupedData[selectedYear] && groupedData[selectedYear][month]) {
						            groupedData[selectedYear][month].forEach(item => {
						                if (item.storCate === 'B001') {
						                    totalIn += item.rmstInQty;
						                } else if (item.storCate === 'B002') {
						                    totalOut += item.rmstOutQty;
						                }
						            });
						        }
								// 입고량과 출고량의 합을 저장할 변수
								let formattedTotalIn = totalIn > 0 ? addCommas(totalIn) : 0;
								let formattedTotalOut = totalOut > 0 ? addCommas(totalOut) : 0;
								
								monthlyData[month] = { formattedTotalIn, formattedTotalOut };
								
								// 입고량과 출고량의 총합을 계산
								totalInSum += totalIn;
								totalOutSum += totalOut;
								
								
						    }
						
						    // 월별 데이터를 표시하는 부분
						  let tableHTML = `<table id="monthlyDataTable" class="table table-bordered  fs--1 mb-0">
											    <thead>
											        <tr>
											            <th></th>
											            ${Array.from({ length: 12 }, (_, i) => `<th>${i + 1}월</th>`).join('')}
											            <th>총합</th>
											        </tr>
											    </thead>
											    <tbody>
											        <tr>
											            ${Array.from({ length: 13 }, (_, i) => `<td>${i === 0 ? '입고 합계' : (monthlyData[i] ? monthlyData[i].formattedTotalIn : '')}</td>`).join('')}
											            <td>${totalInSum > 0 ? addCommas(totalInSum) : 0}</td>
											        </tr>
											        <tr>
											            ${Array.from({ length: 13 }, (_, i) => `<td>${i === 0 ? '출고 합계' : (monthlyData[i] ? monthlyData[i].formattedTotalOut : '')}</td>`).join('')}
											            <td>${totalOutSum > 0 ? addCommas(totalOutSum) : 0}</td>
											        </tr>
											    </tbody>
											</table>`;
											
						$('#monthlyDataContainer').empty().append(tableHTML);
	
						});
					}
					
				}else{//그래프가 아닌 경우
					alert("그래프 아님");
					if(resp.invenList.length===0){
						let spanData = `<span class="text-center" style="display: block; font-size: 20px;">검색된 조건의 데이터가 없습니다.</span>`;
						$('#itemSpace').html(spanData);
					}else{
						alert("그래프 아님->else");
						$('#contentBody').html('');
						$('#graphBody').html('');
						$('#itemSpace').html('');
						/*
						{"itemCd":"D001PH001","itemNm":"도현폰","itemUnit":null,"itemCate":null,"itemSafeQty":0,"itemYn":null,"itemNote":null,"itMaker":null
						,"itWght":null,"itColor":null,"itemInpr":0,"itemOutpr":0,"itemBoolean":false,"itemQty":0,"orderFrag":null,"itCateNm":null,"itemUprc":null
						,"itemDetailVOList":[
							{"itemCd":"D001PH001","itemNm":"도현폰","rmstDate":"2019-12-11","comNm":"초기입고","rmstNote":"초기입고","rmstInQty":0,"rmstOutQty":0,"rmstSelfQty":0,"rmstInitQty":600}
						],
						"searchType":null,"searchWord":null}
						*/
						//console.log('invenList : ~~~' + JSON.stringify(invenList));
						// 반복문으로 nameValue값 변경됨
							let nameValue=0;
							let idValue="";
							let trTags="";
							
							$.each(invenList,function(idx,itemVO){
								let invenId = `inven0_${itemVO.itemCd}`;
								let idValue = itemVO.itemCd;
								let totalStock = itemVO.itemDetailVOList[0].jaego;
								trTags += `
								<div id="flexDiv">
								  <div class="leftContent">
								    품목명: ${itemVO.itemNm}
								  </div>
								  <div class="rightContent">
								    검색일자: ${rmstSdate} ~ ${rmstLdate}
								  </div>
								</div>
								<div class="card mb-3">
									<table class="table table-bordered table-striped fs--1 mb-0 itemTable">
									  <thead>
									    <tr>
									      <th scope="col">일자</th>
									      <th scope="col">거래처명</th>
									      <th scope="col">적요</th>
									      <th scope="col">입고수량</th>
									      <th scope="col">출고수량</th>
									      <th scope="col">재고수량</th>
									    </tr>
									  </thead>
									  <tbody class="irpList">
										<tr>
											<td colspan='3' style='text-align: center;'><span style='color : red'>전일재고</span></td>
											<td></td>
											<td></td>
											<td id="">${totalStock}</td>
										</tr>
										`;
									/*
									"itemDetailVOList":[
										{"itemCd":"D001PH001","itemNm":"도현폰","rmstDate":"2019-12-11","comNm":"초기입고"
										,"rmstNote":"초기입고","rmstInQty":0,"rmstOutQty":0,"rmstSelfQty":0,"rmstInitQty":600}
									]
									*/
									let col1 = 0;
									let col2 = 0;
									let col3 = 0;
									$.each(itemVO.itemDetailVOList,function(idx2,itemDetailVO){
										if(idx2>0){
											totalStock = totalStock + itemDetailVO.rmstInQty - (itemDetailVO.rmstOutQty + itemDetailVO.rmstSelfQty);
											trTags += `
												<tr>
													<td>${itemDetailVO.rmstDate}</td>
													<td>${itemDetailVO.storRsn!='C007'?itemDetailVO.comNm:'창고이동'}</td>
													<td>${itemDetailVO.rmstNote==null?'':itemDetailVO.rmstNote}</td>
													<td>${itemDetailVO.rmstInQty}</td>
													<td>${itemDetailVO.rmstOutQty + itemDetailVO.rmstSelfQty}</td>
													<td>${totalStock}</td>
												</tr>
											`;
											
											col1 += itemDetailVO.rmstInQty;
											col2 += itemDetailVO.rmstOutQty + itemDetailVO.rmstSelfQty;
											col3 = totalStock;
										}
									});
									
									trTags += `
										<tr>
											<td>합계</td>
											<td></td>
											<td></td>
											<td id="rec_count${idValue}">${col1}</td>
											<td id="out_count${idValue}">${col2}</td>
											<td id="names">${col3}</td>
										</tr>
										</tbody>
										</table></div>
									`;
								});//end for
								$('#contentBody').append(trTags);
								let totals = setCount(idValue); 
							    recTotal = totals.recTotal; 
							    outTotal = totals.outTotal;	
					}//end inner if
					
				}//end outer if
				
			Swal.close();
			},
			error: function (xhr, status, error) {
				console.log(xhr);
				console.log(status);
				console.log(error);
				Swal.close();	
			}
		});	
		
		/* 아작스를 위한 데이터 설정 */
		let makeTrTag = function (rslt, nameValue) {
		    let recId = 'rec_' + rslt.itemCd;
		    let outId = 'out_' + rslt.itemCd;
			let InvenId = 'inven_' + rslt.itemCd;
			
			let invenVal = parseInt(nameValue); // 전일재고
			let recVal = rslt.storCate == 'B001' ? parseInt(rslt.rmstQty) : 0; // 입고수량
			
			// 출고수량
			let outVal = 0;
			if(rslt.storCate == 'B002' || rslt.storCate == 'B003')
				outVal = parseInt(rslt.rmstQty);
			else
				outVal = 0;
			
			// 계산
			let invenResult = invenVal + recVal - outVal;
			
			invenValue = invenResult; // 계산된 결과를 전역변수에 저장
			
		    let trTag = `<tr>
			    <td>${rslt.rmstDate}</td>
			    ${rslt.saleComNm ? `<td>[판매]-${rslt.saleComNm}</td>` : ''}
			    ${rslt.purComNm ? `<td>[구매]-${rslt.purComNm}</td>` : ''}
			    ${rslt.defectCd ? `<td>[폐기]-${rslt.defectCd}</td>` : ''}
			    ${rslt.storRsn=='C007' ? `<td>[창고이동]-${rslt.wareNm} 로 이동</td>` : ''}
			    <td>${rslt.rmstNote  ? rslt.rmstNote  : ''}</td>
			    <td id="${recId}">${rslt.storCate == 'B001' ? rslt.rmstQty > 0 ? addCommas(rslt.rmstQty) :0: ''}</td>
			    <td id="${outId}">
			        ${rslt.storCate == 'B002' ? (rslt.rmstQty > 0 ? addCommas(rslt.rmstQty) : 0) : ''}
			        ${rslt.storCate == 'B003' ? rslt.rmstQty : ''}
			    </td>
				<td id="${InvenId}">${addCommas(invenResult) || 0}</td>
		    </tr>`;
			console.log(addCommas(rslt.rmstQty));
			return trTag;
		};
		
		function setCount(idValue){
			let recTotal=0;
			let outTotal=0;
			
			$('[id^="rec_' + idValue + '"]').each(function() {
				
				let textValue = $(this).text(); // 여기서 $(this).text()는 '1,000'과 같은 형태일 것으로 가정합니다.
				let parsedValue = parseFloat(textValue.replace(/,/g, '')) || 0; // 콤마를 제거한 후 파싱하고, 숫자가 아니면 기본값으로 0을 사용합니다.

				recTotal += parsedValue;
		    });
			    
		    $('[id^="out_' + idValue + '"]').each(function() {
		        let textValue = $(this).text(); // 여기서 $(this).text()는 '1,000'과 같은 형태일 것으로 가정합니다.
				let parsedValue = parseFloat(textValue.replace(/,/g, '')) || 0; // 콤마를 제거한 후 파싱하고, 숫자가 아니면 기본값으로 0을 사용합니다.
 
		        outTotal += parsedValue; 
		    });
						
			$(`#rec_count${idValue}`).text(`${recTotal > 0 ? addCommas(recTotal) : 0}`);
			$(`#out_count${idValue}`).text(`${outTotal > 0 ? addCommas(outTotal) : 0}`);
			
			return  { recTotal, outTotal };
		}
	})
});

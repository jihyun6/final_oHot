/**
 * 티켓 관리자 페이지 검색 js
 * 
 */

const blockSize = 5; // 한 번에 표시할 페이지 수

$(function() {
	
	fn_search(1)
	// 검색 버튼 클릭 시
	$('#btnSearch').on('click', function() {
		fn_search(1);
	});
	
	//초기화 버튼 클릭시
	$('#resetBtn').on('click', function(){
		$('#srhFrm')[0].reset();
		fn_search(1);
	})
});


// 공통 검색 및 페이징 함수
function fn_search(page) {
	console.log("fn_search실행 data: "+page)
	const datas = {
		artGroupNo: $('#artGroupNo').val(),
		tkCtgr: $('#tkCtgr').val(),
		tkLctn: $('#tkLctn').val(),
		gdsNo: $('#gdsNo').val(),
		pic: $('#pic').val(),
		gdsDelYn: $('#gdsDelYn').val(),
		gdsNm: $('#gdsNm').val(),
		startDate: $('#start-date input').val(),
		endDate: $('#end-date input').val(),
		
		page: page,
		blockSize: blockSize,
		startRow: (page - 1) * blockSize + 1,
		endRow: page * blockSize
	};
	const instance = axios.create();
	instance.interceptors.request.use(function() { $('#listBody').html('<tr><td colspan="5" class="text-center">로딩 중...</td></tr>'); });

	axios.post('/admin/shop/tkListSearchPost', datas).then(resp => {
		const { content, currentPage, totalPages, startPage, endPage } = resp.data;
	    renderTable(content,currentPage);
	    renderPagination({ currentPage, totalPages, startPage, endPage });
	}).catch(() => {
		$('#listBody').html('<tr><td colspan="5" class="text-center text-danger">검색 중 오류 발생</td></tr>');
	})

};

// 테이블 렌더링 함수
function renderTable(data, currentPage) {
  console.log("renderTable 실행:", data);
  const tbody = $('#listBody');
  tbody.empty();

  if (!data || data.length === 0) {
    tbody.append('<tr><td colspan="9" class="text-center">데이터가 없습니다.</td></tr>');
    return;
  }

  const startNo = (currentPage - 1) * blockSize;
  data.forEach((item, idx) => {
    const playNm = !item.artGroupNm ? item.artActNm : item.artGroupNm;
    const row = `
      <tr onclick="location.href='adTicketDetail?gdsNo=${item.gdsNo}'" style="cursor: pointer;">
        <td>${startNo+idx + 1}</td>
        <td><img src="/upload/${item.ticketVO.tkFileSaveLocate}" alt="포스터" width="35px" height="55px"></td>
        <td style="text-align:left;">
			<div style="white-space: normal; min-width: 100px; word-break: break-word;">
				${item.gdsNm}
			</div>
		</td>
        <td>${playNm}</td>
        <td>${item.ticketVO.tkStartYmd} ~ ${item.ticketVO.tkFinishYmd}</td>
        <td style="text-align:left; white-space: normal; min-width: 100px;">${item.ticketVO.tkLctn}</td>
        <td style="text-align:right;">${numberWithCommas(item.unitPrice)}</td>
        <td>${item.pic}</td>
      </tr>
    `;
    tbody.append(row);
  });
}

// 숫자 세 자리 콤마 포맷 함수
function numberWithCommas(dateStr) {
  return dateStr != null ? dateStr.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") : '-';
}

function renderPagination(paging) {
	console.log("renderPagination실행 data: "+JSON.stringify(paging))
  const container = $('#pagination-container');
  container.empty();

  if (!paging || paging.totalPages === 0) {
    return;
  }
 
      const totalPages = paging.totalPages;
      let startPage = Math.floor((paging.currentPage - 1) / blockSize) * blockSize + 1;
      let endPage = startPage + blockSize - 1;
      
      if (endPage > totalPages) {
          endPage = totalPages;
      }

      let html = '<ul class="pagination">';

      const disabledFirst = startPage <= 1 ? 'disabled' : '';
      const disabledLast = endPage >= totalPages ? 'disabled' : '';

      html += `<li class="page-item ${disabledFirst}">
          <a class="page-link" href="#" onclick="fn_search(1)">&lt;&lt;</a></li>`;
      html += `<li class="page-item ${disabledFirst}">
          <a class="page-link" href="#" onclick="fn_search(${paging.currentPage - 1})">&lt;</a></li>`;

      for (let i = startPage; i <= endPage; i++) {
          const active = i === paging.currentPage ? 'active' : '';
          html += `<li class="page-item ${active}">
              <a class="page-link" href="#" onclick="fn_search(${i})">${i}</a></li>`;
      }

      html += `<li class="page-item ${disabledLast}">
          <a class="page-link" href="#" onclick="fn_search(${endPage + 1})">&gt;</a></li>`;
      html += `<li class="page-item ${disabledLast}">
          <a class="page-link" href="#" onclick="fn_search(${totalPages})">&gt;&gt;</a></li>`;

      html += '</ul>';

      container.append(html);
}


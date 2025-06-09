
const rowSize = 10; // 한 번에 표시할 페이지 수
const blockSize= 10; //페이지네이션 수

$(document).ready(function() {
	fn_search(1);

	$('#btnSearch').on('click', function() {
		fn_search(1);
	});

	$('#btnReset').on('click', function() {
		fn_reset();
		fn_search(1);
	});
});

/* 검색필터 초기화 버튼 */
function fn_reset() {

	$('#artGroupNm').val('all').trigger('change');
	$('#startDate').val('');
	$('#endDate').val('');
	$('#artGroupDebutYmd').val('');
	$('#artGroupRegYmd').val('');
	$('#artGroupDelYn').val('all').trigger('change');

}

function fn_search(page) {

	// 검색 옵션 파라미터 수집
	const params = {

		artGroupNm: $('#artGroupNm').val(),
		startDate: $('#startDate').val(),
		endDate: $('#endDate').val(),
		artGroupDebutYmd: $('#artGroupDebutYmd').val(),
		/*artGroupRegYmd: $('#artGroupRegYmd').val(),*/
		artGroupDelYn: $('#artGroupDelYn').val(),

		page: page,
		rowSize: rowSize,
		blockSize: blockSize,
		startRow: (page - 1) * rowSize + 1,
		endRow: page * rowSize

	};

	const instance = axios.create();

	instance.interceptors.request.use(function() { $('#listBody').html('<tr><td colspan="9" class="text-center"><i class="fas fa-spinner fa-spin"></i> 검색 중...</td></tr>'); });

	axios.post('/admin/artistGroup/artistGroupListAjax', params).then(resp => {
		const { content, currentPage, totalPages, startPage, endPage } = resp.data;
		renderTable(content);
		renderPagination({ content, currentPage, totalPages, startPage, endPage });

	}).catch(() => {
		$('#listBody').html('<tr><td colspan="9" class="text-center text-danger">검색 중 오류 발생</td></tr>');
	})


}



function renderTable(data) {

	console.log("renderTable 실행 : ", data);

	const tbody = $('#listBody');
	tbody.empty();

	if (!data || data.length === 0) {
		tbody.append(`<tr><td colspan="9" class="text-center">검색 결과가 없습니다</td></tr>`);
		$('#pagination-container').empty();
		return;
	}

	data.forEach((item, idx) => {
		const row = `
			<tr onclick="location.href='/admin/artistGroup/artistGroupDetail?artGroupNo=${item.artGroupNo}'" style="cursor:pointer;">
				<td>${item.rrnum}</td>
				<td><img src="/upload${item.fileLogoSaveLocate}" alt="logoFile" style="width: 40px; height: 40px; border-radius: 50%;"/></td>
				<td style="text-align:left; width :250px; text-overflow: ellipsis;">${item.artGroupNm}</td>
				<td>${item.artGroupRegYmd}</td>
				<td>${item.artGroupDebutYmd}</td>
				<td>${item.artGroupDelYn == 'Y' ? 'Y' : 'N'}</td>
				<td>
					<a href="/admin/artistGroup/artistGroupEdit?artGroupNo=${item.artGroupNo}"
						class="btn btn-secondary">수정</a>
				</td>
			</tr>
		`;
		tbody.append(row);
	});

}

function renderPagination(paging) {
	console.log("renderPagination실행 data: " + paging)
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
	          <a class="page-link" href="#" onclick="fn_search(1); return false;"><<</a></li>`;
	html += `<li class="page-item ${disabledFirst}">
	          <a class="page-link" href="#" onclick="fn_search(${startPage - 1}); return false;"><</a></li>`;

	for (let i = startPage; i <= endPage; i++) {
		const active = i === paging.currentPage ? 'active' : '';
		html += `<li class="page-item ${active}">
	              <a class="page-link" href="#" onclick="fn_search(${i}); return false;">${i}</a></li>`;
	}

	html += `<li class="page-item ${disabledLast}">
	          <a class="page-link" href="#" onclick="fn_search(${endPage + 1}); return false;">></a></li>`;
	html += `<li class="page-item ${disabledLast}">
	          <a class="page-link" href="#" onclick="fn_search(${totalPages}); return false;">>></a></li>`;

	html += '</ul>';

	container.append(html);

}

$('#startDate, #endDate').datetimepicker({
	format: 'YYYY-MM-DD'
});
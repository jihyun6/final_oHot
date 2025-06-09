$(function () {
  // 초기 페이지 로드
  loadMediaData(1);
  
  // 검색 버튼 클릭 이벤트
  $('#search-btn').on('click', function() {
    loadMediaData(1);
  });
  
  // 초기화 버튼 클릭 이벤트
  $('#reset-btn').on('click', function() {
    // 모든 필터 초기화
    $('#community-name').val('').trigger('change');
    $('#membership-filter').val('').trigger('change');
    $('#banner-filter').val('').trigger('change');
    $('#delete-filter').val('').trigger('change');
    $('#start-date input').val('');
    $('#end-date input').val('');
    $('#search-title').val('');
    
    // 데이터 새로 불러오기
    loadMediaData(1);
  });
  
  // Select2 초기화
  $('#community-name, #membership-filter, #banner-filter, #delete-filter').select2({
    placeholder: "선택",
    allowClear: true,
    theme: 'bootstrap4'
  });

  // 날짜 피커 초기화
  $('#start-date, #end-date').datetimepicker({
    format: 'YYYY-MM-DD'
  });
  
  $(document).on('click', '.pagination .page-link', function(e) {
    e.preventDefault();
    
    // 비활성화된 버튼은 처리하지 않음
    if ($(this).parent().hasClass('disabled')) {
      console.log("비활성화된 버튼 클릭");
      return;
    }
    
    const page = $(this).data('page');
    console.log("페이지 클릭:", page);
    
    if (page) {
      loadMediaData(parseInt(page));
    }
  });

  // 데이터 로드 함수
  function loadMediaData(currentPage) {
    // 로딩 표시
    $('#listBody').html('<tr><td colspan="9" class="text-center"><i class="fas fa-spinner fa-spin"></i> 검색 중...</td></tr>');
    
    // 검색 옵션 파라미터 수집
    const params = {
      artGroupNm: $('#community-name').val(),
      startDate: $('#start-date input').val(),
      endDate: $('#end-date input').val(),
      mediaMebershipYn: $('#membership-filter').val(),
      isbannerYn: $('#banner-filter').val(),
      mediaDelYn: $('#delete-filter').val(),
      mediaPostTitle: $('#search-title').val(),
      currentPage: currentPage,
      size: 10 // 페이지당 표시할 항목 수
    };

    $.ajax({
      url: '/api/media/getPagedList',
      method: 'GET',
      data: params,
      dataType: 'json',
      success: function(response) {
        updateMediaTable(response);
      },
      error: function(xhr, status, error) {
        console.error('검색 중 오류: ', error);
        $('#listBody').html('<tr><td colspan="9" class="text-center text-danger">검색 오류</td></tr>');
        $('#pagination-container').empty();
      }
    });
  }

  // 테이블 업데이트 함수
  function updateMediaTable(data) {
    const tableBody = $('#listBody');
    tableBody.empty();
    
    if (!data.content || data.content.length === 0) {
      tableBody.append('<tr><td colspan="9" class="text-center">검색 결과가 없습니다.</td></tr>');
      $('#pagination-container').empty();
      return;
    }
    
    // 테이블 데이터 렌더링
    $.each(data.content, function(index, mediaPostVO) {
      const row = `
        <tr onclick="fn_clickPost(${mediaPostVO.mediaPostNo}, ${mediaPostVO.artGroupNo})" style="cursor: pointer;">
          <td class="text-center">${(data.currentPage - 1) * 10 + index + 1}</td>
          <td>
            <span class="ellipsis-text" title="${mediaPostVO.mediaPostNo}">
              ${mediaPostVO.mediaPostNo}
            </span>
          </td>
          <td>
            <span class="ellipsis-text" title="${mediaPostVO.artistGroupVO ? mediaPostVO.artistGroupVO.artGroupNm : '-'}">
              ${mediaPostVO.artistGroupVO ? mediaPostVO.artistGroupVO.artGroupNm : '-'}
            </span>
          </td>
          <td>
            <span class="ellipsis-text" title="${mediaPostVO.mediaPostTitle}">
              ${mediaPostVO.mediaPostTitle}
            </span>
          </td>
          <td class="text-center">${formatDate(mediaPostVO.mediaRegDt)}</td>
          <td class="text-center">${mediaPostVO.mediaMebershipYn === 'Y' ? 'Y' : 'N'}</td>
          <td class="text-center">${mediaPostVO.isbannerYn === 'Y' ? 'Y' : 'N'}</td>
          <td class="text-center">${mediaPostVO.mediaDelYn === 'Y' ? 'Y' : 'N'}</td>
          <td class="text-center">
            <a href="/oho/community/media/post?postNo=${mediaPostVO.mediaPostNo}&artGroupNo=${mediaPostVO.artGroupNo}"
               class="btn btn-sm btn-info" onclick="event.stopPropagation();" target="_blank">게시글 바로가기</a>
          </td>
        </tr>
      `;
      tableBody.append(row);
    });
    
    // 페이지네이션 렌더링
    renderPagination(data);
  }

  function renderPagination(data) {
    const paginationContainer = $('#pagination-container');
    paginationContainer.empty();
    
    const totalPages = data.totalPages;
    const currentPage = data.currentPage;
    const startPage = data.startPage;
    const endPage = data.endPage;
    
    // 전체 페이지가 1페이지 이하면 페이지네이션 표시하지 않음
    if (totalPages <= 1) {
      return;
    }
    
    let pagination = $('<ul class="pagination"></ul>');
    
    // 첫 페이지로 이동 버튼
    let firstPageItem = $('<li class="page-item"></li>');
    if (currentPage === 1) {
      firstPageItem.addClass('disabled');
    }
    let firstPageLink = $('<a class="page-link href="javascript:void(0)">&lt;&lt;</a>');
    firstPageLink.attr('data-page', 1);
    firstPageItem.append(firstPageLink);
    pagination.append(firstPageItem);
    
    // 이전 블록 이동 버튼
    let prevBlockItem = $('<li class="page-item"></li>');
    if (startPage <= 1) {
      prevBlockItem.addClass('disabled');
    }
    let prevBlockLink = $('<a class="page-link" href="javascript:void(0)">&lt;</a>');
    prevBlockLink.attr('data-page', Math.max(1, startPage - 5));
    prevBlockItem.append(prevBlockLink);
    pagination.append(prevBlockItem);
    
    // 페이지 번호 버튼
    for (let i = startPage; i <= endPage; i++) {
      let pageItem = $('<li class="page-item"></li>');
      if (i === currentPage) {
        pageItem.addClass('active');
      }
      let pageLink = $('<a class="page-link" href="javascript:void(0)"></a>');
      pageLink.text(i);
      pageLink.attr('data-page', i);
      pageItem.append(pageLink);
      pagination.append(pageItem);
    }
    
    // 다음 블록 이동 버튼
    let nextBlockItem = $('<li class="page-item"></li>');
    if (endPage >= totalPages) {
      nextBlockItem.addClass('disabled');
    }
    let nextBlockLink = $('<a class="page-link" href="javascript:void(0)">&gt;</a>');
    nextBlockLink.attr('data-page', Math.min(totalPages, endPage + 1));
    nextBlockItem.append(nextBlockLink);
    pagination.append(nextBlockItem);
    
    // 마지막 페이지 이동 버튼
    let lastPageItem = $('<li class="page-item"></li>');
    if (currentPage >= totalPages) {
      lastPageItem.addClass('disabled');
    }
    let lastPageLink = $('<a class="page-link" href="javascript:void(0)">&gt;&gt;</a>');
    lastPageLink.attr('data-page', totalPages);
    lastPageItem.append(lastPageLink);
    pagination.append(lastPageItem);
    
    paginationContainer.append(pagination);
    
    $('#pagination-container .page-item.disabled').css({
      'pointer-events': 'none',
      'opacity': '0.6',
      'cursor': 'not-allowed'
    });
  }
  
  // 날짜 포맷 함수
  function formatDate(dateString) {
    if (!dateString) return '-';
    const date = new Date(dateString);
    return date.getFullYear() + '-' + 
           String(date.getMonth() + 1).padStart(2, '0') + '-' + 
           String(date.getDate()).padStart(2, '0');
  }
  
  window.fn_clickPost = function(postNo, artGroupNo) {
    location.href = `/admin/media/detail?postNo=${postNo}&artGroupNo=${artGroupNo}`;
  };
});
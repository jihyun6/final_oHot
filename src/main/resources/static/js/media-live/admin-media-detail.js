$(function () {
    // Summernote 에디터 초기화
    $('.summernote').summernote({
        height: 300,
        toolbar: [
            ['style', ['style']],
            ['font', ['bold', 'underline', 'clear']],
            ['color', ['color']],
            ['para', ['ul', 'ol', 'paragraph']],
            ['table', ['table']],
            ['insert', ['link', 'picture']],
            ['view', ['fullscreen', 'codeview', 'help']]
        ]
    });
    
    // 파일 입력 시 파일명 표시
    bsCustomFileInput.init();
    
    // 원본 경로들
    var originalThumbnailPath = $("#original-thumbnail-path").val() ? "/upload" + $("#original-thumbnail-path").val() : "";
    var originalVideoPath = $("#original-video-path").val() ? "/upload" + $("#original-video-path").val() : "";
    var originalMediaType = $("#original-media-type").val();
	var originalYoutubeUrl = "";
    
	// 일반 미디어일때 초기 Youtube Url 설정
	    if (originalMediaType === 'N' && $("#original-video-path").val()) {
	        originalYoutubeUrl = "https://www.youtube.com/watch?v=" + $("#original-video-path").val();
	        $('#media-url').val(originalYoutubeUrl);
	        
	        // YouTube 미리보기 설정
	        var youtubeId = extractYoutubeId(originalYoutubeUrl);
	        if (youtubeId) {
	            $('#youtube-preview').attr('src', 'https://www.youtube.com/embed/' + youtubeId);
	        }
	    }
		
    // 첫 렌더링 페이지 ㅗ기화
    function initFieldVisibility() {
        var mediaType = $('input[name="mediaMebershipYn"]:checked').val();
        
        if (mediaType === 'N') {
            $('.normal-media-field').show();
            $('.membership-media-field').hide();
            
            // 유튜브미리보기 표시
            var youtubeUrl = $('#media-url').val();
            if (youtubeUrl) {
                var youtubeId = extractYoutubeId(youtubeUrl);
                if (youtubeId) {
                    $('#youtube-preview').attr('src', 'https://www.youtube.com/embed/' + youtubeId);
                    $('#youtube-preview-container').show();
                }
            }
        } else {
            $('.normal-media-field').hide();
            $('.membership-media-field').show();
            $('#youtube-preview-container').hide();
            
            // 기존 썸네일/비디오가 있으면 미리보기 표시
            if (originalThumbnailPath && (originalMediaType === 'Y' || originalMediaType === 'L')) {
                $('#thumbnail-preview').attr('src', originalThumbnailPath);
                $('#thumbnail-preview-container').show();
            }
            
            if (originalVideoPath && (originalMediaType === 'Y' || originalMediaType === 'L')) {
                $('#video-preview source').attr('src', originalVideoPath);
                $('#video-preview')[0].load(); // 비디오 로드
                $('#video-preview-container').show();
            }
        }
    }
    
    // 페이지 초기 설정
    initFieldVisibility();
    
    // 게시글 유형 변경 시 숨김처리
    $('input[name="mediaMebershipYn"]').change(function() {
        if (this.value === 'N') {
            $('.normal-media-field').show();
            $('.membership-media-field').hide();
            // 미리보기 컨테이너도 초기화
            $('#thumbnail-preview-container, #video-preview-container').hide();
      		// 원본 url 할당
            if (originalMediaType === 'N' && originalYoutubeUrl) {
                $('#media-url').val(originalYoutubeUrl);
                
                // youtube미리보기
                var youtubeId = extractYoutubeId(originalYoutubeUrl);
                if (youtubeId) {
                    $('#youtube-preview').attr('src', 'https://www.youtube.com/embed/' + youtubeId);
                    $('#youtube-preview-container').show();
                }
            } else {
                $('#media-url').val('');
                $('#youtube-preview-container').hide();
            }
        } else {
            $('.normal-media-field').hide();
            $('.membership-media-field').show();
            // YouTube 미리보기 컨테이너 초기화
            $('#youtube-preview-container').hide();
            
            // 라디오버튼 변경시 미리보기들 처리
            if (originalMediaType === 'Y' || originalMediaType === 'L') {
                if (originalThumbnailPath) {
                    $('#thumbnail-preview').attr('src', originalThumbnailPath);
                    $('#thumbnail-preview-container').show();
                }
                
                if (originalVideoPath) {
                    $('#video-preview source').attr('src', originalVideoPath);
                    $('#video-preview')[0].load(); // 비디오 로드
                    $('#video-preview-container').show();
                }
            }
        }
    });
    
    $('#createPostForm, #updatePostForm').submit(function(e) {
		console.log("submit확인");
        var mediaType = $('input[name="mediaMebershipYn"]:checked').val();
        
		
        // 일반 미디어인 경우 URL 필수
        if (mediaType === 'N' && !$('#media-url').val()) {
            e.preventDefault();
			console.log("alert은 안뜨고 포커스만?");
            alert('유튜브 URL을 입력해주세요.');
            $('#media-url').focus();
            return false;
        }
        
        // 멤버십, 라이브게시글 처리
        if (mediaType !== 'N') {
            // 기존 파일 없고 새 게시글 처리
            if (!originalThumbnailPath && !$('#thumbnail-upload').val()) {
                e.preventDefault();
                alert('썸네일 이미지를 업로드 해주세요.');
                $('#thumbnail-upload').focus();
                return false;
            }
            
            if (!originalVideoPath && !$('#video-upload').val()) {
                e.preventDefault();
                alert('비디오 파일을 업로드 해주세요.');
                $('#video-upload').focus();
                return false;
            }
        }
        
        return true;
    });
 
    // 썸네일 미리보기
    $('#thumbnail-upload').change(function() {
        if (this.files && this.files[0]) {
            var reader = new FileReader();
            
            reader.onload = function(e) {
                $('#thumbnail-preview').attr('src', e.target.result);
                $('#thumbnail-preview-container').show();
            }
            
            reader.readAsDataURL(this.files[0]);
        } else {
            // 파일 선택 취소 오류 수정
            if (originalThumbnailPath && (originalMediaType === 'Y' || originalMediaType === 'L')) {
                $('#thumbnail-preview').attr('src', originalThumbnailPath);
                $('#thumbnail-preview-container').show();
            } else {
                $('#thumbnail-preview-container').hide();
            }
        }
    });
    
    // 비디오 파일 미리보기
    $('#video-upload').change(function() {
        if (this.files && this.files[0]) {
            var reader = new FileReader();
            
            reader.onload = function(e) {
                $('#video-preview source').attr('src', e.target.result);
                $('#video-preview')[0].load(); // 비디오 로드
                $('#video-preview-container').show();
            }
            
            reader.readAsDataURL(this.files[0]);
        } else {
            // 파일 취소 오류 수정
            if (originalVideoPath && (originalMediaType === 'Y' || originalMediaType === 'L')) {
                $('#video-preview source').attr('src', originalVideoPath);
                $('#video-preview')[0].load();
                $('#video-preview-container').show();
            } else {
                $('#video-preview-container').hide();
            }
        }
    });
    
    // Youtube 미리보기
    $('#media-url').on('input', function() {
        var youtubeUrl = $(this).val();
		console.log("dasg:", youtubeUrl);
        if (youtubeUrl) {
            // yotubue id 가져오기
            var youtubeId = extractYoutubeId(youtubeUrl);
            if (youtubeId) {
                $('#youtube-preview').attr('src', 'https://www.youtube.com/embed/' + youtubeId);
                $('#youtube-preview-container').show();
            } else {
                $('#youtube-preview-container').hide();
            }
        } else {
            $('#youtube-preview-container').hide();
        }
    });
    
    // YouTube ID 추출
    function extractYoutubeId(url) {
        var regExp = /^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#&?]*).*/;
        var match = url.match(regExp);
        return (match && match[7].length == 11) ? match[7] : false;
    }
    
    // 삭제 버튼 처리
    $("#deleteBtn").on("click", function(){
        let mediaPostNo = $(this).data("postNo");
        
        console.log("삭제 이벤트 postNo: ", mediaPostNo);
        // ajax로 삭제
        if(confirm("정말 삭제하시겠습니까?")){
            $.ajax({
                url: '/api/media/deletePost',
                type: 'POST',
                data: {
                    'mediaPostNo': mediaPostNo
                },
                success: function(result){
                    alert('게시글을 삭제했습니다.');
                    window.location.href = '/admin/media';
                },
                error: function(xhr, status, error){
                    alert('삭제를 실패했습니다.: ' + error);
                }
            })
        }
    });
});


// 시연용 버튼 시작
function testBtn(type) {
	console.log("미디어 등록 type : ", type);
	
	// 커뮤니티 선택
	document.getElementById("community-select").value = 1;
	document.getElementById("community-select").dispatchEvent(new Event("change")); // 강제로 select 박스에 change 이벤트를 발생함 -> 안그럼 내부값만 변경됨
	
	
	if(type=='normal') {
		// 게시글 유형 '일반 미디어' 선택
		const mediaMebershipYn = document.querySelector("input[name='mediaMebershipYn']");
		mediaMebershipYn.value = "N";
		mediaMebershipYn.dispatchEvent(new Event("change"));
		document.getElementById("normalMedia").checked = true;
		
		// 미디어 URL 입력
		document.getElementById("media-url").value="https://www.youtube.com/watch?v=1QUvF7zsIpc0";
		
		// 게시글 제목 입력
		document.getElementById("post-title").value='당일 급조된 첫버스킹? 창작곡-" Iam OkYou are Ok"를 불러봤다[무한루프]';
		
		let content = ``;
		content += `무한루프의 세상밖 나들이 첫 도전\n`;
		content += `"I am OK! You ar OK!- 무한루프"의 창작곡 입니다.\n` ;
		content += `취업난에 공부하고 노력하며, 미래를 향한 그들에게 바치는 노래!`;
		document.getElementById("post-content").value = content;
		
	}else {
		// 게시글 유형 '지난라이브' 선택
		const mediaMebershipYn = document.querySelector("input[name='mediaMebershipYn']");
		mediaMebershipYn.value = "L";
		mediaMebershipYn.dispatchEvent(new Event("change"));
		document.getElementById("liveMedia").checked = true;
		
		document.getElementById("post-title").value = "250507 무한루프 oHoT 라이브 - MUHANLOOP oHoT Live"
		document.getElementById("post-content").value = "#무한루프 #오핫라이브 #라방 #송중호쌤 #이규방쌤 #oHoT ";
		
	}
}
// 시연용 버튼 끝
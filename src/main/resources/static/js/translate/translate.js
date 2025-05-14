
// 커뮤니티 포스트 번역 (제목+내용)

async function commuPostTrans() {
		const transBtn = event.target;
		console.log("내가 클릭한 버튼", transBtn);
		
		const target = transBtn.dataset.lang;
		console.log("targetLang : ", target);
		
		const card = transBtn.closest(".card");
		const titleTag = card.querySelector(".post-title");
		const postTag = card.querySelector(".card-text");
		
		const status = transBtn.dataset.status; // original or translated
		
		if (status === 'original') {
			const titleData = {
					text : titleTag.innerText,
					target : target
			}
			
			const postData = {
					text : postTag.innerText,
					target : target
			}
			
			try {
				/*
				const titleResult = await axios.post("/api/translate", titleData);
				console.log("제목 결과 값! : ", titleResult.data);
				
				const postResult = await axios.post("/api/translate", postData);
				console.log("게시글 결과 값! : ", postResult.data);
				// 밑으로 축약!
				*/
				
					const [titleResult, postResult] = await Promise.all([
		                axios.post("/api/translate", titleData),
		                axios.post("/api/translate", postData)
		            ]);
				// 번역 내용 표시
				titleTag.innerText = titleResult.data;
	            postTag.innerText = postResult.data;
	            
	            // 버튼명/상태 변경
	            transBtn.innerText = '원본보기';
	            transBtn.dataset.status = 'translated';
				
			} catch(e) {
				console.log("번역 실패", e);
			}
			
		} else { // 원본보기
	        titleTag.innerText = titleTag.dataset.original;
	        postTag.innerText = postTag.dataset.original;

	        transBtn.innerText = '번역하기';
	        transBtn.dataset.status = 'original';
		}
		
	}
	
// 댓글 번역
async function commuReplyTrans() {
	const transBtn = event.target;
	console.log("내가 클릭한 버튼", transBtn);
	
	const target = transBtn.dataset.lang;
	console.log("target : ", target);
	
	const replyTag = transBtn.previousElementSibling;
	console.log("replyTag", replyTag);
	
	const status = transBtn.dataset.status; // original or translated
	
	if (status === 'original') {
		const replyData = {
				text : replyTag.innerText,
				target : target
		}
		
		try {
			const replyResult = await axios.post("/api/translate", replyData);
			
			// 번역 내용 표시
			replyTag.innerText = replyResult.data;
				
            // 버튼명/상태 변경
            transBtn.innerText = '원본보기';
            transBtn.dataset.status = 'translated';
			
		} catch(e) {
			console.log("번역 실패", e);
		}
		
	} else { // 원본보기
        replyTag.innerText = replyTag.dataset.original;

        transBtn.innerText = '번역하기';
        transBtn.dataset.status = 'original';
	}

}
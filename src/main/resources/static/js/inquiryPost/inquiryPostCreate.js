/**
 * 
 */

ClassicEditor
   .create(document.querySelector('#editor1'), {
   	extraPlugins: [MyCustomUploadAdapterPlugin],
       simpleUpload: {
           // 이미지 업로드 컨트롤러 주소
           uploadUrl: '/oho/inquiryPost/upload',

           // 인증 헤더 등 필요한 경우 추가
           headers: {
               // 'X-CSRF-TOKEN': 'CSRF-토큰',
           }
       }
   })
   .then(editor => {
       window.editor = editor;
   })
   .catch(error => {
       console.error(error);
   });
   
	 
 function MyCustomUploadAdapterPlugin(editor) {
   editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
     return new MyUploadAdapter(loader);
   };
 }

 class MyUploadAdapter {
   constructor(loader) {
     this.loader = loader;
   }

   upload() {
     return this.loader.file.then(file => new Promise((resolve, reject) => {
       const data = new FormData();
       data.append('upload', file);

       fetch('/ckEditor/tempUpload', {
         method: 'POST',
         body: data
       })
       .then(res => res.json())
       .then(res => resolve({ default: res.url }))
       .catch(err => reject(err));
     }));
   }

   abort() {
     // optional
   }
 }
   
   
   const submitBtn = document.getElementById("submitBtn");
   if (submitBtn) {
       submitBtn.addEventListener("click", () => {
       	 	let htmlContent = window.editor.getData(); // ckEditor가 알아서 escpae 변환해 줌
			let bbsTitle = document.getElementById("bbsTitle").value; 
			bbsTitle = escapeHtml(bbsTitle);
			console.log("cleaned bbsTitle : ", bbsTitle);
            
            // HTML을 임시 div에 넣고 textContent만 추출
            const tempDiv = document.createElement("div");
            tempDiv.innerHTML = htmlContent;
            let plainText = tempDiv.textContent || tempDiv.innerText || "";
			plainText = escapeHtml(plainText)
            console.log("plainText : ", plainText);
            
            // hidden input에 plain text 저장
            document.getElementById("plainText").value = plainText;
			
			if (plainText.trim() === "") {
	            alert("내용을 입력해주세요.");
	            // 시각적 피드백도 주고 싶다면 아래 한 줄 추가
	            document.querySelector('.ck-editor__editable').style.border = '2px solid red';
	            return; // 제출 막기
	        } else {
	            // border 원복 (필요한 경우)
	            document.querySelector('.ck-editor__editable').style.border = '';
	        }
            
           const writer = document.getElementById("writer").value;
            if(writer.trim().includes("관리")) {
            	alert("사용할 수 없는 이름입니다.");
            }else{
			 document.getElementById("bbsTitle").value = bbsTitle;
             const form = document.querySelector("#frmSubmit");
          	 // required 검사
             if (form.checkValidity()) {
                 form.submit(); // 통과하면 제출
             }else {
                 form.reportValidity(); // 실패 시 오류 메시지 표시
             }
            }
            
       });
   }
   
   const saveBtn = document.getElementById("saveBtn");
   if (saveBtn) {
       saveBtn.addEventListener("click", () => {
		let htmlContent = window.editor.getData();
		let bbsTitle = document.getElementById("bbsTitle").value; 
        console.log("htmlContent : ", htmlContent);
		console.log("bbsTitle : ", bbsTitle);
		
		// DOMPurify로 XSS 방어 (HTML 정화)
		htmlContent = escapeHtml(htmlContent);
		bbsTitle = escapeHtml(bbsTitle);
		console.log("cleaned bbsTitle : ", bbsTitle);
		console.log("cleaned htmlContent : ", htmlContent);
        
        // HTML을 임시 div에 넣고 textContent만 추출
        const tempDiv = document.createElement("div");
        tempDiv.innerHTML = htmlContent;
        const plainText = tempDiv.textContent // textContent 부분만 추출
        console.log("plainText : ", plainText);
		tempDiv.innerText = plainText;
        
        // hidden input에 plain text 저장
        document.getElementById("plainText").value = plainText;
		
		if (plainText.trim() === "") {
            alert("내용을 입력해주세요.");
            // 시각적 피드백도 주고 싶다면 아래 한 줄 추가
            document.querySelector('.ck-editor__editable').style.border = '2px solid red';
            return; // 제출 막기
        } else {
            // border 원복 (필요한 경우)
            document.querySelector('.ck-editor__editable').style.border = '';
        }
        
		document.getElementById("bbsTitle").value = bbsTitle;
		const form = document.querySelector("#frmEditSubmit");
		if (form.checkValidity()) {
	         form.submit(); // 통과하면 제출
	     }else {
	         form.reportValidity(); // 실패 시 오류 메시지 표시
	     }
   	})
}
   
   const cancelBtn = document.getElementById("cancelBtn");
   if(cancelBtn) {
   	cancelBtn.addEventListener("click", () => {
   		location.href="/oho/inquiryPost"
   	})
   }
   
   // escape 문자
   function escapeHtml(str) {
     return str
       .replace(/&/g, "&amp;")
       .replace(/</g, "&lt;")
       .replace(/>/g, "&gt;")
       .replace(/"/g, "&quot;")
       .replace(/'/g, "&#039;");
   }
   
   function cleanText(html) {
     return html
       .replace(/<p><br\s*\/?><\/p>/gi, '') // 빈 p 태그 제거
       .replace(/<[^>]*>/g, '')             // 모든 태그 제거
       .replace(/&nbsp;/gi, '')             // &nbsp 제거
       .replace(/\u200B/g, '')              // zero-width space 제거
       .replace(/\s+/g, '')                 // 기타 공백 제거
       .trim();
   }

   // 저장용: 앞뒤 불필요한 빈 단락 제거 (공백 p, br, &nbsp)
   function cleanHtml(html) {
     return html
       .replace(/^(?:\s*<p>(&nbsp;|<br\s*\/?>|\s)*<\/p>\s*)+/gi, '') // 앞쪽
       .replace(/(?:\s*<p>(&nbsp;|<br\s*\/?>|\s)*<\/p>\s*)+$/gi, '') // 뒤쪽
       .trim();
   }
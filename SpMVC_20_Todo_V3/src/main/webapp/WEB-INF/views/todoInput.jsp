<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="rootPath" value="${pageContext.request.contextPath}"/>
<form class="form" id="todoInput" method="post" enctype="multipart/form-data">
	<div class="image_wrapper">
		<img id="to_image_thumnail"
			src="${rootPath}/static/images/noImage.png" 
			width="30px">
	</div>
	<input name="to_text" placeholder="TODO">
	<div class="insert-button">추가</div>
	<input accept="image/*" 
			type="file" 
			id="imgTag" 
			name="to_image" />
	
</form>
<script>
document.addEventListener("DOMContentLoaded", function(){
	document.querySelector("div.image_wrapper")
		.addEventListener("click", function(){
			document.querySelector("input#imgTag").click()
	})
	
	document.querySelector("div.insert-button")
		.addEventListener("click", function() {
			// 입력한걸 서버로 전송해라
			// document.querySelector("form#todoInput").submit()
			
			
			const main_form = document.querySelector("form#todoInput")
			main_form.submit()
			
			// form 에 담긴 데이터를 취급하기 위한 클래스
			
			// form#todoInput form 의 모든 input box에 담긴 데이터를
			// FormData 객체로 한꺼번에 변환하기
			
			// 객체 생성
			const upData = new FormData(main_form) 
			
			//const todoText = 
			//	document.querySelector("input[name='to_text']").value; // 문자열값 추출
			//const todoImage = 
			//	document.querySelector("input[name='to_image']");
					
			// 생성된 객체에 데이터 append 
			// => form자체를 매개변수로 주입해버리면 input tag내 데이터를 전부 넣을 수 있다
			// upData.append("to_image", todoImage.files[0]) 
			// upData.append("to_text", todoText)
			
			// headers 부분은 file을 보낼때 반드시있어야한다.
			fetch("${rootPath}/upload",
				{
					method:'POST',
					body: upData
				}
			)
			.then(result=>result.json())
			.then(json=>{
				alert(JSON.stringify(json))
				document.querySelector("img#imgView")
				.src = "${rootPath}/files/" + json.SAVENAME
			})
		})
		
	// input type=file tag를 클릭하고 fileOpenDialog 가 뜨고
	// 파일을 선택한 후 open 을 누른 후의 event = load
	const imgTag = document.querySelector("input#imgTag")
	if(imgTag){
		imgTag.addEventListener("change", function(){
			
			// fileOpen Dialog에서 선택한 파일들 getter
			const fileList = imgTag.files
			
			// 선택한 파일 중 첫번째 파일만 또 getter
			const file0 = fileList[0]
			
			// 파일 열기(읽기) 클래스 : 이게 최신브라우저에서만 적용된다
			const fileReader = new FileReader()
			fileReader.readAsDataURL(file0)
			
			// 파일을 열고 모두 읽어 들였으면
			fileReader.onload = function(){ // 비동기방식의 callback
				document.querySelector("img#to_image_thumnail")
					.src = fileReader.result // 이미지태그의 src에 부착시켜라
			}
			
			
			// 첫번째 파일 이름 alert()
			// alert(file0.name)
		})
	}
})
</script>
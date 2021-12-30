<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="rootPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
// js코드를 아무곳에나 위치하기 위하여
document.addEventListener("DOMContentLoaded", function(){
	const username = document.querySelector("input[name='username']")
	const password = document.querySelector("input[name='password']")
	
	const login = document.querySelector("button.btn-login")
	if(login){
		
		login.addEventListener("click", function(){
			const login_option = {
					method: "POST",
					credentials:"include", //세션괄리를 위해 필수적
					headers: {
						"Content-Type" : "application/json"
					},
					body: JSON.stringify({
						username: username.value,
						password: password.value
					})
				}
				
				fetch("${rootPath}/user/login", login_option) // jsp내부이기때문에 el태그이다. `을 사용하지 않는다.
				.then(res=> res.text())
				.then(result=> alert(result))
		})
	}
})
</script>
</head>
<body>
	<h1>Home</h1>
	<form>
	<div>
		<input name="username" placeholder="USERNAME 입력"/>
	</div>
	<div>
		<input name="password" type="password" placeholder="PASSWORD 입력"/>
	</div>
	<button type="button" class="btn btn-login">로그인</button>
	</form>
</body>
</html>
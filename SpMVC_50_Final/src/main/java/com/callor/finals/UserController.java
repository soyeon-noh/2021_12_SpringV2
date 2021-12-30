package com.callor.finals;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.callor.finals.model.LoginUser;

@Controller
@RequestMapping(value = "/user")
public class UserController {

	/**
	 * RequestBody 는 
	 * fetch 를 사용하여 JSON 데이터를 보냈을 때 
	 * VO(DTO) 객체에 자동적으로 변환하여 담아주는 설정이다.
	 * 단, equestBody 는 매개변수의 가장 마지막에 한번만 사용할 수 있다.
	 * 
	 */
	@ResponseBody
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	// model에있는건 RequestBody해야한다
	public String login(HttpSession session,
			// 아래와 같을 땐 aaa가 무시된다. 주의! 또 주의!
			@RequestBody LoginUser loginuser, String aaa) {

		/**
		 * Sever에서 loginUser 객체 데이터를 저장하고 클라이언트와 상태를 공유하기 위하여 준비하라
		 */
		session.setAttribute("USER", loginuser);

		return loginuser.getUsername();

	}

	@ResponseBody
	@RequestMapping(value = "/loginOK", method = RequestMethod.POST)
	public String loginOk(HttpSession session) {
		/**
		 * session 이 생성된 상태에서는
		 * 클라이언트가 서버에 URL 요청을 하면
		 * 브라우저는 자동으로 Session ID 를 Http 프로토콜 body 에 담아서 서버로 전송한다
		 * 서버에서는 전달받은 Session ID 가 유효한지를 내부에서 판단한 후
		 * 유효한 ID 이면 HttpSession으로부터 저장된 Attrivute 를 getter 할 수 있도록 허용한다.
		 */
		LoginUser loginUser = (LoginUser) session.getAttribute("USER");
		return loginUser.getUsername();
	}
}

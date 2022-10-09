package kr.ac.kyonggi.cs.handler.action.graduation;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.ac.kyonggi.cs.common.controller.Action;

public class GraduationActionController implements Action {
	// 여기서 graduation_form.do 요청이 들어온거 처리
	// 처리방법은 요청들어올때 schedule_name_int를 같이 받는데 이거는 각단계를 표시한거니
	// 각단계를 여기서 구분해서 보낸다.
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String stage = request.getParameter("stage");
		String num = request.getParameter("num");
		String perid = request.getParameter("per_id"); // 학생의 학번!
		String modify = request.getParameter("modify");
		String resulturl = null;
		String temp = stage;
		String numtemp = num.toString();

		if (stage.equals("1")) { // 신청접수

			GraduationFormRequestAction g = new GraduationFormRequestAction();
			g.thisperid = perid;
			return g.execute(request, response);
		} else if (stage.equals("2")) { // 제안서
			GraduationFormSuggestAction g = new GraduationFormSuggestAction();
			return g.execute(request, response);
		} else if (stage.equals("3")) { // 중간
			GraduationFormInterimAction g = new GraduationFormInterimAction();
			return g.execute(request, response);

		} else if (stage.equals("4")) { // 최종
			GraduationFormFinalAction g = new GraduationFormFinalAction();
			return g.execute(request, response);
		}

		return null;

	}

}

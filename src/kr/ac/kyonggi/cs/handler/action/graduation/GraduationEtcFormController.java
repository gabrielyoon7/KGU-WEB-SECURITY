package kr.ac.kyonggi.cs.handler.action.graduation;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.ac.kyonggi.cs.common.controller.Action;

//기타자격은 경우 수가 많아서 컨트롤러로 아예 빼놓았습니다
public class GraduationEtcFormController implements Action {
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String perid = request.getParameter("per_id");
		String num = request.getParameter("num");
		String stage = request.getParameter("stage");
		String modify = request.getParameter("modify");
		String numtemp = num.toString();

		// 자격증
		if (stage.equals("7")) {
			GraduationCertificateAction g = new GraduationCertificateAction();
			return g.execute(request,response);
		}

		// 학술대회
		else if (stage.equals("8")) {
			GraduationConferenceAction g = new GraduationConferenceAction();
			return g.execute(request,response);
		}

		// 공모전
		else if (stage.equals("9")) {
			GraduationContestAction g = new GraduationContestAction();
			return g.execute(request,response);
		}

		return null;
	}
}

package kr.ac.kyonggi.cs.handler.action.graduation;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.ac.kyonggi.cs.common.controller.Action;
import kr.ac.kyonggi.cs.handler.dao.graduation.GraduationTestDAO;
import kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO;
import kr.ac.kyonggi.cs.handler.dao.user.UserDAO;
import kr.ac.kyonggi.cs.handler.dto.graduation.GraduationCertificateDataDTO;
import kr.ac.kyonggi.cs.handler.dto.graduation.GraduationUserDTO;
import kr.ac.kyonggi.cs.handler.stateenum.Capstone;
import kr.ac.kyonggi.cs.handler.vo.user.UserBean;

import com.google.gson.Gson;

//기타자격 자격증 액션
public class GraduationCertificateAction implements Action {
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Gson gson = new Gson();
		String per_id = request.getParameter("per_id");
		String num = request.getParameter("num");
		String stage = request.getParameter("stage");
		String modify = request.getParameter("modify");
		int perid = Integer.parseInt(per_id);
		
		UserBean user = UserDAO.getInstance().getUser(per_id);
		GraduationUserDTO grduser = GraduationTestDAO.getInstance().getUser(perid);
		
		String userr=(String)request.getSession().getAttribute("user");
		UserBean user2 = gson.fromJson(userr, UserBean.class);
		if (user2.type.equals("졸업논문관리자")) {
			request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getGrdTabMenu(num, 4)));
		} else if (user2.type.contains("교수")) {
			request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getGrdTabMenu(num, 3)));
		} else if (user2.type.equals("학부생") || user2.type.equals("복수전공생")) {
			request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getGrdTabMenu(num, 2)));
		} else
			return "RequestDispatcher:jsp/main/error.jsp";
		
		request.setAttribute("num", num);
		request.setAttribute("stage", stage);
		request.setAttribute("modify", modify);
		request.setAttribute("per_id", perid);
		//request.setAttribute("tabmenulist", gson.toJson(HomeDAO.getInstance().getGrdTabMenu(num, 2)));
		request.setAttribute("graduationuser", gson.toJson(grduser));
		request.setAttribute("grduser", gson.toJson(user));
		
		// modify == 0(신청자 보기)
		if (modify.equals("0")) {
			GraduationCertificateDataDTO certificate_data = GraduationTestDAO.getInstance().getCertiData(perid);
			
			request.setAttribute("stage_data", gson.toJson(certificate_data));
			request.setAttribute("download", GraduationTestDAO.getInstance().getEtcFileName(1, perid));
			
			return "RequestDispatcher:jsp/graduation/form_etc1_test3.jsp";
		}
		
		// modify == 1(신청자 수정)
		if (modify.equals("1")) {
			GraduationCertificateDataDTO certificate_data = GraduationTestDAO.getInstance().getCertiData(perid);
			request.setAttribute("stage_data", gson.toJson(certificate_data));
			request.setAttribute("download", GraduationTestDAO.getInstance().getEtcFileName(1, perid));
			
			return "RequestDispatcher:jsp/graduation/form_etc1_test.jsp";
		}
		

		// modify == 2(신청자 추가 및 제출)
		else if (modify.equals("2")) {
			return "RequestDispatcher:jsp/graduation/form_etc1_test.jsp";
		}

		// modify == 3(신청자 삭제)
		// 자격증 데이터 테이블 default로 초기화 dao

		else if (modify.equals("3")) {
			GraduationTestDAO.getInstance().delete_certificate(perid);
			
			request.setAttribute("tabMenu", gson.toJson(HomeDAO.getInstance().getGrdTabMenu(num, 2)));
			grduser.setEtc_accept(Capstone.getCapstone(grduser.getCapstone())); 
			request.setAttribute("grdu_student",gson.toJson(grduser));
			request.setAttribute("grdu_students_state_list", gson.toJson(GraduationTestDAO.getInstance().getGrduStateList(Integer.parseInt(per_id),1))); // 요거
			request.setAttribute("etc_state", gson.toJson(GraduationTestDAO.getInstance().getEtc(Integer.parseInt(per_id))));
			request.setAttribute("log_list", gson.toJson(GraduationTestDAO.getInstance().getGrdLog(Integer.parseInt(per_id))));
			
			return "RequestDispatcher:jsp/graduation/graduation_mypage_test.jsp";
		}

		// modify == 4(관리자 보기)
		else if (modify.equals("4")) {
			GraduationCertificateDataDTO certificate_data = GraduationTestDAO.getInstance().getCertiData(perid);
			request.setAttribute("stage_data", gson.toJson(certificate_data));
			request.setAttribute("download", GraduationTestDAO.getInstance().getEtcFileName(1, perid));
			
			return "RequestDispatcher:jsp/graduation/form_etc1_test.jsp";
		}

		// modify == 5(관리자 승인 및 반려)
		else if (modify.equals("5")) {
			GraduationCertificateDataDTO certificate_data = GraduationTestDAO.getInstance().getCertiData(perid);
			request.setAttribute("stage_data", gson.toJson(certificate_data));
			request.setAttribute("download", GraduationTestDAO.getInstance().getEtcFileName(1, perid));
			
			return "RequestDispatcher:jsp/graduation/form_etc1_test.jsp";
		}

		// modify == 6(관리자 연장)
		else if (modify.equals("6")) {
		}
		return null;
	}
}

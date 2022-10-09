/*
url
졸업논문 : graduation_back_info.do?num=94&perid=201711111&grdType=thesis
자격증 : graduation_back_info.do?num=94&perid=201711111&grdType=certificate
학술대회 : graduation_back_info.do?num=94&perid=201711111&grdType=conference
공모전 : graduation_back_info.do?num=94&perid=201711111&grdType=contest
*/
package kr.ac.kyonggi.cs.handler.action.graduationBack;

import kr.ac.kyonggi.cs.common.controller.Action;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class GraduateInfoController implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception{
        String perid = request.getParameter("perid");
        String num = request.getParameter("num");
        String type = request.getParameter("grdType");
        //졸업논문
        if(type.equals("thesis")){
            GraduateThesisAction graduateThesisAction = new GraduateThesisAction();
            return graduateThesisAction.execute(request, response);
        }

        //자격증
        else if(type.equals("certificate")){
            GraduateCertificateAction graduateCertificateAction = new GraduateCertificateAction();
            return graduateCertificateAction.execute(request, response);
        }

        //학술대회
        else if(type.equals("conference")){
            GraduateConferenceAction graduateConferenceAction = new GraduateConferenceAction();
            return graduateConferenceAction.execute(request, response);
        }

        //공모전
        else if(type.equals("contest")){
            GraduateContestAction graduateContestAction = new GraduateContestAction();
            return graduateContestAction.execute(request, response);
        }

        //에러
        else{
            return "RequestDispatcher:jsp/main/error.jsp";
        }
    }
}

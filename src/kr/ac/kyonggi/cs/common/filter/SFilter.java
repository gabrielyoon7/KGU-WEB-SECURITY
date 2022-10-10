package kr.ac.kyonggi.cs.common.filter;

import java.io.IOException;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import kr.ac.kyonggi.cs.handler.dao.setting.HomeDAO;
import kr.ac.kyonggi.cs.handler.dao.user.UserDAO;

@WebFilter("/*")
public class SFilter implements Filter{

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {

	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) res;
		HttpSession session = request.getSession(true);
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		//response.setContentType("text/html;charset=UTF-8");
		response.setHeader("P3P","CP='CAO PSA CONI OTR OUR DEM ONL'");
		Gson gson = new Gson();

		/**
		 * 알 수 없는 톰캣 버그 수정을 위한 조치 시작.
		 * AI컴퓨터공학부 홈페이지에서만 적용 되는 것임!!!!!
		 * */
		StringBuffer url = request.getRequestURL();
		String urlString = url+"";
		if(!urlString.contains("KGU_WEB_SECURITY")){
			response.sendRedirect("KGU_WEB_SECURITY/Index");
			return;
		}
		/**
		 * 알 수 없는 톰캣 버그 수정을 위한 조치 끝.
		 * */

		/**
		 * 현재 URL을 검사하는 과정 시작.
		 * 서브도메인 == http://subdomain.kyonggi.ac.kr에서의 subdomain
		 * 그 중 맨 앞자리 두 글자를 가지고 현재 접속한 페이지를 판별하고 있음
		 * */
		String subdomain = request.getRequestURL().toString().split("://")[1].substring(0,2);
		if(subdomain.equals("lo")){ //로컬에서 아무것도 안뜰까봐 추가
			subdomain="cs"; //로컬에서 어떤 페이지를 보이고 싶은지 여기에서 결정해야 함 (cs / ai 둘 중 하나만 가능)
		}
		session.setAttribute("subdomain", gson.toJson(subdomain));
		/**
		 * 현재 URL을 검사하는 과정 끝
		 * */

		if(session.getAttribute("type") == null) {

			session.setAttribute("type", gson.toJson(UserDAO.getInstance().getType("게스트")));
			session.setAttribute("headermenulist", gson.toJson(HomeDAO.getInstance().getHeaderMenu()));
			session.setAttribute("menulist", gson.toJson(HomeDAO.getInstance().getMenu()));
    		response.sendRedirect("Index");
    		return;
		}
    	chain.doFilter(request, response);
    	
	}

	@Override
	public void destroy() {

	}
}

package spring.utility.blog;
 
import java.io.IOException;
 
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
 
public class AdminLoginCheckFilter implements Filter {
 
    public void init(FilterConfig arg0) throws ServletException {
    }
 
    public void doFilter(ServletRequest request, ServletResponse response, 
            FilterChain chain)
    throws IOException, ServletException {
        
        // Filter媛� �슂泥� 以묎컙�뿉�꽌 request 媛앹껜瑜� 異붿텧�빀�땲�떎.
        HttpServletRequest httpRequest = (HttpServletRequest)request;
 
        // �깉濡쒖슫 �꽭�뀡�쓣 �깮�꽦�븯吏��븡怨� request 媛앹껜�뿉�꽌 湲곗〈�쓽 �꽭�뀡 諛섑솚
        HttpSession session = httpRequest.getSession(false);
        
        // 濡쒓렇�씤 �븯吏� �븡�븯�떎怨� 媛��젙
        boolean login = false;
        
        if (session != null) { // session 媛앹껜媛� �깮�꽦�릺�뼱 �엳�뒗吏� �솗�씤
            // 濡쒓렇�씤�쓣 �뻽�쑝硫댁꽌 愿�由ъ옄�씤吏� �솗�씤�빀�땲�떎.
            if (session.getAttribute("id") != null 
                    && session.getAttribute("grade").equals("A")) {
                login = true;  // 愿�由ъ옄�씪硫�
            }
        }
        
        // �젙�긽�쟻�쑝濡� 濡쒓렇�씤�씠 �릺�뿀�떎硫� �슂泥� �럹�씠吏�濡� �씠�룞�빀�땲�떎.
        if (login) {
            chain.doFilter(request, response); //�슂泥� �럹�씠吏�濡� �씠�룞
        } else {
            // 濡쒓렇�씤�씠 �븞�릺�뿀�떎硫� 濡쒓렇�씤 �럹�씠吏�濡� �씠�룞
            RequestDispatcher dispatcher = 
                request.getRequestDispatcher("/member/login");
            dispatcher.forward(request, response);
        }
    }
 
    public void destroy() {
    }
}
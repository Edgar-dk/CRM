package com.sias.crm.settings.web.interceptor;

import com.sias.crm.commons.constans.Constant;
import com.sias.crm.settings.domain.User;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * @author Edgar
 * @create 2022-04-02 16:44
 * @faction:
 */
public class LoginInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        /*1.在这个方法中，不可以添加session这参数，可以在下面通过request来获取
        *   然后在把获取的session，从里面得到数据，在判断里面的数据是否为空，空的话，去
        *   到登陆页面，不空的话，放行，这个不空是在用户访问这个浏览器了已经登陆了页面
        *   如果说把窗口关闭，session还是存在的，直接访问子页面地址的话，是可以访问到的
        *   访问到的是controller中的地址，WEB-INF下面的还是不可以访问的，*/
        HttpSession session = request.getSession();
        User user =(User) session.getAttribute(Constant.SESSION_USER);
        if (user==null){
            response.sendRedirect(request.getContextPath());
            return false;
        }
        /*true是不拦截，false是拦截*/
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

    }
}

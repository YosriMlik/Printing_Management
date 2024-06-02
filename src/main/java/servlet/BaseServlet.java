package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

//@WebServlet("/")
public class BaseServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String VERIFIED_FLAG = "sessionVerified";

    protected static boolean verifySession(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null) {
            System.out.println("No session found, redirecting to login");
            response.sendRedirect(request.getContextPath() + "/login");
            return false;
        }

        if (Boolean.TRUE.equals(session.getAttribute(VERIFIED_FLAG))) {
            System.out.println("Session already verified for this request");
            return true;
        }

        String role = (String) session.getAttribute("role");
        if (role == null) {
            System.out.println("No role found in session, redirecting to login");
            response.sendRedirect(request.getContextPath() + "/login");
            return false;
        }

        String contextPath = request.getContextPath();
        String currentPath = request.getServletPath();

        if (role.equals("admin") && !currentPath.equals("/admin")) {
            System.out.println("Role is admin but current path is not /admin, redirecting to /admin");
            response.sendRedirect(contextPath + "/admin");
            return false;
        } else if (role.equals("teacher") && !currentPath.equals("/teacher")) {
            System.out.println("Role is teacher but current path is not /teacher, redirecting to /teacher");
            response.sendRedirect(contextPath + "/teacher");
            return false;
        } else if (role.equals("printing_agent") && !currentPath.equals("/printing_agent")) {
            System.out.println("Role is printing_agent but current path is not /printing_agent, redirecting to /printing_agent");
            response.sendRedirect(contextPath + "/printing_agent");
            return false;
        }

        session.setAttribute(VERIFIED_FLAG, true);
        System.out.println("verifySession True");
        return true;
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (verifySession(request, response)) {
            String role = (String) request.getSession().getAttribute("role");
            switch (role) {
                case "admin":
                    response.sendRedirect(request.getContextPath() + "/admin");
                    break;
                case "teacher":
                    response.sendRedirect(request.getContextPath() + "/teacher");
                    break;
                case "printing_agent":
                    response.sendRedirect(request.getContextPath() + "/printing_agent");
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/login");
                    break;
            }
        }
    }
}

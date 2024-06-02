package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.Session;
import org.hibernate.query.Query;

import hibernate.HibernateUtil;
import model.User;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        
        if (role != null) {
            switch (role) {
                case "admin":
                    response.sendRedirect(request.getContextPath() +"/admin");
                    break;
                case "teacher":
                    response.sendRedirect(request.getContextPath() +"/teacher");
                    break;
                case "printing_agent":
                    response.sendRedirect(request.getContextPath() +"/printing_agent");
                    break;
                default:
                    response.sendRedirect(request.getContextPath() +"/logout");
            }
        } else {
        	RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
            dispatcher.forward(request, response); // Redirect to login if no user is logged in
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        HttpSession session = request.getSession();
        RequestDispatcher dispatcher = null;

        try {
            Session hibernateSession = HibernateUtil.getSessionFactory().openSession();
            Query<User> query = hibernateSession.createQuery("FROM User WHERE email = :email AND password = :password AND activated = true", User.class);
            query.setParameter("email", username);
            query.setParameter("password", password);
            List<User> users = query.getResultList();
            hibernateSession.close();

            if (!users.isEmpty()) {
                User user = users.get(0);
                session.setAttribute("name", user.getName());
                session.setAttribute("role", user.getRole());
                System.out.println("User connected as: "+user.getRole());
                session.setAttribute("userId", user.getId());
                // Set other attributes as needed
                response.sendRedirect(request.getContextPath() + "/");
            } else {
                System.out.println("NOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO");
                request.setAttribute("status", "failed");
                dispatcher = request.getRequestDispatcher("login.jsp");
                dispatcher.forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
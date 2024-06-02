package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;
import org.hibernate.query.Query;

import hibernate.HibernateUtil;
import model.PrintingRequest;
import model.User;
import service.UserService;

@WebServlet("/printing_agent")
public class PrintingAgentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (BaseServlet.verifySession(request, response)) {
            Session session = HibernateUtil.getSessionFactory().openSession();
            Query<PrintingRequest> query = session.createQuery("FROM PrintingRequest where completed = 0 ORDER BY completed ASC, date ASC", PrintingRequest.class);
            List<PrintingRequest> printRequests = query.getResultList();
            List<User> teachers = UserService.getAllTeachers();
        	request.setAttribute("printRequests", printRequests);
        	request.setAttribute("teachers", teachers);
        	session.close();
            RequestDispatcher dispatcher = request.getRequestDispatcher("printing_agent.jsp");
            dispatcher.forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Add logic for printing agent actions (e.g., mark printing requests as completed)
    }
}

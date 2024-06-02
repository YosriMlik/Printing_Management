package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;
import org.hibernate.Transaction;

import hibernate.HibernateUtil;
import model.PrintingRequest;

@WebServlet("/completeTask")
public class CompleteTaskServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("********************* "+request.getParameter("requestId"));
		Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = null;
        try {
            transaction = session.beginTransaction();
            Long printingRequestId = Long.parseLong(request.getParameter("requestId"));
            PrintingRequest printingRequest = null;
    	    printingRequest = session.get(PrintingRequest.class, printingRequestId);
    	    printingRequest.setCompleted(true);
            session.update(printingRequest);
            transaction.commit();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
            response.sendRedirect(request.getContextPath() +"/printing_agent");
        }
	}

}

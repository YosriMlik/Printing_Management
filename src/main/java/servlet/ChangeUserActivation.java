package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.UserService;

@WebServlet("/changeUser")
public class ChangeUserActivation extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	int userId = Integer.parseInt(request.getParameter("userId"));
    	String act = ""+request.getParameter("act");        
        UserService.changeActivation(userId, act);
        //response.sendRedirect(request.getContextPath() +"/admin");
    }
}


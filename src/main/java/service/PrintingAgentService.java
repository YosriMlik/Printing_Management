package service;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import hibernate.HibernateUtil;
import model.PrintingRequest;
public class PrintingAgentService {
    
    public List<PrintingRequest> getAllPrintingRequests() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Query<PrintingRequest> query = session.createQuery("FROM PrintingRequest", PrintingRequest.class);
        List<PrintingRequest> requests = query.getResultList();
        session.close();
        return requests;
    }

    public void completePrintingRequest(Long requestId) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction tx = session.beginTransaction();
        PrintingRequest request = session.get(PrintingRequest.class, requestId);
        request.setCompleted(true);
        session.update(request);
        tx.commit();
        session.close();
    }
}


package com.konakartadmin.app;

import com.konakartadmin.appif.*;
import com.konakartadmin.bl.KKAdmin;

/**
 *  The KonaKart Custom Engine - SendTemplateEmailToCustomers - Generated by CreateKKAdminCustomEng
 */
@SuppressWarnings("all")
public class SendTemplateEmailToCustomers
{
    KKAdmin kkAdminEng = null;

    /**
     * Constructor
     */
     public SendTemplateEmailToCustomers(KKAdmin _kkAdminEng)
     {
         kkAdminEng = _kkAdminEng;
     }

     public void sendTemplateEmailToCustomers(String sessionId, AdminCustomerSearch custSearch, String templateName, Object obj1, Object obj2, Object obj3, Object obj4, Object obj5, int numEmailThreads) throws KKAdminException
     {
         kkAdminEng.sendTemplateEmailToCustomers(sessionId, custSearch, templateName, obj1, obj2, obj3, obj4, obj5, numEmailThreads);
     }
}

package com.konakartadmin.app;

import com.konakartadmin.bl.KKAdmin;

/**
 *  The KonaKart Custom Engine - DeleteFilter - Generated by CreateKKAdminCustomEng
 */
@SuppressWarnings("all")
public class DeleteFilter
{
    KKAdmin kkAdminEng = null;

    /**
     * Constructor
     */
     public DeleteFilter(KKAdmin _kkAdminEng)
     {
         kkAdminEng = _kkAdminEng;
     }

     public void deleteFilter(String sessionId, int id) throws KKAdminException
     {
         kkAdminEng.deleteFilter(sessionId, id);
     }
}
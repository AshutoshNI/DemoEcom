package com.konakartadmin.app;

import com.konakartadmin.bl.KKAdmin;

/**
 *  The KonaKart Custom Engine - DeleteZone - Generated by CreateKKAdminCustomEng
 */
@SuppressWarnings("all")
public class DeleteZone
{
    KKAdmin kkAdminEng = null;

    /**
     * Constructor
     */
     public DeleteZone(KKAdmin _kkAdminEng)
     {
         kkAdminEng = _kkAdminEng;
     }

     public int deleteZone(String sessionId, int id) throws KKAdminException
     {
         return kkAdminEng.deleteZone(sessionId, id);
     }
}
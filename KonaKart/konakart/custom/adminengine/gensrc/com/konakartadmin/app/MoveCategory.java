package com.konakartadmin.app;

import com.konakartadmin.bl.KKAdmin;

/**
 *  The KonaKart Custom Engine - MoveCategory - Generated by CreateKKAdminCustomEng
 */
@SuppressWarnings("all")
public class MoveCategory
{
    KKAdmin kkAdminEng = null;

    /**
     * Constructor
     */
     public MoveCategory(KKAdmin _kkAdminEng)
     {
         kkAdminEng = _kkAdminEng;
     }

     public void moveCategory(String sessionId, int categoryId, int newParentId) throws KKAdminException
     {
         kkAdminEng.moveCategory(sessionId, categoryId, newParentId);
     }
}

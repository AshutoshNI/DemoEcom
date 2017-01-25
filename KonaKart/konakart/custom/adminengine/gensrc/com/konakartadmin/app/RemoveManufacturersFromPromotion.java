package com.konakartadmin.app;

import com.konakartadmin.appif.*;
import com.konakartadmin.bl.KKAdmin;

/**
 *  The KonaKart Custom Engine - RemoveManufacturersFromPromotion - Generated by CreateKKAdminCustomEng
 */
@SuppressWarnings("all")
public class RemoveManufacturersFromPromotion
{
    KKAdmin kkAdminEng = null;

    /**
     * Constructor
     */
     public RemoveManufacturersFromPromotion(KKAdmin _kkAdminEng)
     {
         kkAdminEng = _kkAdminEng;
     }

     public void removeManufacturersFromPromotion(String sessionId, AdminManufacturer[] manufacturers, int promotionId) throws KKAdminException
     {
         kkAdminEng.removeManufacturersFromPromotion(sessionId, manufacturers, promotionId);
     }
}

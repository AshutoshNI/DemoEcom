package com.konakartadmin.app;

import com.konakartadmin.appif.*;
import com.konakartadmin.bl.KKAdmin;

/**
 *  The KonaKart Custom Engine - GetProductsPerPromotion - Generated by CreateKKAdminCustomEng
 */
@SuppressWarnings("all")
public class GetProductsPerPromotion
{
    KKAdmin kkAdminEng = null;

    /**
     * Constructor
     */
     public GetProductsPerPromotion(KKAdmin _kkAdminEng)
     {
         kkAdminEng = _kkAdminEng;
     }

     public AdminProducts getProductsPerPromotion(String sessionId, AdminProductSearch search, int offset, int size) throws KKAdminException
     {
         return kkAdminEng.getProductsPerPromotion(sessionId, search, offset, size);
     }
}

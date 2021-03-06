package com.konakartadmin.app;

import com.konakartadmin.appif.*;
import com.konakartadmin.bl.KKAdmin;

/**
 *  The KonaKart Custom Engine - GetProductWithOptions - Generated by CreateKKAdminCustomEng
 */
@SuppressWarnings("all")
public class GetProductWithOptions
{
    KKAdmin kkAdminEng = null;

    /**
     * Constructor
     */
     public GetProductWithOptions(KKAdmin _kkAdminEng)
     {
         kkAdminEng = _kkAdminEng;
     }

     public AdminProduct getProductWithOptions(String sessionId, int productId, AdminProductMgrOptions mgrOptions) throws KKAdminException
     {
         return kkAdminEng.getProductWithOptions(sessionId, productId, mgrOptions);
     }
}

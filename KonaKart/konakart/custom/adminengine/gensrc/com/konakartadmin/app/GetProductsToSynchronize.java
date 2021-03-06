package com.konakartadmin.app;

import com.konakartadmin.appif.*;
import com.konakart.app.*;
import com.konakartadmin.bl.KKAdmin;

/**
 *  The KonaKart Custom Engine - GetProductsToSynchronize - Generated by CreateKKAdminCustomEng
 */
@SuppressWarnings("all")
public class GetProductsToSynchronize
{
    KKAdmin kkAdminEng = null;

    /**
     * Constructor
     */
     public GetProductsToSynchronize(KKAdmin _kkAdminEng)
     {
         kkAdminEng = _kkAdminEng;
     }

     public AdminProducts getProductsToSynchronize(String sessionId, String storeIdFrom, String storeIdTo, AdminDataDescriptor dataDesc, int languageId, AdminSynchProductsOptions options, AdminProductMgrOptions mgrOptions) throws KKAdminException
     {
         return kkAdminEng.getProductsToSynchronize(sessionId, storeIdFrom, storeIdTo, dataDesc, languageId, options, mgrOptions);
     }
}

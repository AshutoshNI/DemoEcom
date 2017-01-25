package com.konakartadmin.app;

import com.konakartadmin.bl.KKAdmin;

/**
 *  The KonaKart Custom Engine - GetCouponCode - Generated by CreateKKAdminCustomEng
 */
@SuppressWarnings("all")
public class GetCouponCode
{
    KKAdmin kkAdminEng = null;

    /**
     * Constructor
     */
     public GetCouponCode(KKAdmin _kkAdminEng)
     {
         kkAdminEng = _kkAdminEng;
     }

     public String getCouponCode(String sessionId, String options) throws KKAdminException
     {
         return kkAdminEng.getCouponCode(sessionId, options);
     }
}

package com.konakartadmin.app;

import com.konakartadmin.appif.*;
import com.konakartadmin.bl.KKAdmin;

/**
 *  The KonaKart Custom Engine - UpdateAddressFormat - Generated by CreateKKAdminCustomEng
 */
@SuppressWarnings("all")
public class UpdateAddressFormat
{
    KKAdmin kkAdminEng = null;

    /**
     * Constructor
     */
     public UpdateAddressFormat(KKAdmin _kkAdminEng)
     {
         kkAdminEng = _kkAdminEng;
     }

     public int updateAddressFormat(String sessionId, AdminAddressFormat updateObj) throws KKAdminException
     {
         return kkAdminEng.updateAddressFormat(sessionId, updateObj);
     }
}
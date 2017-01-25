package com.konakartadmin.app;

import com.konakartadmin.bl.KKAdmin;

/**
 *  The KonaKart Custom Engine - DeleteReview - Generated by CreateKKAdminCustomEng
 */
@SuppressWarnings("all")
public class DeleteReview
{
    KKAdmin kkAdminEng = null;

    /**
     * Constructor
     */
     public DeleteReview(KKAdmin _kkAdminEng)
     {
         kkAdminEng = _kkAdminEng;
     }

     public void deleteReview(String sessionId, int reviewId) throws KKAdminException
     {
         kkAdminEng.deleteReview(sessionId, reviewId);
     }
}
package com.konakart.app;

import com.konakart.appif.*;

/**
 *  The KonaKart Custom Engine - GetRewardPointsWithOptions - Generated by CreateKKCustomEng
 */
@SuppressWarnings("all")
public class GetRewardPointsWithOptions
{
    KKEng kkEng = null;

    /**
     * Constructor
     */
     public GetRewardPointsWithOptions(KKEng _kkEng)
     {
         kkEng = _kkEng;
     }

     public RewardPointsIf getRewardPointsWithOptions(String sessionId, DataDescriptorIf dataDesc, FetchRewardPointOptionsIf options) throws KKException
     {
         return kkEng.getRewardPointsWithOptions(sessionId, dataDesc, options);
     }
}
